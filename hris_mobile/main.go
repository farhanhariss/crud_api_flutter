package main

import (
	"fmt"
	models "hris_mobile/model"
	"hris_mobile/storage"
	"log"
	"net/http"
	"os"

	"github.com/gofiber/fiber/v2"
	"github.com/joho/godotenv"
	"gorm.io/gorm"
)

type User struct {
	Name     string `json:"name"`
	Email    string `json:"email"`
	Phone    int    `json:"phone"`
	Birthday string `json:"birthday"`
	Salary   string `json:"salary"`
}

type Repository struct {
	DB *gorm.DB
}

func (r *Repository) DeleteUser(context *fiber.Ctx) error {

	userModels := models.User{}
	id := context.Params("id")
	if id == "" {
		context.Status(http.StatusInternalServerError).JSON(&fiber.Map{
			"message": "id cannot be empty",
		})
		return nil
	}

	err := r.DB.Delete(userModels, id)

	if err.Error != nil {
		context.Status(http.StatusBadRequest).JSON(&fiber.Map{
			"message": "could not delete user",
		})
		return err.Error
	}
	context.Status(http.StatusOK).JSON(&fiber.Map{
		"message": "user delete successfully",
	})
	return nil
}

func (r *Repository) GetAllUsers(context *fiber.Ctx) error {
	userModels := &[]models.User{}
	err := r.DB.Find(userModels).Error

	if err != nil {
		context.Status(http.StatusBadRequest).JSON(
			&fiber.Map{"message": "could not get users"})
		return err
	}

	context.Status(http.StatusOK).JSON(&fiber.Map{"message": "success get all users", "data": userModels})

	return nil
}

func (r *Repository) GetUserById(context *fiber.Ctx) error {
	userModels := &models.User{} // & is used to get the address of a variable in the same memory.
	id := context.Params("id")

	if id == "" {
		context.Status(http.StatusInternalServerError).JSON(&fiber.Map{
			"message": "id cannot be empty",
		})
		return nil
	}

	fmt.Println("the id is", id)

	err := r.DB.Where("id = ?", id).First(userModels).Error
	if err != nil {
		context.Status(http.StatusBadRequest).JSON(&fiber.Map{
			"message": "could not get user",
		})
		return err
	}

	context.Status(http.StatusOK).JSON(&fiber.Map{"message": "success get user", "data": userModels})

	return nil
}

func (r *Repository) UpdateUser(context *fiber.Ctx) error {
	userModels := &models.User{}
	id := context.Params("id")

	if id == "" {
		context.Status(http.StatusInternalServerError).JSON(&fiber.Map{
			"message": "id cannot be empty",
		})
		return nil
	}

	// search user models with id
	err := r.DB.Where("id = ?", id).First(userModels).Error

	if err != nil {
		context.Status(http.StatusBadRequest).JSON(&fiber.Map{
			"message": "could not get user",
		})
		return err
	}

	err = context.BodyParser(&userModels)

	if err != nil {
		context.Status(http.StatusUnprocessableEntity).JSON(&fiber.Map{"message": "request failed"})
		return err
	}

	// Lakukan pembaruan ke database
	err = r.DB.Save(userModels).Error

	if err != nil {
		context.Status(http.StatusUnprocessableEntity).JSON(&fiber.Map{"message": "request failed"})
		return err
	}

	context.Status(http.StatusOK).JSON(&fiber.Map{"message": "success update user", "data": userModels})

	return nil
}

func (r *Repository) CreateUser(context *fiber.Ctx) error {
	user := User{}

	err := context.BodyParser(&user)

	if err != nil {
		context.Status(http.StatusUnprocessableEntity).JSON(&fiber.Map{"message": "request failed"})
		return err
	}

	// = used to assign a value to an existing variable or declare a variable at the package level.
	err = r.DB.Create(&user).Error

	if err != nil {
		context.Status(http.StatusUnprocessableEntity).JSON(&fiber.Map{"message": "request failed"})
		return err
	}

	context.Status(http.StatusOK).JSON(&fiber.Map{"message": "success create user"})

	return nil
}

func (r *Repository) SetupRoutes(app *fiber.App) {
	api := app.Group("/api")
	api.Get("/users", r.GetAllUsers)
	api.Get("/get_user/:id", r.GetUserById)
	api.Post("/create_user", r.CreateUser)
	api.Put("/update_user/:id", r.UpdateUser)
	api.Delete("/delete_user/:id", r.DeleteUser)
}

func main() {
	err := godotenv.Load(".env")

	if err != nil {
		log.Fatalf(err.Error())
	}

	config := &storage.Config{
		Host:     os.Getenv("DB_HOST"),
		Port:     os.Getenv("DB_PORT"),
		User:     os.Getenv("DB_USER"),
		Password: os.Getenv("DB_PASSWORD"),
		DBName:   os.Getenv("DB_NAME"),
		SSLMode:  os.Getenv("DB_SSLMODE"),
	}

	db, err := storage.NewConnection(config)

	if err != nil {
		log.Fatalf("could not load the database")
	}

	// Migrate the schema
	err = models.MigrateUsers(db)
	if err != nil {
		log.Fatalf("could not migrate db")
	}

	r := Repository{
		DB: db,
	}

	app := fiber.New()
	r.SetupRoutes(app)
	app.Listen(":3000") // default port 3000

}

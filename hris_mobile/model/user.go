package models

import "gorm.io/gorm"

type User struct {
	ID       uint   `gorm:"primary_key;autoIncrement" json:"id"`
	Name     string `json:"name"`
	Email    string `json:"email"`
	Phone    int    `json:"phone"`
	Birthday string `json:"birthday"`
	Salary   string `json:"salary"`
}

func MigrateUsers(db *gorm.DB) error {
	err := db.AutoMigrate(&User{})
	return err
}

package server

import (
	"fmt"
	"net/http"
)

func checkAuthentication(r *http.Request) (*User, error) {
	userEmail, _, ok := (*r).BasicAuth()
	if !ok {
		return nil, nil
	}

	stmt := fmt.Sprintf(`SELECT * FROM users WHERE email = '%s'`, userEmail)

	rows, err := db.Query(stmt)
	if err != nil {
		return nil, err
	}

	var user User

	if rows.Next() {
		err = rows.Scan(&user.Id, &user.Name, &user.Email, &user.Birthday, &user.Sex, &user.Permission)
		if err != nil {
			return nil, err
		}
	} else {
		return nil, nil
	}

	return &user, nil
}

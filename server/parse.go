package server

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"net/http"
)

func parseBody(r *http.Request) (*string, error) {
	if r.Body == nil {
		return nil, fmt.Errorf("req.Body: %v", r.Body)
	}

	bytes, err := ioutil.ReadAll(r.Body)
	if err != nil {
		return nil, err
	}
	body := string(bytes)

	if len(body) == 0 {
		return nil, fmt.Errorf("len(body) == 0")
	}

	return &body, nil
}

func parseUser(r *http.Request) (*User, error) {
	if r.Body == nil {
		return nil, fmt.Errorf("req.Body: %v", r.Body)
	}

	var user User
	if err := json.NewDecoder(r.Body).Decode(&user); err != nil {
		return nil, err
	}

	return &user, nil
}

/*
 * Takí Project
 *
 * IF683 Takí project
 *
 * API version: 1.0.0
 * Contact: mvgmb@cin.ufpe.br
 * Generated by: Swagger Codegen (https://github.com/swagger-api/swagger-codegen.git)
 */

package server

import (
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

type StoreMap struct {
	Map [][]interface{} `json:"map"`
}

// StoreStoreIDListListIDDelete deletes a List
func StoreStoreIDListListIDDelete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	_, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	vars := mux.Vars(r)

	stmt := fmt.Sprintf(`DELETE FROM lists WHERE _id = %s`, vars["listId"])

	_, err = db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	stmt = fmt.Sprintf(`DELETE FROM user_lists WHERE list_id = %s`, vars["listId"])

	_, err = db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
}

// TODO get
func StoreStoreIdListListIdGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	// Dummy test, shows how to use gorilla/mux
	vars := mux.Vars(r)
	log.Println(vars["storeId"])
	log.Println(vars["listId"])
}

// StoreStoreIdListListIdPut update list given listId
func StoreStoreIdListListIdPut(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	_, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	list, err := parseList(r)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	vars := mux.Vars(r)
	list_json, _ := json.Marshal(list.Products)

	stmt := fmt.Sprintf(`
	UPDATE lists
	SET name = '%s', list = '%s'
	WHERE _id = '%s'`, list.Name, string(list_json), vars["listId"])

	_, err = db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
}

func StoreStoreIdListListIdRouteGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// StoreStoreIdListNewPost create a new list given the store ID
func StoreStoreIdListNewPost(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	list, err := parseList(r)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	list_json, _ := json.Marshal(list.Products)

	stmt := fmt.Sprintf(`
	INSERT INTO lists (name, list) 
	VALUES ('%s', '%s')`, list.Name, string(list_json))

	_, err = db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	user, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	vars := mux.Vars(r)

	stmt_1 := fmt.Sprintf(`
	INSERT INTO user_lists(USER_ID, LIST_ID, STORE_ID)
	VALUES(%d, (SELECT MAX(_id) FROM lists), %s)`, user.Id, vars["storeId"])

	_, err = db.Query(stmt_1)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)

}

// TODO get
func StoreStoreIdListsGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// StoreStoreIdMapGet return the Map of a given Store
func StoreStoreIdMapGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	_, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	vars := mux.Vars(r)

	stmt := fmt.Sprintf(`
	SELECT map
	FROM stores 
	WHERE _id = %s`, vars["storeId"])

	rows, err := db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	var mapString string

	if rows.Next() {
		err = rows.Scan(&mapString)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			log.Println(err)
			return
		}
	}

	raw := StoreMap{}

	err = json.Unmarshal([]byte(mapString), &raw)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	var storeMap ModelMap
	var mapValue MapValue

	for i := range raw.Map {
		var row []MapValue
		for j := range raw.Map[i] {
			slot := raw.Map[i][j].([]interface{})

			aisle, err := strconv.Atoi(slot[1].(string))
			if err != nil {
				w.WriteHeader(http.StatusBadRequest)
				log.Println(err)
				return
			}

			direction, err := strconv.Atoi(slot[2].(string))
			if err != nil {
				w.WriteHeader(http.StatusBadRequest)
				log.Println(err)
				return
			}

			mapValue.Category = slot[0].(string)
			mapValue.Aisle = int32(aisle)
			mapValue.Direction = int32(direction)

			row = append(row, mapValue)
		}
		storeMap.Matrix = append(storeMap.Matrix, row)
	}

	bytes, err := json.Marshal(storeMap)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(bytes)
}

// StoreStoreIdProductsGet returns all Products of a given Store
func StoreStoreIdProductsGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	_, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	vars := mux.Vars(r)

	stmt := fmt.Sprintf(`
	SELECT p._id, p.name, p.description 
	FROM products AS p, product_category AS pc 
	WHERE p._id = pc.product_id AND pc.store_id = %s`, vars["storeId"])

	rows, err := db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	var products []Product
	var p Product

	for rows.Next() {
		err = rows.Scan(&p.Id, &p.Name, &p.Description)
		if err != nil {
			w.WriteHeader(http.StatusBadRequest)
			log.Println(err)
			return
		}
		products = append(products, p)
	}

	bytes, err := json.Marshal(products)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(bytes)
}

// TODO get
func StoresGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// UserGet returns an User information
func UserGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	user, err := checkAuthentication(r)
	if err != nil {
		w.WriteHeader(http.StatusUnauthorized)
		log.Println(err)
		return
	}

	bytes, err := json.Marshal(user)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
	w.Write(bytes)
}

// UserNewPost registers a new User
func UserNewPost(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")

	user, err := parseUser(r)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	stmt := fmt.Sprintf(`
	INSERT INTO users (name, email, birthday, sex, permission) 
	VALUES ('%s', '%s', '%s', %d, '%s')`, user.Name, user.Email, user.Birthday, user.Sex, user.Permission)

	_, err = db.Query(stmt)
	if err != nil {
		w.WriteHeader(http.StatusBadRequest)
		log.Println(err)
		return
	}

	w.WriteHeader(http.StatusOK)
}

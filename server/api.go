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

	"github.com/gorilla/mux"
)

func StoreStoreIDListListIDDelete(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
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

func StoreStoreIdListListIdPut(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

func StoreStoreIdListListIdRouteGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

func StoreStoreIdListNewPost(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// TODO get
func StoreStoreIdListsGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// TODO get
func StoreStoreIdMapGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// StoreStoreIdProductsGet returns all Products of a given Store
func StoreStoreIdProductsGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)

	vars := mux.Vars(r)

	stmt := fmt.Sprintf(`
	SELECT p._id, p.name, p.description 
	FROM products AS p, product_category AS pc 
	WHERE p._id = pc.product_id AND pc.store_id = %s`, vars["storeId"])

	rows, err := db.Query(stmt)
	if err != nil {
		log.Fatal(err)
	}

	var products []Product
	var p Product

	for rows.Next() {
		err = rows.Scan(&p.Id, &p.Name, &p.Description)
		if err != nil {
			log.Fatal(err)
		}
		products = append(products, p)
	}

	bytes, err := json.Marshal(products)
	if err != nil {
		log.Fatal(err)
	}
	w.Write(bytes)
}

// TODO get
func StoresGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

// TODO get
func UserGet(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

func UserNewPost(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json; charset=UTF-8")
	w.WriteHeader(http.StatusOK)
}

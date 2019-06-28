package api 

import (
	"os"
	"fmt"
	"encoding/base64"
	"log"
	"bufio"
	"io/ioutil"
	"encoding/json"
	"strconv"

	"github.com/sahilm/fuzzy"
)

func mapRoute(storeId, listId string) (*MapRoute, error){
	return nil, nil

	// not working
	// list, err := getList(listId) 
	// if err != nil {
	// 	return nil, err
	// }

	// listMap := make(map[string]bool)
	// for i := range list.Products {
	// 	category, err := getProductCategory(storeId, list.Products[i].Id)
	// 	if err != nil {
	// 		return nil, err
	// 	}
	// 	listMap[category] = true
	// }	

	// storeMap, err := getMap(storeId)
	// if err != nil {
	// 	return nil, err
	// }

	// noRows := len(storeMap.Matrix)
	// noColumns := len(storeMap.Matrix[0])

	// startRow := -1
	// startColumn := -1

	// for i := 0; i < noRows; i++ {
	// 	for j := 0; j < noColumns; j++ {
	// 		if storeMap.Matrix[i][j].Category == "Start" {
	// 			startRow = i
	// 			startColumn = j
	// 			break
	// 		}
	// 	}
	// 	if startRow != -1 {
	// 		break
	// 	}
	// }

	// visited := make([][]bool, noRows)
	// for i := range visited {
	// 	visited[i] = make([]bool, noColumns)
	// }

	// type Pair struct {
	// 	i, j int
	// }

	// var route []MapValue

	// queue := make([]Pair, 0)
	// queue = append(queue, Pair{i:startRow, j:startColumn})

	// for len(queue) != 0 && len(listMap) > 0 {
	// 	i := queue[0].i
	// 	j := queue[0].j

	// 	queue = queue[1:]
	// 	visited[i][j] = true

	// 	if i-1 >= 0 && !visited[i-1][j] { 
	// 		category := storeMap.Matrix[i-1][j].Category
	// 		if category == "Free" {
	// 			queue = append(queue, Pair{i:i-1, j:j})
	// 		} else if listMap[category] {
	// 			route = append(route, storeMap.Matrix[i-1][j])

	// 			delete(listMap, category)
	// 			clearMatrix(&visited)
	// 			queue := make([]Pair, 0)
	// 			queue = append(queue, Pair{i:i,j:j})
	// 		}
	// 	}
	// 	if i+1 < noRows && !visited[i+1][j] { 
	// 		category := storeMap.Matrix[i+1][j].Category
	// 		if category == "Free" {
	// 			queue = append(queue, Pair{i:i+1, j:j})
	// 		} else if listMap[category] {
	// 			route = append(route, storeMap.Matrix[i+1][j])

	// 			delete(listMap, category)				
	// 			clearMatrix(&visited)
	// 			queue := make([]Pair, 0)
	// 			queue = append(queue, Pair{i:i,j:j})
	// 		}
	// 	}
	// 	if j-1 >= 0 && !visited[i][j-1]  {
	// 		category := storeMap.Matrix[i][j-1].Category
	// 		if category == "Free" {
	// 			queue = append(queue, Pair{i:i, j:j-1})
	// 		} else if listMap[category] {
	// 			route = append(route, storeMap.Matrix[i][j-1])
				
	// 			delete(listMap, category)				
	// 			clearMatrix(&visited)
	// 			queue := make([]Pair, 0)
	// 			queue = append(queue, Pair{i:i,j:j})
	// 		}
	// 	}
	// 	if j+1 < noColumns && !visited[i][j+1] {
	// 		category := storeMap.Matrix[i][j+1].Category
	// 		if category == "Free" {
	// 			queue = append(queue, Pair{i:i, j:j+1})
	// 		} else if listMap[category] {
	// 			route = append(route, storeMap.Matrix[i][j+1])
				
	// 			delete(listMap, category)				
	// 			clearMatrix(&visited)
	// 			queue := make([]Pair, 0)
	// 			queue = append(queue, Pair{i:i,j:j})
	// 		}
	// 	}		
	// }

	// e := &MapRoute{
	// 	Route: route,
	// }
	// return e, err
}

func clearMatrix(matrix *[][]bool) {
	for i:=0; i < len(*matrix); i++ {
		for j:=0; j < len((*matrix)[0]); j++ {
			(*matrix)[i][j] = false
		}
	}
}

func getProductCategory(storeId string, productId int32) (string, error) {
	stmt := fmt.Sprintf(`
	SELECT c.name
	FROM product_category AS pc, categories AS c
	WHERE pc.store_id = %s AND pc.product_id = %d AND pc.category_id = c._id`, storeId, productId)

	rows, err := db.Query(stmt)
	if err != nil {
		log.Println(err)
	}

	var category string

	if rows.Next() {
		err = rows.Scan(&category)
		if err != nil {
			log.Println(err)
		}
	}

	return category, nil
}

func getMap(storeId string) (*ModelMap, error) {
	stmt := fmt.Sprintf(`
	SELECT map
	FROM stores 
	WHERE _id = %s`, storeId)

	rows, err := db.Query(stmt)
	if err != nil {
		log.Println(err)
	}

	var mapString string

	if rows.Next() {
		err = rows.Scan(&mapString)
		if err != nil {
			log.Println(err)
		}
	}
	raw := StoreMap{}

	err = json.Unmarshal([]byte(mapString), &raw)
	if err != nil {
		log.Println(err)
	}

	var storeMap ModelMap
	var mapValue MapValue

	for i := range raw.Map {
		var row []MapValue
		for j := range raw.Map[i] {
			slot := raw.Map[i][j].([]interface{})

			aisle, err := strconv.Atoi(slot[1].(string))
			if err != nil {
				log.Println(err)
			}

			mapValue.Category = slot[0].(string)
			mapValue.Aisle = int32(aisle)
			mapValue.Direction = slot[2].(string)

			row = append(row, mapValue)
		}
		storeMap.Matrix = append(storeMap.Matrix, row)
	}

	return &storeMap, nil
}

func getCategoryList(categoryListId string) (*CategoryList, error) {
	stmt := fmt.Sprintf(`
	SELECT cl._id, cl.name, cl.list
	FROM category_lists AS cl 
	WHERE cl._id = %s`, categoryListId)

	rows, err := db.Query(stmt)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	var categoryList CategoryList
	var categoryListString string

	if rows.Next() {
		err = rows.Scan(&categoryList.Id, &categoryList.Name, &categoryListString)
		if err != nil {
			log.Println(err)
			return nil, err
		}
	}

	raw := StoreCategoriesList{}

	err = json.Unmarshal([]byte(categoryListString), &raw)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	for _, v := range raw.Categories {
		stmt1 := fmt.Sprintf(`
		SELECT c._id, c.Name, c.Description
		FROM categories AS c 
		WHERE c._id = %v`, v)

		category, err := db.Query(stmt1)
		if err != nil {
			log.Println(err)
			return nil, err
		}

		var category1 Category

		if category.Next() {
			err = category.Scan(&category1.Id, &category1.Name, &category1.Description)
			if err != nil {
				log.Println(err)
				return nil, err
			}
		}

		categoryList.Categories = append(categoryList.Categories, category1)
	}

	fmt.Println(categoryList)

	return &categoryList, nil
}

func getList(listId string) (*List, error) {
	stmt := fmt.Sprintf(`
	SELECT l._id, l.name, l.list
	FROM lists AS l 
	WHERE l._id = %s`, listId)

	rows, err := db.Query(stmt)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	var list List
	var listString string

	if rows.Next() {
		err = rows.Scan(&list.Id, &list.Name, &listString)
		if err != nil {
			log.Println(err)
			return nil, err
		}
	}

	raw := StoreList{}

	err = json.Unmarshal([]byte(listString), &raw)
	if err != nil {
		log.Println(err)
		return nil, err
	}

	for _, v := range raw.Products {
		stmt1 := fmt.Sprintf(`
		SELECT p._id, p.Name, p.Description
		FROM products AS p 
		WHERE p._id = %v`, v)

		product, err := db.Query(stmt1)
		if err != nil {
			log.Println(err)
			return nil, err
		}

		var product1 Product

		if product.Next() {
			err = product.Scan(&product1.Id, &product1.Name, &product1.Description)
			if err != nil {
				log.Println(err)
				return nil, err
			}
		}

		list.Products = append(list.Products, product1)
	}

	return &list, nil
}

func getProductEncodedImageById(productId string) (string, error) {
	f, err := os.Open(fmt.Sprintf("./images/%s.png", productId))
	if err != nil {
		return "", err
	}
	reader := bufio.NewReader(f)
	content, _ := ioutil.ReadAll(reader)
	
	return base64.StdEncoding.EncodeToString(content), nil
}

func GetPossibleStoreCategoriesFromProductName(userInput, storeId string) ([]string, error){
	stmt := fmt.Sprintf(`
	SELECT p.name, c.name
	FROM products AS p, product_category AS pc, categories AS c 
	WHERE p._id = pc.product_id AND pc.store_id = %s AND pc.category_id = c._id`, storeId)
	
	rows, err := db.Query(stmt)
	if err != nil {
		return nil, err
	}

	var names []string
	categories := make(map[string]string)
	var name, category string

	for rows.Next() {
		err = rows.Scan(&name, &category)
		if err != nil {
			return nil, err
		}
		names = append(names, name)
		categories[name] = category
	}

	matches := fuzzy.Find(userInput, names)
	
	possibleCategories := make([]string, len(matches))
	unique := make(map[string]bool)
	size := 0
	for i := range matches {
		if !unique[categories[matches[i].Str]] {
			possibleCategories[i] = categories[matches[i].Str]
			unique[categories[matches[i].Str]] = true
			size++
		}
	}

	return possibleCategories[:size], err
}
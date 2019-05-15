package util

import "database/sql"

// #################################################
// #         FUNCTION ONLY FOR TESTING             #
// #       DO NOT USE IN ACTUAL PROJECT			   #
// #################################################

// RunStatement executes a statement and return its column names and values
// Names at row of index 0, values at every other row
func RunStatement(db *sql.DB, stmt string) ([][]string, error) {
	// Result matrix
	var result [][]string

	// Excecutes statement, returning its rows values
	rows, err := db.Query(stmt)
	if err != nil {
		return result, err
	}

	// Getting column names and appending to result matrix
	columnNames, err := rows.Columns()
	if err != nil {
		return result, err
	}
	result = append(result, columnNames)

	for rows.Next() {
		// Creating interface with size equal to the number of columns
		pointers := make([]interface{}, len(columnNames))
		for i := 0; i < len(columnNames); i++ {
			var s string
			pointers[i] = &s
		}

		// Scanning values from the row into the pointers slice
		err = rows.Scan(pointers...)
		if err != nil {
			return result, err
		}

		// Appending row to result matrix
		var rowValues []string
		for _, str := range pointers {
			v := str.(*string)
			rowValues = append(rowValues, *v)
		}
		result = append(result, rowValues)
	}

	return result, nil
}

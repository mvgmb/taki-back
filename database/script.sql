-- This script will be executed once the db is up

CREATE TABLE users (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    email TEXT,
    birthday DATE,
    sex INT, -- 0 male, 1 female
    permission TEXT -- ADMINISTRATOR, MANAGER, USER
);

CREATE TABLE products (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT, 
    description TEXT
);

CREATE TABLE stores (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    map JSON -- matrix
    -- each slot == [category, aisle, direction] == [string, int, int]
    -- direction == 0 - horizontal, 1 | vertical, 2 / right_diagonal, 3 \ left_diagonal 
);

CREATE TABLE lists (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    list JSON -- array of products id
);

CREATE TABLE product_category (
    store_id INT NOT NULL ,
    product_id INT NOT NULL,
    category TEXT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);

CREATE TABLE user_lists (
    user_id INT NOT NULL,
    list_id INT NOT NULL,
    store_id INT NOT NULL
);


INSERT INTO users (name, email, birthday, sex, permission) VALUES ('alex', 'alexandro@gmail.com', '1986-07-11', 0, 'USER');

INSERT INTO products (name, description) VALUES ('Toddynho', 'Achocolatado delicioso');
INSERT INTO products (name, description) VALUES ('Nescau Achocolatado', 'Toddynho, so que de outra marca');
INSERT INTO products (name, description) VALUES ('Leite Moça', 'Um Leite Condensado famoso ai');

INSERT INTO stores (name, map) VALUES ('Ferreira Costa', 
'{
  "map":[
  	[ ["Achocolatado", "1", "1"], ["Free", "1", "1"], ["Leite Condensado", "1", "1"] ],
  	[ ["Achocolatado", "1", "1"], ["Free", "1", "1"], ["Leite Condensado", "1", "1"] ],
  	[ ["Achocolatado", "1", "1"], ["Free", "1", "1"], ["Leite Condensado", "1", "1"] ]
  ]
}');

INSERT INTO lists (name, list) VALUES ('Awesome List', '{ "list": ["1","3","2"] }');
INSERT INTO lists (name, list) VALUES ('Not so Awesome List', '{ "list": ["2"] }');

INSERT INTO product_category (store_id, product_id, category) VALUES (1, 1, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 2, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 3, 'Leite Condensado');

INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 1, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 2, 1);

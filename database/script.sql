-- This script will be executed once the db is up

CREATE TABLE users (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    email TEXT,
    birthday DATE,
    sex CHAR,
    permission INT -- 0 admin, 1 manager, 2 user
);

CREATE TABLE products (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT, 
    description TEXT
);

CREATE TABLE stores (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    map JSON -- 2D array, e.g. { "map":[ ["0","1","2"], ["3","4","5"], ["6","7","8"] ] }
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


INSERT INTO users (name, email, birthday, sex, permission) VALUES ('alex', 'alexandro@gmail.com', '1986-07-11', 'm', 2);

INSERT INTO products (name, description) VALUES ('Toddynho', 'Achocolatado delicioso');
INSERT INTO products (name, description) VALUES ('Nescau Achocolatado', 'Toddynho, so que de outra marca');
INSERT INTO products (name, description) VALUES ('Leite Moça', 'Um Leite Condensado famoso ai');

INSERT INTO stores (name, map) VALUES ('Ferreira Costa', 
'{
  "map":[
  	[ "0", "1", "2" ],
  	[ "3", "4", "5" ],
  	[ "6", "7", "8" ]
  ]
}');

INSERT INTO lists (name, list) VALUES ('Awesome List', '{ "list": ["1","3","2"] }');
INSERT INTO lists (name, list) VALUES ('Not so Awesome List', '{ "list": ["2"] }');

INSERT INTO product_category (store_id, product_id, category) VALUES (1, 1, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 2, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 3, 'Leite Condensado');

INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 1, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 2, 1);

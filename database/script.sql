-- This script will be executed once the db is up
SET NAMES UTF8;

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

CREATE TABLE categories (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT, 
    description TEXT
);

CREATE TABLE stores (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    map JSON -- matrix
    -- each slot == [category, aisle, direction] == [string, int, string]
    -- direction == h - horizontal, v - vertical
);

CREATE TABLE lists (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    list JSON -- array of products id
);

CREATE TABLE category_lists (
    _id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    list JSON -- array of categories id
);

CREATE TABLE product_category (
    store_id INT NOT NULL ,
    product_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (store_id, product_id)
);

CREATE TABLE user_lists (
    user_id INT NOT NULL,
    list_id INT NOT NULL,
    store_id INT NOT NULL
);

INSERT INTO users (name, email, birthday, sex, permission) VALUES ('alex', 'alexandro@gmail.com', '1986-07-11', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('valdecio', 'vald@gmail.com', '1964-02-01', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('ana maria', 'braga@gmail.com', '1904-01-10', 1, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('marilyn manson', '666@gmail.com', '1969-01-05', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('robert plant', 'rblz@gmail.com', '1948-08-20', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('janis joplin', 'jjpearl@gmail.com', '1943-01-19', 1, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('dolores mary', 'eeidiswcw@gmail.com', '1971-09-06', 1, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('jim morrison', 'tchangeling@gmail.com', '1943-12-08', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('steven morrisey', 'englangismine@gmail.com', '1959-05-22', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('priscilla novaes', 'pitty@gmail.com', '1977-10-07', 1, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('joe strummer', 'tclash@gmail.com', '1952-08-21', 0, 'USER'); 
INSERT INTO users (name, email, birthday, sex, permission) VALUES ('david byrne', 'psychok@gmail.com', '1952-05-14', 0, 'USER'); 

INSERT INTO products (name, description) VALUES ('Nescau', '');
INSERT INTO products (name, description) VALUES ('Toddynho', '');

INSERT INTO products (name, description) VALUES ('Leite Ninho', '');

INSERT INTO products (name, description) VALUES ('Bombril', '');

INSERT INTO products (name, description) VALUES ('Skoll', '');
INSERT INTO products (name, description) VALUES ('Heineken', '');
INSERT INTO products (name, description) VALUES ('Brahma', '');
INSERT INTO products (name, description) VALUES ('Itaipava', '');
INSERT INTO products (name, description) VALUES ('Budweiser', '');
INSERT INTO products (name, description) VALUES ('Schin', '');

INSERT INTO products (name, description) VALUES ('Guaraná', '');
INSERT INTO products (name, description) VALUES ('Coca-cola', '');
INSERT INTO products (name, description) VALUES ('Fanta', '');
INSERT INTO products (name, description) VALUES ('Kuat', '');
INSERT INTO products (name, description) VALUES ('Sprite', '');
INSERT INTO products (name, description) VALUES ('Antártica', '');
INSERT INTO products (name, description) VALUES ('Fanta uva', '');
INSERT INTO products (name, description) VALUES ('Frevo', '');
INSERT INTO products (name, description) VALUES ('Indaiá refri', '');

INSERT INTO products (name, description) VALUES ('Paçoca', '');
INSERT INTO products (name, description) VALUES ('Goiabada', '');

INSERT INTO products (name, description) VALUES ('Twix', '');
INSERT INTO products (name, description) VALUES ('Baton', '');
INSERT INTO products (name, description) VALUES ('Bis', '');
INSERT INTO products (name, description) VALUES ('Sonho de valsa', '');

INSERT INTO products (name, description) VALUES ('Sardinha', '');
INSERT INTO products (name, description) VALUES ('Atum', '');

INSERT INTO products (name, description) VALUES ('Tempero', '');
INSERT INTO products (name, description) VALUES ('Cominho', '');
INSERT INTO products (name, description) VALUES ('Colorau', '');
INSERT INTO products (name, description) VALUES ('Orégano', '');

INSERT INTO products (name, description) VALUES ('Ruffles', '');
INSERT INTO products (name, description) VALUES ('Cheetos', '');
INSERT INTO products (name, description) VALUES ('Cheetos Lua', '');
INSERT INTO products (name, description) VALUES ('Pringles', '');
INSERT INTO products (name, description) VALUES ('Doritos', '');

INSERT INTO products (name, description) VALUES ('Toddy', 'Achocolatado delicioso');
INSERT INTO products (name, description) VALUES ('Nescau', 'Toddynho, so que de outra marca');

INSERT INTO products (name, description) VALUES ('Papel higiênico', '');
INSERT INTO products (name, description) VALUES ('Cotonetes', '');

INSERT INTO stores (name, map) VALUES ('Arco Iris', 
'{
  "map":[
  	[ ["Start", "0", "v"],       ["Free", "0", "v"],    ["Free", "0", "v"],          ["Free", "0", "v"],      ["Free", "0", "v"],    ["Free", "0", "v"],         ["Free", "0", "v"],       ["Free", "0", "v"],  ["Free", "0", "v"],             ["Free", "0", "v"],      ["Free", "0", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"] ],
  	[ ["Eletronicos", "1", "v"], ["Free", "1", "v"],    ["Leites", "1", "v"],        ["Biscoitos", "2", "v"], ["Free", "2", "v"],    ["Massas", "2", "v"],       ["Higiene", "3", "v"],    ["Free", "3", "v"],  ["Higiene", "3", "v"],          ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Bazar", "4", "v"], ["Graos", "5", "v"],     ["Free", "5", "v"],        ["Frangos", "5", "v"],     ["Peixes", "6", "v"],      ["Free", "6", "v"],        ["Sorvetes", "6", "v"] ],
  	[ ["Eletronicos", "1", "v"], ["Free", "1", "v"],    ["Leites", "1", "v"],        ["Biscoitos", "2", "v"], ["Free", "2", "v"],    ["Massas", "2", "v"],       ["Higiene", "3", "v"],    ["Free", "3", "v"],  ["Higiene", "3", "v"],          ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Bazar", "4", "v"], ["Graos", "5", "v"],     ["Free", "5", "v"],        ["Frangos", "5", "v"],     ["Peixes", "6", "v"],      ["Free", "6", "v"],        ["Sorvetes", "6", "v"] ],
  	[ ["Eletronicos", "1", "v"], ["Free", "1", "v"],    ["Leites", "1", "v"],        ["Biscoitos", "2", "v"], ["Free", "2", "v"],    ["Massas", "2", "v"],       ["Higiene", "3", "v"],    ["Free", "3", "v"],  ["Higiene", "3", "v"],          ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Bazar", "4", "v"], ["Graos", "5", "v"],     ["Free", "5", "v"],        ["Frangos", "5", "v"],     ["Peixes", "6", "v"],      ["Free", "6", "v"],        ["Sorvetes", "6", "v"] ],
  	[ ["Chocolates", "1", "v"],  ["Free", "1", "v"],    ["Achocolatados", "1", "v"], ["Oleos", "2", "v"],     ["Free", "2", "v"],    ["Condimentos", "2", "v"],  ["Fraldas", "3", "v"],    ["Free", "3", "v"],  ["Perfumaria", "3", "v"],       ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Bazar", "4", "v"], ["Graos", "5", "v"],     ["Free", "5", "v"],        ["Frangos", "5", "v"],     ["Peixes", "6", "v"],      ["Free", "6", "v"],        ["Sorvetes", "6", "v"] ],
  	[ ["Chocolates", "1", "v"],  ["Free", "1", "v"],    ["Achocolatados", "1", "v"], ["Oleos", "2", "v"],     ["Free", "2", "v"],    ["Condimentos", "2", "v"],  ["Fraldas", "3", "v"],    ["Free", "3", "v"],  ["Perfumaria", "3", "v"],       ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Bazar", "4", "v"], ["Graos", "5", "v"],     ["Free", "5", "v"],        ["Frangos", "5", "v"],     ["Peixes", "6", "v"],      ["Free", "6", "v"],        ["Laticinios", "6", "v"] ],
  	[ ["Biscoitos", "1", "v"],   ["Free", "1", "v"],    ["Achocolatados", "1", "v"], ["Azeites", "2", "v"],   ["Free", "2", "v"],    ["Condimentos", "2", "v"],  ["Fraldas", "3", "v"],    ["Free", "3", "v"],  ["Perfumaria", "3", "v"],       ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Pets", "4", "v"],  ["Biscoitos", "5", "v"], ["Free", "5", "v"],        ["Carnes", "5", "v"],      ["Congelados", "6", "v"],  ["Free", "6", "v"],        ["Laticinios", "6", "v"] ],
  	[ ["Biscoitos", "1", "v"],   ["Free", "1", "v"],    ["Bebidas", "1", "v"],       ["Enlatados", "2", "v"], ["Free", "2", "v"],    ["Enlatados", "2", "v"],    ["Perfumaria", "3", "v"], ["Free", "3", "v"],  ["Escova de dentes", "3", "v"], ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Pets", "4", "v"],  ["Biscoitos", "5", "v"], ["Free", "5", "v"],        ["Carnes", "5", "v"],      ["Congelados", "6", "v"],  ["Free", "6", "v"],        ["Laticinios", "6", "v"] ],
  	[ ["Bebidas", "1", "v"],     ["Free", "1", "v"],    ["Bebidas", "1", "v"],       ["Enlatados", "2", "v"], ["Free", "2", "v"],    ["Enlatados", "2", "v"],    ["Perfumaria", "3", "v"], ["Free", "3", "v"],  ["Sabonetes", "3", "v"],        ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Pets", "4", "v"],  ["Massas", "5", "v"],    ["Free", "5", "v"],        ["Carnes", "5", "v"],      ["Congelados", "6", "v"],  ["Free", "6", "v"],        ["Frios", "6", "v"] ],
  	[ ["Bebidas", "1", "v"],     ["Free", "1", "v"],    ["Bebidas", "1", "v"],       ["Enlatados", "2", "v"], ["Free", "2", "v"],    ["Enlatados", "2", "v"],    ["Perfumaria", "3", "v"], ["Free", "3", "v"],  ["Sabonetes", "3", "v"],        ["Limpeza", "4", "v"],   ["Free", "4", "v"],  ["Pets", "4", "v"],  ["Massas", "5", "v"],    ["Free", "5", "v"],        ["Carnes", "5", "v"],      ["Congelados", "6", "v"],  ["Free", "6", "v"],        ["Frios", "6", "v"] ],
  	[ ["Bebidas", "1", "v"],     ["Free", "0", "v"],    ["Free", "0", "v"],          ["Free", "0", "v"],      ["Free", "0", "v"],    ["Free", "0", "v"],         ["Free", "0", "v"],       ["Free", "0", "v"],  ["Free", "0", "v"],             ["Free", "0", "v"],      ["Free", "0", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "7", "v"],        ["Frioes", "7", "v"] ],
  	[ ["Bebidas", "1", "v"],     ["Free", "1", "v"],    ["Frutas", "1", "v"],        ["Frutas", "2", "v"],    ["Free", "2", "v"],    ["Frutas", "2", "v"],       ["Verduras", "3", "v"],   ["Free", "3", "v"],  ["Verduras", "3", "v"],         ["Verduras", "4", "v"],  ["Free", "4", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "7", "v"],        ["Carnes", "7", "v"] ],
  	[ ["Ovos", "1", "v"],        ["Free", "1", "v"],    ["Frutas", "1", "v"],        ["Frutas", "2", "v"],    ["Free", "2", "v"],    ["Frutas", "2", "v"],       ["Verduras", "3", "v"],   ["Free", "3", "v"],  ["Verduras", "3", "v"],         ["Verduras", "4", "v"],  ["Free", "4", "v"],  ["Free", "0", "v"],  ["Free", "5", "v"],      ["Laticinios", "5", "v"],  ["Embutidos", "6", "v"],   ["Free", "6", "v"],        ["Free", "7", "v"],        ["Carnes", "7", "v"] ],
  	[ ["Hortifruit", "1", "v"],  ["Free", "1", "v"],    ["Frutas", "1", "v"],        ["Frutas", "2", "v"],    ["Free", "2", "v"],    ["Frutas", "2", "v"],       ["Verduras", "3", "v"],   ["Free", "3", "v"],  ["Bebidas", "3", "v"],          ["Carnes", "4", "v"],    ["Free", "4", "v"],  ["Free", "0", "v"],  ["Free", "5", "v"],      ["Carnes", "5", "v"],      ["Bebidas", "6", "v"],     ["Free", "6", "v"],        ["Free", "7", "v"],        ["Carnes", "7", "v"] ],
  	[ ["Hortifruit", "1", "v"],  ["Free", "1", "v"],    ["Frutas", "1", "v"],        ["Frutas", "2", "v"],    ["Free", "2", "v"],    ["Frutas", "2", "v"],       ["Verduras", "3", "v"],   ["Free", "3", "v"],  ["Bebidas", "3", "v"],          ["Carnes", "4", "v"],    ["Free", "4", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "0", "v"],        ["Free", "7", "v"],        ["Carnes", "7", "v"] ],
  	[ ["Hortifruit", "1", "v"],  ["Free", "1", "v"],    ["Free", "1", "h"],          ["Free", "2", "v"],      ["Free", "2", "v"],    ["Free", "0", "v"],         ["Free", "0", "v"],       ["Free", "0", "v"],  ["Free", "0", "v"],             ["Free", "0", "v"],      ["Free", "0", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Free", "8", "h"],        ["Free", "8", "h"],        ["Free", "8", "h"],        ["Free", "8", "h"],        ["Carnes", "8", "v"] ],
  	[ ["Wall", "1", "h"],        ["Padaria", "1", "h"], ["Padaria", "1", "h"],       ["Padaria", "2", "h"],   ["Padaria", "2", "h"], ["Free", "0", "v"],         ["Free", "0", "v"],       ["Free", "0", "v"],  ["Free", "0", "v"],             ["Free", "0", "v"],      ["Free", "0", "v"],  ["Free", "0", "v"],  ["Free", "0", "v"],      ["Frigorifico", "8", "h"], ["Frigorifico", "8", "h"], ["Frigorifico", "8", "h"], ["Frigorifico", "8", "h"], ["Wall", "8", "v"] ]
    ]
}');

INSERT INTO stores (name, map) VALUES ('Tupan', 
'{
  "map":[
  	[ ["Arroz", "1", "v"], ["Feijão", "1", "v"], ["Macarrão", "1", "v"] ],
  	[ ["Arroz", "1", "v"], ["Feijão", "1", "v"], ["Macarrão", "1", "v"] ],
  	[ ["Arroz", "1", "v"], ["Feijão", "1", "v"], ["Macarrão", "1", "v"] ]
  ]
}');

INSERT INTO lists (name, list) VALUES ('Feira Arco Iris', '{ "list": ["4","18", "9"] }'); -- arco iris
INSERT INTO lists (name, list) VALUES ('Meio de semana', '{ "list": ["1","2","3","4","5","7","8"] }');
INSERT INTO lists (name, list) VALUES ('Fim de semana', '{ "list": ["15","9","11","13","3"] }');
INSERT INTO lists (name, list) VALUES ('Lista Bocal', '{ "list": ["16","10","8"] }');
INSERT INTO lists (name, list) VALUES ('Lista 1', '{ "list": ["1","2","7","17"] }');
INSERT INTO lists (name, list) VALUES ('Lista 2', '{ "list": ["4","8","2","3","16"] }');
INSERT INTO lists (name, list) VALUES ('list tatooed in reverse', '{ "list": ["1","3","6","15"] }');
INSERT INTO lists (name, list) VALUES ('lista melhor que stairway to heaven', '{ "list": ["17","16","15","4","2"] }');
INSERT INTO lists (name, list) VALUES ('lista predaco do meu coracao', '{ "list": ["1","2","7","17"] }');
INSERT INTO lists (name, list) VALUES ('lista que demora', '{ "list": ["1"] }');
INSERT INTO lists (name, list) VALUES ('List for those who live uptown', '{ "list": ["17"] }');
INSERT INTO lists (name, list) VALUES ('list for Johnny Marr', '{ "list": ["3","2","1","15","7","9"] }');
INSERT INTO lists (name, list) VALUES ('lista equalizavel', '{ "list": ["3","4","1","2","6","10","11"] }');
INSERT INTO lists (name, list) VALUES ('list for when london finally drown', '{ "list": ["10","12","13","14","15","17","1"] }');
INSERT INTO lists (name, list) VALUES ('list for after the house burn', '{ "list": ["11","5","6","7","8","9","10"] }');

INSERT INTO category_lists (name, list) VALUES ('Feira Arco Iris', '{ "list": ["12","1","6"] }');

INSERT INTO categories (name, description) VALUES ('Achocolatado', '');
INSERT INTO categories (name, description) VALUES ('Leite em pó', '');
INSERT INTO categories (name, description) VALUES ('Lã de Aço', '');
INSERT INTO categories (name, description) VALUES ('Cerveja', '');
INSERT INTO categories (name, description) VALUES ('Refrigerante', '');
INSERT INTO categories (name, description) VALUES ('Doce', '');
INSERT INTO categories (name, description) VALUES ('Chocolate', '');
INSERT INTO categories (name, description) VALUES ('Enlatado', '');
INSERT INTO categories (name, description) VALUES ('Condimentos', '');
INSERT INTO categories (name, description) VALUES ('Salgadinho', '');
INSERT INTO categories (name, description) VALUES ('Chocolate em pó', '');
INSERT INTO categories (name, description) VALUES ('Higiene', '');

INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 1, 1);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 2, 1);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 3, 2);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 4, 3);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 5, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 6, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 7, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 8, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 9, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 10, 4);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 11, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 12, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 13, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 14, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 15, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 16, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 17, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 18, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 19, 5);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 20, 6);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 21, 6);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 22, 7);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 23, 7);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 24, 7);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 25, 7);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 26, 8);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 27, 8);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 28, 9);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 29, 9);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 30, 9);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 31, 9);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 32, 10);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 33, 10);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 34, 10);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 35, 10);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 36, 10);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 37, 11);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 38, 11);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 39, 12);
INSERT INTO product_category (store_id, product_id, category_id) VALUES (1, 40, 12);

INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 1, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 2, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (3, 3, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (2, 4, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (2, 5, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (4, 6, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (5, 7, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (6, 8, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (7, 9, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (8, 10, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (9, 11, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (10, 12, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (11, 13, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (12, 14, 1);
INSERT INTO user_lists (user_id, list_id, store_id) VALUES (12, 15, 1);

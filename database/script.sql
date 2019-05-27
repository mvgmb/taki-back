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


INSERT INTO products (name, description) VALUES ('Toddynho', 'Achocolatado delicioso');
INSERT INTO products (name, description) VALUES ('Nescau Achocolatado', 'Toddynho, so que de outra marca');
INSERT INTO products (name, description) VALUES ('Leite Moça', 'Um Leite Condensado famoso ai');
INSERT INTO products (name, description) VALUES ('Leite', 'De vaca'); -- arco iris
INSERT INTO products (name, description) VALUES ('Margarina', 'Dizem que e boa no pao');
INSERT INTO products (name, description) VALUES ('Manteiga', 'Dizem que e melhor que margarina');
INSERT INTO products (name, description) VALUES ('Iogurte', 'Gelado e bom');
INSERT INTO products (name, description) VALUES ('Queijo', 'Rima com vinho');
INSERT INTO products (name, description) VALUES ('Cerveja', 'Ahhhhhhh'); -- arco iris
INSERT INTO products (name, description) VALUES ('Vinho', 'Rima com queijo');
INSERT INTO products (name, description) VALUES ('Whiskey', 'Sem gelo porfavor');
INSERT INTO products (name, description) VALUES ('Vodka', 'Bons valores nutritivos');
INSERT INTO products (name, description) VALUES ('Cachaca', 'Uma ideia boa puxa outra');
INSERT INTO products (name, description) VALUES ('Frango', 'Cortado em bandeja');
INSERT INTO products (name, description) VALUES ('Alcatra', 'File bom de assar');
INSERT INTO products (name, description) VALUES ('Corvina', 'Peixe de couro pra cozinhar');
INSERT INTO products (name, description) VALUES ('Camarao', 'Pra assar, alho e oleo');
INSERT INTO products (name, description) VALUES ('Oreo', 'Equivalente a ostentacao, so que em forma de biscoito'); -- arco iris

INSERT INTO stores (name, map) VALUES ('Ferreira Costa', 
'{
  "map":[
  	[ ["Achocolatado", "1", "h"], ["Free", "1", "h"], ["Leite Condensado", "1", "h"] ],
  	[ ["Achocolatado", "1", "h"], ["Free", "1", "h"], ["Leite Condensado", "1", "h"] ],
  	[ ["Achocolatado", "1", "h"], ["Free", "1", "h"], ["Leite Condensado", "1", "h"] ]
  ]
}');
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

INSERT INTO product_category (store_id, product_id, category) VALUES (1, 1, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 2, 'Achocolatado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 3, 'Leite Condensado');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 4, 'Laticinios');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 5, 'Laticinios');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 6, 'Laticinios');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 7, 'Laticinios');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 8, 'Laticinios');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 9, 'Bebidas Alcoolicas');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 10, 'Bebidas Alcoolicas');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 11, 'Bebidas Alcoolicas');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 12, 'Bebidas Alcoolicas');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 13, 'Bebidas Alcoolicas');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 14, 'Carnes e Peixes');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 15, 'Carnes e Peixes');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 16, 'Carnes e Peixes');
INSERT INTO product_category (store_id, product_id, category) VALUES (1, 17, 'Carnes e Peixes');
INSERT INTO product_category (store_id, product_id, category) VALUES (2, 4, 'Leites'); -- arco iris
INSERT INTO product_category (store_id, product_id, category) VALUES (2, 18, 'Biscoitos'); -- arco iris
INSERT INTO product_category (store_id, product_id, category) VALUES (2, 9, 'Bebidas'); -- arco iris

INSERT INTO user_lists (user_id, list_id, store_id) VALUES (1, 1, 2); -- arco iris
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

SELECT USER();
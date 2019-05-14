-- This script will be executed once the db is up

-- Dummy test
CREATE TABLE users (
    user_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name TEXT,
    phone_number TEXT
);

INSERT INTO users (name, phone_number) VALUES ('maria', '1234');
INSERT INTO users (name, phone_number) VALUES ('josue', '5678');
INSERT INTO users (name, phone_number) VALUES ('fernando', '9101');
CREATE DATABASE app_todo;

USE app_todo;

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255),
    email VARCHAR(255) UNIQUE NOT NULL, 
    password VARCHAR(255)
);

CREATE TABLE todos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    completed BOOLEAN DEFAULT false, 
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

CREATE TABLE shared_todos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  todo_id INT,
  user_id INT,
  shared_with_id INT,
  FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
);

INSERT INTO users (name, email, password) VALUES ('Magui', 'magui@gmail.com', '1234abcd')
INSERT INTO users (name, email, password) VALUES ('Json', 'jota@gmail.com', '0303456')

INSERT INTO todos (title, user_id) 
VALUES 
("🏃‍♀️ Salir a correr 🌄", 1),
("💻 Hacer la presentación 💼", 1),
("🛒 Ir al supermercado 🛍️", 1),
("📚 Leer 30 páginas del libro 📖", 1),
("🚴‍♂️ Salir a andar en bicicleta 🌳", 1),
("🍲 Comer con la familia 🍴", 1),
("💆‍♂️ Hacer yoga 🧘‍♂️", 1),
("🎧 Escuchar un podcast 🎤", 1),
("🧹 Limpiar la casa 🧼", 1),
("🛌 Dormir 8 horas 💤", 1);

INSERT INTO shared_todos (todo_id, user_id, shared_with_id) VALUES (1, 1, 2);

SELECT todos.*, shared_todos.shared_with_id
FROM todos
LEFT JOIN shared_todos ON todos.id = shared_todos.todo_id
WHERE todos.user_id = [user_id] OR shared_todos.shared_with_id = [user_id];



SELECT todos.* 
FROM todos 
JOIN shared_todos ON todos.id = shared_todos.todo_id 
WHERE shared_todos.user_id = 2;
/*reate a database named "library"*/
CREATE DATABASE  library;

USE library;
/* Create a table named "books" with columns for id, title, author, and genre*/
CREATE TABLE IF NOT EXISTS books (
id INT NOT NULL AUTO_INCREMENT,
title VARCHAR(255) NOT NULL,
author VARCHAR(255) NOT NULL,
genre VARCHAR(255) NOT NULL,
PRIMARY KEY (id)
);
 /*sert data into the "books" table */
INSERT INTO books (title, author, genre) VALUES
('The Lord of the Rings', 'J.R.R. Tolkien', 'Fantasy'),
('Harry Potter and the Philosopher''s Stone', 'J.K. Rowling', 'Fantasy'),
('The Shining', 'Stephen King', 'Horror'),
('The Raven', 'Edgar Allan Poe', 'Horror'),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Philosophical novel'),
('Eugene Onegin', 'Alexander Pushkin', 'Novel in verse'),
('The Picture of Dorian Gray', 'Oscar Wilde', 'Gothic fiction'),
('Songs of Innocence and of Experience', 'William Blake', 'Poetry'),
('Hamlet', 'William Shakespeare', 'Tragedy'),
('Pride and Prejudice', 'Jane Austen', 'Romantic novel');

/*create table users with columns for id, name, email, and phone */
CREATE TABLE users (
id INT NOT NULL AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL,
phone VARCHAR(20),
PRIMARY KEY (id)
);

/* Insert  data into the "users" table */ 
INSERT INTO users (name, email, phone) VALUES
('John Smith', 'john.smith@examplemail.com', '555-1234'),
('Clark Kent', 'clark.kent@fakemail.com', '555-5678'),
('Richard Dawkins', 'richard.dawkins@anyemail.com', '555-9101'),
('Gillian Edwards', 'gillian.edwards@example.com', '555-2345'),
('Kate Kombs', 'kate.kombs@example.com', '555-6789');

/*table named loaned_books with columns for id, book_id, user_id, loan_date, and return_date */
CREATE TABLE  loaned_books (
id INT NOT NULL AUTO_INCREMENT,
book_id INT NOT NULL,
user_id INT NOT NULL,
loan_date DATE NOT NULL,
return_date DATE,
PRIMARY KEY (id),
FOREIGN KEY (book_id) REFERENCES books(id),
FOREIGN KEY (user_id) REFERENCES users(id)
);

/*Insert data into the loaned_books table : book_id, user_id, loan_date, return_date */
INSERT INTO loaned_books (book_id, user_id, loan_date, return_date) VALUES
(1, 1, '2022-02-01', '2022-03-01'),
(2, 2, '2022-02-15', '2022-03-15'),
(3, 3, '2022-02-28', NULL),
(4, 4, '2022-03-01', '2022-03-15'),
(5, 1, '2022-03-05', NULL),
(6, 2, '2022-03-10', '2022-03-17'),
(7, 3, '2022-03-12', NULL),
(8, 4, '2022-03-15', NULL),
(9, 5, '2022-03-22', NULL);

/*Set the delimiter to '$$' to allow for stored procedures to be created */
DELIMITER $$

CREATE PROCEDURE find_overdue_books()
BEGIN
SELECT books.title, users.name, loaned_books.loan_date, loaned_books.return_date
FROM loaned_books
JOIN books ON loaned_books.book_id = books.id
JOIN users ON loaned_books.user_id = users.id
WHERE return_date < CURDATE();
END$$

/* Reset delimiter back to semicolon */
DELIMITER ;

SELECT users.name, user_contacts.contact_name
FROM users
LEFT JOIN user_contacts
ON users.id = user_contacts.user_id
WHERE users.id = 1
ORDER BY user_contacts.contact_name ASC;

/*Set the delimiter to '$$' to allow for stored procedures to be created */
DELIMITER $$

/*This procedure retrieves users by age from the users and addresses tables, filtered by age range */
CREATE PROCEDURE get_users_by_age(IN min_age INT, IN max_age INT)
BEGIN
SELECT users.name, users.age, addresses.city
FROM users
JOIN addresses ON users.id = addresses.user_id
WHERE users.age BETWEEN min_age AND max_age;
END $$

/* Reset delimiter back to semicolon */
DELIMITER ;

/*This statement calls the previously created stored procedure with specified arguments. */
CALL get_users_by_age(18, 30);
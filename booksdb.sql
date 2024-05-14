DROP DATABASE IF EXISTS booksdb;

-- Crear la base de datos
CREATE DATABASE booksdb;

-- Seleccionar la base de datos
USE booksdb;

-- Verificar y eliminar la tabla 'page' si existe
DROP TABLE IF EXISTS page;

-- Verificar y eliminar la tabla 'book' si existe
DROP TABLE IF EXISTS book;

-- Crear la tabla 'book'
CREATE TABLE book (
    book_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    author VARCHAR(255) NOT NULL,
    image_url TEXT
);

-- Crear la tabla 'page'
CREATE TABLE page (
    page_id INT AUTO_INCREMENT PRIMARY KEY,
    book_id INT,
    page_number INT NOT NULL,
    content LONGTEXT,
    FOREIGN KEY (book_id) REFERENCES book(book_id)
);

-- Insertar datos de prueba en la tabla 'book'
INSERT INTO book (book_id, name, author, image_url) VALUES
  (1,'Harry Potter and the Sorcerer\'s Stone','J.K. Rowling','https://m.media-amazon.com/images/I/71HbYElfY0L._AC_UF1000,1000_QL80_.jpg'),
  (2,'Harry Potter and the Chamber of Secrets','J.K. Rowling','https://m.media-amazon.com/images/I/91OINeHnJGL._AC_UF8941000_QL80_.jpg'),
  (3,'Harry Potter and the Prisoner of Askaban','J.K. Rowling','https://m.media-amazon.com/images/I/81lAPl9Fl0L._AC_UF10001000_QL80_.jpg'),
  (4,'Harry Potter and the Goblet of Fire','J.K. Rowling','https://m.media-amazon.com/images/I/71ykU-RQ0nL.jpg'),
  (5,'Harry Potter and the Order of the Phoenix','J.K. Rowling','https://m.media-amazon.com/images/I/51XDBEZFD1L._AC_UF8941000_QL80_.jpg'),
  (6,'Harry Potter and the Half Blood Prince','J.K. Rowling','https://m.media-amazon.com/images/I/61sXBXmAWML._AC_UF10001000_QL80_.jpg'),
  (7,'Harry Potter and the Deathly Hallows','J.K. Rowling','https://media.harrypotterfanzone.com/deathly-hallows-us-childrens-edition.jpg');

-- Insertar datos de prueba en la tabla 'page'
INSERT INTO page (page_id, book_id, page_number, content) VALUES
(9,1,1,'Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they were perfectly normal, thank you very much. They were the last people you’d expect to be involved in anything strange or mysterious, because they just didn’t hold with such nonsense.'),
(10,1,2,'Contenido de la pagina 2'),
(11,1,3,'Contenido de la pagina 3'),
(12,2,1,'LIBRO 2: Mr. and Mrs. Dursley, of number four, Privet Drive, were proud to say that they were perfectly normal, thank you very much. They were the last people you’d expect to be involved in anything strange or mysterious, because they just didn’t hold with such nonsense.'),
(13,2,2,'Contenido pagina 2'),
(14,2,3,'Contenido pagina 3');

DROP PROCEDURE IF EXISTS GetAllBooks;

-- Stored Procedure para buscar todos los libros
DELIMITER //
CREATE PROCEDURE GetAllBooks()
BEGIN
    SELECT * FROM book;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS GetBookById;

-- Stored Procedure para buscar un libro por ID
DELIMITER //
CREATE PROCEDURE GetBookById(IN bookId INT)
BEGIN
    SELECT * FROM book WHERE book_id = bookId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS InsertBook;

-- Stored Procedure para insertar un nuevo libro
DELIMITER //
CREATE PROCEDURE InsertBook(IN bookName VARCHAR(255), IN bookAuthor VARCHAR(255), IN bookImageUrl TEXT)
BEGIN
    INSERT INTO book (name, author, image_url) VALUES (bookName, bookAuthor, bookImageUrl);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdateBook;

-- Stored Procedure para editar un libro por ID
DELIMITER //
CREATE PROCEDURE UpdateBook(IN bookId INT, IN bookName VARCHAR(255), IN bookAuthor VARCHAR(255), IN bookImageUrl TEXT)
BEGIN
    UPDATE book SET name = bookName, author = bookAuthor, image_url = bookImageUrl WHERE book_id = bookId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS DeleteBook;

-- Stored Procedure para borrar un libro por ID y todas sus páginas asociadas
DELIMITER //
CREATE PROCEDURE DeleteBook(IN bookId INT)
BEGIN
    DELETE FROM page WHERE book_id = bookId;
    DELETE FROM book WHERE book_id = bookId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS GetAllPages;

-- Stored Procedure para buscar todas las páginas
DELIMITER //
CREATE PROCEDURE GetAllPages()
BEGIN
    SELECT * FROM page;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS GetPageById;

-- Stored Procedure para buscar una página por ID
DELIMITER //
CREATE PROCEDURE GetPageById(IN pageId INT)
BEGIN
    SELECT * FROM page WHERE page_id = pageId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS GetPagesByBookId;

-- Stored Procedure para buscar todas las páginas por book_id
DELIMITER //
CREATE PROCEDURE GetPagesByBookId(IN bookId INT)
BEGIN
    SELECT * FROM page WHERE book_id = bookId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS InsertPage;

-- Stored Procedure para insertar una nueva página
DELIMITER //
CREATE PROCEDURE InsertPage(IN bookId INT, IN pageNumber INT, IN pageContent LONGTEXT)
BEGIN
    INSERT INTO page (book_id, page_number, content) VALUES (bookId, pageNumber, pageContent);
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS UpdatePage;

-- Stored Procedure para editar una página por ID
DELIMITER //
CREATE PROCEDURE UpdatePage(IN pageId INT, IN bookId INT, IN pageNumber INT, IN pageContent LONGTEXT)
BEGIN
    UPDATE page SET book_id = bookId, page_number = pageNumber, content = pageContent WHERE page_id = pageId;
END //
DELIMITER ;

DROP PROCEDURE IF EXISTS DeletePage;

-- Stored Procedure para borrar una página por ID
DELIMITER //
CREATE PROCEDURE DeletePage(IN pageId INT)
BEGIN
    DELETE FROM page WHERE page_id = pageId;
END //
DELIMITER ;


CALL GetAllBooks();

CALL GetBookById(1);

CALL InsertBook('Solo Leveling I', 'Chugong', 'https://m.media-amazon.com/images/I/91X6rx1HX5L._AC_UF1000,1000_QL80_.jpg');

CALL UpdateBook(1, 'Solo Leveling I', 'Chu-Gong', 'https://example.com/updated-image.jpg');

CALL DeleteBook(1);

CALL GetAllPages();

CALL GetPageById(12);

CALL GetPagesByBookId(2);

CALL InsertPage(2, 1, 'una nueva era ha llegado');

CALL UpdatePage(1, 2, 15, 'una nueva era ha llegado para los cazadores');

CALL DeletePage(12);

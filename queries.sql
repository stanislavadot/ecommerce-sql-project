SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM order_items;


--Kupci sortirani po gradu
SELECT id, first_name, last_name, city FROM customers
ORDER BY city;

--Kupci cije ime pocinje na A
SELECT first_name, last_name, email FROM customers 
WHERE first_name LIKE 'A%';

--Svi proizvodi sortirani po ceni
SELECT * FROM products ORDER BY price DESC;

--Svi proizvodi skuplje od 300
SELECT id, name, price FROM products WHERE price > 300;

--Sve porudzbine sortirane po datumu
SELECT id, order_date FROM orders ORDER BY order_date DESC;

--Ukupan broj porudzbina po kupcu
SELECT customer_id, COUNT(*) AS broj_porudzbina 
FROM orders GROUP BY customer_id ORDER BY broj_porudzbina DESC;

--Proizvodi koji kostaju vise od 100
SELECT name, price FROM products WHERE price > 100 ORDER BY price DESC;

--Prikaz porudzbina sa imenom kupca
SELECT customers.first_name, customers.last_name, COUNT(orders.id) AS broj_porudzbina FROM orders
JOIN customers ON orders.customer_id=customers.id GROUP BY customers.first_name, customers.last_name;

--Koji proizvodi su naručeni u kojoj porudžbini
SELECT orders.id AS porudzbina, products.name AS proizvod, order_items.quantity FROM order_items 
JOIN orders ON orders.id = order_items.order_id
JOIN products ON products.id = order_items.product_id
ORDER BY orders.id;

--Ukupna vrednost svake porudzbine
SELECT orders.id, SUM(order_items.quantity * products.price) AS ukupna_vrednost
FROM orders
JOIN order_items ON orders.id=order_items.order_id
JOIN products ON products.id = order_items.product_id
GROUP BY orders.id ORDER BY ukupna_vrednost DESC; 

--Top 5 kupaca po ukupnoj potrosnji
SELECT customers.id, customers.first_name, customers.last_name, SUM(order_items.quantity * products.price) AS ukupna_potrosnja
FROM customers
JOIN orders ON customers.id = orders.customer_id
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON products.id = order_items.product_id
GROUP BY customers.id, customers.first_name, customers.last_name
ORDER BY ukupna_potrosnja DESC
LIMIT 5;

--Koji proizvod se najviše prodaje po kolicini
SELECT products.name, SUM (order_items.quantity) AS ukupna_kolicina FROM products
JOIN order_items ON products.id = order_items.product_id
GROUP BY products.name
ORDER BY ukupna_kolicina DESC;

--Ukupan prihod po mesecu

SELECT EXTRACT (YEAR FROM orders.order_date) AS godina, EXTRACT (MONTH FROM orders.order_date) AS mesec, SUM (order_items.quantity * products.price) AS ukupan_prihod FROM orders
JOIN order_items ON orders.id = order_items.order_id
JOIN products ON products.id = order_items.product_id
GROUP BY godina, mesec
ORDER BY mesec;


--Kupci koji su narucili vise od 3 puta (kandidati za newsletter)
SELECT customers.id, customers.first_name, customers.last_name, customers.email FROM customers 
JOIN orders ON customers.id = orders.customer_id
GROUP BY customers.id, customers.first_name, customers.last_name, customers.email
HAVING COUNT(orders.id) > 3
ORDER BY customers.id;

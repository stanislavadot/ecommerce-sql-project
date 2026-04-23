# E-Commerce SQL Project

## Opis projekta
Baza podataka za e-commerce platformu kreirana u PostgreSQL-u. 
Podaci su generisani pomoću Mockaroo-a.

## Tabele
- **customers** - informacije o kupcima (100 redova)
- **products** - katalog proizvoda (50 redova)
- **orders** - porudžbine (500 redova)
- **order_items** - stavke porudžbina (1000 redova)

## Tehnologije
- PostgreSQL
- Mockaroo (generisanje podataka)
- VS Code

## Upiti
- Filtriranje i sortiranje podataka
- JOIN upiti između više tabela
- Agregacije (SUM, COUNT)
- GROUP BY i HAVING
- Analiza prodaje po mesecu i godini

## Kako pokrenuti
1. Kreirati bazu: `CREATE DATABASE ecommerce_db;`
2. Pokrenuti fajlove iz `/data` foldera redom:
   - `customers.sql`
   - `products.sql`
   - `orders.sql`
   - `order_items.sql`
3. Pokrenuti `queries.sql`

## Napomene
- Podaci su generisani preko Mockaroo-a pa čišćenje nije bilo potrebno 
  (nema NULL vrednosti ni duplikata)
- LEFT JOIN bi vratio i kupce koji nemaju nijednu porudžbinu, ali pošto su svi podaci popunjeni rezultat je isti kao    INNER JOIN

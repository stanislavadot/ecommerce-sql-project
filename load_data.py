import psycopg2
import pandas as pd

# Konekcija na bazu
# ETL Pipeline:
# Extract  - citanje CSV fajlova generisanih u Mockaroo
# Transform - pandas ucitava i prikazuje podatke
# Load     - ubacivanje u PostgreSQL bazu
conn = psycopg2.connect(
    host="localhost",
    database="ecommerce_db",
    user="postgres"
)

print("Konekcija uspesna!")

# Citanje CSV fajlova
df_customers = pd.read_csv('data/customers.csv')
df_products = pd.read_csv('data/products.csv')
df_orders = pd.read_csv('data/orders.csv')
df_order_items = pd.read_csv('data/order_items.csv')

print("CSV fajlovi ucitani!")
print(df_customers.head())

# Ubacivanje u bazu
cursor = conn.cursor()

for index, row in df_customers.iterrows():
    cursor.execute("""
        INSERT INTO customers (id, first_name, last_name, email, city)
        VALUES (%s, %s, %s, %s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (row['id'], row['first_name'], row['last_name'], row['email'], row['city']))

conn.commit()
print("Customers ubaceni u bazu!")

# Products
for index, row in df_products.iterrows():
    cursor.execute("""
        INSERT INTO products (id, name, price)
        VALUES (%s, %s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (row['id'], row['name'], row['price']))

conn.commit()
print("Products ubaceni u bazu!")

# Orders
for index, row in df_orders.iterrows():
    cursor.execute("""
        INSERT INTO orders (id, customer_id, order_date)
        VALUES (%s, %s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (row['id'], row['customer_id'], row['order_date']))

conn.commit()
print("Orders ubaceni u bazu!")

# Order items
for index, row in df_order_items.iterrows():
    cursor.execute("""
        INSERT INTO order_items (id, order_id, product_id, quantity)
        VALUES (%s, %s, %s, %s)
        ON CONFLICT (id) DO NOTHING;
    """, (int(row['id']), int(row['order_id']), int(row['product_id']), int(row['quantity'])))

conn.commit()
print("Order items ubaceni u bazu!")

cursor.close()
conn.close()

conn.close()


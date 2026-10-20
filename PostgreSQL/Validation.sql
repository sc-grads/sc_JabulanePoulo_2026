CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40),
    department VARCHAR(40),
    price INTEGER,
    weight INTEGER
);
select * from products
INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'clothes', 20, 1);

INSERT INTO products (name, department, weight)
VALUES ('pants', 'clothes', 3);

UPDATE products
SET price = 999
WHERE price IS NULL;


ALTER TABLE products
ALTER COLUMN price SET NOT NULL;

INSERT INTO products (name, department, weight)
VALUES ('shoes', 'clothes', 5);

ALTER TABLE products
ALTER COLUMN price SET DEFAULT 9999;

INSERT INTO products (name, department, weight)
VALUES ('gloves', 'tools', 1);


ALTER TABLE products
ADD UNIQUE (name, department);

INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'housewares', 24, 1);

INSERT INTO products (name, department, price, weight)
VALUES ('shirt', 'clothes', 24, 1);

ALTER TABLE products
ADD CHECK (price > 0);


INSERT INTO products (name, department, price, weight)
VALUES ('belt', 'housewares', -99, 1);


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    created_at TIMESTAMP NOT NULL,
    estimated_delivery TIMESTAMP NOT NULL,
    CHECK (created_at < estimated_delivery)
);

INSERT INTO orders (name, created_at, estimated_delivery)
VALUES ('shirt', '2000-11-20 01:00:00', '2000-11-25 01:00:00');


INSERT INTO orders (name, created_at, estimated_delivery)
VALUES ('shirt', '2000-11-20 01:00:00', '2000-11-10 01:00:00');
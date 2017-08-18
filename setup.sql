DROP DATABASE IF EXISTS vendordb;
CREATE DATABASE vendordb;

\c vendordb

CREATE TABLE machine(
  machine_id SERIAL PRIMARY KEY,
  name TEXT,
  bank INTEGER
);


CREATE TABLE item(
  item_id SERIAL PRIMARY KEY,
  description TEXT,
  cost FLOAT,
  quantity INTEGER,
  machine_id INTEGER REFERENCES machine
);

CREATE TABLE purchase(
  purchase_id SERIAL PRIMARY KEY,
  purchase_time TIMESTAMPTZ,
  amount_taken FLOAT,
  change_given FLOAT,
  machine_id INTEGER REFERENCES machine,
  item_id INTEGER REFERENCES item
);

INSERT INTO machine(name, bank)
VALUES('Snack Time', 500),
('Munchies', 500),
('Beer Time', 500);

INSERT INTO item(description, cost, quantity, machine_id)
VALUES ('Milky Way', 2.00, 10, (SELECT machine_id FROM machine WHERE name='Snack Time')),
('Butterfinger', 2.00, 20, (SELECT machine_id FROM machine WHERE name='Snack Time')),
('Cow Tail', 1.00, 40, (SELECT machine_id FROM machine WHERE name='Snack Time')),
('Charleston Chew', 1.00, 10, (SELECT machine_id FROM machine WHERE name='Snack Time')),
('Doritos Cool Ranch', 4.00, 10, (SELECT machine_id FROM machine WHERE name='Munchies')),
('Kettle Chips', 4.00, 10, (SELECT machine_id FROM machine WHERE name='Munchies')),
('Cookies', 2.50, 30, (SELECT machine_id FROM machine WHERE name='Munchies')),
('Corn Chips', 4.00, 20, (SELECT machine_id FROM machine WHERE name='Munchies')),
('Sapporo', 3.00, 40, (SELECT machine_id FROM machine WHERE name='Beer Time')),
('Blue Moon', 4.00, 20, (SELECT machine_id FROM machine WHERE name='Beer Time')),
('Guiness', 4.00, 40, (SELECT machine_id FROM machine WHERE name='Beer Time')),
('Duff', 2.00, 4, (SELECT machine_id FROM machine WHERE name='Beer Time'));

INSERT INTO purchase(purchase_time, amount_taken, machine_id, item_id)
VALUES
('now', 20.00,(SELECT machine_id FROM machine WHERE name = 'Beer Time'), (SELECT item_id FROM item WHERE description ='Sapporo'));


select * from machine;
select * from item;
select * from purchase;

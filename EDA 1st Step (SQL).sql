CREATE TABLE Inventory (
    material_id VARCHAR,
    material_description VARCHAR,
    plant_code VARCHAR,
    storage_location VARCHAR,
    movement_type VARCHAR,
    material_document VARCHAR,
    material_doc_item VARCHAR,
    posting_date varchar,
    qty_in_un_of_entry varchar,
    unit_of_entry VARCHAR,
    batch VARCHAR,
    "order" VARCHAR,
    reference VARCHAR,
    movement_type_text VARCHAR,
    document_date varchar,
    qty_in_opun varchar,
    order_price_unit VARCHAR,
    order_unit VARCHAR,
    qty_in_order_unit varchar,
    company_code VARCHAR,
    entry_date varchar,
    time_of_entry varchar,
    amount_in_lc varchar,
    purchase_order VARCHAR,
    item VARCHAR,
    reason_for_movement VARCHAR,
    cost_center VARCHAR,
    movement_indicator VARCHAR,
    consumption VARCHAR,
    receipt_indicator VARCHAR,
    supplier VARCHAR,
    base_unit_of_measure VARCHAR,
    quantity varchar,
    material_doc_year varchar,
    reservation VARCHAR,
    item_no_stock_transfer_reserv VARCHAR,
    debit_credit_ind VARCHAR,
    user_name VARCHAR,
    trans_event_type VARCHAR,
    currency VARCHAR,
    item_automatically_created varchar,
    product_code VARCHAR,
    product_description VARCHAR,
    material_type VARCHAR,
    vendor_code VARCHAR
);
drop table inventory;

copy Inventory(
    material_id, 
    material_description, 
    plant_code, 
    storage_location, 
    movement_type, 
    material_document, 
    material_doc_item, 
    posting_date, 
    qty_in_un_of_entry, 
    unit_of_entry, 
    batch, 
    "order", 
    reference, 
    movement_type_text, 
    document_date, 
    qty_in_opun, 
    order_price_unit, 
    order_unit, 
    qty_in_order_unit, 
    company_code, 
    entry_date, 
    time_of_entry, 
    amount_in_lc, 
    purchase_order, 
    item, 
    reason_for_movement, 
    cost_center, 
    movement_indicator, 
    consumption, 
    receipt_indicator, 
    supplier, 
    base_unit_of_measure, 
    quantity, 
    material_doc_year, 
    reservation, 
    item_no_stock_transfer_reserv, 
    debit_credit_ind, 
    user_name, 
    trans_event_type, 
    currency, 
    item_automatically_created, 
    product_code, 
    product_description, 
    material_type, 
    vendor_code
) 
FROM 'C:\\Users\\HP\\Documents\\Pharmaceuticals Inventory Management\\Cleaned_Dataset.csv' 
DELIMITER ',' 
CSV HEADER
ENCODING 'UTF8';

select * from inventory;
CREATE TABLE Inventory_backup AS TABLE Inventory;

/* ALter Table To Integer Datatypes */

ALTER TABLE Inventory
 ALTER COLUMN material_id TYPE INTEGER USING material_id::INTEGER;
 ALTER COLUMN plant_code TYPE INTEGER USING plant_code::INTEGER,
 ALTER COLUMN movement_type TYPE INTEGER USING movement_type::INTEGER,
 ALTER COLUMN company_code TYPE INTEGER USING company_code::INTEGER,
 ALTER COLUMN item TYPE INTEGER USING item::INTEGER,
 ALTER COLUMN reason_for_movement TYPE INTEGER USING reason_for_movement::INTEGER,
 ALTER COLUMN supplier TYPE INTEGER USING supplier::INTEGER,
 ALTER COLUMN material_doc_year TYPE INTEGER USING material_doc_year::INTEGER,
 ALTER COLUMN item_no_stock_transfer_reserv TYPE INTEGER USING item_no_stock_transfer_reserv::INTEGER,
 ALTER COLUMN vendor_code TYPE INTEGER USING vendor_code::INTEGER;

/* ALter Table To Biginteger Datatypes */

ALTER TABLE Inventory
    ALTER COLUMN material_document TYPE BIGINT USING material_document::BIGINT;

ALTER TABLE Inventory
    ALTER COLUMN batch TYPE BIGINT USING batch::BIGINT;

ALTER TABLE Inventory
    ALTER COLUMN "order" TYPE BIGINT USING "order"::BIGINT;

ALTER TABLE Inventory
    ALTER COLUMN purchase_order TYPE BIGINT USING purchase_order::BIGINT;

ALTER TABLE Inventory
    ALTER COLUMN cost_center TYPE BIGINT USING cost_center::BIGINT;

ALTER TABLE Inventory
    ALTER COLUMN product_code TYPE BIGINT USING product_code::BIGINT;

/* Change Datatype To Date And Time */
ALTER TABLE Inventory
ALTER COLUMN posting_date TYPE DATE USING TO_DATE(posting_date, 'DD/MM/YYYY');

ALTER TABLE Inventory
ALTER COLUMN document_date TYPE DATE USING TO_DATE(document_date, 'DD/MM/YYYY');

ALTER TABLE Inventory
ALTER COLUMN entry_date TYPE DATE USING TO_DATE(entry_date, 'DD/MM/YYYY');

ALTER TABLE Inventory
ALTER COLUMN time_of_entry TYPE TIME USING TO_TIMESTAMP(time_of_entry, 'HH24:MI:SS')::TIME;

/* Change Datatype to Double Precision */
UPDATE Inventory
SET qty_in_un_of_entry = REPLACE(qty_in_un_of_entry, ',', '')::FLOAT;

ALTER TABLE Inventory
ALTER COLUMN qty_in_un_of_entry TYPE DOUBLE PRECISION USING qty_in_un_of_entry::DOUBLE PRECISION;

UPDATE Inventory
SET qty_in_opun = REPLACE(qty_in_opun, ',', '')::FLOAT;

ALTER TABLE Inventory
ALTER COLUMN qty_in_opun TYPE DOUBLE PRECISION USING qty_in_opun::DOUBLE PRECISION;

UPDATE Inventory
SET qty_in_order_unit = REPLACE(qty_in_order_unit, ',', '')::FLOAT;

ALTER TABLE Inventory
ALTER COLUMN qty_in_order_unit TYPE DOUBLE PRECISION USING qty_in_order_unit::DOUBLE PRECISION;

UPDATE Inventory
SET amount_in_lc = REPLACE(amount_in_lc, ',', '')::FLOAT;

ALTER TABLE Inventory
ALTER COLUMN amount_in_lc TYPE DOUBLE PRECISION USING amount_in_lc::DOUBLE PRECISION;

UPDATE Inventory
SET quantity = REPLACE(quantity, ',', '')::FLOAT;

ALTER TABLE Inventory
ALTER COLUMN quantity TYPE DOUBLE PRECISION USING quantity::DOUBLE PRECISION;


/* Missing Values Count Of Each Column */
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) FILTER (WHERE material_id IS NULL) AS missing_material_id,
    COUNT(*) FILTER (WHERE material_description IS NULL) AS missing_material_description,
    COUNT(*) FILTER (WHERE plant_code IS NULL) AS missing_plant_code,
    COUNT(*) FILTER (WHERE storage_location IS NULL) AS missing_storage_location,
    COUNT(*) FILTER (WHERE movement_type IS NULL) AS missing_movement_type,
    COUNT(*) FILTER (WHERE material_document IS NULL) AS missing_material_document,
    COUNT(*) FILTER (WHERE material_doc_item IS NULL) AS missing_material_doc_item,
    COUNT(*) FILTER (WHERE posting_date IS NULL) AS missing_posting_date,
    COUNT(*) FILTER (WHERE qty_in_un_of_entry IS NULL) AS missing_qty_in_un_of_entry,
    COUNT(*) FILTER (WHERE unit_of_entry IS NULL) AS missing_unit_of_entry,
    COUNT(*) FILTER (WHERE batch IS NULL) AS missing_batch,
    COUNT(*) FILTER (WHERE "order" IS NULL) AS missing_order,
    COUNT(*) FILTER (WHERE reference IS NULL) AS missing_reference,
    COUNT(*) FILTER (WHERE movement_type_text IS NULL) AS missing_movement_type_text,
    COUNT(*) FILTER (WHERE document_date IS NULL) AS missing_document_date,
    COUNT(*) FILTER (WHERE qty_in_opun IS NULL) AS missing_qty_in_opun,
    COUNT(*) FILTER (WHERE order_price_unit IS NULL) AS missing_order_price_unit,
    COUNT(*) FILTER (WHERE order_unit IS NULL) AS missing_order_unit,
    COUNT(*) FILTER (WHERE qty_in_order_unit IS NULL) AS missing_qty_in_order_unit,
    COUNT(*) FILTER (WHERE company_code IS NULL) AS missing_company_code,
    COUNT(*) FILTER (WHERE entry_date IS NULL) AS missing_entry_date,
    COUNT(*) FILTER (WHERE time_of_entry IS NULL) AS missing_time_of_entry,
    COUNT(*) FILTER (WHERE amount_in_lc IS NULL) AS missing_amount_in_lc,
    COUNT(*) FILTER (WHERE purchase_order IS NULL) AS missing_purchase_order,
    COUNT(*) FILTER (WHERE item IS NULL) AS missing_item,
    COUNT(*) FILTER (WHERE reason_for_movement IS NULL) AS missing_reason_for_movement,
    COUNT(*) FILTER (WHERE cost_center IS NULL) AS missing_cost_center,
    COUNT(*) FILTER (WHERE movement_indicator IS NULL) AS missing_movement_indicator,
    COUNT(*) FILTER (WHERE consumption IS NULL) AS missing_consumption,
    COUNT(*) FILTER (WHERE receipt_indicator IS NULL) AS missing_receipt_indicator,
    COUNT(*) FILTER (WHERE supplier IS NULL) AS missing_supplier,
    COUNT(*) FILTER (WHERE base_unit_of_measure IS NULL) AS missing_base_unit_of_measure,
    COUNT(*) FILTER (WHERE quantity IS NULL) AS missing_quantity,
    COUNT(*) FILTER (WHERE material_doc_year IS NULL) AS missing_material_doc_year,
    COUNT(*) FILTER (WHERE reservation IS NULL) AS missing_reservation,
    COUNT(*) FILTER (WHERE item_no_stock_transfer_reserv IS NULL) AS missing_item_no_stock_transfer_reserv,
    COUNT(*) FILTER (WHERE debit_credit_ind IS NULL) AS missing_debit_credit_ind,
    COUNT(*) FILTER (WHERE user_name IS NULL) AS missing_user_name,
    COUNT(*) FILTER (WHERE trans_event_type IS NULL) AS missing_trans_event_type,
    COUNT(*) FILTER (WHERE currency IS NULL) AS missing_currency,
    COUNT(*) FILTER (WHERE item_automatically_created IS NULL) AS missing_item_automatically_created,
    COUNT(*) FILTER (WHERE product_code IS NULL) AS missing_product_code,
    COUNT(*) FILTER (WHERE product_description IS NULL) AS missing_product_description,
    COUNT(*) FILTER (WHERE material_type IS NULL) AS missing_material_type,
    COUNT(*) FILTER (WHERE vendor_code IS NULL) AS missing_vendor_code
FROM Inventory;

-- Query that fetch all the numeric columns
SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'inventory'
    AND data_type IN ('integer', 'bigint', 'numeric', 'double precision', 'real');

---Statistical Insights of all numeric columns
WITH material_stats AS (
    SELECT
        material_id,
        ROW_NUMBER() OVER (ORDER BY material_id) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
plant_stats AS (
    SELECT
        plant_code,
        ROW_NUMBER() OVER (ORDER BY plant_code) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
movement_stats AS (
    SELECT
        movement_type,
        ROW_NUMBER() OVER (ORDER BY movement_type) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
material_doc_stats AS (
    SELECT
        material_document,
        ROW_NUMBER() OVER (ORDER BY material_document) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
qty_in_un_stats AS (
    SELECT
        qty_in_un_of_entry,
        ROW_NUMBER() OVER (ORDER BY qty_in_un_of_entry) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
batch_stats AS (
    SELECT
        batch,
        ROW_NUMBER() OVER (ORDER BY batch) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
order_stats AS (
    SELECT
        "order",
        ROW_NUMBER() OVER (ORDER BY "order") AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
qty_in_opun_stats AS (
    SELECT
        qty_in_opun,
        ROW_NUMBER() OVER (ORDER BY qty_in_opun) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
qty_in_order_stats AS (
    SELECT
        qty_in_order_unit,
        ROW_NUMBER() OVER (ORDER BY qty_in_order_unit) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
company_stats AS (
    SELECT
        company_code,
        ROW_NUMBER() OVER (ORDER BY company_code) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
amount_in_lc_stats AS (
    SELECT
        amount_in_lc,
        ROW_NUMBER() OVER (ORDER BY amount_in_lc) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
purchase_order_stats AS (
    SELECT
        purchase_order,
        ROW_NUMBER() OVER (ORDER BY purchase_order) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
item_stats AS (
    SELECT
        item,
        ROW_NUMBER() OVER (ORDER BY item) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
reason_for_movement_stats AS (
    SELECT
        reason_for_movement,
        ROW_NUMBER() OVER (ORDER BY reason_for_movement) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
cost_center_stats AS (
    SELECT
        cost_center,
        ROW_NUMBER() OVER (ORDER BY cost_center) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
supplier_stats AS (
    SELECT
        supplier,
        ROW_NUMBER() OVER (ORDER BY supplier) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
quantity_stats AS (
    SELECT
        quantity,
        ROW_NUMBER() OVER (ORDER BY quantity) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
material_doc_year_stats AS (
    SELECT
        material_doc_year,
        ROW_NUMBER() OVER (ORDER BY material_doc_year) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
item_no_stock_transfer_reserv_stats AS (
    SELECT
        item_no_stock_transfer_reserv,
        ROW_NUMBER() OVER (ORDER BY item_no_stock_transfer_reserv) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
product_code_stats AS (
    SELECT
        product_code,
        ROW_NUMBER() OVER (ORDER BY product_code) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
),
vendor_code_stats AS (
    SELECT
        vendor_code,
        ROW_NUMBER() OVER (ORDER BY vendor_code) AS rn,
        COUNT(*) OVER () AS total_rows
    FROM inventory
)

/* Summary Statistics: Calculating count, mean, standard deviation, min, max, and percentiles for each numeric column */
SELECT 
    'material_id' AS column_name,
    COUNT(material_id) AS count,
    AVG(material_id) AS average,
    MIN(material_id) AS min,
    MAX(material_id) AS max,
    STDDEV(material_id) AS stddev,
    SUM(material_id) AS sum,
    (SELECT AVG(material_id) FROM material_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'plant_code' AS column_name,
    COUNT(plant_code) AS count,
    AVG(plant_code) AS average,
    MIN(plant_code) AS min,
    MAX(plant_code) AS max,
    STDDEV(plant_code) AS stddev,
    SUM(plant_code) AS sum,
    (SELECT AVG(plant_code) FROM plant_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'movement_type' AS column_name,
    COUNT(movement_type) AS count,
    AVG(movement_type) AS average,
    MIN(movement_type) AS min,
    MAX(movement_type) AS max,
    STDDEV(movement_type) AS stddev,
    SUM(movement_type) AS sum,
    (SELECT AVG(movement_type) FROM movement_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'material_document' AS column_name,
    COUNT(material_document) AS count,
    AVG(material_document) AS average,
    MIN(material_document) AS min,
    MAX(material_document) AS max,
    STDDEV(material_document) AS stddev,
    SUM(material_document) AS sum,
    (SELECT AVG(material_document) FROM material_doc_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'qty_in_un_of_entry' AS column_name,
    COUNT(qty_in_un_of_entry) AS count,
    AVG(qty_in_un_of_entry) AS average,
    MIN(qty_in_un_of_entry) AS min,
    MAX(qty_in_un_of_entry) AS max,
    STDDEV(qty_in_un_of_entry) AS stddev,
    SUM(qty_in_un_of_entry) AS sum,
    (SELECT AVG(qty_in_un_of_entry) FROM qty_in_un_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'batch' AS column_name,
    COUNT(batch) AS count,
    AVG(batch) AS average,
    MIN(batch) AS min,
    MAX(batch) AS max,
    STDDEV(batch) AS stddev,
    SUM(batch) AS sum,
    (SELECT AVG(batch) FROM batch_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    '"order"' AS column_name,
    COUNT("order") AS count,
    AVG("order") AS average,
    MIN("order") AS min,
    MAX("order") AS max,
    STDDEV("order") AS stddev,
    SUM("order") AS sum,
    (SELECT AVG("order") FROM order_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'qty_in_opun' AS column_name,
    COUNT(qty_in_opun) AS count,
    AVG(qty_in_opun) AS average,
    MIN(qty_in_opun) AS min,
    MAX(qty_in_opun) AS max,
    STDDEV(qty_in_opun) AS stddev,
    SUM(qty_in_opun) AS sum,
    (SELECT AVG(qty_in_opun) FROM qty_in_opun_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'qty_in_order_unit' AS column_name,
    COUNT(qty_in_order_unit) AS count,
    AVG(qty_in_order_unit) AS average,
    MIN(qty_in_order_unit) AS min,
    MAX(qty_in_order_unit) AS max,
    STDDEV(qty_in_order_unit) AS stddev,
    SUM(qty_in_order_unit) AS sum,
    (SELECT AVG(qty_in_order_unit) FROM qty_in_order_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'company_code' AS column_name,
    COUNT(company_code) AS count,
    AVG(company_code) AS average,
    MIN(company_code) AS min,
    MAX(company_code) AS max,
    STDDEV(company_code) AS stddev,
    SUM(company_code) AS sum,
    (SELECT AVG(company_code) FROM company_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'amount_in_lc' AS column_name,
    COUNT(amount_in_lc) AS count,
    AVG(amount_in_lc) AS average,
    MIN(amount_in_lc) AS min,
    MAX(amount_in_lc) AS max,
    STDDEV(amount_in_lc) AS stddev,
    SUM(amount_in_lc) AS sum,
    (SELECT AVG(amount_in_lc) FROM amount_in_lc_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'purchase_order' AS column_name,
    COUNT(purchase_order) AS count,
    AVG(purchase_order) AS average,
    MIN(purchase_order) AS min,
    MAX(purchase_order) AS max,
    STDDEV(purchase_order) AS stddev,
    SUM(purchase_order) AS sum,
    (SELECT AVG(purchase_order) FROM purchase_order_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'item' AS column_name,
    COUNT(item) AS count,
    AVG(item) AS average,
    MIN(item) AS min,
    MAX(item) AS max,
    STDDEV(item) AS stddev,
    SUM(item) AS sum,
    (SELECT AVG(item) FROM item_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'reason_for_movement' AS column_name,
    COUNT(reason_for_movement) AS count,
    AVG(reason_for_movement) AS average,
    MIN(reason_for_movement) AS min,
    MAX(reason_for_movement) AS max,
    STDDEV(reason_for_movement) AS stddev,
    SUM(reason_for_movement) AS sum,
    (SELECT AVG(reason_for_movement) FROM reason_for_movement_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'cost_center' AS column_name,
    COUNT(cost_center) AS count,
    AVG(cost_center) AS average,
    MIN(cost_center) AS min,
    MAX(cost_center) AS max,
    STDDEV(cost_center) AS stddev,
    SUM(cost_center) AS sum,
    (SELECT AVG(cost_center) FROM cost_center_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'supplier' AS column_name,
    COUNT(supplier) AS count,
    AVG(supplier) AS average,
    MIN(supplier) AS min,
    MAX(supplier) AS max,
    STDDEV(supplier) AS stddev,
    SUM(supplier) AS sum,
    (SELECT AVG(supplier) FROM supplier_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'quantity' AS column_name,
    COUNT(quantity) AS count,
    AVG(quantity) AS average,
    MIN(quantity) AS min,
    MAX(quantity) AS max,
    STDDEV(quantity) AS stddev,
    SUM(quantity) AS sum,
    (SELECT AVG(quantity) FROM quantity_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'material_doc_year' AS column_name,
    COUNT(material_doc_year) AS count,
    AVG(material_doc_year) AS average,
    MIN(material_doc_year) AS min,
    MAX(material_doc_year) AS max,
    STDDEV(material_doc_year) AS stddev,
    SUM(material_doc_year) AS sum,
    (SELECT AVG(material_doc_year) FROM material_doc_year_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'item_no_stock_transfer_reserv' AS column_name,
    COUNT(item_no_stock_transfer_reserv) AS count,
    AVG(item_no_stock_transfer_reserv) AS average,
    MIN(item_no_stock_transfer_reserv) AS min,
    MAX(item_no_stock_transfer_reserv) AS max,
    STDDEV(item_no_stock_transfer_reserv) AS stddev,
    SUM(item_no_stock_transfer_reserv) AS sum,
    (SELECT AVG(item_no_stock_transfer_reserv) FROM item_no_stock_transfer_reserv_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'product_code' AS column_name,
    COUNT(product_code) AS count,
    AVG(product_code) AS average,
    MIN(product_code) AS min,
    MAX(product_code) AS max,
    STDDEV(product_code) AS stddev,
    SUM(product_code) AS sum,
    (SELECT AVG(product_code) FROM product_code_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory

UNION ALL

SELECT 
    'vendor_code' AS column_name,
    COUNT(vendor_code) AS count,
    AVG(vendor_code) AS average,
    MIN(vendor_code) AS min,
    MAX(vendor_code) AS max,
    STDDEV(vendor_code) AS stddev,
    SUM(vendor_code) AS sum,
    (SELECT AVG(vendor_code) FROM vendor_code_stats WHERE rn IN (total_rows/2, total_rows/2+1)) AS median
FROM inventory;



-- Creating a table to store the top 10 counts of each numeric column
CREATE TABLE top_frequent_values (
    column_name VARCHAR(50),
    value VARCHAR(255),
    frequency INT
);

select * from top_frequent_values;

--top 10 most frequent values for each numeric column
-- Insert top 10 most frequent material_id values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'material_id' AS column_name,
    material_id AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_id
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent plant_code values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'plant_code' AS column_name,
    plant_code AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    plant_code
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent movement_type values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'movement_type' AS column_name,
    movement_type AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    movement_type
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent material_document values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'material_document' AS column_name,
    material_document AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_document
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent qty_in_un_of_entry values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'qty_in_un_of_entry' AS column_name,
    qty_in_un_of_entry AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    qty_in_un_of_entry
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent batch values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'batch' AS column_name,
    batch AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    batch
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent order values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'order' AS column_name,
    "order" AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    "order"
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent qty_in_opun values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'qty_in_opun' AS column_name,
    qty_in_opun AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    qty_in_opun
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent qty_in_order_unit values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'qty_in_order_unit' AS column_name,
    qty_in_order_unit AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    qty_in_order_unit
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent company_code values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'company_code' AS column_name,
    company_code AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    company_code
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent amount_in_lc values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'amount_in_lc' AS column_name,
    amount_in_lc AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    amount_in_lc
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent purchase_order values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'purchase_order' AS column_name,
    purchase_order AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    purchase_order
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent item values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'item' AS column_name,
    item AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    item
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent reason_for_movement values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'reason_for_movement' AS column_name,
    reason_for_movement AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    reason_for_movement
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent cost_center values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'cost_center' AS column_name,
    cost_center AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    cost_center
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent supplier values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'supplier' AS column_name,
    supplier AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    supplier
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent quantity values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'quantity' AS column_name,
    quantity AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    quantity
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent material_doc_year values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'material_doc_year' AS column_name,
    material_doc_year AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_doc_year
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent item_no_stock_transfer_reserv values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'item_no_stock_transfer_reserv' AS column_name,
    item_no_stock_transfer_reserv AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    item_no_stock_transfer_reserv
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent product_code values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'product_code' AS column_name,
    product_code AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    product_code
ORDER BY 
    frequency DESC
LIMIT 10;

-- Insert top 10 most frequent vendor_code values
INSERT INTO top_frequent_values (column_name, value, frequency)
SELECT 
    'vendor_code' AS column_name,
    vendor_code AS value,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    vendor_code
ORDER BY 
    frequency DESC
LIMIT 10;


--Exploratory Data Analysis (EDA) on categorical columns
-- Query that fetch all the categorical columns
SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'inventory'
    AND data_type IN ('character varying', 'text');


-- Material Description: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT material_description) AS unique_material_descriptions,
    material_description,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_description
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent material descriptions

-- Storage Location: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT storage_location) AS unique_storage_locations,
    storage_location,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    storage_location
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent storage locations


-- Material Doc Item: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT material_doc_item) AS unique_material_doc_items,
    material_doc_item,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_doc_item
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent material doc items

-- Unit of Entry: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT unit_of_entry) AS unique_units_of_entry,
    unit_of_entry,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    unit_of_entry
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent units of entry

-- Reference: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT reference) AS unique_references,
    reference,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    reference
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent references


-- Movement Type Text: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT movement_type_text) AS unique_movement_type_texts,
    movement_type_text,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    movement_type_text
ORDER BY 
    frequency DESC;
--LIMIT 10; -- Top 10 most frequent movement type texts

-- Order Price Unit: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT order_price_unit) AS unique_order_price_units,
    order_price_unit,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    order_price_unit
ORDER BY 
    frequency DESC;
--LIMIT 10; -- Top 10 most frequent order price units


-- Order Unit: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT order_unit) AS unique_order_units,
    order_unit,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    order_unit
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent order units


-- Movement Indicator: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT movement_indicator) AS unique_movement_indicators,
    movement_indicator,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    movement_indicator
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent movement indicators


-- Base Unit of Measure: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT base_unit_of_measure) AS unique_base_units_of_measure,
    base_unit_of_measure,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    base_unit_of_measure
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent base units of measure

-- Reservation: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT reservation) AS unique_reservations,
    reservation,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    reservation
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent reservations

-- Debit Credit Indicator: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT debit_credit_ind) AS unique_debit_credit_inds,
    debit_credit_ind,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    debit_credit_ind
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent debit credit indicators

-- User Name: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT user_name) AS unique_user_names,
    user_name,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    user_name
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent user names

-- Transaction Event Type: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT trans_event_type) AS unique_trans_event_types,
    trans_event_type,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    trans_event_type
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent transaction event types

-- Currency: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT currency) AS unique_currencies,
    currency,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    currency
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent currencies

-- Item Automatically Created: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT item_automatically_created) AS unique_item_auto_created,
    item_automatically_created,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    item_automatically_created
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent item automatically created values


-- Product Description: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT product_description) AS unique_product_descriptions,
    product_description,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    product_description
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent product descriptions


-- Material Type: Unique Values and Frequency Distribution
SELECT 
    COUNT(DISTINCT material_type) AS unique_material_types,
    material_type,
    COUNT(*) AS frequency
FROM 
    inventory
GROUP BY 
    material_type
ORDER BY 
    frequency DESC
LIMIT 10; -- Top 10 most frequent material types

--Null Values Count of categorical columns
SELECT 
    SUM(CASE WHEN material_description IS NULL THEN 1 ELSE 0 END) AS material_description_null_count,
    SUM(CASE WHEN storage_location IS NULL THEN 1 ELSE 0 END) AS storage_location_null_count,
    SUM(CASE WHEN material_doc_item IS NULL THEN 1 ELSE 0 END) AS material_doc_item_null_count,
    SUM(CASE WHEN unit_of_entry IS NULL THEN 1 ELSE 0 END) AS unit_of_entry_null_count,
    SUM(CASE WHEN reference IS NULL THEN 1 ELSE 0 END) AS reference_null_count,
    SUM(CASE WHEN movement_type_text IS NULL THEN 1 ELSE 0 END) AS movement_type_text_null_count,
    SUM(CASE WHEN order_price_unit IS NULL THEN 1 ELSE 0 END) AS order_price_unit_null_count,
    SUM(CASE WHEN order_unit IS NULL THEN 1 ELSE 0 END) AS order_unit_null_count,
    SUM(CASE WHEN movement_indicator IS NULL THEN 1 ELSE 0 END) AS movement_indicator_null_count,
    SUM(CASE WHEN consumption IS NULL THEN 1 ELSE 0 END) AS consumption_null_count,
    SUM(CASE WHEN receipt_indicator IS NULL THEN 1 ELSE 0 END) AS receipt_indicator_null_count,
    SUM(CASE WHEN base_unit_of_measure IS NULL THEN 1 ELSE 0 END) AS base_unit_of_measure_null_count,
    SUM(CASE WHEN reservation IS NULL THEN 1 ELSE 0 END) AS reservation_null_count,
    SUM(CASE WHEN debit_credit_ind IS NULL THEN 1 ELSE 0 END) AS debit_credit_ind_null_count,
    SUM(CASE WHEN user_name IS NULL THEN 1 ELSE 0 END) AS user_name_null_count,
    SUM(CASE WHEN trans_event_type IS NULL THEN 1 ELSE 0 END) AS trans_event_type_null_count,
    SUM(CASE WHEN currency IS NULL THEN 1 ELSE 0 END) AS currency_null_count,
    SUM(CASE WHEN item_automatically_created IS NULL THEN 1 ELSE 0 END) AS item_automatically_created_null_count,
    SUM(CASE WHEN product_description IS NULL THEN 1 ELSE 0 END) AS product_description_null_count,
    SUM(CASE WHEN material_type IS NULL THEN 1 ELSE 0 END) AS material_type_null_count
FROM inventory;


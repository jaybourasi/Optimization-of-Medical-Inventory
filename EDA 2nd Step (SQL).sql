-- Creating a new backup table for further analysis
CREATE TABLE Inventory_backup AS TABLE Inventory;
select * from inventory_backup;

-- Query that fetch all the numeric columns
SELECT
    column_name,
    data_type
FROM
    information_schema.columns
WHERE
    table_name = 'inventory_backup'
    AND data_type IN ('integer', 'bigint', 'numeric', 'double precision', 'real');

-- Count Of Null Values On Numeric Columns
SELECT 
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(material_id) AS null_material_id,
    COUNT(*) - COUNT(plant_code) AS null_plant_code,
    COUNT(*) - COUNT(movement_type) AS null_movement_type,
    COUNT(*) - COUNT(material_document) AS null_material_document,
    COUNT(*) - COUNT(qty_in_un_of_entry) AS null_qty_in_un_of_entry,
    COUNT(*) - COUNT(batch) AS null_batch,
    COUNT(*) - COUNT("order") AS null_order,
    COUNT(*) - COUNT(qty_in_opun) AS null_qty_in_opun,
    COUNT(*) - COUNT(qty_in_order_unit) AS null_qty_in_order_unit,
    COUNT(*) - COUNT(company_code) AS null_company_code,
    COUNT(*) - COUNT(amount_in_lc) AS null_amount_in_lc,
    COUNT(*) - COUNT(purchase_order) AS null_purchase_order,
    COUNT(*) - COUNT(item) AS null_item,
    COUNT(*) - COUNT(reason_for_movement) AS null_reason_for_movement,
    COUNT(*) - COUNT(cost_center) AS null_cost_center,
    COUNT(*) - COUNT(supplier) AS null_supplier,
    COUNT(*) - COUNT(quantity) AS null_quantity,
    COUNT(*) - COUNT(material_doc_year) AS null_material_doc_year,
    COUNT(*) - COUNT(item_no_stock_transfer_reserv) AS null_item_no_stock_transfer_reserv,
    COUNT(*) - COUNT(product_code) AS null_product_code,
    COUNT(*) - COUNT(vendor_code) AS null_vendor_code
FROM 
    inventory_backup;

-- Skewness calculation for each numeric column
WITH stats AS (
    SELECT
        AVG("material_id") AS mean_material_id,
        STDDEV("material_id") AS stddev_material_id,
        AVG("plant_code") AS mean_plant_code,
        STDDEV("plant_code") AS stddev_plant_code,
        AVG("movement_type") AS mean_movement_type,
        STDDEV("movement_type") AS stddev_movement_type,
        AVG("material_document") AS mean_material_document,
        STDDEV("material_document") AS stddev_material_document,
        AVG("qty_in_un_of_entry") AS mean_qty_in_un_of_entry,
        STDDEV("qty_in_un_of_entry") AS stddev_qty_in_un_of_entry,
        AVG("batch") AS mean_batch,
        STDDEV("batch") AS stddev_batch,
        AVG("order") AS mean_order,
        STDDEV("order") AS stddev_order,
        AVG("qty_in_opun") AS mean_qty_in_opun,
        STDDEV("qty_in_opun") AS stddev_qty_in_opun,
        AVG("qty_in_order_unit") AS mean_qty_in_order_unit,
        STDDEV("qty_in_order_unit") AS stddev_qty_in_order_unit,
        AVG("company_code") AS mean_company_code,
        STDDEV("company_code") AS stddev_company_code,
        AVG("amount_in_lc") AS mean_amount_in_lc,
        STDDEV("amount_in_lc") AS stddev_amount_in_lc,
        AVG("purchase_order") AS mean_purchase_order,
        STDDEV("purchase_order") AS stddev_purchase_order,
        AVG("item") AS mean_item,
        STDDEV("item") AS stddev_item,
        AVG("reason_for_movement") AS mean_reason_for_movement,
        STDDEV("reason_for_movement") AS stddev_reason_for_movement,
        AVG("cost_center") AS mean_cost_center,
        STDDEV("cost_center") AS stddev_cost_center,
        AVG("supplier") AS mean_supplier,
        STDDEV("supplier") AS stddev_supplier,
        AVG("quantity") AS mean_quantity,
        STDDEV("quantity") AS stddev_quantity,
        AVG("material_doc_year") AS mean_material_doc_year,
        STDDEV("material_doc_year") AS stddev_material_doc_year,
        AVG("item_no_stock_transfer_reserv") AS mean_item_no_stock_transfer_reserv,
        STDDEV("item_no_stock_transfer_reserv") AS stddev_item_no_stock_transfer_reserv,
        AVG("product_code") AS mean_product_code,
        STDDEV("product_code") AS stddev_product_code,
        AVG("vendor_code") AS mean_vendor_code,
        STDDEV("vendor_code") AS stddev_vendor_code
    FROM "inventory_backup"
),

null_counts AS (
    SELECT
        'material_id' AS column_name,
        COUNT(*) - COUNT("material_id") AS null_count
    FROM "inventory_backup"
    
    UNION ALL

    SELECT
        'plant_code' AS column_name,
        COUNT(*) - COUNT("plant_code") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'movement_type' AS column_name,
        COUNT(*) - COUNT("movement_type") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'material_document' AS column_name,
        COUNT(*) - COUNT("material_document") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'qty_in_un_of_entry' AS column_name,
        COUNT(*) - COUNT("qty_in_un_of_entry") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'batch' AS column_name,
        COUNT(*) - COUNT("batch") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'order' AS column_name,
        COUNT(*) - COUNT("order") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'qty_in_opun' AS column_name,
        COUNT(*) - COUNT("qty_in_opun") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'qty_in_order_unit' AS column_name,
        COUNT(*) - COUNT("qty_in_order_unit") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'company_code' AS column_name,
        COUNT(*) - COUNT("company_code") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'amount_in_lc' AS column_name,
        COUNT(*) - COUNT("amount_in_lc") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'purchase_order' AS column_name,
        COUNT(*) - COUNT("purchase_order") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'item' AS column_name,
        COUNT(*) - COUNT("item") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'reason_for_movement' AS column_name,
        COUNT(*) - COUNT("reason_for_movement") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'cost_center' AS column_name,
        COUNT(*) - COUNT("cost_center") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'supplier' AS column_name,
        COUNT(*) - COUNT("supplier") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'quantity' AS column_name,
        COUNT(*) - COUNT("quantity") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'material_doc_year' AS column_name,
        COUNT(*) - COUNT("material_doc_year") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'item_no_stock_transfer_reserv' AS column_name,
        COUNT(*) - COUNT("item_no_stock_transfer_reserv") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'product_code' AS column_name,
        COUNT(*) - COUNT("product_code") AS null_count
    FROM "inventory_backup"

    UNION ALL

    SELECT
        'vendor_code' AS column_name,
        COUNT(*) - COUNT("vendor_code") AS null_count
    FROM "inventory_backup"
),

skewness AS (
    SELECT
        'material_id' AS column_name,
        COUNT("material_id") AS total_count,
        COUNT(*) - COUNT("material_id") AS null_count,
        SUM(POWER(("material_id" - stats.mean_material_id) / NULLIF(stats.stddev_material_id, 0), 3)) / NULLIF(COUNT("material_id"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "material_id" IS NOT NULL

    UNION ALL

    SELECT
        'plant_code' AS column_name,
        COUNT("plant_code") AS total_count,
        COUNT(*) - COUNT("plant_code") AS null_count,
        SUM(POWER(("plant_code" - stats.mean_plant_code) / NULLIF(stats.stddev_plant_code, 0), 3)) / NULLIF(COUNT("plant_code"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "plant_code" IS NOT NULL

    UNION ALL

    SELECT
        'movement_type' AS column_name,
        COUNT("movement_type") AS total_count,
        COUNT(*) - COUNT("movement_type") AS null_count,
        SUM(POWER(("movement_type" - stats.mean_movement_type) / NULLIF(stats.stddev_movement_type, 0), 3)) / NULLIF(COUNT("movement_type"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "movement_type" IS NOT NULL

    UNION ALL

    SELECT
        'material_document' AS column_name,
        COUNT("material_document") AS total_count,
        COUNT(*) - COUNT("material_document") AS null_count,
        SUM(POWER(("material_document" - stats.mean_material_document) / NULLIF(stats.stddev_material_document, 0), 3)) / NULLIF(COUNT("material_document"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "material_document" IS NOT NULL

    UNION ALL

    SELECT
        'qty_in_un_of_entry' AS column_name,
        COUNT("qty_in_un_of_entry") AS total_count,
        COUNT(*) - COUNT("qty_in_un_of_entry") AS null_count,
        SUM(POWER(("qty_in_un_of_entry" - stats.mean_qty_in_un_of_entry) / NULLIF(stats.stddev_qty_in_un_of_entry, 0), 3)) / NULLIF(COUNT("qty_in_un_of_entry"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "qty_in_un_of_entry" IS NOT NULL

    UNION ALL

    SELECT
        'batch' AS column_name,
        COUNT("batch") AS total_count,
        COUNT(*) - COUNT("batch") AS null_count,
        SUM(POWER(("batch" - stats.mean_batch) / NULLIF(stats.stddev_batch, 0), 3)) / NULLIF(COUNT("batch"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "batch" IS NOT NULL

    UNION ALL

    SELECT
        'order' AS column_name,
        COUNT("order") AS total_count,
        COUNT(*) - COUNT("order") AS null_count,
        SUM(POWER(("order" - stats.mean_order) / NULLIF(stats.stddev_order, 0), 3)) / NULLIF(COUNT("order"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "order" IS NOT NULL

    UNION ALL

    SELECT
        'qty_in_opun' AS column_name,
        COUNT("qty_in_opun") AS total_count,
        COUNT(*) - COUNT("qty_in_opun") AS null_count,
        SUM(POWER(("qty_in_opun" - stats.mean_qty_in_opun) / NULLIF(stats.stddev_qty_in_opun, 0), 3)) / NULLIF(COUNT("qty_in_opun"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "qty_in_opun" IS NOT NULL

    UNION ALL

    SELECT
        'qty_in_order_unit' AS column_name,
        COUNT("qty_in_order_unit") AS total_count,
        COUNT(*) - COUNT("qty_in_order_unit") AS null_count,
        SUM(POWER(("qty_in_order_unit" - stats.mean_qty_in_order_unit) / NULLIF(stats.stddev_qty_in_order_unit, 0), 3)) / NULLIF(COUNT("qty_in_order_unit"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "qty_in_order_unit" IS NOT NULL

    UNION ALL

    SELECT
        'company_code' AS column_name,
        COUNT("company_code") AS total_count,
        COUNT(*) - COUNT("company_code") AS null_count,
        SUM(POWER(("company_code" - stats.mean_company_code) / NULLIF(stats.stddev_company_code, 0), 3)) / NULLIF(COUNT("company_code"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "company_code" IS NOT NULL

    UNION ALL

    SELECT
        'amount_in_lc' AS column_name,
        COUNT("amount_in_lc") AS total_count,
        COUNT(*) - COUNT("amount_in_lc") AS null_count,
        SUM(POWER(("amount_in_lc" - stats.mean_amount_in_lc) / NULLIF(stats.stddev_amount_in_lc, 0), 3)) / NULLIF(COUNT("amount_in_lc"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "amount_in_lc" IS NOT NULL

    UNION ALL

    SELECT
        'purchase_order' AS column_name,
        COUNT("purchase_order") AS total_count,
        COUNT(*) - COUNT("purchase_order") AS null_count,
        SUM(POWER(("purchase_order" - stats.mean_purchase_order) / NULLIF(stats.stddev_purchase_order, 0), 3)) / NULLIF(COUNT("purchase_order"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "purchase_order" IS NOT NULL

    UNION ALL

    SELECT
        'item' AS column_name,
        COUNT("item") AS total_count,
        COUNT(*) - COUNT("item") AS null_count,
        SUM(POWER(("item" - stats.mean_item) / NULLIF(stats.stddev_item, 0), 3)) / NULLIF(COUNT("item"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "item" IS NOT NULL

    UNION ALL

    SELECT
        'reason_for_movement' AS column_name,
        COUNT("reason_for_movement") AS total_count,
        COUNT(*) - COUNT("reason_for_movement") AS null_count,
        SUM(POWER(("reason_for_movement" - stats.mean_reason_for_movement) / NULLIF(stats.stddev_reason_for_movement, 0), 3)) / NULLIF(COUNT("reason_for_movement"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "reason_for_movement" IS NOT NULL

    UNION ALL

    SELECT
        'cost_center' AS column_name,
        COUNT("cost_center") AS total_count,
        COUNT(*) - COUNT("cost_center") AS null_count,
        SUM(POWER(("cost_center" - stats.mean_cost_center) / NULLIF(stats.stddev_cost_center, 0), 3)) / NULLIF(COUNT("cost_center"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "cost_center" IS NOT NULL

    UNION ALL

    SELECT
        'supplier' AS column_name,
        COUNT("supplier") AS total_count,
        COUNT(*) - COUNT("supplier") AS null_count,
        SUM(POWER(("supplier" - stats.mean_supplier) / NULLIF(stats.stddev_supplier, 0), 3)) / NULLIF(COUNT("supplier"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "supplier" IS NOT NULL

    UNION ALL

    SELECT
        'quantity' AS column_name,
        COUNT("quantity") AS total_count,
        COUNT(*) - COUNT("quantity") AS null_count,
        SUM(POWER(("quantity" - stats.mean_quantity) / NULLIF(stats.stddev_quantity, 0), 3)) / NULLIF(COUNT("quantity"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "quantity" IS NOT NULL

    UNION ALL

    SELECT
        'material_doc_year' AS column_name,
        COUNT("material_doc_year") AS total_count,
        COUNT(*) - COUNT("material_doc_year") AS null_count,
        SUM(POWER(("material_doc_year" - stats.mean_material_doc_year) / NULLIF(stats.stddev_material_doc_year, 0), 3)) / NULLIF(COUNT("material_doc_year"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "material_doc_year" IS NOT NULL

    UNION ALL

    SELECT
        'item_no_stock_transfer_reserv' AS column_name,
        COUNT("item_no_stock_transfer_reserv") AS total_count,
        COUNT(*) - COUNT("item_no_stock_transfer_reserv") AS null_count,
        SUM(POWER(("item_no_stock_transfer_reserv" - stats.mean_item_no_stock_transfer_reserv) / NULLIF(stats.stddev_item_no_stock_transfer_reserv, 0), 3)) / NULLIF(COUNT("item_no_stock_transfer_reserv"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "item_no_stock_transfer_reserv" IS NOT NULL

    UNION ALL

    SELECT
        'product_code' AS column_name,
        COUNT("product_code") AS total_count,
        COUNT(*) - COUNT("product_code") AS null_count,
        SUM(POWER(("product_code" - stats.mean_product_code) / NULLIF(stats.stddev_product_code, 0), 3)) / NULLIF(COUNT("product_code"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "product_code" IS NOT NULL

    UNION ALL

    SELECT
        'vendor_code' AS column_name,
        COUNT("vendor_code") AS total_count,
        COUNT(*) - COUNT("vendor_code") AS null_count,
        SUM(POWER(("vendor_code" - stats.mean_vendor_code) / NULLIF(stats.stddev_vendor_code, 0), 3)) / NULLIF(COUNT("vendor_code"), 0) AS skewness
    FROM "inventory_backup", stats
    WHERE "vendor_code" IS NOT NULL
)

SELECT
    skewness.column_name,
    skewness.total_count,
    null_counts.null_count,
    skewness.skewness
FROM skewness
JOIN null_counts ON skewness.column_name = null_counts.column_name
ORDER BY skewness.column_name;

-- Kurtosis calculation for each numeric column
WITH stats AS (
    SELECT
        COUNT(*) AS n,
        AVG("material_id") AS mean_material_id,
        VAR_SAMP("material_id") AS variance_material_id,
        AVG("plant_code") AS mean_plant_code,
        VAR_SAMP("plant_code") AS variance_plant_code,
        AVG("movement_type") AS mean_movement_type,
        VAR_SAMP("movement_type") AS variance_movement_type,
        AVG("material_document") AS mean_material_document,
        VAR_SAMP("material_document") AS variance_material_document,
        AVG("qty_in_un_of_entry") AS mean_qty_in_un_of_entry,
        VAR_SAMP("qty_in_un_of_entry") AS variance_qty_in_un_of_entry,
        AVG("batch") AS mean_batch,
        VAR_SAMP("batch") AS variance_batch,
        AVG("order") AS mean_order,
        VAR_SAMP("order") AS variance_order,
        AVG("qty_in_opun") AS mean_qty_in_opun,
        VAR_SAMP("qty_in_opun") AS variance_qty_in_opun,
        AVG("qty_in_order_unit") AS mean_qty_in_order_unit,
        VAR_SAMP("qty_in_order_unit") AS variance_qty_in_order_unit,
        AVG("company_code") AS mean_company_code,
        VAR_SAMP("company_code") AS variance_company_code,
        AVG("amount_in_lc") AS mean_amount_in_lc,
        VAR_SAMP("amount_in_lc") AS variance_amount_in_lc,
        AVG("purchase_order") AS mean_purchase_order,
        VAR_SAMP("purchase_order") AS variance_purchase_order,
        AVG("item") AS mean_item,
        VAR_SAMP("item") AS variance_item,
        AVG("reason_for_movement") AS mean_reason_for_movement,
        VAR_SAMP("reason_for_movement") AS variance_reason_for_movement,
        AVG("cost_center") AS mean_cost_center,
        VAR_SAMP("cost_center") AS variance_cost_center,
        AVG("supplier") AS mean_supplier,
        VAR_SAMP("supplier") AS variance_supplier,
        AVG("quantity") AS mean_quantity,
        VAR_SAMP("quantity") AS variance_quantity,
        AVG("material_doc_year") AS mean_material_doc_year,
        VAR_SAMP("material_doc_year") AS variance_material_doc_year,
        AVG("item_no_stock_transfer_reserv") AS mean_item_no_stock_transfer_reserv,
        VAR_SAMP("item_no_stock_transfer_reserv") AS variance_item_no_stock_transfer_reserv,
        AVG("product_code") AS mean_product_code,
        VAR_SAMP("product_code") AS variance_product_code,
        AVG("vendor_code") AS mean_vendor_code,
        VAR_SAMP("vendor_code") AS variance_vendor_code
    FROM "inventory_backup"
),

kurtosis AS (
    SELECT
        'material_id' AS column_name,
        CASE 
            WHEN stats.variance_material_id = 0 THEN NULL
            ELSE (SUM(POWER("material_id" - stats.mean_material_id, 4)) / (COUNT(*) * POWER(stats.variance_material_id, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_id, stats.variance_material_id

    UNION ALL

    SELECT
        'plant_code' AS column_name,
        CASE 
            WHEN stats.variance_plant_code = 0 THEN NULL
            ELSE (SUM(POWER("plant_code" - stats.mean_plant_code, 4)) / (COUNT(*) * POWER(stats.variance_plant_code, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_plant_code, stats.variance_plant_code

    UNION ALL

    SELECT
        'movement_type' AS column_name,
        CASE 
            WHEN stats.variance_movement_type = 0 THEN NULL
            ELSE (SUM(POWER("movement_type" - stats.mean_movement_type, 4)) / (COUNT(*) * POWER(stats.variance_movement_type, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_movement_type, stats.variance_movement_type

    UNION ALL

    SELECT
        'material_document' AS column_name,
        CASE 
            WHEN stats.variance_material_document = 0 THEN NULL
            ELSE (SUM(POWER("material_document" - stats.mean_material_document, 4)) / (COUNT(*) * POWER(stats.variance_material_document, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_document, stats.variance_material_document

    UNION ALL

    SELECT
        'qty_in_un_of_entry' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_un_of_entry = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_un_of_entry" - stats.mean_qty_in_un_of_entry, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_un_of_entry, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_un_of_entry, stats.variance_qty_in_un_of_entry

    UNION ALL

    SELECT
        'batch' AS column_name,
        CASE 
            WHEN stats.variance_batch = 0 THEN NULL
            ELSE (SUM(POWER("batch" - stats.mean_batch, 4)) / (COUNT(*) * POWER(stats.variance_batch, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_batch, stats.variance_batch

    UNION ALL

    SELECT
        'order' AS column_name,
        CASE 
            WHEN stats.variance_order = 0 THEN NULL
            ELSE (SUM(POWER("order" - stats.mean_order, 4)) / (COUNT(*) * POWER(stats.variance_order, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_order, stats.variance_order

    UNION ALL

    SELECT
        'qty_in_opun' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_opun = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_opun" - stats.mean_qty_in_opun, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_opun, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_opun, stats.variance_qty_in_opun

    UNION ALL

    SELECT
        'qty_in_order_unit' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_order_unit = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_order_unit" - stats.mean_qty_in_order_unit, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_order_unit, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_order_unit, stats.variance_qty_in_order_unit

    UNION ALL

    SELECT
        'company_code' AS column_name,
        CASE 
            WHEN stats.variance_company_code = 0 THEN NULL
            ELSE (SUM(POWER("company_code" - stats.mean_company_code, 4)) / (COUNT(*) * POWER(stats.variance_company_code, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_company_code, stats.variance_company_code

    UNION ALL

    SELECT
        'amount_in_lc' AS column_name,
        CASE 
            WHEN stats.variance_amount_in_lc = 0 THEN NULL
            ELSE (SUM(POWER("amount_in_lc" - stats.mean_amount_in_lc, 4)) / (COUNT(*) * POWER(stats.variance_amount_in_lc, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_amount_in_lc, stats.variance_amount_in_lc

    UNION ALL

    SELECT
        'purchase_order' AS column_name,
        CASE 
            WHEN stats.variance_purchase_order = 0 THEN NULL
            ELSE (SUM(POWER("purchase_order" - stats.mean_purchase_order, 4)) / (COUNT(*) * POWER(stats.variance_purchase_order, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_purchase_order, stats.variance_purchase_order

    UNION ALL

    SELECT
        'item' AS column_name,
        CASE 
            WHEN stats.variance_item = 0 THEN NULL
            ELSE (SUM(POWER("item" - stats.mean_item, 4)) / (COUNT(*) * POWER(stats.variance_item, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_item, stats.variance_item

    UNION ALL

    SELECT
        'reason_for_movement' AS column_name,
        CASE 
            WHEN stats.variance_reason_for_movement = 0 THEN NULL
            ELSE (SUM(POWER("reason_for_movement" - stats.mean_reason_for_movement, 4)) / (COUNT(*) * POWER(stats.variance_reason_for_movement, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_reason_for_movement, stats.variance_reason_for_movement

    UNION ALL

    SELECT
        'cost_center' AS column_name,
        CASE 
            WHEN stats.variance_cost_center = 0 THEN NULL
            ELSE (SUM(POWER("cost_center" - stats.mean_cost_center, 4)) / (COUNT(*) * POWER(stats.variance_cost_center, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_cost_center, stats.variance_cost_center

    UNION ALL

    SELECT
        'supplier' AS column_name,
        CASE 
            WHEN stats.variance_supplier = 0 THEN NULL
            ELSE (SUM(POWER("supplier" - stats.mean_supplier, 4)) / (COUNT(*) * POWER(stats.variance_supplier, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_supplier, stats.variance_supplier

    UNION ALL

    SELECT
        'quantity' AS column_name,
        CASE 
            WHEN stats.variance_quantity = 0 THEN NULL
            ELSE (SUM(POWER("quantity" - stats.mean_quantity, 4)) / (COUNT(*) * POWER(stats.variance_quantity, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_quantity, stats.variance_quantity

    UNION ALL

    SELECT
        'material_doc_year' AS column_name,
        CASE 
            WHEN stats.variance_material_doc_year = 0 THEN NULL
            ELSE (SUM(POWER("material_doc_year" - stats.mean_material_doc_year, 4)) / (COUNT(*) * POWER(stats.variance_material_doc_year, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_doc_year, stats.variance_material_doc_year

    UNION ALL

    SELECT
        'item_no_stock_transfer_reserv' AS column_name,
        CASE 
            WHEN stats.variance_item_no_stock_transfer_reserv = 0 THEN NULL
            ELSE (SUM(POWER("item_no_stock_transfer_reserv" - stats.mean_item_no_stock_transfer_reserv, 4)) / (COUNT(*) * POWER(stats.variance_item_no_stock_transfer_reserv, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_item_no_stock_transfer_reserv, stats.variance_item_no_stock_transfer_reserv

    UNION ALL

    SELECT
        'product_code' AS column_name,
        CASE 
            WHEN stats.variance_product_code = 0 THEN NULL
            ELSE (SUM(POWER("product_code" - stats.mean_product_code, 4)) / (COUNT(*) * POWER(stats.variance_product_code, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_product_code, stats.variance_product_code

    UNION ALL

    SELECT
        'vendor_code' AS column_name,
        CASE 
            WHEN stats.variance_vendor_code = 0 THEN NULL
            ELSE (SUM(POWER("vendor_code" - stats.mean_vendor_code, 4)) / (COUNT(*) * POWER(stats.variance_vendor_code, 2))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_vendor_code, stats.variance_vendor_code
)

SELECT * FROM kurtosis;

-- Another Kurtosis Distribution with power 4
-- Kurtosis calculation for each numeric column
WITH stats AS (
    SELECT
        COUNT(*) AS n,
        AVG("material_id") AS mean_material_id,
        VAR_SAMP("material_id") AS variance_material_id,
        AVG("plant_code") AS mean_plant_code,
        VAR_SAMP("plant_code") AS variance_plant_code,
        AVG("movement_type") AS mean_movement_type,
        VAR_SAMP("movement_type") AS variance_movement_type,
        AVG("material_document") AS mean_material_document,
        VAR_SAMP("material_document") AS variance_material_document,
        AVG("qty_in_un_of_entry") AS mean_qty_in_un_of_entry,
        VAR_SAMP("qty_in_un_of_entry") AS variance_qty_in_un_of_entry,
        AVG("batch") AS mean_batch,
        VAR_SAMP("batch") AS variance_batch,
        AVG("order") AS mean_order,
        VAR_SAMP("order") AS variance_order,
        AVG("qty_in_opun") AS mean_qty_in_opun,
        VAR_SAMP("qty_in_opun") AS variance_qty_in_opun,
        AVG("qty_in_order_unit") AS mean_qty_in_order_unit,
        VAR_SAMP("qty_in_order_unit") AS variance_qty_in_order_unit,
        AVG("company_code") AS mean_company_code,
        VAR_SAMP("company_code") AS variance_company_code,
        AVG("amount_in_lc") AS mean_amount_in_lc,
        VAR_SAMP("amount_in_lc") AS variance_amount_in_lc,
        AVG("purchase_order") AS mean_purchase_order,
        VAR_SAMP("purchase_order") AS variance_purchase_order,
        AVG("item") AS mean_item,
        VAR_SAMP("item") AS variance_item,
        AVG("reason_for_movement") AS mean_reason_for_movement,
        VAR_SAMP("reason_for_movement") AS variance_reason_for_movement,
        AVG("cost_center") AS mean_cost_center,
        VAR_SAMP("cost_center") AS variance_cost_center,
        AVG("supplier") AS mean_supplier,
        VAR_SAMP("supplier") AS variance_supplier,
        AVG("quantity") AS mean_quantity,
        VAR_SAMP("quantity") AS variance_quantity,
        AVG("material_doc_year") AS mean_material_doc_year,
        VAR_SAMP("material_doc_year") AS variance_material_doc_year,
        AVG("item_no_stock_transfer_reserv") AS mean_item_no_stock_transfer_reserv,
        VAR_SAMP("item_no_stock_transfer_reserv") AS variance_item_no_stock_transfer_reserv,
        AVG("product_code") AS mean_product_code,
        VAR_SAMP("product_code") AS variance_product_code,
        AVG("vendor_code") AS mean_vendor_code,
        VAR_SAMP("vendor_code") AS variance_vendor_code
    FROM "inventory_backup"
),

kurtosis AS (
    SELECT
        'material_id' AS column_name,
        CASE 
            WHEN stats.variance_material_id = 0 THEN NULL
            ELSE (SUM(POWER("material_id" - stats.mean_material_id, 4)) / (COUNT(*) * POWER(stats.variance_material_id, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_id, stats.variance_material_id

    UNION ALL

    SELECT
        'plant_code' AS column_name,
        CASE 
            WHEN stats.variance_plant_code = 0 THEN NULL
            ELSE (SUM(POWER("plant_code" - stats.mean_plant_code, 4)) / (COUNT(*) * POWER(stats.variance_plant_code, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_plant_code, stats.variance_plant_code

    UNION ALL

    SELECT
        'movement_type' AS column_name,
        CASE 
            WHEN stats.variance_movement_type = 0 THEN NULL
            ELSE (SUM(POWER("movement_type" - stats.mean_movement_type, 4)) / (COUNT(*) * POWER(stats.variance_movement_type, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_movement_type, stats.variance_movement_type

    UNION ALL

    SELECT
        'material_document' AS column_name,
        CASE 
            WHEN stats.variance_material_document = 0 THEN NULL
            ELSE (SUM(POWER("material_document" - stats.mean_material_document, 4)) / (COUNT(*) * POWER(stats.variance_material_document, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_document, stats.variance_material_document

    UNION ALL

    SELECT
        'qty_in_un_of_entry' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_un_of_entry = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_un_of_entry" - stats.mean_qty_in_un_of_entry, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_un_of_entry, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_un_of_entry, stats.variance_qty_in_un_of_entry

    UNION ALL

    SELECT
        'batch' AS column_name,
        CASE 
            WHEN stats.variance_batch = 0 THEN NULL
            ELSE (SUM(POWER("batch" - stats.mean_batch, 4)) / (COUNT(*) * POWER(stats.variance_batch, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_batch, stats.variance_batch

    UNION ALL

    SELECT
        'order' AS column_name,
        CASE 
            WHEN stats.variance_order = 0 THEN NULL
            ELSE (SUM(POWER("order" - stats.mean_order, 4)) / (COUNT(*) * POWER(stats.variance_order, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_order, stats.variance_order

    UNION ALL

    SELECT
        'qty_in_opun' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_opun = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_opun" - stats.mean_qty_in_opun, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_opun, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_opun, stats.variance_qty_in_opun

    UNION ALL

    SELECT
        'qty_in_order_unit' AS column_name,
        CASE 
            WHEN stats.variance_qty_in_order_unit = 0 THEN NULL
            ELSE (SUM(POWER("qty_in_order_unit" - stats.mean_qty_in_order_unit, 4)) / (COUNT(*) * POWER(stats.variance_qty_in_order_unit, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_qty_in_order_unit, stats.variance_qty_in_order_unit

    UNION ALL

    SELECT
        'company_code' AS column_name,
        CASE 
            WHEN stats.variance_company_code = 0 THEN NULL
            ELSE (SUM(POWER("company_code" - stats.mean_company_code, 4)) / (COUNT(*) * POWER(stats.variance_company_code, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_company_code, stats.variance_company_code

    UNION ALL

    SELECT
        'amount_in_lc' AS column_name,
        CASE 
            WHEN stats.variance_amount_in_lc = 0 THEN NULL
            ELSE (SUM(POWER("amount_in_lc" - stats.mean_amount_in_lc, 4)) / (COUNT(*) * POWER(stats.variance_amount_in_lc, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_amount_in_lc, stats.variance_amount_in_lc

    UNION ALL

    SELECT
        'purchase_order' AS column_name,
        CASE 
            WHEN stats.variance_purchase_order = 0 THEN NULL
            ELSE (SUM(POWER("purchase_order" - stats.mean_purchase_order, 4)) / (COUNT(*) * POWER(stats.variance_purchase_order, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_purchase_order, stats.variance_purchase_order

    UNION ALL

    SELECT
        'item' AS column_name,
        CASE 
            WHEN stats.variance_item = 0 THEN NULL
            ELSE (SUM(POWER("item" - stats.mean_item, 4)) / (COUNT(*) * POWER(stats.variance_item, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_item, stats.variance_item

    UNION ALL

    SELECT
        'reason_for_movement' AS column_name,
        CASE 
            WHEN stats.variance_reason_for_movement = 0 THEN NULL
            ELSE (SUM(POWER("reason_for_movement" - stats.mean_reason_for_movement, 4)) / (COUNT(*) * POWER(stats.variance_reason_for_movement, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_reason_for_movement, stats.variance_reason_for_movement

    UNION ALL

    SELECT
        'cost_center' AS column_name,
        CASE 
            WHEN stats.variance_cost_center = 0 THEN NULL
            ELSE (SUM(POWER("cost_center" - stats.mean_cost_center, 4)) / (COUNT(*) * POWER(stats.variance_cost_center, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_cost_center, stats.variance_cost_center

    UNION ALL

    SELECT
        'supplier' AS column_name,
        CASE 
            WHEN stats.variance_supplier = 0 THEN NULL
            ELSE (SUM(POWER("supplier" - stats.mean_supplier, 4)) / (COUNT(*) * POWER(stats.variance_supplier, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_supplier, stats.variance_supplier

    UNION ALL

    SELECT
        'quantity' AS column_name,
        CASE 
            WHEN stats.variance_quantity = 0 THEN NULL
            ELSE (SUM(POWER("quantity" - stats.mean_quantity, 4)) / (COUNT(*) * POWER(stats.variance_quantity, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_quantity, stats.variance_quantity

    UNION ALL

    SELECT
        'material_doc_year' AS column_name,
        CASE 
            WHEN stats.variance_material_doc_year = 0 THEN NULL
            ELSE (SUM(POWER("material_doc_year" - stats.mean_material_doc_year, 4)) / (COUNT(*) * POWER(stats.variance_material_doc_year, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_material_doc_year, stats.variance_material_doc_year

    UNION ALL

    SELECT
        'item_no_stock_transfer_reserv' AS column_name,
        CASE 
            WHEN stats.variance_item_no_stock_transfer_reserv = 0 THEN NULL
            ELSE (SUM(POWER("item_no_stock_transfer_reserv" - stats.mean_item_no_stock_transfer_reserv, 4)) / (COUNT(*) * POWER(stats.variance_item_no_stock_transfer_reserv, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_item_no_stock_transfer_reserv, stats.variance_item_no_stock_transfer_reserv

    UNION ALL

    SELECT
        'product_code' AS column_name,
        CASE 
            WHEN stats.variance_product_code = 0 THEN NULL
            ELSE (SUM(POWER("product_code" - stats.mean_product_code, 4)) / (COUNT(*) * POWER(stats.variance_product_code, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_product_code, stats.variance_product_code

    UNION ALL

    SELECT
        'vendor_code' AS column_name,
        CASE 
            WHEN stats.variance_vendor_code = 0 THEN NULL
            ELSE (SUM(POWER("vendor_code" - stats.mean_vendor_code, 4)) / (COUNT(*) * POWER(stats.variance_vendor_code, 4))) - 3
        END AS kurtosis
    FROM "inventory_backup", stats
    GROUP BY stats.mean_vendor_code, stats.variance_vendor_code
)

SELECT * FROM kurtosis;

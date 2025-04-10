-- EXTERNAL TABLES

create or replace external table cloud_data_db.s3_data.EXT_SUPPLY_CHAIN
  with location = @supply_chain_data_stage
  auto_refresh = true
  file_format = csvformat;

SELECT * FROM cloud_data_db.s3_data.EXT_SUPPLY_CHAIN;

create or replace external table cloud_data_db.s3_data.EXT_SUPPLY_CHAIN_HARMONIZED
  (PRODUCT_ID VARCHAR   as (value:c1::varchar), 
   SUPPLIER_VENDOR_NAME VARCHAR   as (value:c2::varchar),
   INVOICE_NUMBER VARCHAR as (value:c3::varchar),
	PRODUCT_NAME VARCHAR as (value:c4::varchar),
	ORDER_DATE DATE as (value:c5::date),
	SHIP_DATE DATE as (value:c6::date),
	DELIVERY_DATE DATE as (value:c7::date),
	DELIVERY_TIME NUMBER as (value:c8::number),
	PRICE NUMBER as (value:c9::number),
	AVERAGE_SHIPPING_TIME NUMBER as (value:c10::number),
	AVERAGE_PRODUCT_PRICE NUMBER as (value:c11::number),
	CAPACITY NUMBER as (value:c12::number),
	PAYMENT_TERMS VARCHAR as (value:c13::varchar),
	RETURN_RATE NUMBER as (value:c14::number),
	SHIPPING_START_LOCATION VARCHAR as (value:c15::varchar))
  with location = @supply_chain_data_stage
  auto_refresh = true
  file_format = csvformat;

SELECT * FROM cloud_data_db.s3_data.EXT_SUPPLY_CHAIN_HARMONIZED;
 
copy into cloud_data_db.s3_data.SUPPLY_CHAIN  
  from @supply_chain_data_stage;


-- Analyze the sales by provider

SELECT
    SUPPLIER_VENDOR_NAME,
    SUM(PRICE) AS total_sales,
    COUNT(DISTINCT INVOICE_NUMBER) AS total_orders,
    AVG(AVERAGE_SHIPPING_TIME) AS avg_shipping_time,
    AVG(RETURN_RATE) AS avg_return_rate
FROM
    cloud_data_db.s3_data.SUPPLY_CHAIN
GROUP BY
    SUPPLIER_VENDOR_NAME
ORDER BY
    total_sales DESC;

SELECT
    SUPPLIER_VENDOR_NAME,
    SUM(PRICE) AS total_sales,
    COUNT(DISTINCT INVOICE_NUMBER) AS total_orders,
    AVG(AVERAGE_SHIPPING_TIME) AS avg_shipping_time,
    AVG(RETURN_RATE) AS avg_return_rate
FROM
    cloud_data_db.s3_data.EXT_SUPPLY_CHAIN_HARMONIZED
GROUP BY
    SUPPLIER_VENDOR_NAME
ORDER BY
    total_sales DESC;

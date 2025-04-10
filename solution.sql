-- TRY BY YOURSELF

create or replace stage cloud_data_db.s3_data.supply_chain_data_stage  
  file_format = csvformat  
  url = 's3://sfquickstarts/sfguide_integrate_snowflake_cortex_agents_with_microsoft_teams/supply_chain/';  


create or replace TABLE cloud_data_db.s3_data.SUPPLY_CHAIN (
	PRODUCT_ID VARCHAR(16777216),
	SUPPLIER_VENDOR_NAME VARCHAR(16777216),
	INVOICE_NUMBER VARCHAR(16777216),
	PRODUCT_NAME VARCHAR(16777216),
	ORDER_DATE DATE,
	SHIP_DATE DATE,
	DELIVERY_DATE DATE,
	DELIVERY_TIME NUMBER(38,0),
	PRICE NUMBER(38,2),
	AVERAGE_SHIPPING_TIME NUMBER(38,1),
	AVERAGE_PRODUCT_PRICE NUMBER(38,2),
	CAPACITY NUMBER(38,0),
	PAYMENT_TERMS VARCHAR(16777216),
	RETURN_RATE NUMBER(38,2),
	SHIPPING_START_LOCATION VARCHAR(16777216)
);

copy into  SUPPLY_CHAIN
  from @supply_chain_data_stage ;


SELECT * FROM cloud_data_db.s3_data.SUPPLY_CHAIN;

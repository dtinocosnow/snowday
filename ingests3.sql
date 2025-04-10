USE ROLE accountadmin;
USE WAREHOUSE compute_wh;

CREATE OR REPLACE DATABASE cloud_data_db
  COMMENT = 'Database for loading cloud data';

CREATE OR REPLACE SCHEMA cloud_data_db.s3_data
  COMMENT = 'Schema for tables loaded from S3';

CREATE OR REPLACE TABLE cloud_data_db.s3_data.SUPPORT_TICKETS 
  (
  ticket_id VARCHAR(60),  
  customer_name VARCHAR(60),  
  customer_email VARCHAR(60),  
  service_type VARCHAR(60),  
  request VARCHAR,  
  contact_preference VARCHAR(60)  
  )
  COMMENT = 'Table to be loaded from S3';

SELECT * FROM cloud_data_db.s3_data.SUPPORT_TICKETS;

-- Create integration to AWS

 -- CREATE OR REPLACE STORAGE INTEGRATION s3_data_integration
 --  TYPE = EXTERNAL_STAGE
 --  STORAGE_PROVIDER = 'S3'
 --  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::631373164455:role/tutorial_role'
 --  ENABLED = TRUE
 --  STORAGE_ALLOWED_LOCATIONS = ('s3://snow-tutorial-bucket/s3data/');


create or replace file format csvformat  
  skip_header = 1  
  field_optionally_enclosed_by = '"'  
  type = 'CSV';  
  
create or replace stage support_tickets_data_stage  
  file_format = csvformat  
  url = 's3://sfquickstarts/sfguide_integrate_snowflake_cortex_agents_with_microsoft_teams/support/';  

-- Create a stage

-- CREATE OR REPLACE STAGE cloud_data_db.s3_data.s3data_stage
--   STORAGE_INTEGRATION = s3_data_integration
--   URL = 's3://snow-tutorial-bucket/s3data/'
--   FILE_FORMAT = (TYPE = CSV);

SHOW STAGES;

copy into SUPPORT_TICKETS  
  from @support_tickets_data_stage;


SELECT * FROM cloud_data_db.s3_data.SUPPORT_TICKETS;

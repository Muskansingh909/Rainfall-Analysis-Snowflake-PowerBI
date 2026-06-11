CREATE OR REPLACE STORAGE INTEGRATION PBI_Integration
  TYPE = EXTERNAL_STAGE
  STORAGE_PROVIDER = 'S3'
  ENABLED = TRUE
  STORAGE_AWS_ROLE_ARN = 'arn:aws:iam::651863678540:role/powerbi.role'
  STORAGE_ALLOWED_LOCATIONS = ('s3://powerbiii-project/')
  COMMENT = 'Optional Comment'



 //description Integration Object
  desc integration PBI_Integration;

//drop integration PBI_Integration

--------------------------------------------
//drop database PowerBI

CREATE database PowerBI;

create schema PBI_Data;

create table PBI_Dataset (
Year int,	Location string,	Area	int,
Rainfall	float, Temperature	float, Soil_type string,
Irrigation	string, yeilds	int,Humidity	float,
Crops	string,price	int,Season string



);

select * from PBI_Dataset;

//drop database test;

create stage PowerBI.PBI_Data.pbi_stage
url = 's3://powerbiii-project'
storage_integration = PBI_Integration

//desc stage s1

//drop stage s1;



copy into PBI_Dataset 
from @pbi_stage
file_format = (type=csv field_delimiter=',' skip_header=1 )
on_error = 'continue'



desc stage pbi_stage;
desc integration pbi_integration;

select * from pbi_dataset;

select year,count(*) from pbi_dataset group by year;

create table agriculture as 
select * from pbi_dataset;

select * from agriculture;


update agriculture
set rainfall = 1.1* rainfall;

update agriculture
set area= 0.9* area;

//year btw 2004 and 2009- Y1
           //2010 N 2015- Y2
           //2016 N 2019- Y3    

alter  table agriculture         
add Year_Group String;

update agriculture
set Year_Group ='Y1'
where year>=2004 and year<= 2009

update agriculture
set Year_Group ='Y1'
where year>=2010 and year<= 2015


update agriculture
set Year_Group ='Y1'
where year>=2016 and year<= 2019


//RAINFALL GROUPSSS
MIN 255 MAX 4103

ALTER TABLE agriculture
add Rainfall_Groups string;

update agriculture
set rainfall_groups ='Low'
where rainfall>=255 and rainfall<=1200;

update agriculture
set rainfall_groups ='Meduim'
where rainfall>=1200 and rainfall<=2800;

update agriculture
set rainfall_groups ='High'
where rainfall>=2800 ;


select * from pbi_dataset;

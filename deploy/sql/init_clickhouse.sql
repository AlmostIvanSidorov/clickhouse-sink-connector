use test;

CREATE TABLE employees
(
    `emp_no` Int32,
    `birth_date` Date32,
    `first_name` String,
    `last_name` String,
    `gender` String,
    `hire_date` Date32,
    `_offset` Nullable(UInt64),
    `_key` Nullable(String),
    `_topic` Nullable(String),
    `_partition` Nullable(UInt64),
    `_timestamp` Nullable(DateTime),
    `_timestamp_ms` Nullable(DateTime64(3)),
    `_ts_ms` Nullable(DateTime64(3)),
    `_server_id` Nullable(Int32),
    `_gtid` Nullable(Int32),
    `_binlog_file` Nullable(String),
    `_binlog_pos` Nullable(Int32),
    `_binlog_row` Nullable(Int32),
    `_server_thread` Nullable(Int32)
)
ENGINE = MergeTree
PRIMARY KEY emp_no
ORDER BY emp_no;

alter table employees
add column `salary` Nullable(UInt64),
add column num_years Nullable(UInt8),
add column bonus Nullable(UInt32),
add column small_value Nullable(UInt16),
add column int_value Nullable(UInt32),

add column discount Nullable(Int64),
add column num_years_signed Nullable(Int8),
add column bonus_signed Nullable(Int32),
add column small_value_signed Nullable(Int16),
add column int_value_signed Nullable(Int32);

alter table employees add column last_modified_date_time Nullable(String);
alter table employees add column last_access_time Nullable(String);

alter table employees  add column `married_status` Nullable(String);
alter table employees add column `perDiemRate` Nullable(Decimal(30, 12));

alter table employees  add column `hourlyRate` Nullable(Float64);
alter table employees add column `jobDescription` Nullable(String);

alter table employees add column `raw_data` Nullable(String);

-- alter table employees add column `updated_time` Nullable(DateTime);

alter table employees add column `bytes_date` Nullable(String);

alter table employees add column `binary_test_column` String;

alter table employees add column `blob_med` String;

alter table employees add column `blob_new` String;

CREATE TABLE products(
  `productCode` String,
  `productName` String,
  `productLine` String,
  `productScale` String,
  `productVendor` String,
  `productDescription` String,
  `quantityInStock` Int32,
  `buyPrice` Decimal(10,2),
  `MSRP` Decimal(10,2),
  `raw_data` String
)
ENGINE = MergeTree
PRIMARY KEY productCode;

CREATE TABLE t1(
`intcol1` UInt64,
`charcol1` String
)
ENGINE = MergeTree
PRIMARY KEY intcol1
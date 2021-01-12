create table dbo.PUBACC_LL
(
      record_type               char(2)              null,
      unique_system_identifier  numeric(9,0)         not null,
      uls_file_number           char(14)             null,
      ebf_number                varchar(30)          null,
      call_sign			char(10)             null,		
      lease_id			char(10)             null,      
      unique_system_identifier_2   numeric(9,0)         null     /*(the licensee) */
)

go

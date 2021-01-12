-- Parse::SQL::Dia version 0.11_01                           
-- Documentation   http://search.cpan.org/dist/Parse-Dia-SQL/
-- Environment     Perl 5.010001, /usr/bin/perl              
-- Architecture    i486-linux-gnu-thread-multi               
-- Target Database postgres                                  
-- Input file      Test.dia                                  
-- Generated at    Wed Nov 11 10:40:27 2009                  

-- get_constraints_drop 
alter table tbl_detail drop constraint fk_detail_main ;

-- get_permissions_drop 

-- get_view_drop

-- get_schema_drop
drop table tbl_main;
drop table tbl_detail;

-- get_smallpackage_pre_sql 

-- get_schema_create
create table tbl_main (
   pk_main SERIAL not null,
   constraint pk_tbl_main primary key (pk_main)
)   ;
create table tbl_detail (
   pk_detail SERIAL  not null,
   fk_main   INTEGER         ,
   constraint pk_tbl_detail primary key (pk_detail)
)   ;

-- get_view_create

-- get_permissions_create

-- get_inserts

-- get_smallpackage_post_sql

-- get_associations_create
alter table tbl_detail add constraint fk_detail_main 
    foreign key (fk_main)
    references tbl_main (pk_main) ON DELETE CASCADE;

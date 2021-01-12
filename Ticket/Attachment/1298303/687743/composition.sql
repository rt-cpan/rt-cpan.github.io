-- Parse::SQL::Dia      version 0.25                              
-- Documentation        http://search.cpan.org/dist/Parse-Dia-SQL/
-- Environment          Perl 5.010001, /usr/bin/perl              
-- Architecture         i486-linux-gnu-thread-multi               
-- Target Database      postgres                                  
-- Input file           composition.dia                           
-- Generated at         Wed Dec  4 17:54:48 2013                  
-- Typemap for postgres not found in input file                   

-- get_constraints_drop 
alter table two drop constraint two_fk_One_id ;

-- get_permissions_drop 

-- get_view_drop

-- get_schema_drop
drop table one;
drop table two;

-- get_smallpackage_pre_sql 

-- get_schema_create
create table one (
   id integer not null,
   constraint pk_one primary key (id)
)   ;
create table two (
   id     integer not null,
   one_id integer         ,
   constraint pk_two primary key (id)
)   ;

-- get_view_create

-- get_permissions_create

-- get_inserts

-- get_smallpackage_post_sql

-- get_associations_create
alter table two add constraint two_fk_One_id 
    foreign key (one_id)
    references one (id) ;

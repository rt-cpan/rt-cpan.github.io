-- Parse::SQL::Dia version 0.12                              
-- Documentation   http://search.cpan.org/dist/Parse-Dia-SQL/
-- Environment     Perl 5.010000, /usr/bin/perl              
-- Architecture    i486-linux-gnu-thread-multi               
-- Target Database postgres                                  
-- Input file      sp_columns.dia-0.97.dia                   
-- Generated at    Wed Dec 16 18:20:26 2009                  

-- get_constraints_drop 

-- get_permissions_drop 

-- get_view_drop

-- get_schema_drop
drop table users;
drop table testimonies;

-- get_smallpackage_pre_sql 

-- get_schema_create
create table users (
   id    serial         ,
   first TEXT   not null,
   last  TEXT           ,
   UNIQUE (first, last),
   UNIQUE (first)
)   ;
create table testimonies (
   id      serial          ,
   from    integer not null,
   to      integer not null,
   subject text            ,
   comment text    not null,
   UNIQUE (id, from)
)   ;

-- get_view_create

-- get_permissions_create

-- get_inserts

-- get_smallpackage_post_sql

-- get_associations_create

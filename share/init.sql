create role developer_commons;
grant create session to developer_commons;
grant resource to developer_commons;

select * from dba_tablespaces;

create tablespace event
datafile '/u01/app/oracle/product/11.2.0/xe/dbs/event.dbf' size 10M AUTOEXTEND ON
nologging;

create tablespace event_data01
datafile '/u01/app/oracle/product/11.2.0/xe/dbs/event_data01.dbf' size 10M AUTOEXTEND ON
nologging;

create tablespace event_data02
datafile '/u01/app/oracle/product/11.2.0/xe/dbs/event_data02.dbf' size 10M AUTOEXTEND ON
nologging;

create tablespace event_idx
datafile '/u01/app/oracle/product/11.2.0/xe/dbs/event_idx.dbf' size 10M AUTOEXTEND ON
nologging;

create or replace PROCEDURE create_develop_user(str VARCHAR2)
    IS
      usr varchar(30);
      stmt varchar(500);
    BEGIN
      usr := str;
      stmt := 'create user ' || usr ||
                ' identified by ' || usr ||
                ' account unlock ' ||
                ' default tablespace event ' ||
                ' temporary tablespace temp ' ||
                ' quota unlimited on event ' ||
                ' quota unlimited on event_data01 ' ||
                ' quota unlimited on event_data02 ' ||
                ' quota unlimited on event_idx';
      execute immediate stmt;

      stmt := 'grant developer_commons to ' || usr;
      execute immediate stmt;
    END;
/

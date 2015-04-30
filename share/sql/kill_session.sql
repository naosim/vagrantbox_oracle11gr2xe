CREATE OR REPLACE PROCEDURE kill_session
IS
  CURSOR c1 IS select sid || ',' || serial# as s_id,username,logon_time from v$session where username = 'MOBILE';
  s_id varchar(30);
  stmt varchar(300);

BEGIN
  DBMS_OUTPUT.PUT_LINE('start...');
  FOR rec IN c1 LOOP

    s_id := rec.s_id;
    stmt := 'ALTER SYSTEM KILL SESSION ''' || s_id || '''' || 'IMMEDIATE';

    execute immediate stmt;
    END LOOP;
  DBMS_OUTPUT.PUT_LINE('...end');
END;
/

exit

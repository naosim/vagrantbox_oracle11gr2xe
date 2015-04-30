/*
  interval_day_to_second型を秒数に変換する
*/


CREATE OR REPLACE FUNCTION itvl_to_sec(i INTERVAL DAY TO SECOND) RETURN NUMBER
IS
  itvl INTERVAL DAY TO SECOND;
  TOTAL_SECOND NUMBER;

BEGIN
  DBMS_OUTPUT.PUT_LINE('start...');
  
  itvl := i;
  
  SELECT 
      EXTRACT(DAY    FROM itvl) * 86400
    + EXTRACT(HOUR   FROM itvl) *  3600
    + EXTRACT(MINUTE FROM itvl) *    60
    + EXTRACT(SECOND FROM itvl) AS TOTAL_SECOND INTO TOTAL_SECOND
  FROM DUAL;
  DBMS_OUTPUT.PUT_LINE('...end');
  
  return TOTAL_SECOND;
END itvl_to_sec;
/

exit

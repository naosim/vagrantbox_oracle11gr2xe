/*
  第一引数に指定した日付に、第２引数のタイムスタンプ型をくっつける。
  例）
    select recent_date(to_date('2013/12/8', 'yyyy/mm/dd'), '12/9', 'MM/DD') from dual;
    → 2012/12/09 00:00:00 
    
    select recent_date(to_date('2013/12/9', 'yyyy/mm/dd'), '12/9', 'MM/DD') from dual;
    → 2013/12/09 00:00:00
    
    select recent_date(to_date('2013/12/10', 'yyyy/mm/dd'), '12/9', 'MM/DD') from dual;
    → 2013/12/09 00:00:00
  
  dt：基準となる日付
  md：返却する日付
  fmt：mdの日付フォーマット
  
*/


CREATE OR REPLACE FUNCTION conn_dt_tstmp(dt DATE, ts VARCHAR) RETURN TIMESTAMP
IS
  tstmp TIMESTAMP;
BEGIN
  
  tstmp := CAST(dt AS TIMESTAMP) + to_dsinterval('0 ' || ts);
  return tstmp;
END conn_dt_tstmp;
/

exit
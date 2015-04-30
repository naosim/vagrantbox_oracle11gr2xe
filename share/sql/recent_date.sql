/*
  第一引数に指定した日時から数えて、最も最近の第２引数に指定した日付を返却する。
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


CREATE OR REPLACE FUNCTION recent_date(dt DATE, md VARCHAR2, fmt VARCHAR2) RETURN DATE
IS
  TMP_DATE DATE;
  RECENT_DATE DATE;
BEGIN
  
  TMP_DATE := to_date(to_char(dt, 'yyyy') || '/' || md, 'yyyy/' || fmt);
  
  if(dt >= TMP_DATE) THEN
    RECENT_DATE := TMP_DATE;
  ELSIF (dt < TMP_DATE) THEN
    RECENT_DATE := to_date(to_char(to_number(to_char(dt, 'yyyy')) -1 ) || '/' || md, 'yyyy/' || fmt);
  END IF;

  return RECENT_DATE;
END recent_date;
/

exit
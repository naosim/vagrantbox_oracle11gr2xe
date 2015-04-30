CREATE OR REPLACE FUNCTION binary_to_euc(b IN blob)
  RETURN varchar2
  IS
    ret varchar2(32767);
  BEGIN
    ret := utl_raw.cast_to_varchar2(b);
    RETURN ret;
  END;
/

exit

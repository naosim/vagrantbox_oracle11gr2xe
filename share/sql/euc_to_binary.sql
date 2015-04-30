CREATE OR REPLACE FUNCTION euc_to_binary(str IN varchar2)
  RETURN blob
  IS
    ret blob;
  BEGIN
    ret := utl_raw.cast_to_raw(str);
    RETURN ret;
  END;
/

exit

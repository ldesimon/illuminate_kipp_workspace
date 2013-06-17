SET serveroutput on
set termout off
set echo off
set feedback off

DEFINE IE_YEAR_ID = 22
DEFINE IE_ACADEMIC_YEAR = '2012-2013'
DEFINE IE_FIRST_DAY = '30-JUN-2012'

VARIABLE TAB CHAR;
EXEC :TAB := CHR(9);


@@enrollment_ALL.sql
@@mastschd_ALL.sql
@@roster_ALL.sql
@@studemo_ALL.sql
@@terms_ALL.sql

EXIT



SET serveroutput on
set termout off
set echo off
set feedback off

DEFINE IE_YEAR_ID = 22
DEFINE IE_ACADEMIC_YEAR = '2012-2013'
DEFINE IE_FIRST_DAY = '30-JUN-2012'


VARIABLE TAB CHAR;
EXEC :TAB := CHR(9);

@@contacts_father.sql
@@contacts_mother.sql
@@courses.sql
@@enrollment.sql
@@mastschd.sql
@@programs.sql
@@roster.sql
@@sites.sql
@@studemo.sql
@@terms.sql
@@transcripts.sql
@@users.sql


EXIT



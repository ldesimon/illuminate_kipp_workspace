SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 3000
SET VERIFY OFF
SPOOL 'psexports\contacts_father.txt';
-- Write student demographic column headers.
--
SELECT
		   '01 Student ID'
|| :TAB || '02 State Student ID'
|| :TAB || '03 Student Last Name'
|| :TAB || '04 Student First Name'
|| :TAB || '05 Student Middle Name'
|| :TAB || '06 Birth Date'
|| :TAB || '07 Contact Last Name'
|| :TAB || '08 Contact First Name'
|| :TAB || '09 Address 1'
|| :TAB || '10 Address 2'
|| :TAB || '11 City'
|| :TAB || '12 State'
|| :TAB || '13 Zip'
|| :TAB || '14 Phone 1'
|| :TAB || '15 Phone Type 1'
|| :TAB || '16 Phone 2'
|| :TAB || '17 Phone Type 2'
|| :TAB || '18 Legal Guardian'
|| :TAB || '19 Primary Contact'
|| :TAB || '20 Contact Type'
|| :TAB || '21 Contact ID'
|| :TAB || '22 Email Address'
|| :TAB || '23 Correspndence Language'
|| :TAB || '24 Restraining Order'
|| :TAB || '25 Family Household ID'
|| :TAB || '26 Emergency Contact'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write student demographic data.
--
SELECT
             s.Student_Number
  || :TAB || s.STATE_STUDENTNUMBER
  || :TAB || s.Last_Name
  || :TAB || s.First_Name
  || :TAB || s.Middle_Name
  || :TAB || TO_CHAR( s.DOB, 'MM/dd/yyyy' )
  || :TAB || SUBSTR (s.father, 1, INSTR(s.father, ',', 1, 1) -1)
  || :TAB || SUBSTR (s.father, (INSTR(s.father, ',', 1, 1)+1))
  || :TAB || s.Mailing_Street
  || :TAB || s.Street
  || :TAB || s.Mailing_City
  || :TAB || s.Mailing_State
  || :TAB || s.Mailing_Zip
  || :TAB ||  ps_customfields.getStudentsCF (s.id,'father_home_phone')
  || :TAB || 'H'
  || :TAB ||  ps_customfields.getStudentsCF (s.id,'fatherdayphone')
  || :TAB || 'D'
  || :TAB || 1
  || :TAB || 1
  || :TAB || 'Father'
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Students table.  Table alias name is 's'.  Custom fields can be pulled using: ps_customfields.getStudentsCF(s.id, 'FIELDNAME')
--END additional data columns
FROM
  (SELECT * FROM ps.students ORDER BY last_name, first_name) s
  WHERE s.entrydate >= '&IE_FIRST_DAY'
/
SPOOL OFF
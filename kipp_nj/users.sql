--prepped 6/26
--need to review how PW/logins are managed with LDAP?
--removed all custom fields

SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 3000
SET VERIFY OFF
SPOOL 'psexports\users.txt';
-- Write teacher column headers.
--
SELECT DISTINCT
			 '01 User ID'
  || :TAB || '02 User Last Name'
  || :TAB || '03 User First Name'
  || :TAB || '04 User Middle Name'
  || :TAB || '05 Birth Date'
  || :TAB || '06 Gender'
  || :TAB || '07 Email Address'
  || :TAB || '08 Username'
  || :TAB || '09 Password'
  || :TAB || '10 State User or Employee ID'
  || :TAB || '11 Name suffix'
  || :TAB || '12 Former First Name'
  || :TAB || '13 Former Middle Name'
  || :TAB || '14 Former Last Name'
  || :TAB || '15 Primary Race'
  || :TAB || '16 User is Hispanic'
  || :TAB || '17 Address'
  || :TAB || '18 City'
  || :TAB || '19 State'
  || :TAB || '20 Zip'
  || :TAB || '21 Job Title'
  || :TAB || '22 Education Level'
  || :TAB || '23 Hire Date'
  || :TAB || '24 Exit Date'
  || :TAB || '25 Active'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write teacher data.
--
SELECT DISTINCT
             t.ID
  || :TAB || t.Last_Name
  || :TAB || t.First_Name
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || t.EMAIL_ADDR
  || :TAB || t.teacherloginid
  || :TAB || t.teacherloginpw
  || :TAB || t.teachernumber
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
  || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Teachers table(t). Custom teacher fields:  ps_customfields.getTeachersCF(t.id, 'FIELDNAME')
--END additional data columns
FROM
 (SELECT * FROM ps.teachers ORDER BY last_name, first_name) t
JOIN ps.cc ON t.id = cc.teacherid
WHERE t.status = 1 --active teachers only
/
SPOOL OFF
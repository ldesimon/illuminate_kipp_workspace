--prepped 6/26
--no edits

SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 300
SPOOL 'psexports\sites.txt';
-- Write course column headers.
--
SELECT  DISTINCT
			'01 Site ID'
 || :TAB || '02 Site Name'
 || :TAB || '03 State Site ID'
 || :TAB || '04 Start Grade Level ID'
 || :TAB || '05 End Grade Level ID'
 || :TAB || '06 School Type ID'
 || :TAB || '07 Address 1'
 || :TAB || '08 Address 2'
 || :TAB || '09 City'
 || :TAB || '10 State'
 || :TAB || '11 Zip Code'
 || :TAB || '12 Local Site Code'
 || :TAB || '13 Annual Hours of Instruction'
 || :TAB || '14 Annual Number of Weeks of Instruction'
 || :TAB || '15 Parent Site ID'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write course data.
--
SELECT DISTINCT
			s.SCHOOL_NUMBER
 || :TAB || s.NAME
 || :TAB || s.COUNTYNBR||s.DISTRICT_NUMBER||s.SCHOOL_NUMBER
 || :TAB || CASE s.LOW_GRADE WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
 || :TAB || CASE s.HIGH_GRADE WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
 || :TAB || CASE WHEN s.NAME LIKE '%Middle%' THEN 1 WHEN s.NAME LIKE '%High%' THEN 2 WHEN s.NAME LIKE '%Elementary%' THEN 9 WHEN s.NAME LIKE '%Pre%' THEN 4 ELSE 7 END
 || :TAB || s.SCHOOLADDRESS
 || :TAB || ''
 || :TAB || s.SCHOOLCITY
 || :TAB || s.SCHOOLSTATE
 || :TAB || s.SCHOOLZIP
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 --BEGIN additional data columns
--Acceptable fields:
--Schools table(s).  Custom schools fields:  ps_customfields.getSchoolsCF(c.id, 'FIELDNAME')
--END additional data columns
FROM (SELECT * FROM ps.schools order by school_number) s
/
SPOOL OFF
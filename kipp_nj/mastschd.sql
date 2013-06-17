SET HEADING OFF
SET FEEDBACK OFF
SET TRIMSPOOL ON
SET PAGESIZE 0
SET LINESIZE 300
SPOOL 'psexports\mastschd.txt';
-- Write course column headers.
--
SELECT  DISTINCT
			'01 Section ID'
 || :TAB || '02 Site ID'
 || :TAB || '03 Term Name'
 || :TAB || '04 Course ID'
 || :TAB || '05 User ID'
 || :TAB || '06 Period'
 || :TAB || '07 AcademicYear'
 || :TAB || '08 Room Number'
 || :TAB || '09 Session Type'
 || :TAB || '10 Unique Term ID'
 || :TAB || '11 Quarter Number'
 || :TAB || '12 User Start Date'
 || :TAB || '13 User End Date'
 || :TAB || '14 Primary User'
 || :TAB || '15 Highly Qualified Teacher Competency Code'
--BEGIN additional column headers
--END additional column headers
FROM DUAL
/
-- Write course data.
--
SELECT DISTINCT
			s.ID
 || :TAB || s.SCHOOLID
 || :TAB || CASE WHEN t.ABBREVIATION LIKE '%-%' THEN 'Y' ELSE t.ABBREVIATION END
 || :TAB || s.COURSE_NUMBER
 || :TAB || s.TEACHER
 || :TAB || s.EXPRESSION
 || :TAB || TO_CHAR(t.yearid + 1990)||'-'||TO_CHAR(t.yearid + 1991)
 || :TAB || s.room
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
 || :TAB || ''
--BEGIN additional data columns
--Acceptable fields:
--Terms table(t).  Custom section fields:  ps_customfields.getTermsCF(c.id, 'FIELDNAME')
--Section table(s).  Custom section fields:  ps_customfields.getSectionsCF(c.id, 'FIELDNAME')
--END additional data columns
FROM (SELECT * FROM ps.terms) t
INNER JOIN sections s ON (t.ID = s.TERMID and t.schoolid = s.schoolid)
WHERE t.yearid = &IE_YEAR_ID
/
SPOOL OFF
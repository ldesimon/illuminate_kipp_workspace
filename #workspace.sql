
--enrollment


select
 s.Student_Number
,ps_customfields.getStudentsCF(s.id, 'SID')
,s.Last_Name
,s.First_Name
,NULL
,TO_CHAR( s.DOB, 'MM/dd/yyyy' )
,e.SCHOOLID
,TO_CHAR( e.ENTRYDATE, 'MM/dd/yyyy' )
,TO_CHAR( e.EXITDATE, 'MM/dd/yyyy' )
,CASE e.GRADE_LEVEL WHEN -2 THEN 15 WHEN -1 THEN 15 WHEN 0 THEN 1 WHEN 1 THEN 2 WHEN 2 THEN 3 WHEN 3 THEN 4 WHEN 4 THEN 5 WHEN 5 THEN 6 WHEN 6 THEN 7 WHEN 7 THEN 8 WHEN 8 THEN 9 WHEN 9 THEN 10 WHEN 10 THEN 11 WHEN 11 THEN 12 WHEN 12 THEN 13 WHEN 99 THEN 14 END
,TO_CHAR(e.yearid + 1990)||'-'||TO_CHAR(e.yearid + 1991)
,NULL
,NULL
,e.exitcode
,NULL

FROM
(SELECT * FROM ps.students ORDER BY lastfirst) s
  JOIN ps.ps_enrollment_all e ON e.studentid = s.id
  WHERE e.yearid = 22
  

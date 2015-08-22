--Advance query
--1.
SELECT EVENTREQUEST.EVENTNO,CUSTNAME,CONTACT,DATEAUTH
FROM (EVENTPLAN right join EVENTREQUEST on EVENTPLAN.EVENTNO = EVENTREQUEST.EVENTNO)
inner join CUSTOMER on EVENTREQUEST.CUSTNO = CUSTOMER.CUSTNO
WHERE EVENTREQUEST.status = 'Approved'
and EVENTPLAN.PLANNO is null;

--2.
SELECT EVENTPLANLINE.PLANNO,COUNT(LINENO) AS lines,SUM((TIMEEND - TIMESTART)*24) AS total_hours, sum(numberfld) as total_number_Of_Resources, sum(rate) as total_resource_rates
FROM EVENTPLANLINE,EVENTPLAN,RESOURCETBL,LOCATIONTBL,FACILITY
WHERE EVENTPLANLINE.PLANNO = EVENTPLAN.PLANNO
and EVENTPLANLINE.LOCNO = LOCATIONTBL.LOCNO
and LOCATIONTBL.FACNO = FACILITY.FACNO
and EVENTPLANLINE.RESNO = RESOURCETBL.RESNO
and FACNAME = 'Basketball arena' 
and EVENTPLAN.WORKDATE between '1-dec-2013' and '31-dec-2013'
GROUP BY EVENTPLANLINE.PLANNO;

--3.
SELECT EVENTREQUEST.EVENTNO,DATEREQ,DATEAUTH,EVENTPLAN.PLANNO,WORKDATE,EMPNAME
FROM (EVENTPLAN left join EMPLOYEE on EVENTPLAN.EMPNO = EMPLOYEE.EMPNO)
inner join EVENTREQUEST on EVENTPLAN.EVENTNO = EVENTREQUEST.EVENTNO
WHERE DATEREQ between '1-jul-2013' and '31-jul-2013'
and DATEAUTH between '1-jul-2013' and '31-jul-2013'
and EVENTREQUEST.status = 'Approved';

--4.
SELECT LOCNAME,count(LINENO) as lines,sum((TIMEEND - TIMESTART)*24) as total_hours
FROM FACILITY,LOCATIONTBL,EVENTPLANLINE
WHERE LOCATIONTBL.LOCNO = EVENTPLANLINE.LOCNO
and LOCATIONTBL.FACNO = FACILITY.FACNO
and FACNAME = 'Basketball arena'
and TIMESTART between '1-dec-2013' and '31-dec-2013'
and TIMEEND between '1-dec-2013' and '31-dec-2013'
GROUP BY LOCNAME

--5.
SELECT EVENTPLAN.PLANNO,activity,WORKDATE
from EVENTPLAN,EVENTPLANLINE,RESOURCETBL
where eventplan.planno = eventplanline.planno
and eventplanline.resno = resourcetbl.resno
and workdate between '1-oct-2013' and '31-oct-2013'
and rate > 10
group by EVENTPLAN.PLANNO,activity,WORKDATE
HAVING count(*) = (select count(*) from RESOURCETBL where rate > 10);

SELECT iif(([EventPlan.workdate] is null,[EventRequest.eventno]),
	iif(((Year([EventPlan.workdate])=Year([EventRequest.dateheld])) 
	AND (Month([EventPlan.workdate]) = Month([EventRequest.dateheld]))),[EventPlan.eventno]))
FROM EventRequest INNER JOIN EventPlan ON EventRequest.eventno = EventPlan.eventno
ORDER BY EventPlan.workdate;

SELECT IIF(((Year([EventPlan.workdate])=Year([EventRequest.dateheld])) 
	AND (Month([EventPlan.workdate]) = Month([EventRequest.dateheld]))),[EventPlan.eventno],
	iif([EventPlan.workdate] is null,[EventRequest.eventno]))
FROM EventRequest INNER JOIN EventPlan ON EventRequest.eventno = EventPlan.eventno
ORDER BY EventPlan.workdate;

SELECT r.eventno
FROM EventRequest r, EventPlan p
WHERE (LEFT(dateheld, 2) & RIGHT(dateheld,4)) = (LEFT(workdate, 2) & RIGHT(workdate,4))
ORDER BY r.eventno;

SELECT r.eventno,workdate
FROM EventRequest r, EventPlan p
WHERE (Year([workdate])=Year([dateheld])) 
	AND (Month([workdate]) = Month([dateheld]))
GROUP BY r.eventno,workdate
ORDER BY r.eventno;
							  
				  
SELECT IIf(((Year([EventPlan.workdate])=Year([EventRequest.dateheld])) And (Month([EventPlan.workdate])=Month([EventRequest.dateheld]))),[EventPlan.eventno],IIf([EventPlan.workdate] Is Null,[EventRequest.eventno])) AS eventno, EventPlan.workdate, EventRequest.dateheld
FROM EventRequest INNER JOIN EventPlan ON EventRequest.eventno = EventPlan.eventno;

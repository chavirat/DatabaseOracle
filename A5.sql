--5. Write queries for the main form and the subform in Access
--Main form query:
SELECT EventPlan.eventno, 
Customer.custname, 
EventPlan.workdate, 
Facility.facname, 
EventPlan.planno, 
EventPlan.activity, 
EventPlan.empno, 
EventPlan.notes, EventRequest.dateheld
FROM Facility 
INNER JOIN ((Customer 
INNER JOIN EventRequest ON Customer.cusno = EventRequest.custno)
 		INNER JOIN EventPlan ON EventRequest.eventno = EventPlan.eventno) 
ON Facility.facno = EventRequest.facno;
--Sub form query:
SELECT EventPlanLine.lineno, 
EventPlanLine.locno, 
Location.locname, 
Resource.resno, 
Resource.resname, 
EventPlanLine.timestart, 
EventPlanLine.timeend, 
EventPlanLine.number AS Quantity, 
Resource.Rate,
([Resource].[Rate]*[eventplanline].[number]*(DateDiff("n",[timestart],[timeend])/60)) AS Amount, 
EventPlanLine.planno
FROM Resource 
INNER JOIN (Location 
INNER JOIN EventPlanLine ON Location.locno = EventPlanLine.locno) 
ON Resource.resno = EventPlanLine.resno
ORDER BY EventPlanLine.lineno;
Totalcost query: for calculation total cost per plan number
SELECT QyEventPlanning.planno, 
Sum(QyEventLine.Amount) AS Totalcost
FROM QyEventPlanning 
INNER JOIN QyEventLine ON QyEventPlanning.planno = QyEventLine.planno
GROUP BY QyEventPlanning.planno;
Other queries for assignment 3 extra
The supervisor query: for showing employee number in the supervisor combo box
SELECT DISTINCT EventPlan.empno
FROM EventPlan;
The event number query(QyTT): for showing the event number on the work date condition
SELECT r.eventno, p.workdate, r.dateheld
FROM EventRequest AS r, EventPlan AS p
WHERE (((Year([workdate]))=Year([dateheld])) AND ((Month([workdate]))=Month([dateheld])))
GROUP BY r.eventno, p.workdate, r.dateheld
HAVING (((p.workdate)=[Forms]![frmEventPlanning]![workdate]))
ORDER BY r.eventno;
The event number query (QyER): for showing all event number orderly when the work date is null.
SELECT EventRequest.eventno
FROM EventRequest
ORDER BY EventRequest.eventno;

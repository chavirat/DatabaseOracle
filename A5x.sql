--5. Write queries for the main form and the sub form in Access
--The Main Form query
SELECT OrderTbl.*,
 	Customer.*, 
Employee.EmpNo, 
Employee.EmpFirstName, 
Employee.EmpLastName
FROM Employee 
INNER JOIN (Customer 
INNER JOIN OrderTbl ON Customer.CustNo = OrderTbl.CustNo) 
ON Employee.EmpNo = OrderTbl.EmpNo;
The Sub Form query
SELECT OrdLine.ProdNo, 
Product.ProdName, 
Product.SuppNo, 
Supplier.SuppName, 
OrdLine.Qty, 
Product.ProdPrice AS Price, 
Qty*ProdPrice AS Amount, 
OrdLine.OrdNo
FROM Supplier 
INNER JOIN (Product 
INNER JOIN OrdLine ON Product.ProdNo = OrdLine.ProdNo) 
ON Supplier.SuppNo = Product.SuppNo;

--I create other sub form for calculation the total amount.
--The Total Amount query
SELECT MainForm.OrdNo, 
Sum(SubForm.Amount) AS Total_Amount
FROM SubForm 
INNER JOIN MainForm ON SubForm.OrdNo = MainForm.OrdNo
GROUP BY MainForm.OrdNo;

INSERT INTO Categories VALUES
(1,'Electronics'),
(2,'Fashion'),
(3,'Books');

INSERT INTO Customers VALUES
(101,'Akshay','akshay@gmail.com','Mumbai','2025-01-10'),
(102,'Rahul','rahul@gmail.com','Pune','2025-02-15'),
(103,'Priya','priya@gmail.com','Nashik','2025-03-20');

INSERT INTO Products VALUES
(201,'Laptop',1,55000,20),
(202,'Smartphone',1,25000,50),
(203,'T-Shirt',2,800,100),
(204,'Database Book',3,600,40);

INSERT INTO Orders VALUES
(301,101,'2026-06-01',55800),
(302,102,'2026-06-05',25000),
(303,103,'2026-06-10',1200);

INSERT INTO Order_Details VALUES
(1,301,201,1,55000),
(2,301,203,1,800),
(3,302,202,1,25000),
(4,303,204,2,1200);

INSERT INTO Payments VALUES
(401,301,'UPI','Completed','2026-06-01'),
(402,302,'Credit Card','Completed','2026-06-05'),
(403,303,'Cash','Pending','2026-06-10');
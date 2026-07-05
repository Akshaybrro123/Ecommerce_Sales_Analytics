-- =====================================================
-- E-Commerce Sales Analytics System
-- SQL Case Study Queries
-- =====================================================

-- Q1. Find the total number of customers.
SELECT COUNT(*) AS Total_Customers
FROM Customers;

-- Q2. Find the total sales generated.
SELECT SUM(total_amount) AS Total_Sales
FROM Orders;

-- Q3. Find the average order value.
SELECT AVG(total_amount) AS Average_Order
FROM Orders;

-- Q4. Find the highest sale amount.
SELECT MAX(total_amount) AS Highest_Sale
FROM Orders;

-- Q5. Find the lowest sale amount.
SELECT MIN(total_amount) AS Lowest_Sale
FROM Orders;

-- Q6. Display customer names along with their order IDs and order amounts.
SELECT c.customer_name,
       o.order_id,
       o.total_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id;

-- Q7. Display product names along with quantity sold and subtotal.
SELECT p.product_name,
       od.quantity,
       od.subtotal
FROM Products p
JOIN Order_Details od
ON p.product_id = od.product_id;

-- Q8. Display category names along with their products.
SELECT c.category_name,
       p.product_name
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id;

-- Q9. Find the product with the highest price.
SELECT product_name
FROM Products
WHERE price = (
    SELECT MAX(price)
    FROM Products
);

-- Q10. Find the customer who spent the most money.
SELECT customer_name
FROM Customers
WHERE customer_id = (
    SELECT customer_id
    FROM Orders
    GROUP BY customer_id
    ORDER BY SUM(total_amount) DESC
    LIMIT 1
);

-- Q11. Find products that were never ordered.
SELECT product_name
FROM Products
WHERE product_id NOT IN (
    SELECT product_id
    FROM Order_Details
);

-- Q12. Create a view to display customer sales reports.
CREATE VIEW Sales_Report AS
SELECT c.customer_name,
       o.order_id,
       o.total_amount
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id;

-- Q13. Display the sales report view.
SELECT *
FROM Sales_Report;

-- Q14. Create a stored procedure to display orders of a customer.
DELIMITER //
CREATE PROCEDURE GetCustomerOrders(IN cid INT)
BEGIN
    SELECT *
    FROM Orders
    WHERE customer_id = cid;
END //
DELIMITER ;

-- Q15. Execute the stored procedure.
CALL GetCustomerOrders(101);

-- Q16. Create a trigger to automatically update product stock.
DELIMITER //
CREATE TRIGGER Update_Stock
AFTER INSERT ON Order_Details
FOR EACH ROW
BEGIN
    UPDATE Products
    SET stock = stock - NEW.quantity
    WHERE product_id = NEW.product_id;
END //
DELIMITER ;

-- Q17. Display products with stock less than 50.
SELECT *
FROM Products
WHERE stock < 50;

-- Q18. Count the total number of orders.
SELECT COUNT(*)
FROM Orders;

-- Q19. Find the cheapest product.
SELECT product_name
FROM Products
ORDER BY price ASC
LIMIT 1;

-- Q20. Display customer names and their order dates.
SELECT customer_name,
       order_date
FROM Customers
JOIN Orders
ON Customers.customer_id = Orders.customer_id;

-- Q21. Find the category-wise number of products.
SELECT category_name,
       COUNT(*) AS total_products
FROM Categories
JOIN Products
ON Categories.category_id = Products.category_id
GROUP BY category_name;

-- Q22. Find the total amount spent by each customer.
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Q23. Find the product that sold the highest quantity.
SELECT p.product_name,
       SUM(od.quantity) AS total_quantity
FROM Products p
JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY total_quantity DESC
LIMIT 1;

-- Q24. Find customers who spent more than Rs.10000.
SELECT c.customer_name,
       SUM(o.total_amount) AS total_spent
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
HAVING SUM(o.total_amount) > 10000;

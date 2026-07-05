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

-- Q25. Display all customers from Mumbai.
SELECT *
FROM Customers
WHERE city = 'Mumbai';

-- Q26. Count the number of customers in each city.
SELECT city,
       COUNT(*) AS total_customers
FROM Customers
GROUP BY city;

-- Q27. Find customers who have never placed an order.
SELECT customer_name
FROM Customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM Orders
);

-- Q28. Find the customer with the highest number of orders.
SELECT c.customer_name,
       COUNT(*) AS total_orders
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY total_orders DESC
LIMIT 1;

-- Q29. Display customer registration dates in ascending order.
SELECT *
FROM Customers
ORDER BY registration_date;

-- Q30. Display all products with stock greater than 20.
SELECT *
FROM Products
WHERE stock > 20;

-- Q31. Find the total number of products.
SELECT COUNT(*) AS total_products
FROM Products;

-- Q32. Find the average price of products.
SELECT AVG(price) AS average_price
FROM Products;

-- Q33. Display products sorted by price in descending order.
SELECT *
FROM Products
ORDER BY price DESC;

-- Q34. Find the total stock available.
SELECT SUM(stock) AS total_stock
FROM Products;

-- Q35. Display all orders placed after '2026-06-01'.
SELECT *
FROM Orders
WHERE order_date > '2026-06-01';

-- Q36. Count total orders placed by each customer.
SELECT customer_id,
       COUNT(*) AS total_orders
FROM Orders
GROUP BY customer_id;

-- Q37. Find the average order amount.
SELECT AVG(total_amount) AS average_order
FROM Orders;

-- Q38. Find orders whose amount is greater than average order amount.
SELECT *
FROM Orders
WHERE total_amount >
(
    SELECT AVG(total_amount)
    FROM Orders
);

-- Q39. Display orders sorted by total amount.
SELECT *
FROM Orders
ORDER BY total_amount DESC;

-- Q40. Find category-wise revenue.
SELECT c.category_name,
       SUM(od.subtotal) AS revenue
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id
JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY c.category_name;

-- Q41. Find the category with the highest revenue.
SELECT c.category_name,
       SUM(od.subtotal) AS revenue
FROM Categories c
JOIN Products p
ON c.category_id = p.category_id
JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY c.category_name
ORDER BY revenue DESC
LIMIT 1;

-- Q42. Find total revenue generated by each product.
SELECT p.product_name,
       SUM(od.subtotal) AS revenue
FROM Products p
JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY p.product_name;

-- Q43. Find the top-selling product by revenue.
SELECT p.product_name,
       SUM(od.subtotal) AS revenue
FROM Products p
JOIN Order_Details od
ON p.product_id = od.product_id
GROUP BY p.product_name
ORDER BY revenue DESC
LIMIT 1;

-- Q44. Find total revenue generated by each customer.
SELECT c.customer_name,
       SUM(o.total_amount) AS revenue
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name;

-- Q45. Display all completed payments.
SELECT *
FROM Payments
WHERE payment_status = 'Completed';

-- Q46. Count payments by payment method.
SELECT payment_method,
       COUNT(*) AS total_payments
FROM Payments
GROUP BY payment_method;

-- Q47. Count payments by payment status.
SELECT payment_status,
       COUNT(*) AS total_payments
FROM Payments
GROUP BY payment_status;

-- Q48. Find products whose price is above average.
SELECT *
FROM Products
WHERE price >
(
    SELECT AVG(price)
    FROM Products
);

-- Q49. Find the second highest priced product.
SELECT product_name,
       price
FROM Products
ORDER BY price DESC
LIMIT 1 OFFSET 1;

-- Q50. Display customers and their total spending in descending order.
SELECT c.customer_name,
       SUM(o.total_amount) AS spending
FROM Customers c
JOIN Orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_name
ORDER BY spending DESC;
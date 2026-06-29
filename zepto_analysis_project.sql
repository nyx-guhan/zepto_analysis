SELECT * FROM zepto_analysis.data_zepto;

SELECT * FROM zepto_analysis.data_zepto
WHERE 
Category IS NULL
OR name IS NULL
OR mrp IS NULL
OR discountpercent IS NULL
OR availableQuantity IS NULL
OR discountedSellingPrice IS NULL
OR weightInGms IS NULL
OR outOfStock IS NULL
OR quantity IS NULL;

-- different products

SELECT DISTINCT Category
FROM  zepto_analysis.data_zepto
ORDER BY Category;

-- product in stock vs outofstock

SELECT outOfStock, count(outOfStock)
FROM zepto_analysis.data_zepto
WHERE outOfStock = "FALSE" ;

SELECT outOfStock, count(outOfStock)
FROM zepto_analysis.data_zepto
WHERE outOfStock = "TRUE" ;

SELECT outOfStock, COUNT(*) AS total
FROM zepto_analysis.data_zepto
GROUP BY outOfStock;

-- product name present multiple times

SELECT name, count(*) AS "Number of times"
FROM zepto_analysis.data_zepto
GROUP BY name ORDER BY count(*) DESC ;

-- data cleaning 

SELECT * FROM zepto_analysis.data_zepto
WHERE mrp = 0 OR discountedSellingPrice = 0;


DELETE FROM zepto_analysis.data_zepto
WHERE mrp = 0;


UPDATE zepto_analysis.data_zepto
SET mrp = mrp/100.0, discountedSellingPrice =discountedSellingPrice/100.0 ;

SELECT * FROM zepto_analysis.data_zepto;

-- Top 10 best value products based on the discount percentage

SELECT DISTINCT name, mrp, discountPercent, discountedSellingPrice
FROM zepto_analysis.data_zepto
ORDER BY discountPercent DESC 
LIMIT 10;

-- What are the products with high MRP but out of stock

SELECT DISTINCT name, mrp
FROM zepto_analysis.data_zepto
WHERE  outOfStock = "TRUE" and mrp >300
ORDER BY mrp DESC;

-- calculated estimated revenue of each category

SELECT Category, sum(discountedSellingPrice * availableQuantity) AS total_revenue 
FROM  zepto_analysis.data_zepto
GROUP BY category
ORDER BY total_revenue;

-- Find all products where MRP is greater than 500 but discount is less than  10%

SELECT name, mrp, discountPercent 
FROM  zepto_analysis.data_zepto
WHERE mrp > 500 AND discountPercent < 10 
ORDER BY mrp DESC ;

-- Group the products into categories like low,medium,bulk

SELECT DISTINCT name, weightInGms,
CASE WHEN weightInGms < 1000 THEN 'Low'
     WHEN weightInGms < 5000 THEN 'Medium'
     ELSE 'Bulk'
     END AS weight_category
FROM zepto_analysis.data_zepto;



     



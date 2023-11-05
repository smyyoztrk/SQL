--1. Product isimlerini (ProductName) ve birim başına miktar (QuantityPerUnit) değerlerini almak için sorgu yazın.
SELECT product_name,quantity_per_unit FROM products;

--2. Ürün Numaralarını (ProductID) ve Product isimlerini (ProductName) değerlerini almak için sorgu yazın.
SELECT product_id,product_name FROM products;

--Artık satılmayan ürünleri (Discontinued) filtreleyiniz.
SELECT * FROM products WHERE discontinued=1;

--3. Durdurulan Ürün Listesini, Ürün kimliği ve ismi (ProductID, ProductName) değerleriyle almak için bir sorgu yazın.
SELECT *FROM products;
SELECT product_id,product_name FROM products WHERE discontinued=1;

--4. Ürünlerin maliyeti 20'dan az olan Ürün listesini (ProductID, ProductName, UnitPrice) almak için bir sorgu yazın.
SELECT product_id,product_name,unit_price FROM products WHERE unit_price<20;

--5. Ürünlerin maliyetinin 15 ile 25 arasında olduğu Ürün listesini (ProductID, ProductName, UnitPrice) almak için bir sorgu yazın.
SELECT product_id,product_name,unit_price FROM products WHERE unit_price<25 AND unit_price>15;

--6. Ürün listesinin (ProductName, UnitsOnOrder, UnitsInStock) stoğun siparişteki miktardan az olduğunu almak için bir sorgu yazın.
Select product_name,units_on_order,units_in_stock FROM products WHERE units_in_stock<units_on_order;

--7. İsmi a ile başlayan ürünleri listeleyeniz.
SELECT *FROM products WHERE product_name ILIKE 'a%';

--8. İsmi i ile biten ürünleri listeleyeniz.
SELECT *FROM products WHERE product_name ILIKE '%i';

--9. Ürün birim fiyatlarına %18’lik KDV ekleyerek listesini almak (ProductName, UnitPrice, UnitPriceKDV) için bir sorgu yazın.
SELECT product_name,unit_price,unit_price*1.18 AS unit_price_KDV FROM products;

--10. Fiyatı 30 dan büyük kaç ürün var?
SELECT COUNT(*) FROM products WHERE unit_price > 30;


--11. Ürünlerin adını tamamen küçültüp fiyat sırasına göre tersten listele
SELECT LOWER(product_name),unit_price FROM products ORDER BY unit_price DESC;

--12. Çalışanların ad ve soyadlarını yanyana gelecek şekilde yazdır
SELECT *FROM employees;
SELECT first_name,last_name FROM employees;

--13. Region alanı NULL olan kaç tedarikçim var?
SELECT *FROM suppliers;
SELECT COUNT(*) FROM suppliers WHERE region IS NULL;

--14. a.Null olmayanlar?
SELECT COUNT(*) FROM suppliers WHERE region IS NOT NULL;

--15. Ürün adlarının hepsinin soluna TR koy ve büyültüp olarak ekrana yazdır.
SELECT 'TR' || UPPER(product_name) FROM products; 


--16. a.Fiyatı 20den küçük ürünlerin adının başına TR ekle
SELECT 'TR' || product_name FROM products WHERE unit_price < 20;


--17. En pahalı ürün listesini (ProductName , UnitPrice) almak için bir sorgu yazın.
SELECT product_name,unit_price FROM products WHERE unit_price=(SELECT max(unit_price) FROM products);

--18. En pahalı on ürünün Ürün listesini (ProductName , UnitPrice) almak için bir sorgu yazın.
SELECT product_name,unit_price FROM products ORDER BY unit_price DESC LIMIT 10;

--19. Ürünlerin ortalama fiyatının üzerindeki Ürün listesini (ProductName , UnitPrice) almak için bir sorgu yazın.
SELECT product_name,unit_price FROM products WHERE unit_price > (SELECT AVG(unit_price) FROM products);

--20. Stokta olan ürünler satıldığında elde edilen miktar ne kadardır.
SELECT SUM(unit_price*units_in_stock) FROM products;

--21. Mevcut ve Durdurulan ürünlerin sayılarını almak için bir sorgu yazın.
--SELECT *FROM products;
--SELECT units_in_stock,discontinued FROM products WHERE units_in_stock>0 AND discontinued=1;

SELECT COUNT(*)FROM products WHERE units_in_stock>0 AND discontinued=1

--22. Ürünleri kategori isimleriyle birlikte almak için bir sorgu yazın.
--SELECT *FROM categories;
SELECT products.product_name,categories.category_name FROM products INNER JOIN categories
ON products.category_id=categories.category_id;

--23. Ürünlerin kategorilerine göre fiyat ortalamasını almak için bir sorgu yazın.
SELECT categories.category_name, AVG( products.unit_price ) AS average_price FROM products 
INNER JOIN categories ON products.category_id = categories.category_id GROUP BY categories.category_id;

SELECT category_id,AVG(unit_price) AS average_price FROM products
GROUP BY category_id;



--24. En pahalı ürünümün adı, fiyatı ve kategorisin adı nedir?
SELECT products.unit_price,products.product_name,categories.category_name FROM products INNER JOIN categories
on products.category_id=categories.category_id ORDER BY unit_price DESC LIMIT 1;


--25. En çok satılan ürününün adı, kategorisinin adı ve tedarikçisinin adı
SELECT products.product_name,categories.category_name,suppliers.company_name  FROM products 
INNER JOIN categories ON products.category_id=categories.category_id
INNER JOIN suppliers ON suppliers.supplier_id=products.supplier_id 
INNER JOIN order_details ON order_details.product_id=products.product_id 
GROUP BY products.product_name,categories.category_name,suppliers.company_name
ORDER BY SUM(order_details.quantity) DESC LIMIT 1;

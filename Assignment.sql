Task 1
-------

We have been provided with a set of 5 tables. Together, these 5 tables list the 
various orders (office supplies, furnitures etc. for office use) placed by 
different customers along with the order date, ship date
and associated costs, quantities etc. Market_fact is the details table 
which contains the order quantity, sales , shipping cost details etc. The 
other 4 tables provide details around who are the customers (cust_dimen), order
details (orders_dimen), kind of products (prod_dimen) and shipping details 
(shipping_dimen).
orders_dimen -> Ord_id is the primary key. Order_Id is not primary key (it can repeat)
prod_dimen -> Prod_id is the primary key.
shipping_dimen -> Ship_id is the primary key. Order_Id is the foreign key. This table
                  is used to associate Orders to shipments.
cust_dimen ->  Cust_id is the primary key of this table. Its unique.
               This table identifies various customers along with their geographic 
               region and type of business segment (small office, corporate etc.).
Market_fact -> Ord_id, Prod_id,Ship_id, Cust_id are the foreign keys from the above
               4 tables respectively.

Task 2
-------

A. Find the total and the average sales (display total_sales and avg_sales)
select sum(sales) as total_sales,avg(sales) as avg_sales 
  from superstoresdb.market_fact;

Result -> 
# total_sales, avg_sales
'14647187.904000023', '1757.1002763915576'

B. Display the number of customers in each region in decreasing order of no_of_customers. The result should contain columns Region, no_of_customers
select region, count(Cust_id) as no_of_customers
  from superstoresdb.cust_dimen
group by region
order by no_of_customers desc ;

Result -> 
# region, no_of_customers
'WEST', '382'
'ATLANTIC', '344'
'ONTARIO', '337'
'PRARIE', '313'
'QUEBEC', '210'
'YUKON', '130'
'NORTHWEST TERRITORIES', '76'
'NUNAVUT', '40'

C. Find the region having maximum customers (display the region name and max(no_of_customers)
select region, max(no_of_customers) 
from (select region, count(Cust_id) as no_of_customers
		from superstoresdb.cust_dimen
      group by region
      order by no_of_customers desc ) a;

Result ->
# region, max(no_of_customers)
'WEST', '382'

D. Find the number and id of products sold in decreasing order of products sold (display product id, no_of_products sold)
select Prod_id, count(Prod_id) no_of_products 
  from superstoresdb.market_fact
  group by Prod_id
  order by no_of_products desc;

Result ->
# Prod_id, no_of_products
'Prod_6', '1225'
'Prod_3', '915'
'Prod_4', '883'
'Prod_5', '788'
'Prod_8', '758'
'Prod_13', '633'
'Prod_1', '525'
'Prod_2', '434'
'Prod_15', '360'
'Prod_11', '349'
'Prod_17', '337'
'Prod_12', '288'
'Prod_9', '246'
'Prod_10', '185'
'Prod_7', '179'
'Prod_16', '144'
'Prod_14', '87'


E. Find all the customers from Atlantic region who have ever purchased ‘TABLES’ and the number of tables purchased (display the customer name, no_of_tables purchased)
select Customers.Customer_Name,
       sum(Market.Order_Quantity) as no_of_tables
from superstoresdb.market_fact as Market, 
     superstoresdb.cust_dimen as Customers,
     superstoresdb.prod_dimen as Products
where Customers.Region = 'ATLANTIC'
  and Customers.Cust_id = Market.Cust_id
  and Products.Prod_id = Market.Prod_id
  and Products.Product_Sub_Category = 'TABLES'
group by Customers.Customer_Name
order by no_of_tables desc;

Result ->
# Customer_Name, no_of_tables
'MUHAMMED YEDWAB', '59'
'BOBBY TRAFTON', '50'
'ALEKSANDRA GANNAWAY', '49'
'ELENI MCCRARY', '49'
'RICK DUSTON', '48'
'CARLOS SOLTERO', '46'
'CHUCK CLARK', '46'
'ERICA BERN', '45'
'PATRICK JONES', '44'
'FRANK ATKINSON', '43'
'SYLVIA FOULSTON', '42'
'DAVID FLASHING', '40'
'CHUCK SACHS', '39'
'GREG GUTHRIE', '38'
'CATHY ARMSTRONG', '37'
'JOY SMITH', '36'
'CHRISTY BRITTAIN', '35'
'DENISE LEINENBACH', '30'
'BRADLEY TALBOTT', '29'
'MATT ABELMAN', '25'
'IONIA MCGRATH', '24'
'JACK O\'BRIANT', '24'
'BEN PETERMAN', '23'
'JACK LEBRON', '23'
'CHRISTINA DEMOSS', '21'
'CRAIG YEDWAB', '20'
'GEORGE ZREBASSA', '20'
'NORA PAIGE', '20'
'BECKY MARTIN', '18'
'JENNIFER PATT', '16'
'ERIN MULL', '12'
'NONA BALK', '12'
'BRIAN STUGART', '10'
'IVAN LISTON', '9'
'ANEMONE RATNER', '8'
'JAMES GALANG', '8'
'SALLY MATTHIAS', '8'
'BARRY FRANZ', '7'
'CARLOS MEADOR', '6'
'DEBRA CATINI', '4'
'TANJA NORVELL', '4'
'NATHAN CANO', '3'


Task 3
-------

A. Display the product categories in descending order of profits (display the product category wise profits i.e. product_category, profits)?
select Products.Product_Category,
       sum(Market.Profit) as profits
from superstoresdb.market_fact as Market,
     superstoresdb.prod_dimen as Products
where Products.Prod_id = Market.Prod_id
group by Products.Product_Category
order by profits desc;

Result ->

# Product_Category, profits
'TECHNOLOGY', '886313.5200000014'
'OFFICE SUPPLIES', '524956.7699999997'
'FURNITURE', '75968.73000000004'


B. Display the product category, product sub-category and the profit within each sub-category in three columns. 
select Products.Product_Category,
       Products.Product_Sub_Category,
       sum(Market.Profit) as profits
from superstoresdb.market_fact as Market,
     superstoresdb.prod_dimen as Products
where Products.Prod_id = Market.Prod_id
group by Products.Product_Category,
         Product_Sub_Category
order by profits desc;

Result ->
# Product_Category, Product_Sub_Category, profits
'TECHNOLOGY', 'TELEPHONES AND COMMUNICATION', '316951.6200000003'
'TECHNOLOGY', 'OFFICE MACHINES', '307712.92999999993'
'OFFICE SUPPLIES', 'BINDERS AND BINDER ACCESSORIES', '307413.38999999996'
'TECHNOLOGY', 'COPIERS AND FAX', '167361.48999999996'
'FURNITURE', 'CHAIRS & CHAIRMATS', '122738.0699999999'
'FURNITURE', 'OFFICE FURNISHINGS', '100427.93'
'OFFICE SUPPLIES', 'APPLIANCES', '97158.05999999988'
'TECHNOLOGY', 'COMPUTER PERIPHERALS', '94287.48000000001'
'OFFICE SUPPLIES', 'ENVELOPES', '48182.60000000004'
'OFFICE SUPPLIES', 'PAPER', '45263.20000000003'
'OFFICE SUPPLIES', 'LABELS', '13677.16999999999'
'OFFICE SUPPLIES', 'STORAGE & ORGANIZATION', '13599.489999999982'
'OFFICE SUPPLIES', 'PENS & ART SUPPLIES', '7564.780000000003'
'OFFICE SUPPLIES', 'RUBBER BANDS', '-102.6700000000001'
'OFFICE SUPPLIES', 'SCISSORS, RULERS AND TRIMMERS', '-7799.250000000001'
'FURNITURE', 'BOOKCASES', '-33729.09000000002'
'FURNITURE', 'TABLES', '-113468.18000000001'


C. Where is the least profitable product subcategory shipped the most? For the least profitable product sub-category, 
display the region-wise no_of_shipments and the profit made in each region in decreasing order of profits 
(i.e. region, no_of_shipments, profit_in_each_region)
o Note: You can hardcode the name of the least profitable product sub-category

select Customers.Region, count(Shipping.ship_id), sum(Market.Profit) as profits
  from superstoresdb.shipping_dimen Shipping,
       superstoresdb.prod_dimen Products,
       superstoresdb.market_fact as Market,
       superstoresdb.cust_dimen as Customers
 where Products.Prod_id = Market.Prod_id
   and Shipping.Ship_id = Market.Ship_id
   and Customers.Cust_id = Market.Cust_id
   and Products.Product_Sub_Category = 'TABLES'
group by Customers.Region
order by profits desc;

Result ->

# Region, count(Shipping.ship_id), profits
'YUKON', '34', '3151.05'
'NUNAVUT', '1', '-481.04'
'NORTHWEST TERRITORIES', '10', '-3213.11'
'PRARIE', '65', '-8760.3'
'ATLANTIC', '44', '-16559.729999999996'
'WEST', '69', '-21699.789999999997'
'QUEBEC', '47', '-29957.200000000004'
'ONTARIO', '79', '-35948.06'


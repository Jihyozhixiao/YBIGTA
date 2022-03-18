/* Q.1 국가별 office와 employee의 수 */
select country, count(distinct offices.officeCode), count(distinct employeeNumber)
from offices left join employees on offices.officeCode = employees.officeCode
group by country;

/* Q.2 customerFirstName이 R로 시작하는 고객 리스트 */
select customerName as 고객 
from customers
where contactFirstName like 'R%';

/* Q.3 order 상태가 ‘Cancelled’ 또는 ‘On Hold’인 미국 고객의 주문 건수 */
select count(orders.orderNumber)
from orders left join customers on orders.customerNumber = customers.customerNumber
where (orders.status = 'Cancelled' OR orders.status = 'On Hold') AND customers.country = 'USA';

/* Q.4  가장 많은 고객을 담당한 office code */
select officeCode
from employees left join customers on employees.employeeNumber = customers.salesRepEmployeeNumber
group by officeCode
order by count(distinct customers.customerNumber) DESC limit 1;

/* Q.5 2004년 11월 가장 많은 금액을 결제한 고객의 정보 */
select customers.*
from orders 
left join customers on orders.customerNumber = customers.customerNumber
left join orderdetails on orders.orderNumber = orderdetails.orderNumber 
where orders.orderDate like '2004-11%'
group by customerNumber
order by orderdetails.priceEach DESC limit 1;

/* Q.6 2005년 1월의 orderDate와 shippedDate 사이 기간의 최대, 최소값 */
select MAX(diff), MIN(diff)
from (select datediff(shippedDate, orderDate) as diff from orders where orderDate like '2005-01%') orders;

/* Q.7 2004년 1년간 가장 많은 금액을 결제한 고객의 담당 employee 정보 */
select employees.*
from employees left join customers on employees.employeeNumber = customers.salesRepEmployeeNumber
where customerNumber = (select customerNumber from payments 
where paymentDate like '2004%' group by customerNumber order by sum(amount) DESC limit 1);
--  1. List all customers who live in Texas (use JOINs)
select customer.address_id, customer.first_name, customer.last_name, district
from customer 
left join address 
on customer.address_id = address.address_id 
where district = 'Texas'


-- 2. Get all payments above $6.99 with the Customer's Full Name
select customer.first_name, customer.last_name, amount
from customer 
inner join payment 
on customer.customer_id = payment.customer_id 
where amount > 6.99


-- 3. Show all customers names who have made payments over $175(use subqueries)
select first_name, last_name
from customer 
where customer_id in (
	select customer_id 
	from payment 
	group by customer_id 
	having sum(amount) > 175
	order by sum(amount) > 175
)
group by first_name, last_name


-- 4. List all customers that live in Nepal (use the city table)
select customer.first_name, customer.last_name, country
from customer 
full join address 
on customer.address_id  = address.address_id
full join city
on address.city_id  = city.city_id 
full join country 
on city.country_id = country.country_id 
where country = 'Nepal'


-- 5. Which staff member had the most transactions? ????
select staff.staff_id, staff.first_name, staff.last_name
from staff
inner join payment 
on staff.staff_id = payment.staff_id

select count() 

-- this tells me the amount as well
select payment.amount, payment.staff_id, first_name
from payment 
right join staff 
on payment.staff_id = staff.staff_id 
group  by (staff_id) -- ambiguos

-- tells me the count
select count(staff_id) from staff

	
--this is the same as selectiong everything from staff
select staff_id, first_name, last_name
from staff 
where staff_id in (
	select staff_id 
	from payment 
	group by count(staff_id)  
)
group by staff_id, first_name, last_name 


select * from staff -- two ids but different from salesperson

select * from payment -- i can see staff_id from here

-- 6. How many movies of each rating (TIPO PG13) are there?
select rating, count(*)
from film_list 
group by rating 
order by count(*) desc

select * from payment p 

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
select first_name, last_name
from customer
where customer_id in(
	select customer_id 
	from payment 
	group by customer_id, amount
	order by amount > 6.99
)
group by first_name, last_name 

-- 8. How many free rentals did our stores give away?
select amount from payment 
where amount = 0.00

-- or

select rental.rental_id, amount
from payment 
full join rental 
on rental.rental_id = payment.rental_id 
where amount = 0.00

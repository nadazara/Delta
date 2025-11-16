
-- CLV & Top 10 VIP
select Passenger_ID,Ticket_Class,SUM(Fare_USD) as Revenue_per_passenger
from passengers
right join flights on flights.Flight_ID = passengers.Flight_ID
group by Passenger_ID , Ticket_Class
order by Revenue_per_passenger desc

--SEGMENT DELAY REASONS
with delay as (select DATEDIFF(MINUTE , Actual_Departure, Scheduled_Departure) as Delay_minutes
from flights  )

select Delay_Reason ,avg(Delay_Minutes) as Delay_minutes
from delays
where Delay_minutes > 0
group by Delay_Reason
order by Delay_minutes desc

--Retention rate &

select Passenger_ID, booking ,Fare_USD,month(Scheduled_Departure)
from passengers
join flights on flights.Flight_ID = passengers.Flight_ID

-- Cancelation rate per flight % & impact in reservation 
with cancellation as(
select Flight_ID ,sum(case when Cancelled = 1 then 1 else 0 end) / count(Flight_id) * 100 as Cancelation_rate
from flights
group by Flight_ID )

--Lost Revenue After Cancellation & Priority fixing
select Aircraft_ID,Flight_ID,sum(BookedSeats) * sum(Fare_USD) as lost_income
where Cancelation_rate > 5% 
from cancellation cancel
join passengers on passengers.Flight_ID = cancellation.Flight_ID
inner join airline_dynamic_pricing  on passengers.Passenger_ID = airline_dynamic_pricing_dataset.passengerID
group by Aircraft_ID , Flight_ID
order by lost_income desc

--Target & Demand
select top 5 Origin_Airport , Destination_Airport 
from flights

 --Seasonal events
select month(BookingDate) as month ,sum(Fare_USD) as revenue_per_month  , RANK() over order by revenue_per_month
from passengers 
inner join airline_dynamic_pricing_dataset on passengers.flight_ID = airline_dynamic_pricing_dataset.flight_id
group by month
order by revenue_per_month

with booking as (select passenger_id
having bookingdate > 1
from airline_dynamic_pricing_dataset)

 -- Potential Of Discounts
with potential_Of_Discount as (select Origin, sum(BookedSeats) as Booked_Seats,sum(SeatCapacity) as Seat_Capacity
from airline_dynamic_pricing_dataset
group by Origin)

select (Seat_Capacity)-(Booked_Seats) as avaliable_seats 
from potential_Of_Discount


 -- Predictive maintenance
 select 
 from 
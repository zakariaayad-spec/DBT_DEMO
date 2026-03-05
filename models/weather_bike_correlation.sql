{{config(materialized='table')}}

with CTE as (

select t.* , w.* from 
    {{ref('trip_fact')}} t
left join 
{{ref('daily_weather')}} w
on t.TRIP_DATE=w.daily_weather
order by TRIP_DATE DESC 
)

select * from CTE 
{{ config(materialized='table') }}

WITH daily_weather as (

select 
    date(TIME) as daily_weather,
    weather,
    temp,
    pressure,
    humidity,
    clouds
from
     {{ source('demo', 'weather') }}
) , 
daily_weather_agg as (
select 
    daily_weather, weather,
    count(weather) as count_weather,
    ROW_NUMBER() over (PARTITION by daily_weather order by count(weather) desc ) as row_number
from
    daily_weather
group by 
    daily_weather, weather
), result as (

select daily_weather.daily_weather
, daily_weather.weather , daily_weather.temp, 
daily_weather.pressure,
daily_weather.humidity,
daily_weather.clouds
--, daily_weather.pressure

 from  daily_weather 
left join daily_weather_agg
on daily_weather_agg.daily_weather=daily_weather.daily_weather and 
daily_weather_agg.weather=daily_weather.weather
where row_number=1 )

select result.daily_weather
, result.weather , round(avg(result.temp),2) as avg_temp ,
round(avg(result.pressure),2) as avg_pressure,
round(avg(result.humidity),2) as avg_humidity,
round(avg(result.clouds),2) as avg_clouds from result
group by result.daily_weather
, result.weather
order by daily_weather asc 


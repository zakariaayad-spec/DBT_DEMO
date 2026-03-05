{{config(materialized='table')}}

With trips as (
select 
    RIDE_ID,
    RIDEABLE_TYPE,
    DATE(TO_TIMESTAMP(STARTED_AT)) as TRIP_DATE,
    start_station_id,
    end_station_id,
    member_casual,
    TIMESTAMPDIFF(second,TO_TIMESTAMP(started_at),TO_TIMESTAMP(ended_at)) as TRIP_DURATION
from {{source('demo','bike')}}
where  ride_id!='ride_id'
)

select * from trips
with CTE AS (
select
    TO_TIMESTAMP(STARTED_AT) as STARTED_AT,
    DATE(TO_TIMESTAMP(STARTED_AT)) as DATE_STARTED_AT,
    HOUR(TO_TIMESTAMP(STARTED_AT)) as HOUR_STARTED_AT,
        CASE
        WHEN DAYOFWEEK(TRY_TO_TIMESTAMP_NTZ(started_at)) IN (0, 6) THEN 'WEEKEND'
        ELSE 'BUSINESSDAY'
        END                                                           
    AS DAY_TYPE ,
    CASE 
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (12,1,2) then 'WINTER'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (3,4,5) then 'SPRING'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (6,7,8) then 'SUMMER'
    WHEN MONTH(TO_TIMESTAMP(STARTED_AT)) IN (9,10,11) then 'AUTUMN'
    ELSE null
    END 
    AS STATION_OF_YEAR
from 
{{ source('demo', 'bike') }}
where STARTED_AT != 'started_at'
)

select * from CTE 
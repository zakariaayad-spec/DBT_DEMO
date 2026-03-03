{% macro  get_season(x) %}

  CASE 
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (12,1,2) then 'WINTER'
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (3,4,5) then 'SPRING'
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (6,7,8) then 'SUMMER'
    WHEN MONTH(TO_TIMESTAMP({{x}})) IN (9,10,11) then 'AUTUMN'
    ELSE null
    END

{% endmacro %}


{% macro day_type(x) %}
        CASE
        WHEN DAYOFWEEK(TRY_TO_TIMESTAMP_NTZ({{x}})) IN (0, 6) THEN 'WEEKEND'
        ELSE 'BUSINESSDAY'
        END 
{% endmacro %}
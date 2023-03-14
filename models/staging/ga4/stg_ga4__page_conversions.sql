{{ config(
  enabled= var('conversion_events', false) != false,
  materialized = 'view',
    database = 'clean-divbrands',
    dataset = 'clean_ga4'
) }}


select 
    page_key
    {% for ce in var('conversion_events',[]) %}
    , countif(event_name = '{{ce}}') as {{ce}}_count
    {% endfor %}
from {{ref('stg_ga4__events')}}
group by 1
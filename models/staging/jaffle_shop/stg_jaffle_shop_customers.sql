with source_customers as (

    select * from {{ ref('jaffle_shop_customers') }}

),

renamed_customers as (

    select
        id as customer_id,
        first_name,
        last_name

    from source_customers

)

select * from renamed_customers

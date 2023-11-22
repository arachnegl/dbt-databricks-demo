with source_orders as (

    select * from {{ ref('jaffle_shop_orders') }}

),

renamed_orders as (

    select
        id as order_id,
        user_id as customer_id,
        order_date,
        status

    from source_orders

)

select * from renamed_orders

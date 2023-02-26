-- query16
SELECT
         count(DISTINCT cs_order_number) AS order_count ,
         sum(cs_ext_ship_cost)           AS total_shipping_cost ,
         sum(cs_net_profit)              AS total_net_profit
FROM     tpcds.catalog_sales cs1 ,
         tpcds.date_dim ,
         tpcds.customer_address ,
         tpcds.call_center
WHERE    Cast(d_date AS DATE) BETWEEN Cast('2002-3-01' AS DATE) AND (
                  Cast('2002-5-01' AS DATE))
AND      cs1.cs_ship_date_sk = d_date_sk
AND      cs1.cs_ship_addr_sk = ca_address_sk
AND      ca_state = 'IA'
AND      cs1.cs_call_center_sk = cc_call_center_sk
AND      cc_county IN ('Williamson County',
                       'Williamson County',
                       'Williamson County',
                       'Williamson County',
                       'Williamson County' )
AND      EXISTS
         (
                SELECT *
                FROM   tpcds.catalog_sales cs2
                WHERE  cs1.cs_order_number = cs2.cs_order_number
                AND    cs1.cs_warehouse_sk <> cs2.cs_warehouse_sk)
AND      NOT EXISTS
         (
                SELECT *
                FROM   tpcds.catalog_returns cr1
                WHERE  cs1.cs_order_number = cr1.cr_order_number)
ORDER BY count(DISTINCT cs_order_number)
LIMIT 100


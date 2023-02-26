
-- query90
SELECT amc / pmc AS am_pm_ratio
FROM   (SELECT count(*) amc
        FROM   tpcds.web_sales,
               tpcds.household_demographics,
               tpcds.time_dim,
               tpcds.web_page
        WHERE  ws_sold_time_sk = time_dim.t_time_sk
               AND ws_ship_hdemo_sk = household_demographics.hd_demo_sk
               AND ws_web_page_sk = web_page.wp_web_page_sk
               AND time_dim.t_hour BETWEEN 12 AND 12 + 1
               AND household_demographics.hd_dep_count = 8
               AND web_page.wp_char_count BETWEEN 5000 AND 5200) at1,
       (SELECT count(*) pmc
        FROM   tpcds.web_sales,
               tpcds.household_demographics,
               tpcds.time_dim,
               tpcds.web_page
        WHERE  ws_sold_time_sk = time_dim.t_time_sk
               AND ws_ship_hdemo_sk = household_demographics.hd_demo_sk
               AND ws_web_page_sk = web_page.wp_web_page_sk
               AND time_dim.t_hour BETWEEN 20 AND 20 + 1
               AND household_demographics.hd_dep_count = 8
               AND web_page.wp_char_count BETWEEN 5000 AND 5200) pt
ORDER  BY am_pm_ratio
LIMIT 100

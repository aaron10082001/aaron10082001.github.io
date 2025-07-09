/*
1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the Youtube channels with the highest subscriber bases
5. Order by net_profit (from highest to lowest)

*/


--1

DECLARE @conversionRate FLOAT = 0.02;
DECLARE @productCost MONEY = 5.9;
DECLARE @campaignCost MONEY = 5000.0;

--2

WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_uk_youtubers_2024
)
--3

SELECT
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost as net_profit

FROM
    ChannelData
   

--4

WHERE channel_name IN ('NoCopyRightSounds', 'DanTDM', 'Dan Rhodes')

--4
ORDER BY 
    net_profit DESC
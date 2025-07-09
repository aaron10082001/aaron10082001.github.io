# Data Portfolio: Excel to Power BI 


![excel-to-powerbi-animated-diagram](assets/images/kaggle_to_powerbi.gif)




# Table of contents 

- [Objective](#objective)
- [Data Source](#data-source)
- [Stages](#stages)
- [Design](#design)
  - [Mockup](#mockup)
  - [Tools](#tools)
- [Development](#development)
  - [Pseudocode](#pseudocode)
  - [Data Exploration](#data-exploration)
  - [Data Cleaning](#data-cleaning)
  - [Transform the Data](#transform-the-data)
  - [Create the SQL View](#create-the-sql-view)
- [Testing](#testing)
  - [Data Quality Tests](#data-quality-tests)
- [Visualization](#visualization)
  - [Results](#results)
  - [DAX Measures](#dax-measures)
- [Analysis](#analysis)
  - [Findings](#findings)
  - [Validation](#validation)
  - [Discovery](#discovery)
- [Recommendations](#recommendations)
  - [Potential ROI](#potential-roi)
  - [Potential Courses of Actions](#potential-courses-of-actions)
- [Conclusion](#conclusion)




# Objective 

- What is the key pain point? 

The Head of Marketing wants to find out who the top YouTubers are in 2024 to decide on which YouTubers would be best to run marketing campaigns throughout the rest of the year.


- What is the ideal solution? 

To create a dashboard that provides insights into the top UK YouTubers in 2024 that includes their 
- subscriber count
- total views
- total videos, and
- engagement metrics

This will help the marketing team make informed decisions about which YouTubers to collaborate with for their marketing campaigns.

## User story 

As the Head of Marketing, I want to use a dashboard that analyses YouTube channel data in the UK . 

This dashboard should allow me to identify the top performing channels based on metrics like subscriber base and average views. 

With this information, I can make more informed decisions about which Youtubers are right to collaborate with, and therefore maximize how effective each marketing campaign is.


# Data source 

- What data is needed to achieve our objective?

We need data on the top UK YouTubers in 2024 that includes their 
- channel names
- total subscribers
- total views
- total videos uploaded



- Where is the data coming from? 
The data is sourced from Kaggle (an Excel extract), [see here to find it.](https://www.kaggle.com/datasets/bhavyadhingra00020/top-100-social-media-influencers-2024-countrywise?resource=download)


# Stages

- Design
- Developement
- Testing
- Analysis 
 


# Design 

## Dashboard components required 
- What should the dashboard contain based on the requirements provided?

To understand what it should contain, we need to figure out what questions we need the dashboard to answer:

1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

For now, these are some of the questions we need to answer, this may change as we progress down our analysis. 


## Dashboard mockup

- What should it look like? 

Some of the data visuals that may be appropriate in answering our questions include:

1. Table
2. Treemap
3. Scorecards
4. Horizontal bar chart 




![Dashboard-Mockup](assets/images/dashboard_mockup.png)


## Tools 


| Tool | Purpose |
| --- | --- |
| Excel | Exploring the data |
| SQL Server | Cleaning, testing, and analyzing the data |
| Power BI | Visualizing the data via interactive dashboards |
| GitHub | Hosting the project documentation and version control |
| Mokkup AI | Designing the wireframe/mockup of the dashboard | 


# Development

## Pseudocode

- What's the general approach in creating this solution from start to finish?

1. Get the data
2. Explore the data in Excel
3. Load the data into SQL Server
4. Clean the data with SQL
5. Test the data with SQL
6. Visualize the data in Power BI
7. Generate the findings based on the insights
8. Write the documentation + commentary
9. Publish the data to GitHub Pages

## Data exploration notes

This is the stage where you have a scan of what's in the data, errors, inconcsistencies, bugs, weird and corrupted characters etc  


- What are your initial observations with this dataset? What's caught your attention so far? 

1. There are at least 4 columns that contain the data we need for this analysis, which signals we have everything we need from the file without needing to contact the client for any more data. 
2. The first column contains the channel ID with what appears to be channel IDS, which are separated by a @ symbol - we need to extract the channel names from this.
3. Some of the cells and header names are in a different language - we need to confirm if these columns are needed, and if so, we need to address them.
4. We have more data than we need, so some of these columns would need to be removed





## Data cleaning 
- What do we expect the clean data to look like? (What should it contain? What contraints should we apply to it?)

The aim is to refine our dataset to ensure it is structured and ready for analysis. 

The cleaned data should meet the following criteria and constraints:

- Only relevant columns should be retained.
- All data types should be appropriate for the contents of each column.
- No column should contain null values, indicating complete data for all records.

Below is a table outlining the constraints on our cleaned dataset:

| Property | Description |
| --- | --- |
| Number of Rows | 100 |
| Number of Columns | 4 |

And here is a tabular representation of the expected schema for the clean data:

| Column Name | Data Type | Nullable |
| --- | --- | --- |
| channel_name | VARCHAR | NO |
| total_subscribers | INTEGER | NO |
| total_views | INTEGER | NO |
| total_videos | INTEGER | NO |



- What steps are needed to clean and shape the data into the desired format?

1. Remove unnecessary columns by only selecting the ones you need
2. Extract Youtube channel names from the first column
3. Rename columns using aliases







### Transform the data 



```sql
/*
# 1. Select the required columns
# 2. Extract the channel name from the 'NOMBRE' column
*/

-- 1.
SELECT
    SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS channel_name,  -- 2.
    total_subscribers,
    total_views,
    total_videos

FROM
    top_uk_youtubers_2024
```


### Create the SQL view 

```sql
/*
# 1. Create a view to store the transformed data
# 2. Cast the extracted channel name as VARCHAR(100)
# 3. Select the required columns from the top_uk_youtubers_2024 SQL table 
*/

-- 1.
CREATE VIEW view_uk_youtubers_2024 AS

-- 2.
SELECT
    CAST(SUBSTRING(NOMBRE, 1, CHARINDEX('@', NOMBRE) -1) AS VARCHAR(100)) AS channel_name, -- 2. 
    total_subscribers,
    total_views,
    total_videos

-- 3.
FROM
    top_uk_youtubers_2024

```


# Testing 

- What data quality and validation checks are you going to create?

Here are the data quality tests conducted:

## Row count check
```sql
/*
# Count the total number of records (or rows) are in the SQL view
*/

SELECT
    COUNT(*) AS no_of_rows
FROM
    view_uk_youtubers_2024;

```

![Row count check](assets/images/1_row_count_check.png)



## Column count check
### SQL query 
```sql
/*
# Count the total number of columns (or fields) are in the SQL view
*/


SELECT
    COUNT(*) AS column_count
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'view_uk_youtubers_2024'
```
### Output 
![Column count check](assets/images/2_column_count_check.png)



## Data type check
### SQL query 
```sql
/*
# Check the data types of each column from the view by checking the INFORMATION SCHEMA view
*/

-- 1.
SELECT
    COLUMN_NAME,
    DATA_TYPE
FROM
    INFORMATION_SCHEMA.COLUMNS
WHERE
    TABLE_NAME = 'view_uk_youtubers_2024';
```
### Output
![Data type check](assets/images/3_data_type_check.png)


## Duplicate count check
### SQL query 
```sql
/*
# 1. Check for duplicate rows in the view
# 2. Group by the channel name
# 3. Filter for groups with more than one row
*/

-- 1.
SELECT
    channel_name,
    COUNT(*) AS duplicate_count
FROM
    view_uk_youtubers_2024

-- 2.
GROUP BY
    channel_name

-- 3.
HAVING
    COUNT(*) > 1;
```
### Output
![Duplicate count check](assets/images/4_duplicate_records_check.png)

# Visualization 


## Results

- What does the dashboard look like?

![GIF of Power BI Dashboard](assets/images/top_uk_youtubers_2024.gif)

This shows the Top UK Youtubers in 2024 so far. 


## DAX Measures

### 1. Total Subscribers (M)
```sql
Total Subscribers (M) = 
VAR million = 1000000
VAR sumOfSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR totalSubscribers = DIVIDE(sumOfSubscribers,million)

RETURN totalSubscribers

```

### 2. Total Views (B)
```sql
Total Views (B) = 
VAR billion = 1000000000
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR totalViews = ROUND(sumOfTotalViews / billion, 2)

RETURN totalViews

```

### 3. Total Videos
```sql
Total Videos = 
VAR totalVideos = SUM(view_uk_youtubers_2024[total_videos])

RETURN totalVideos

```

### 4. Average Views Per Video (M)
```sql
Average Views per Video (M) = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR  avgViewsPerVideo = DIVIDE(sumOfTotalViews,sumOfTotalVideos, BLANK())
VAR finalAvgViewsPerVideo = DIVIDE(avgViewsPerVideo, 1000000, BLANK())

RETURN finalAvgViewsPerVideo 

```


### 5. Subscriber Engagement Rate
```sql
Subscriber Engagement Rate = 
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR sumOfTotalVideos = SUM(view_uk_youtubers_2024[total_videos])
VAR subscriberEngRate = DIVIDE(sumOfTotalSubscribers, sumOfTotalVideos, BLANK())

RETURN subscriberEngRate 

```


### 6. Views per subscriber
```sql
Views Per Subscriber = 
VAR sumOfTotalViews = SUM(view_uk_youtubers_2024[total_views])
VAR sumOfTotalSubscribers = SUM(view_uk_youtubers_2024[total_subscribers])
VAR viewsPerSubscriber = DIVIDE(sumOfTotalViews, sumOfTotalSubscribers, BLANK())

RETURN viewsPerSubscriber 

```




# Analysis 

## Findings

- What did we find?

For this analysis, we're going to focus on the questions below to get the information we need for our marketing client - 

Here are the key questions we need to answer for our marketing client: 
1. Who are the top 10 YouTubers with the most subscribers?
2. Which 3 channels have uploaded the most videos?
3. Which 3 channels have the most views?
4. Which 3 channels have the highest average views per video?
5. Which 3 channels have the highest views per subscriber ratio?
6. Which 3 channels have the highest subscriber engagement rate per video uploaded?


### 1. Who are the top 10 YouTubers with the most subscribers?

| Rank | Channel Name         | Subscribers (M) |
|------|----------------------|-----------------|
| 1    | NoCopyrightSounds    | 33.60           |
| 2    | DanTDM               | 28.60           |
| 3    | Dan Rhodes           | 26.50           |
| 4    | Miss Katy            | 24.50           |
| 5    | Mister Max           | 24.40           |
| 6    | KSI                  | 24.10           |
| 7    | Jelly                | 23.50           |
| 8    | Dua Lipa             | 23.30           |
| 9    | Sidemen              | 21.00           |
| 10   | Ali-A                | 18.90           |


### 2. Which 3 channels have uploaded the most videos?

| Rank | Channel Name    | Videos Uploaded |
|------|-----------------|-----------------|
| 1    | GRM Daily       | 14,696          |
| 2    | Manchester City | 8,248           |
| 3    | Yogscast        | 6,435           |



### 3. Which 3 channels have the most views?


| Rank | Channel Name | Total Views (B) |
|------|--------------|-----------------|
| 1    | DanTDM       | 19.78           |
| 2    | Dan Rhodes   | 18.56           |
| 3    | Mister Max   | 15.97           |


### 4. Which 3 channels have the highest average views per video?

| Channel Name | Averge Views per Video (M) |
|--------------|-----------------|
| Mark Ronson  | 32.27           |
| Jessie J     | 5.97            |
| Dua Lipa     | 5.76            |


### 5. Which 3 channels have the highest views per subscriber ratio?

| Rank | Channel Name       | Views per Subscriber        |
|------|-----------------   |---------------------------- |
| 1    | GRM Daily          | 1185.79                     |
| 2    | Nickelodeon        | 1061.04                     |
| 3    | Disney Junior UK   | 1031.97                     |



### 6. Which 3 channels have the highest subscriber engagement rate per video uploaded?

| Rank | Channel Name    | Subscriber Engagement Rate  |
|------|-----------------|---------------------------- |
| 1    | Mark Ronson     | 343,000                     |
| 2    | Jessie J        | 110,416.67                  |
| 3    | Dua Lipa        | 104,954.95                  |




### Notes

For this analysis, we'll prioritize analysing the metrics that are important in generating the expected ROI for our marketing client, which are the YouTube channels wuth the most 

- subscribers
- total views
- videos uploaded



# YouTube Campaign Analysis

## Validation: YouTubers with the Most Subscribers

**Campaign Idea**: Product Placement

### a. Dan Rhodes
- **Average views per video**: 11.15 million
- **Product cost**: $5.90
- **Potential units sold per video**: 11.15 million × 2% conversion rate = 223,000 units sold
- **Potential revenue per video**: 223,000 × $5.90 = $1,315,700
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $1,315,700 - $5,000 = $1,310,700

### b. NoCopyrightSounds
- **Average views per video**: 6.92 million
- **Product cost**: $5.90
- **Potential units sold per video**: 6.92 million × 2% conversion rate = 138,400 units sold
- **Potential revenue per video**: 138,400 × $5.90 = $816,560
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $816,560 - $5,000 = $811,560

### c. DanTDM
- **Average views per video**: 5.34 million
- **Product cost**: $5.90
- **Potential units sold per video**: 5.34 million × 2% conversion rate = 106,800 units sold
- **Potential revenue per video**: 106,800 × $5.90 = $630,120
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $630,120 - $5,000 = $625,120

**Best option from category**: Dan Rhodes

### SQL Query
```sql
/*
1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the YouTube channels with the highest subscriber bases
5. Order by net_profit (from highest to lowest)
*/

-- 1. Define variables
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.9;            -- The product cost @ $5.90
DECLARE @campaignCost MONEY = 5000.0;        -- The campaign cost @ $5,000

-- 2. Create a CTE that rounds the average views per video
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_uk_youtubers_2024
)

-- 3. Select the columns that are required for the analysis
SELECT
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM
    ChannelData

-- 4. Filter the results by the YouTube channels
WHERE 
    channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')

-- 5. Order by net_profit (from highest to lowest)
ORDER BY 
    net_profit DESC;
```

**Output**: Most Subscribers

## Discovery
**What did we learn?**

- **NoCopyrightSounds, DanTDM, and Dan Rhodes** are among the channels with the most subscribers in the UK.
- **Dan Rhodes** is the best option for a product placement campaign due to the highest net profit potential ($1,310,700).
- Entertainment and music-focused channels, such as those analyzed, demonstrate significant reach and engagement, making them ideal for product placement campaigns.



# Analysis

## Validation: YouTubers with the Most Subscribers

**Campaign Idea**: Product Placement

### a. Dan Rhodes
- **Average views per video**: 11.15 million
- **Product cost**: $5.90
- **Potential units sold per video**: 11.15 million × 2% conversion rate = 223,000 units sold
- **Potential revenue per video**: 223,000 × $5.90 = $1,315,700
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $1,315,700 - $5,000 = $1,310,700

### b. NoCopyrightSounds
- **Average views per video**: 6.92 million
- **Product cost**: $5.90
- **Potential units sold per video**: 6.92 million × 2% conversion rate = 138,400 units sold
- **Potential revenue per video**: 138,400 × $5.90 = $816,560
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $816,560 - $5,000 = $811,560

### c. DanTDM
- **Average views per video**: 5.34 million
- **Product cost**: $5.90
- **Potential units sold per video**: 5.34 million × 2% conversion rate = 106,800 units sold
- **Potential revenue per video**: 106,800 × $5.90 = $630,120
- **Campaign cost (one-time fee)**: $5,000
- **Net profit**: $630,120 - $5,000 = $625,120

**Best option from category**: Dan Rhodes

### SQL Query
```sql
/*
1. Define the variables
2. Create a CTE that rounds the average views per video
3. Select the columns that are required for the analysis
4. Filter the results by the YouTube channels with the highest subscriber bases
5. Order by net_profit (from highest to lowest)
*/

-- 1. Define variables
DECLARE @conversionRate FLOAT = 0.02;        -- The conversion rate @ 2%
DECLARE @productCost MONEY = 5.9;            -- The product cost @ $5.90
DECLARE @campaignCost MONEY = 5000.0;        -- The campaign cost @ $5,000

-- 2. Create a CTE that rounds the average views per video
WITH ChannelData AS (
    SELECT
        channel_name,
        total_views,
        total_videos,
        ROUND((CAST(total_views AS FLOAT) / total_videos), -4) AS rounded_avg_views_per_video
    FROM 
        youtube_db.dbo.view_uk_youtubers_2024
)

-- 3. Select the columns that are required for the analysis
SELECT
    channel_name,
    rounded_avg_views_per_video,
    (rounded_avg_views_per_video * @conversionRate) AS potential_units_sold_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) AS potential_revenue_per_video,
    (rounded_avg_views_per_video * @conversionRate * @productCost) - @campaignCost AS net_profit
FROM
    ChannelData

-- 4. Filter the results by the YouTube channels
WHERE 
    channel_name IN ('NoCopyrightSounds', 'DanTDM', 'Dan Rhodes')

-- 5. Order by net_profit (from highest to lowest)
ORDER BY 
    net_profit DESC;
```

**Output**: Most Subscribers

## Conclusion
**What did we learn?**

- **NoCopyrightSounds, DanTDM, and Dan Rhodes** are among the channels with the most subscribers in the UK.
- **Dan Rhodes** is the best option for a product placement campaign due to the highest net profit potential ($1,310,700).
- Entertainment and music-focused channels, such as those analyzed, demonstrate significant reach and engagement, making them ideal for product placement campaigns.

## Recommendations

### What do we recommend based on the insights gathered?
- **Dan Rhodes** is the best YouTube channel for collaboration to maximize visibility, boasting the highest subscriber count and a net profit potential of $1,310,700 per video.
- Channels like **GRM Daily**, **Man City**, and **Yogscast**, while frequent publishers, may not justify collaboration under current budget constraints due to lower ROI compared to top channels.
- **Mister Max** is ideal for maximizing reach with high view counts, but **DanTDM** and **Dan Rhodes** are better for long-term partnerships due to their large subscriber bases and consistent engagement.
- The top three channels for collaborations are **NoCopyrightSounds**, **DanTDM**, and **Dan Rhodes**, as they consistently attract high engagement.

### Potential ROI
What ROI can we expect if we take this course of action?
- A collaboration with **Dan Rhodes** for product placement could yield a net profit of **$1,310,700** per video.
- An influencer marketing contract with **Mister Max** could generate significant profits, but requires further analysis beyond current data.
- A product placement campaign with **DanTDM** could generate approximately **$625,120** per video. An influencer marketing campaign with DanTDM requires separate evaluation.
- Collaborating with **NoCopyrightSounds** could profit the client **$811,560** per video, making it a strong secondary option.

### Action Plan
What course of action should we take and why?
- We recommend advancing a long-term partnership with **Dan Rhodes** to promote the client’s products, given its unmatched profit potential and subscriber reach.
- We’ll engage with the marketing client to align expectations for this collaboration. Upon meeting key milestones, we’ll explore partnerships with **DanTDM**, **Mister Max**, and **NoCopyrightSounds** for future campaigns.

What steps do we take to implement the recommended decisions effectively?
1. Contact the teams behind **Dan Rhodes**, **DanTDM**, **NoCopyrightSounds**, and **Mister Max**, prioritizing Dan Rhodes.
2. Negotiate contracts within allocated marketing campaign budgets.
3. Launch campaigns and monitor performance against defined KPIs.
4. Review campaign outcomes, collect insights, and optimize based on feedback from converted customers and channel audiences.

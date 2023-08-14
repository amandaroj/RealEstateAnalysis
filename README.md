# Real Estate Analysis of Apartments in São Paulo, Brazil 



## Table of Contents

1.  [Introduction](#1-introduction)
2.  [Data Cleaning and Preparation](#2-data-cleaning-and-preparation)
3.  [Exploratory Data Analysis](#3-exploratory-data-analysis)
4.  [Data Visualization](#4-data-visualization)
5.  [Summary](#6-summary)
6.  [Key Findings](#7-key-findings)
7.  [Further Insights and Future Steps](#8-further-insights-and-future-steps)
8.  [GitHub Repository](#9-github-repository)
## 1. Introduction

### Project Overview:

São Paulo, with its blend of culture, commerce, and lifestyle, presents a unique context for real estate analysis. This project aims to illuminate the key factors influencing apartment prices and choices in this vibrant city. By diving into a dataset encompassing apartment attributes and neighborhood details, we uncover patterns that empower potential buyers and renters to make informed decisions aligned with their preferences.

### Dataset Description:

#### Sao Paulo Real Estate - Sale / Rent - April 2019
**Dataset Link:** [Kaggle Dataset](https://www.kaggle.com/datasets/argonalyst/sao-paulo-real-estate-sale-rent-april-2019)

This dataset comprises around 13,000 apartments for sale and rent in São Paulo, Brazil, sourced from real estate classified websites.

#### Sao Paulo Districts Shapefile
**Dataset Link:** [Prefeitura SP](http://dados.prefeitura.sp.gov.br/dataset/distritos)

This shapefile provides spatial data for creating the map of São Paulo districts in Tableau.

### Business Problem:

**Problem Statement**: In São Paulo's competitive real estate market, how can we provide valuable insights to potential buyers and renters for making informed decisions about apartment choices?

**Objective**: Analyze the real estate dataset to identify key trends, price variations, and neighborhood preferences, ultimately assisting potential buyers and renters in making data-driven choices.



## 2. Data Cleaning and Preparation

### Data Source and Initial Exploration

- The dataset, sourced from Kaggle, comprises approximately 13,000 rows and 16 columns.
- To ensure precise spatial analysis, the 'district' column was matched with a spatial file map of São Paulo districts. This involved manually grouping each district from the Kaggle file to align with the spatial data. A total of 31 well-known districts were selected for inclusion.
- Special characters from the Portuguese language were not imported correctly into Excel. Manual corrections were made to ensure accurate representation of letters exported as special characters.

### Data Transformation

- A 'total_price' column was created by combining 'price' with 'hoa' fees for each apartment. This merged value, 'total_price', became the focus of our analysis.
- Duplicate entries were identified and removed to maintain data integrity.

### Data Enrichment

- A 'postal_code' column was manually generated to facilitate district filtering in the map visualization. This enabled displaying only the selected districts on the map.
- Some latitude and longitude values were left intentionally blank for apartments without these values, associating them with specific postal code areas.
## 3. Exploratory Data Analysis

During the initial phase of this real estate analysis project, I conducted exploratory data analysis using SQL queries to unearth valuable trends and patterns within the São Paulo real estate market. The following analyses were performed:

- **Rent vs. Sale Prices**: Analyzed the average, minimum, and maximum apartment prices for both rent and sale negotiations.
![Avg Prices](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/reults-avg-prices_ebqnl9.png)

- **Average Prices in Sao Paulo per District (Including HOA)**: Explored the average apartment prices in each district of Sao Paulo, considering negotiation type and HOA fees.

```sql
SELECT
  ROUND(AVG(price)) AS avg_price,
  ROUND(AVG(hoa)) AS avg_hoa,
  ROUND(AVG(total_price)) AS avg_total_price,
  district
FROM
 `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
 WHERE negotiation_type = 'rent' -- Choose 'rent' or 'sale'
GROUP BY 
  district
ORDER BY avg_total_price DESC;
```
- **Top 10 Districts with the Most Available Apartments**: Identified the top 10 districts with the highest number of available apartments for buying or renting.

![Top 10](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/top-10-apts_ojuj3t.png)

- **Average Price by Number of Parking Spots Available**: Investigated the average apartment price based on the number of parking spots available.
- **Percentage of Apartments with Parking**: Calculated the percentage of apartments in Sao Paulo that have parking spots.

![Parking Percentage](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/results-parking_dljv6j.png)

- **Average Amount of Parking Spots per Apartment**: Explored the average number of parking spots per apartment that has parking.
- **Amenity Combinations: Average Price Analysis**: Analyzed the average price for apartments with different combinations of amenities such as pool and elevators.

```sql
SELECT
  CASE
    WHEN swimming_pool = TRUE AND elevator = TRUE THEN 'Both: Pool & Elevator'
    WHEN swimming_pool = TRUE THEN 'Only Pool'
    WHEN elevator = TRUE THEN 'Only Elevator'
    ELSE 'None'
  END AS amenity_combination,
  ROUND(AVG(total_price)) AS avg_price
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
WHERE
  negotiation_type = 'sale' -- choose 'rent' or 'sale'
GROUP BY
  amenity_combination
ORDER BY
  avg_price DESC;
```

- **Amenity Combinations: Count of Apartments Analysis**: Counted the number of apartments based on different combinations of amenities like pool and elevators.

- **Rooms Distribution: Average Price per Number of Rooms**: Explored the relationship between the number of rooms and the average apartment price.

- **Rooms and Bathrooms Distribution**: Investigated the distribution of apartments based on the number of rooms and bathrooms.

- **Percentage of Apartments with Suites**: Calculated the percentage of apartments that have suites in each district.

```sql
SELECT
  SUM(suites) AS total_suites,
  SUM(rooms) AS total_number_of_rooms,
  ROUND(SUM(suites) / SUM(rooms) * 100) AS suites_percentage,
  district
FROM 
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate` 
GROUP BY district
ORDER BY suites_percentage DESC;
```
## 4. Data Visualization

### Tableau Dashboard

![dashboard](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/dashboard_kumfxf.png)

An interactive Tableau dashboard was created to visually represent insights gained from the São Paulo real estate dataset. The dashboard includes four visualizations:

![Avg Total Prices](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/avg-prices_koocvu.png)

- Average Price Comparison: Rent vs. Sale: Side-by-side comparison of average prices for rental and sale apartments in São Paulo.

![Apt Availability](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/apts-availability_uluucr.png)


- Apartment Availability by District: Map visualization showing apartment availability across districts.

![sizes](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/avg-sizes_ojxsgw.png)

- District Analysis: Apartment Size and Price per Square Foot: Heatmap revealing the relationship between apartment sizes, price per square foot, and districts.

![amenities](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/amenity-combinations_pxwhya.png)

- Amenity Combinations Impact: Bar chart displaying the impact of different amenity combinations on apartment prices.

### Dashboard Filters

The interactive Tableau dashboard comes equipped with powerful filters, enabling you to fine-tune your exploration of the São Paulo real estate market. These filters offer a dynamic and personalized analysis experience:

#### Negotiation Type
**Filter by Rent or Sale**: Choose whether to analyze rental properties or properties available for sale. By selecting one of these options, you can instantly influence all visualizations and analyses within the dashboard, gaining insights tailored to your interests.

#### Property Attributes

**Filter by Average Total Price**: Define a specific price range to narrow down your analysis based on the average total price of apartments. This filter allows you to focus on a particular pricing segment.

**Filter by Size (in sq. meters)**: Adjust the range to examine apartments of various sizes and delve into their corresponding characteristics. This feature is particularly useful for comparing different size categories.

**Filter by Number of Rooms**: Select the number of rooms to visualize how it impacts apartment prices and availability. This filter helps you uncover correlations between the number of rooms and other attributes.

**Filter by Number of Suites**: By filtering based on the number of suites in apartments, you can uncover potential correlations with pricing trends. This offers insights into how suites contribute to overall pricing.

**Filter by Number of Bathrooms**: Explore the relationship between the number of bathrooms and apartment prices by applying this filter. This insight can shed light on the importance of bathrooms in property pricing.

**Filter by Number of Parking Spaces**: Investigate how the availability of parking spaces affects apartment prices using this filter. This can help you understand the value of parking amenities.

**Filter by Furnished**: Choose to view furnished or unfurnished apartments and observe any differences in pricing and availability. This filter provides insights into the impact of furnishing on property characteristics.

**Filter by Elevator**: Analyze apartments with or without elevators to understand the impact on pricing and market presence. This filter highlights the influence of elevator amenities on property desirability.

**Filter by Swimming Pool**: Examine the effect of swimming pool availability on apartment prices and market representation. This filter explores the significance of swimming pools as amenities.

**Filter by New Construction**: Select newly constructed apartments to evaluate their pricing trends compared to older properties. This filter helps you compare new and existing developments.

#### Geographic Filters

**Filter by District**: Focus your analysis on specific districts within São Paulo by choosing the desired district(s) from the dropdown menu. This allows you to explore the distinct real estate landscapes across different neighborhoods, providing insights into localized market dynamics.
## 5. Summary

This project has provided a comprehensive analysis of the Sao Paulo real estate market, offering valuable insights that can guide potential buyers and renters in making informed decisions. Through a combination of SQL querying and Tableau visualization, we have explored various dimensions of property pricing, attributes, and neighborhood characteristics. By delving into amenities, room distribution, parking availability, and district-wise trends, we have gained a multifaceted understanding of the real estate landscape.

The interactive Tableau dashboard allows users to dynamically filter and explore the dataset, offering personalized insights based on specific preferences and requirements. Whether it's choosing between sale or rent, or evaluating property size, rooms, suites, bathrooms, parking spaces, or amenities, this dashboard empowers stakeholders to navigate the complexities of the market with confidence.
## 6. Key Findings

**Districts and Pricing**: The chosen districts at the heart of Sao Paulo tend to command higher prices, indicating the premium associated with central locations.

**Parking and Lifestyle**: The prevalence of available parking spaces suggests that car ownership is common in Sao Paulo, reflective of the city's traffic-heavy nature.

**Amenities and Comfort**: The widespread presence of both swimming pools and elevators highlights the popularity of amenities and the convenience of elevators in apartment buildings.

**Market Size and Desirability**: With nearly 7,000 available apartments in April 2019, Sao Paulo boasts a substantial real estate market, reflecting the city's desirability as the largest city in South America.
## 7. Further Insights and Future Steps

While this project provides valuable insights, further exploration and enhancement possibilities exist:

- Incorporating crime data for holistic neighborhood safety view.
- Time-series analysis for market trend identification.
- Predictive modeling for future price projections.

In conclusion, this project demonstrates data analysis power in guiding real estate decisions. Data-driven insights empower individuals and professionals to navigate the market with clarity and purpose.
## 8. Github Repository

For all project files, including SQL queries, Tableau dashboard, and documentation, visit the [GitHub repository](https://github.com/amandaroj/RealEstateAnalysis). Feel free to explore, run queries, and interact with the dashboard to gain deeper insights into the São Paulo real estate market.

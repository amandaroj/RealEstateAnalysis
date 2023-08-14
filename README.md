[# ****Real Estate Analysis of Apartments in São Paulo, Brazil****

## Table of Contents

1. [Introduction](#1-introduction)
2. [Data Cleaning and Preparation](#2-data-cleaning-and-preparation)
3. [Exploratory Data Analysis](#3-exploratory-data-analysis)
4. [Data Visualizations](#4-data-visualizations)
5. [Dashboard Filters](#5-dashboard-filters)
6. [Summary](#6-summary)
7. [Key Findings](#7-key-findings)
8. [Further Insights and Future Steps](#8-further-insights-and-future-steps)
9. [GitHub Repository](#9-github-repository)

## 1. Introduction

**Project Overview**: 

São Paulo's intricate blend of culture, commerce, and lifestyle presents a unique context for real estate analysis. This project aims to shed light on key factors influencing apartment prices and choices in this vibrant city. By delving into a dataset encompassing apartment attributes and neighborhood details, we uncover patterns that can help potential buyers and renters make informed decisions aligned with their preferences.

**Dataset Description:**

1. Sao Paulo Real Estate - Sale / Rent - April 2019
2. https://www.kaggle.com/datasets/argonalyst/sao-paulo-real-estate-sale-rent-april-2019
3. This dataset contains around 13.000 apartments for sale and rent in São Paulo, Brazil. The data comes from multiple sources, specifically from real estate classified websites.
4. http://dados.prefeitura.sp.gov.br/dataset/distritos
5. This dataset provides the shapefile for creating the map of Sao Paulo’s districts in Tableau

**Business Problem:**

**Problem Statement**: In the competitive real estate market of São Paulo, how can we provide valuable insights to potential buyers and renters to make informed decisions about apartment choices?

**Objective**: Analyze the real estate dataset to identify key trends, price variations, and neighborhood preferences, ultimately aiding potential buyers and renters in making data-driven choices.

## 2. Data Cleaning and Preparation

**Data Source and Initial Exploration**

- The dataset was sourced from Kaggle and consists of approximately 13,000 rows and 16 columns.
- To ensure accurate spatial analysis, the 'district' column was matched with a spatial file map of São Paulo districts. This involved manual grouping of each district from the Kaggle file to align with the spatial data. A total of 31 well-known districts were selected to be included in this dataset.
- Special characters from the Portuguese language were not imported correctly into Excel. To address this, manual corrections were made to ensure accurate representation of letters that were exported as special characters.

**Data Transformation**

- A new column named 'total_price' was created by combining 'price' with 'hoa' fees for each apartment. This merged value, 'total_price', will be the focus of our analysis.
- Duplicate entries were identified within the dataset and subsequently removed to maintain data integrity.

**Data Enrichment**

- A 'postal_code' column was manually generated to facilitate district filtering in the map visualization. This enabled us to display only the selected districts from the dataset on the map.

**Spatial Data Enhancement**

Some latitude and longitude values were missing, but they were intentionally left blank as apartments without these values were associated with specific postal code areas.

## 2. Exploratory Data Analysis

During the initial phase of this real estate analysis project, I conducted exploratory data analysis to gain insights into the dataset. The following SQL queries were used to uncover valuable trends and patterns within the Sao Paulo real estate market:

1. **Average, Minimum, and Maximum Rent vs. Sale Prices**:
Analyzed the average, minimum, and maximum apartment prices for both rent and sale negotiations.

![Avg Prices](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/reults-avg-prices_ebqnl9.png)

1. **Average Prices in Sao Paulo per District, Including HOA**:
Explored the average apartment prices in each district of Sao Paulo, considering negotiation type and HOA fees.

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

1. **Top 10 Districts with the Most Available Apartments**:
Identified the top 10 districts with the highest number of available apartments for buying or renting.

![Top 10](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/top-10-apts_ojuj3t.png)

1. **Average Price by Number of Parking Spots Available**:
Investigated the average apartment price based on the number of parking spots available.
2. **Percentage of Apartments with Parking**:
Calculated the percentage of apartments in Sao Paulo that have parking spots.

![Parking Percentage](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/results-parking_dljv6j.png)

1. **Average Amount of Parking Spots per Apartment**:
Explored the average number of parking spots per apartment that has parking.
2. **Amenity Combinations: Average Price Analysis**:
Analyzed the average price for apartments with different combinations of amenities such as pool and elevators.

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

1. **Amenity Combinations: Count of Apartments Analysis**:
Counted the number of apartments based on different combinations of amenities like pool and elevators.
2. **Rooms Distribution: Average Price per Number of Rooms**:
Explored the relationship between the number of rooms and the average apartment price.
3. **Rooms and Bathrooms Distribution**:
Investigated the distribution of apartments based on the number of rooms and bathrooms.
4. **Percentage of Apartments with Suites**:
Calculated the percentage of apartments that have suites in each district.

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

These exploratory analyses provided a foundation for deeper insights into the Sao Paulo real estate market. The visualizations and interpretations of these results are presented in the subsequent sections of this project. By examining these aspects, we aim to gain a comprehensive understanding of the factors influencing apartment prices and preferences in different districts of Sao Paulo.

## **Data Visualizations**

### **Tableau Dashboard**

I have created an interactive Tableau dashboard to visually represent the insights gained from the analysis of the Sao Paulo real estate dataset. This dashboard comprises four distinct visualizations, each designed to provide a clear and insightful representation of various aspects of the real estate market.

### 1. Average Price Comparison: Rent vs. Sale

This bar chart presents a side-by-side comparison of the average prices for rental and sale apartments in Sao Paulo. The visualization helps highlight any significant price variations between the two negotiation types.

![Avg Total Prices](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/avg-prices_koocvu.png)

### 2. Apartment Availability by District

The map visualization provides a geographic representation of apartment availability across different districts of Sao Paulo. Each district is color-coded based on the number of apartments available, offering a comprehensive overview of the real estate market distribution.

![Apt Availability](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/apts-availability_uluucr.png)

### 3. District Analysis: Apartment Size and Price per Square Foot

The heatmap visualization showcases the relationship between apartment sizes, price per square foot, and districts. By using color intensity, it allows for a quick comparison of district-wise average sizes and price per square foot.

![sizes](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/avg-sizes_ojxsgw.png)

### 4. Amenity Combinations Impact

This bar chart displays the impact of different amenity combinations on apartment prices. It categorizes apartments based on their amenities, such as swimming pool and elevator, providing insights into how specific combinations influence pricing.

![amenities](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036221/amenity-combinations_pxwhya.png)

### **Dashboard Filters**

To enhance your exploration of the real estate data, I have included interactive filters within the Tableau dashboard. These filters allow you to customize the view and focus on specific aspects of the market:

- **Negotiation Type**: Filter apartments by sale or rent to compare pricing trends.
- **Apartment Size**: Adjust the view based on the desired size range in square meters.
- **District**: Select specific districts to examine their individual market dynamics.

These filters empower you to tailor the visualizations according to your interests and research questions, providing a more personalized and in-depth analysis experience.

![dashboard](https://res.cloudinary.com/dmxsjswbi/image/upload/v1692036222/dashboard_kumfxf.png)

### **Negotiation Type**

- **Filter by Rent or Sale**: Choose whether to analyze rental properties or properties available for sale. Selecting one of these options will influence all the visualizations and analyses in the dashboard.

### **Property Attributes**

- **Filter by Average Total Price**: Define a price range to narrow down your analysis based on the average total price of apartments.
- **Filter by Size (in sq. meters)**: Adjust the range to examine apartments of various sizes and their corresponding characteristics.
- **Filter by Number of Rooms**: Select the number of rooms to view the impact on apartment prices and availability.
- **Filter by Number of Suites**: Filter based on the number of suites in apartments to uncover potential correlations with pricing trends.
- **Filter by Number of Bathrooms**: Explore the relationship between the number of bathrooms and apartment prices by applying this filter.
- **Filter by Number of Parking Spaces**: Investigate how the availability of parking spaces affects apartment prices using this filter.
- **Filter by Furnished**: Choose to view furnished or unfurnished apartments and observe any differences in pricing and availability.
- **Filter by Elevator**: Analyze apartments with or without elevators to understand the impact on pricing and market presence.
- **Filter by Swimming Pool**: Examine the effect of swimming pool availability on apartment prices and market representation.
- **Filter by New Construction**: Select newly constructed apartments to evaluate their pricing trends compared to older properties.

### **Geographic Filters**

- **Filter by District**: Focus your analysis on specific districts within Sao Paulo by choosing the desired district(s) from the dropdown menu. This allows you to explore the distinct real estate landscapes across different neighborhoods.

## **Summary**

This project has provided a comprehensive analysis of the Sao Paulo real estate market, offering valuable insights that can guide potential buyers and renters in making informed decisions. Through a combination of SQL querying and Tableau visualization, we have explored various dimensions of property pricing, attributes, and neighborhood characteristics. By delving into amenities, room distribution, parking availability, and district-wise trends, we have gained a multifaceted understanding of the real estate landscape.

The interactive Tableau dashboard allows users to dynamically filter and explore the dataset, offering personalized insights based on specific preferences and requirements. Whether it's choosing between sale or rent, or evaluating property size, rooms, suites, bathrooms, parking spaces, or amenities, this dashboard empowers stakeholders to navigate the complexities of the market with confidence.

## **Key Findings**

Through our analysis, several noteworthy findings have emerged:

1. **Districts and Pricing**: The chosen districts at the heart of Sao Paulo tend to command higher prices, indicating the premium associated with central locations.
2. **Parking and Lifestyle**: The prevalence of available parking spaces suggests that car ownership is common in Sao Paulo, reflective of the city's traffic-heavy nature.
3. **Amenities and Comfort**: The widespread presence of both swimming pools and elevators highlights the popularity of amenities and the convenience of elevators in apartment buildings.
4. **Market Size and Desirability**: With nearly 7,000 available apartments in April 2019, Sao Paulo boasts a substantial real estate market, reflecting the city's desirability as the largest city in South America.

## **Further Insights and Future Steps**

While this project has provided valuable insights, there are additional avenues for exploration and enhancement. Incorporating crime data into the analysis could offer a holistic view of neighborhood safety, aiding potential buyers in making well-rounded decisions. Time-series analysis could reveal market trends, while predictive modeling might offer future price projections, further assisting stakeholders in their decision-making.

In conclusion, this project demonstrates the power of data analysis in guiding decisions within the complex realm of real estate. By harnessing data-driven insights, individuals and professionals alike can navigate the real estate landscape with clarity and purpose, ensuring that every investment aligns with individual preferences and strategic goals.

## **GitHub Repository**

All project files, including SQL queries, Tableau dashboard, and documentation, can be accessed in the GitHub repository: **[Link to GitHub Repository](https://github.com/yourusername/your-repo-name)**

Feel free to explore, run queries, and interact with the dashboard to gain deeper insights into the Sao Paulo real estate market.
](https://github.com/amandaroj/RealEstateAnalysis)https://github.com/amandaroj/RealEstateAnalysis

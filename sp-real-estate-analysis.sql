-- Average, minimum and maximum rent vs. sale prices
SELECT
  negotiation_type,
  COUNT(*) AS apartment_count,
  MIN(price) AS min_price,
  MAX(price) AS max_price,
  ROUND(AVG(price)) AS avg_price
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
GROUP BY
  negotiation_type;
  
-- Average prices in Sao Paulo per district, including HOA
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

-- Top 10 districts with the most available apartments to buy/rent
SELECT
  COUNT(*) AS total_apts,
  district
FROM 
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
GROUP BY
  district
ORDER BY
  total_apts DESC -- change to 'ASC' to view least available districts to buy/rent
LIMIT 10;

-- Average price by number of parking spots availble
SELECT
  parking AS has_parking,
  ROUND(AVG(price)) AS avg_price
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
WHERE
  negotiation_type = 'sale'
GROUP BY
  has_parking
ORDER BY 
  has_parking;

-- how many apartments have parking? What percentage of apartments in Sao Paulo have parking?
SELECT
  COUNTIF(parking > 0) AS parking_spots,
  COUNT(apt_id) AS total_apartments,
  ROUND(COUNTIF(parking > 0) / COUNT(apt_id) * 100) AS percent_of_apts_with_parking
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`;

-- average amount of parking spots per apartment
SELECT
  SUM(parking) AS parking_spots,
  COUNT(apt_id) AS total_apartments,
  SUM(parking) / COUNT(apt_id) AS avg_parking_spaces
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
WHERE 
  parking > 0;

  -- Amenity Combinations: average price for apartments with pool & elevators
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

-- Amenity Combinations: count of apartments with with pool & elevators

SELECT
  CASE
    WHEN swimming_pool = TRUE AND elevator = TRUE THEN 'Both: Pool & Elevator'
    WHEN swimming_pool = TRUE THEN 'Only Pool'
    WHEN elevator = TRUE THEN 'Only Elevator'
    ELSE 'None'
  END AS amenity_combination,
  COUNT(*) AS apartment_count
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
WHERE 
  negotiation_type = 'sale' -- choose 'rent' or 'sale'
GROUP BY
  amenity_combination
ORDER BY
  apartment_count DESC;

  -- Rooms Distribution: Average price per number of rooms
SELECT
  rooms,
  AVG(price) AS avg_price
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
GROUP BY
  rooms
ORDER BY
  rooms;

-- How many rooms and bathrooms do apartments have?
SELECT
  rooms,
  bathrooms,
  COUNT(*) AS apartment_count
FROM
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate`
GROUP BY
  rooms, bathrooms
ORDER BY
  rooms, bathrooms;

  -- What percentage of all apartments have suites?
SELECT
  SUM(suites) AS total_suites,
  SUM(rooms) AS total_number_of_rooms,
  ROUND(SUM(suites) / SUM(rooms) * 100) AS suites_percentage,
  district
FROM 
  `saopaulorealestateproject.RealEstateSp2019.SaoPauloRealEstate` 
GROUP BY district
ORDER BY suites_percentage DESC;
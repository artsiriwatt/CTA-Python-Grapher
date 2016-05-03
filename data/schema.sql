DROP VIEW IF EXISTS route_db;

CREATE TABLE cta_stops (
  "stop_id" varchar(10) PRIMARY KEY,
  "on_street" varchar(40),
  "cross_street" varchar(40),
  "routes" varchar(50),
  "boardings" decimal,
  "alightings" decimal,
  "month_beginning" varchar(16),
  "daytype" varchar(10),
  "location" varchar(50)
);

COPY cta_stops FROM '/Users/ArtSiriwatt/Desktop/Bokeh Example/data/data.csv' DELIMITER ',' CSV;

update cta_stops set routes = replace(routes, ' ', '');
--note small edit - on stop_id 1121 - there's an extra comma that 
--messes up the table, I manually removed it from the CSV


--CREATE VIEW route_db AS
--SELECT stop_id, on_street, cross_street, s.route, month_beginning, daytype, location
--FROM cta_stops t, unnest(string_to_array(t.routes, ',')) s(route);

CREATE TABLE replacement AS
SELECT stop_id, on_street, cross_street, s.route, boardings, alightings, month_beginning, daytype, location
FROM cta_stops t, unnest(string_to_array(t.routes, ',')) s(route);

DROP TABLE cta_stops;
ALTER TABLE replacement RENAME to "cta_stops";


--Longest Bus route by number of stops
--SELECT route, COUNT(route) 
--FROM route_db 
--GROUP BY route 
--ORDER BY COUNT(route) DESC;


--COPY (
--SELECT row_to_json(t)
--FROM 
--(SELECT route, COUNT(route) 
--FROM route_db 
--GROUP BY route 
--ORDER BY COUNT(route) DESC) t)
--TO '/Users/ArtSiriwatt/Desktop/Civis Analytics Project/route-num_stops';


--Bus Stop that Appears on Most Bus Routes
--SELECT stop_id, on_street, cross_street, COUNT(stop_id) 
--FROM route_db 
--GROUP BY stop_id, on_street, cross_street 
--ORDER BY COUNT(stop_id) DESC;

--COPY (
--SELECT row_to_json(t)
--FROM 
--(SELECT stop_id, on_street, cross_street, COUNT(stop_id) 
--FROM route_db 
--GROUP BY stop_id, on_street, cross_street 
--ORDER BY COUNT(stop_id) DESC) t)
--TO '/Users/ArtSiriwatt/Desktop/Civis Analytics Project/stop_num_routes';


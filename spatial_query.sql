SELECT * FROM (SELECT lc.sam_address_id AS "SamID",
lc.license_worktype AS "worktype",
lc.license_status AS "licensestatus",
lc.application_date AS "ApplicationDate",
lc.hansen_milestone_id AS "MilID",
sam_internal_data.address_lat_long_vw."latitude" AS lat,
sam_internal_data.address_lat_long_vw."longitude" AS lon
FROM(SELECT * FROM analytics_internal_data.str_license_fact)lc
LEFT JOIN sam_internal_data.address_lat_long_vw ON sam_internal_data.address_lat_long_vw.sam_address_id = lc.sam_address_id)ls
LEFT JOIN analytics_internal_data.str_license_milestone_dim ON analytics_internal_data.str_license_milestone_dim.hansen_milestone_id = ls."MilID"

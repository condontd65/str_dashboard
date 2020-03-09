SELECT 'Intake' AS "milestone",
COUNT("hans_lmile")
FROM (SELECT lc.sam_address_id AS "SamID",
lc.license_worktype AS "WorkType",
lc.license_status AS "LicenseStatus",
lc.application_date AS "ApplicationDate",
lc.hansen_milestone_id AS "MilID",
analytics_internal_data.str_license_milestone_dim.license_status AS "HANS_LSTAT",
analytics_internal_data.str_license_milestone_dim.milestone_status AS "hans_lmile"
FROM(SELECT * FROM analytics_internal_data.str_license_fact) AS lc
LEFT JOIN analytics_internal_data.str_license_milestone_dim ON analytics_internal_data.str_license_milestone_dim.hansen_milestone_id = lc.hansen_milestone_id)wt
WHERE hans_lmile = 'Intake'
UNION ALL
SELECT hans_lmile,
       COUNT(hans_lmile)
FROM (SELECT lc.str_license_id,
lc.sam_address_id AS "SamID",
lc.license_worktype AS "WorkType",
lc.license_status AS "LicenseStatus",
lc.application_date AS "ApplicationDate",
lc.hansen_milestone_id AS "MilID",
analytics_internal_data.str_license_milestone_dim.license_status AS "HANS_LSTAT",
analytics_internal_data.str_license_milestone_dim.milestone_status AS "hans_lmile"
FROM(SELECT * FROM analytics_internal_data.str_license_fact) AS lc
LEFT JOIN analytics_internal_data.str_license_milestone_dim ON analytics_internal_data.str_license_milestone_dim.hansen_milestone_id = lc.hansen_milestone_id)wt
WHERE hans_lmile = 'Updates Required' OR hans_lmile = 'Pay Fees'
GROUP BY hans_lmile

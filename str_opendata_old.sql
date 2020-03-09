SELECT la.addrkey AS address_id,
       la.licenseno AS license_num,
       regexp_replace(lc.descript, '^\s*x\s*', '', 'gi') AS license_type,
       la.adddttm::DATE AS application_date,
       CASE WHEN la.licstatus = 'Active' AND la.issdttm IS NOT NULL
              THEN 'Active'
            WHEN la.licstatus = 'Active' AND la.issdttm IS NULL
              THEN 'Under Review'
            WHEN lps.code = 'Abandoned'
              THEN 'Abandoned App'
            WHEN lps.code = 'Closed' AND la.issdttm IS NULL
              THEN 'Denied'
            WHEN lps.code = 'Expired'
              THEN 'Expired'
            WHEN lps.code = 'Suspended'
              THEN 'Suspended'
            WHEN lps.code = 'Closed' AND la.issdttm IS NOT NULL
              THEN 'Closed'
            END AS license_status,
       CASE WHEN la.licstatus = 'Expired' THEN expdttm::DATE
            ELSE la.lstactdttm::DATE
            END AS last_status_change
  FROM hansen_internal_data.license_applications la
  LEFT JOIN hansen_internal_data.license_process_state lps
       ON la.aplicprocessstatekey = lps.aplicprocessstatekey
  LEFT JOIN hansen_internal_data.license_category lc
       ON la.licensecat = lc.code
 WHERE la.aplicdefnkey IN (1041, 1026)
       AND (la.comments !~* '(^|\s)test(\s|$)' or la.comments is null) 
       and la.licenseno ilike 'STR%'

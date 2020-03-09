SELECT license_applications.licenseno AS str_licence_id,
       license_type.licensetype AS license_type,
       license_applications.ADDDTTM AS application_date, 
	   license_applications.ISSDTTM AS issue_date,
	   license_applications.EXPDTTM AS expire_date, 
       license_applications.LICENSECAT AS licence_worktype,  
       license_applications.LICSTATUS AS licence_status,
	   license_review_type.REVIEWTYPE AS review_type,
	   license_review.APLICREVIEWKEY AS review_no,
	   license_review.TYPENO AS review_instance,
	   license_review.ADDDTTM AS review_add_date,
	   license_review.RESULTDTTM AS review_result_date,
	   license_review.RESULTBY AS reviewer,
	   license_review.RESULT AS review_result, 
       (license_review.RESULTDTTM::date - license_review.ADDDTTM::date) AS days_to_review,
       (license_applications.ISSDTTM::date - license_applications.ADDDTTM::date) AS days_to_issuance
  FROM 
       hansen_internal_data.license_applications
       INNER JOIN hansen_internal_data.license_type
	   ON license_applications.aplicdefnkey = hansen_internal_data.license_type.aplicdefnkey
       INNER JOIN hansen_internal_data.license_review
	   ON license_applications.aplickey = license_review.aplickey
	   INNER JOIN hansen_internal_data.license_review_type 
	   ON hansen_internal_data.license_type.aplicdefnkey = license_review_type.aplicdefnkey
	   AND license_review.aplicreviewtypekey = license_review_type.aplicreviewtypekey
 WHERE 
       hansen_internal_data.license_type.licensetype = 'STR'
   AND license_applications.LICSTATUS <> 'Void'

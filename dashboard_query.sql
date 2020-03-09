SELECT la.licenseno AS str_license_id,
		lt.licensetype AS license_type,
		la.ADDDTTM AS application_date,
		la.ISSDTTM AS issue_date,
		la.EXPDTTM AS expire_date,
		la.LICENSECAT AS license_worktype,
		la.LICSTATUS AS license_status,
		lrt.REVIEWTYPE AS review_type,
		lr.APLICREVIEWKEY AS review_no,
		lr.TYPENO AS review_instance,
		lr.ADDDTTM AS review_add_date,
		lr.RESULTDTTM AS review_result_date,
		lr.RESULTBY AS reviewer,
		lr.RESULT AS review_result, 
       (lr.ADDDTTM::date - lr.RESULTDTTM::date) AS days_to_review
FROM hansen_internal_data.license_applications AS la
INNER JOIN hansen_internal_data.license_type AS lt
	ON la.aplicdefnkey = lt.aplicdefnkey
INNER JOIN hansen_internal_data.license_review AS lr
	ON la.aplickey = lr.aplickey
INNER JOIN hansen_internal_data.license_review_type AS lrt
	ON lt.aplicdefnkey = lrt.aplicdefnkey
		AND lr.aplicreviewtypekey = lrt.aplicreviewtypekey
WHERE lt.licensetype = 'STR'
ORDER BY lr.resultdttm DESC

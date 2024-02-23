SELECT *,IIF(Gender=0,'Nam','Nu') FROM [User]
SELECT *,
	CASE
		WHEN Gender = 0 THEN 'Nu'
		ELSE 'Nam'
	END
FROM [User]
/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		PRINT '*********************Entered into Try Block****************************'

		PRINT '*********************Loading CRM Tables********************************'

		PRINT '*********************Truncating Table : bronze.crm_cust_info**********************'
		SET @batch_start_time = GETDATE();
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info;
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		--Select * from bronze.crm_cust_info

		PRINT '*********************Truncating Table : bronze.crm_prd_info**********************'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		--Select * from bronze.crm_prd_info
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '*********************Truncating Table : bronze.crm_sales_details**********************'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		--Select * from bronze.crm_sales_details
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '*********************Loading ERP Tables********************************'

		PRINT '*********************Truncating Table : bronze.erp_cust_az12**********************'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_cust_az12;
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		--Select * from bronze.erp_cust_az12
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '*********************Truncating Table : bronze.erp_loc_a101**********************'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_loc_a101;
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		--Select * from bronze.erp_loc_a101
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';

		PRINT '*********************Truncating Table : bronze.erp_px_cat_g1v2**********************'
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\Projects\Warehouse project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (				-- specifications with which data has to be inserted
			FIRSTROW = 2,	--Skip first row because actual data starts from second row
			FIELDTERMINATOR = ',',
			TABLOCK			--lOCKING THE WHOLE TABLE IS sql IS TRYING TO LOAD THE TABLE WITH DATA
		);
		SET @end_time = GETDATE();
		--Select * from bronze.erp_px_cat_g1v2
		PRINT '>>Load Duration is ' + CAST(DATEDIFF(second,@start_time,@end_time) AS NVARCHAR) + 'seconds';
		SET @batch_end_time = GETDATE();

		PRINT '*********************Loading Bronze layer is completed*******************'
		PRINT 'BATCH LOAD DURATION is : ' + CAST(DATEDIFF(second,@batch_start_time, @batch_end_time) AS NVARCHAR) + 'seconds';
	END TRY
	BEGIN CATCH
	PRINT '*********************Entered into Catch Block********************************'
	PRINT '*********************Error occured while loading Bronze Layer****************'
	PRINT 'Error Message' + ERROR_MESSAGE();
	PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
	PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
	END CATCH
END

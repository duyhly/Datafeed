<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Manager Revenue table: Stores the total sum of each
	 * affiliate account manager for each store.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('TABLE_AFFILIATE_LIST', 'dl_ib_Affiliate_Manager_System_Affiliate_List');
	DEFINE('TABLE_AFFILIATE_SUMMARY', 'dl_ib_Affiliate_Manager_System_Affiliate_Summary');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Manager Revenue table: Stores the total sum of each
	 * affiliate account manager for each store.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('TABLE_MANAGER_REVENUE', 'dl_ib_Affiliate_Manager_System_Manager_Revenue');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Peak Sales report tables: Store details about the 
	 * peak net sales for each store and each account manager.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('TABLE_STORE_PEAK_SALES', 'dl_ib_Affiliate_Manager_System_Peak_Store_Statistics');
	DEFINE('TABLE_MANAGER_PEAK_SALES', 'dl_ib_Affiliate_Manager_System_Peak_Manager_Statistics');

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Leaderboard report table: Stores information about the
	 * the monthly statistics rank for each manager.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('TABLE_MANAGER_LEADERBOARD', 'dl_ib_Affiliate_Manager_System_Leaderboard');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Affiliate Manager commission tables.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('TABLE_BONUS_SUMMARY', 'dl_ib_Affiliate_Manager_System_Bonus_Summary');
	DEFINE('TABLE_MONTHLY_BONUS_DETAILS', 'dl_ib_Affiliate_Manager_System_Monthly_Bonus_Details');
	DEFINE('TABLE_FIRST_IMPACT_BONUS_DETAILS', 'dl_ib_Affiliate_Manager_System_First_Impact_Bonus_Details');
    DEFINE('TABLE_ACCOUNT_MANAGER', 'dl_ib_Affiliate_Manager_System_Users');
    
    /*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Helper tables.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
    DEFINE('TABLE_ROLES', 'dl_ib_Affiliate_Manager_System_Roles');
    DEFINE('TABLE_STORE_INFO', 'dl_ib_Affiliate_Manager_System_Store_Names');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Define running modes
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
    DEFINE('DEFAULT_MODE', 'easycron');
	DEFINE('RECALCULATION_MODE', 'recalculate');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Define roles
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
    
    DEFINE('ROLE_NAME_ACCOUNT_MANAGER', 'AccountManager');
    DEFINE('ROLE_NAME_ADMIN', 'Admin');
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Define Bonus Attributes
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('MONTHLY_BONUS', 'Monthly_Bonus'); 
	DEFINE('FIRST_IMPACT_BONUS', 'First_Impact_Bonus'); 
	 
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_REGULAR', 'regular');
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_REGULAR_PERCENTAGE', 1);

	DEFINE('MONTHLY_BONUS_SUBCATEGORY_HIGHEST', 'highest');
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_HIGHEST_PERCENTAGE', 2);
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_HIGHEST_BASIS', 500);
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_HIGHEST_MAX_ADDITION', 500);
	
	DEFINE('MONTHLY_BONUS_SUBCATEGORY_MOM', 'mom');
	
	DEFINE('FIRST_IMPACT_BONUS_SUBCATEGORY_PEAK_MONTH', 'peak_month');
	DEFINE('FIRST_IMPACT_BONUS_SUBCATEGORY_PEAK_QUARTER', 'peak_quarter');
	DEFINE('FIRST_IMPACT_BONUS_SUBCATEGORY_PEAK_MONTH_PERCENTAGE', 5);
	DEFINE('FIRST_IMPACT_BONUS_SUBCATEGORY_PEAK_QUARTER_PERCENTAGE', 5);
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Define constant values
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	DEFINE('VALUE_TRUE', 1);
	DEFINE('VALUE_FALSE', 0);
	
	DEFINE('REPORT_TYPE_QUARTERLY', 'Quarterly');
	DEFINE('REPORT_TYPE_MONTHLY', 'Monthly');
	

?>
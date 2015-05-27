<?php 
    /*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
     * Author: Duy Ly & Isabel B. O.
     * Description: 
     * Date: 5/13/2015
     *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
    
    require('MysqliDb.php');
    require_once(__DIR__.'./../Config/Config.php');

    abstract class BaseModel extends MysqliDb 
    {
        protected $table;
        
		protected $affiliateListTable    		= TABLE_AFFILIATE_LIST;
        protected $affiliateSummaryTable    	= TABLE_AFFILIATE_SUMMARY;
        protected $managerRevenueTable      	= TABLE_MANAGER_REVENUE;
        protected $accountManagerTable      	= TABLE_ACCOUNT_MANAGER;
        protected $rolesTable               	= TABLE_ROLES;    
	    protected $bonusSummaryTable        	= TABLE_BONUS_SUMMARY;
		protected $monthlyBonusDetailsTable 	= TABLE_MONTHLY_BONUS_DETAILS;
		protected $firstImpactBonusDetailsTable = TABLE_FIRST_IMPACT_BONUS_DETAILS;
        protected $leaderboardTable         	= TABLE_MANAGER_LEADERBOARD;
        protected $storeInfoTable           	= TABLE_STORE_INFO;
		protected $peakSalesTable 				= TABLE_STORE_PEAK_SALES;
		

        function __construct()
        {
            $db_config = Config::getInstance()->load('DATABASE');
            parent::__construct($db_config['host'], $db_config['username'], $db_config['password'], $db_config['database']);
        }

        function getFullStoreName($storeAbbreviation) 
        {
            return $this->where('Store_Abbreviation', $storeAbbreviation, '=')
            			->getValue($this->storeInfoTable, 'Full_Store_Name');
        }
    }

?>
<?php    
    /*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
    
    require_once(__DIR__.'./../../MySQLDao.php');
    require_once(__DIR__.'./../../../Config/Config.php');
	require_once(__DIR__.'./../../../Config/Constants.php');

    abstract class MySQLDatafeedDao extends MySQLDao 
    {      
		protected $_tableProducts  				= TABLE_PRODUCTS;
		protected $_tableProductChanges 		= TABLE_PRODUCT_CHANGES;
		
        function __construct()
        {
            $dbConfig = Config::getInstance()->load('MYSQL_DATAFEED_DATABASE');
            parent::__construct($dbConfig['host'], $dbConfig['username'], $dbConfig['password'], $dbConfig['database']);
        }

    }

?>
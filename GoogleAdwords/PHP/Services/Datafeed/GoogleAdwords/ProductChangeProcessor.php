<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
 
    require_once (__DIR__."./../../BaseService.php");
    require_once (__DIR__."./../../../Config/Config.php");
	require_once (__DIR__."./../../../Models/Datafeed/DatafeedDaoFactory.php");
	require_once (__DIR__."./../../../Models/Datafeed/Product.php");

	class ProductChangeProcessor extends BaseService 
	{
		protected $_productChangeDao;

		function __construct() {
			$this->_productChangeDao = DatafeedDaoFactory::getFactory()->getProductChangeDao();
		}
		
		public function saveProductChange(ProductChange $productChange)
		{
			$this->_productChangeDao->insertProductChange($productChange);
		}
		
		public function truncateProductChanges()
		{
			$this->_productChangeDao->deleteAll();
		}
		
	}

?>
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

	class ProductProcessor extends BaseService 
	{
		protected $_productDao;

		function __construct() {
			$this->_productDao = DatafeedDaoFactory::getFactory()->getProductDao();
		}
		
		public function getProducts()
		{
			d('start getting product');
			
			return $this->_productDao->getAll();
		}
		
		public function saveProducts($products)
		{
			foreach ($products as $product)
			{
				$this->_productDao->insertProduct($product);
			}
		}
		
		public function truncateProducts()
		{
			$this->_productDao->deleteAll();
		}
		
	}

?>
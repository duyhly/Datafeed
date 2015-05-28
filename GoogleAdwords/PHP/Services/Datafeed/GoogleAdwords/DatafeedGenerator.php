<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
 
    require_once (__DIR__."./../../BaseService.php");
	require_once (__DIR__."./VolutionDataProvider.php");
	require_once (__DIR__."./ProductProcessor.php");
	require_once (__DIR__."./ChangesTracker.php");

	class DatafeedGenerator extends BaseService 
	{
		// Workers 
		protected $_volutionDataProvider;
		protected $_productProcessor;
		protected $_changesTracker;
		
		// Properties
		protected $_newProducts = array();
		protected $_oldProducts = array();
		protected $_changes = array();
		
		function __construct() {
			$this->_volutionDataProvider 	= new VolusionDataProvider();
			$this->_productProcessor 		= new ProductProcessor();
			$this->_changesTracker			= new ChangesTracker();
		}
		
		public function generateDatafeed()
		{
			// first step is to get new product
			$this->getNewProducts();
			$this->getOldProducts();
			$this->trackChanges();
			$this->saveNewProducts();
			
		}
		
		protected function getNewProducts()
		{
			$this->_newProducts = $this->_volutionDataProvider->getProducts();
//dd($this->_newProducts);
		}
		
		protected function getOldProducts()
		{
			$this->_oldProducts = $this->_productProcessor->getProducts();
//			dd($this->_oldProducts);
		}
		
		protected function trackChanges()
		{
			$this->_changesTracker->setNewProducts($this->_newProducts);
			$this->_changesTracker->setOldProducts($this->_oldProducts);
			$this->_changesTracker->compareProducts();
			$this->_changesTracker->truncateProductChanges();
			$this->_changesTracker->saveProductChanges();
		}
		
		protected function saveNewProducts()
		{
			$this->_productProcessor->truncateProducts();
			$this->_productProcessor->saveProducts($this->_newProducts);
		}
		
		
	}

?>
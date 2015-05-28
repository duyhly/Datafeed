<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	
	require_once(__DIR__.'./MySQLDatafeedDao.php');
	require_once(__DIR__.'./../Interfaces/ProductChangeInterface.php');
	require_once(__DIR__.'./../ProductChange.php');
	
	class MySQLProductChangeDao extends MySQLDatafeedDao implements ProductChangeInterface
	{
		
		public function insertProductChange(ProductChange $productChange)
		{
			$productChangeData = array(
				'type_of_change'			=> $productChange->getTypeOfChange(),
				'sku' 						=> $productChange->getSku(),
				'brand' 					=> $productChange->getBrand(),
				'name' 						=> $productChange->getName(),
				'price'						=> $productChange->getPrice(),
				'retail_price'				=> $productChange->getRetailPrice(),
				'money_saving'				=> $productChange->getMoneySaving(),
				'product_url'				=> $productChange->getProductUrl(),
				'compatible_printer_models' => $productChange->getCompatiblePrinterModels(),
				'old_data'					=> $productChange->getOldData()
			);
	 		
			$this->insert($this->_tableProductChanges, $productChangeData);
			return true;
		}
		
		public function deleteAll()
		{
			$this->delete($this->_tableProductChanges);
		}
	}
		
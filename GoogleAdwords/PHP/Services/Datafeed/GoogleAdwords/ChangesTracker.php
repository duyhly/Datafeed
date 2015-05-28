<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
    require_once (__DIR__."./../../BaseService.php");
	require_once (__DIR__."./ProductChangeProcessor.php");
	require_once (__DIR__."./../../../Models/Datafeed/ProductChange.php");
	

	class ChangesTracker extends BaseService
	{
		// Services 
		protected $_productChangeProcessor = array();
		
		// Properties
		protected $_comparisonDict = array();
		protected $_productChanges = array();
		
		function __construct()
		{
			$this->_productChangeProcessor = new ProductChangeProcessor();
		}

		public function setNewProducts($products)
		{
			foreach ($products as $product)
			{
				$sku = $product->getSku();
				if (array_key_exists($sku, $this->_comparisonDict))
				{
					$this->_comparisonDict[$sku]['new'] = $product;
				} 
				else 
				{
					$this->_comparisonDict[$sku] = array(
						'new' => $product,
						'old' => null
						);
				}
			}
		}
		
		public function setOldProducts($products)
		{
			foreach ($products as $product)
			{
				$sku = $product->getSku();
				if (array_key_exists($sku, $this->_comparisonDict))
				{
					$this->_comparisonDict[$sku]['old'] = $product;
				} 
				else 
				{
					$this->_comparisonDict[$sku] = array(
						'new' => null,
						'old' => $product
						);
				}
			}
		}
		
		public function compareProducts()
		{
			$this->_productChanges = array();
			foreach ($this->_comparisonDict as $comparedObj)
			{
				$newProduct = $comparedObj['new'];
				$oldProduct = $comparedObj['old'];
				$productChange = null;
				
				if (is_null($newProduct))
				{
					$productChange = castObject($oldProduct, 'ProductChange');
					$productChange->setTypeOfChange(TYPE_OF_CHANGE_DELETED);
					
				}
				else if (is_null($oldProduct))
				{
					$productChange = castObject($newProduct, 'ProductChange');
					$productChange->setTypeOfChange(TYPE_OF_CHANGE_NEW);
				}
				else 
				{
					if ($newProduct != $oldProduct)
					{
						$productChange = castObject($newProduct, 'ProductChange');
						$productChange->setTypeOfChange(TYPE_OF_CHANGE_UPDATED);
					}
				}
				
				if (!is_null($productChange))
				{
					$jsonOldData = json_encode($oldProduct->getJsonData());
					$productChange->setOldData($jsonOldData);
					
					$this->_productChanges[] = $productChange;
				}
			}
		}
		
		public function truncateProductChanges()
		{
			$this->_productChangeProcessor->truncateProductChanges();
		}
		
		public function saveProductChanges()
		{
			if ($this->_productChanges)
			{
				foreach ($this->_productChanges as $productChange)
				{
					$this->_productChangeProcessor->saveProductChange($productChange);
				}
			}
		}
	
	}

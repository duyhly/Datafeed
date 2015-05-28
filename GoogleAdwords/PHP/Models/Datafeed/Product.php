<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	require_once(__DIR__.'./../BaseModel.php');
	
	class Product extends BaseModel
	{
		protected $_sku;
		protected $_brand;
		protected $_name;
		protected $_price;
		protected $_retailPrice;
		protected $_moneySaving;
		protected $_productUrl;
		protected $_compatiblePrinterModels;
	
		public function getSku()
		{
			return $this->_sku;
		}	
		
		public function setSku($sku=null)
		{
			$this->_sku = $sku;
		}
		
		public function getBrand()
		{
			return $this->_brand;
		}	
		
		public function setBrand($brand=null)
		{
			$this->_brand = $brand;
		}
		
		public function getName()
		{
			return $this->_name;
		}	
		
		public function setName($name=null)
		{
			$this->_name = $name;
		}
		
		public function getPrice()
		{
			return $this->_price;
		}	
		
		public function setPrice($price=null)
		{
			$this->_price = !is_null($price) ? floatval($price) : $price;
		}
		
		public function getRetailPrice()
		{
			return $this->_retailPrice;
		}
		
		public function setRetailPrice($retailPrice=null)
		{
			$this->_retailPrice = !is_null($retailPrice) ? floatval($retailPrice) : $retailPrice;
		}
		
		public function getMoneySaving()
		{
			return $this->_moneySaving;
		}
		
		public function setMoneySaving($moneySaving=null)
		{
			$this->_moneySaving = !is_null($moneySaving) ? floatval($moneySaving) : $moneySaving;
		}
		
		public function getProductUrl()
		{
			return $this->_productUrl;
		}
		
		public function setProductUrl($productUrl=null)
		{
			$this->_productUrl = $productUrl;
		}
		
		public function getCompatiblePrinterModels()
		{
			return $this->_compatiblePrinterModels;
		}
		
		public function setCompatiblePrinterModels($compatiblePrinterModels=null)
		{
			$this->_compatiblePrinterModels = $compatiblePrinterModels;
		}

	}

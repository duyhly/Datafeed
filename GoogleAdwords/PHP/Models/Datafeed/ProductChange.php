<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	require_once (__DIR__.'/Product.php');
	
	class ProductChange extends Product 
	{
		protected $_typeOfChange;
		protected $_oldData;
	
		public function getTypeOfChange()
		{
			return $this->_typeOfChange;
		}	
		
		public function setTypeOfChange($typeOfChange=null)
		{
			$this->_typeOfChange = $typeOfChange;
		}
		
		public function getOldData()
		{
			return $this->_oldData;
		}
		
		public function setOldData($oldData=null)
		{
			$this->_oldData = $oldData;
		}
	}

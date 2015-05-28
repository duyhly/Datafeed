<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	interface ProductChangeInterface
	{
		public function insertProductChange(ProductChange $productChange);
		public function deleteAll();
	}

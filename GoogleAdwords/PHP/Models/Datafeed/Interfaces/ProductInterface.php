<?php
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	interface ProductInterface
	{
		public function insertProduct(Product $product);
		public function findProductByID($id);
		public function getAll();
		public function deleteAll();
	}
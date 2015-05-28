<?php
	
	require_once(__DIR__.'./MySQLDatafeedDao.php');
	require_once(__DIR__.'./../Interfaces/ProductInterface.php');
	require_once(__DIR__.'./../Product.php');
	
	class MySQLProductDao extends MySQLDatafeedDao implements ProductInterface
	{
		/**
		 * Insert a product into the database
		 * @param Product $question
		 */
		public function insertProduct(Product $product)
		{
			$productData = array(
				'sku' 						=> $product->getSku(),
				'brand' 					=> $product->getBrand(),
				'name' 						=> $product->getName(),
				'price'						=> $product->getPrice(),
				'retail_price'				=> $product->getRetailPrice(),
				'money_saving'				=> $product->getMoneySaving(),
				'product_url'				=> $product->getProductUrl(),
				'compatible_printer_models' => $product->getCompatiblePrinterModels()
			);
			 
			$this->insert($this->_tableProducts, $productData);
			return true;
		}
	 
		/**
		 * Find a product by ID
		 * @param int $id
		 * @return Quiz_Question
		 */
		public function findProductByID($id)
		{
			$data = array();
	 
			if(!$data)
				return null;
	 
			$product = new Product();
			$product->setName($data['name']);
	
			return $product;
		}
	 
		public function getAll()
		{
			$products = array();
			$data = $this->get($this->_tableProducts);
			foreach ($data as $row)
			{
				$product = new Product();
			
				$product->setSku($row['sku']);
				$product->setBrand($row['brand']);
				$product->setName($row['name']);
				$product->setPrice($row['price']);
				$product->setRetailPrice($row['retail_price']);
				$product->setMoneySaving($row['money_saving']);
				$product->setProductUrl($row['product_url']);
				$product->setCompatiblePrinterModels($row['compatible_printer_models']);
			
				$products[] = $product;
			}
			return $products;
		}
		
		public function deleteAll()
		{
			$this->delete($this->_tableProducts);
		}
		
	}
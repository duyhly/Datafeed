<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
 
	require_once (__DIR__."./../DataProvider.php");
    require_once (__DIR__."./../../../Config/Config.php");
	require_once (__DIR__."./../../../Helpers/CurlHelpers.php");
	require_once (__DIR__."./../../../Libraries/PHPExcel/PHPExcel/IOFactory.php");
	require_once (__DIR__."./../../../Models/Datafeed/Product.php");

	class VolusionDataProvider extends DataProvider 
	{
		protected $_triggerUrl;
		protected $_storagePath;
		protected $_storageFile;
		
		function __construct() 
		{
			$this->_triggerUrl  = Config::getInstance()->load('GOOGLE_ADWORDS_DATAFEED', 'vb_url');
			$this->_storagePath = Config::getInstance()->load('GOOGLE_ADWORDS_DATAFEED', 'storage_path');
			$this->_storageFile = Config::getInstance()->load('GOOGLE_ADWORDS_DATAFEED', 'storage_file');
		}
		
		public function getProducts()
		{
			$csvPath = $this->triggerGeneratingFile();
			$storedFile = $this->downloadFile($csvPath);
			return $this->getProductsFromFile($storedFile);
		}
		
		protected function triggerGeneratingFile()
		{
			$csvPath = execCurl($this->_triggerUrl);
			return $csvPath;
		}
		
		protected function downloadFile($url)
		{
			$storedFile = downloadFile($url, $this->_storagePath, $this->_storageFile);
//dd($storedFile);
			return $storedFile;
		}
		
		protected function getProductsFromFile($file)
		{
			$products = array();
			
			if ($file)
			{
				$objPHPExcel = PHPExcel_IOFactory::load($file);
				try {
				    $inputFileType = PHPExcel_IOFactory::identify($file);
				    $objReader = PHPExcel_IOFactory::createReader($inputFileType);
				    $objPHPExcel = $objReader->load($file);
				} catch(Exception $e) {
				    die('Error loading file "'.pathinfo($inputFileName,PATHINFO_BASENAME).'": '.$e->getMessage());
				}
				
				//  Get worksheet dimensions
				$sheet = $objPHPExcel->getSheet(0); 
				$highestRow = $sheet->getHighestRow(); 
				$highestColumn = $sheet->getHighestColumn();
				
				//  Loop through each row of the worksheet in turn
				for ($row = 1; $row <= $highestRow; $row++){
					
					//  Ignore table headings
					if ($row == 1) continue; 
					
				    //  Read a row of data into an array
				    $rowData = $sheet->rangeToArray('A' . $row . ':' . $highestColumn . $row,
				                                    NULL,
				                                    TRUE,
				                                    FALSE);
													
				//	dd($rowData);
					
				    //  Insert row data array into your database of choice here
				    $products[] = $this->createProduct($rowData[0]);
				}
			}

			return $products;
			//dd($products);
		}

		protected function createProduct($data)
		{
			$product = new Product();
			
			$product->setSku($data[0]);
			$product->setBrand($data[1]);
			$product->setName($data[2]);
			$product->setPrice($data[3]);
			$product->setRetailPrice($data[4]);
			$product->setMoneySaving($data[5]);
			$product->setProductUrl($data[6]);
			$product->setCompatiblePrinterModels($data[7]);
			
			return $product;
		}
	}

?>
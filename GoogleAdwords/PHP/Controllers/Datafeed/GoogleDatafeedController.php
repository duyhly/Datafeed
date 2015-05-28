<?php
	/*
	|--------------------------------------------------------------------------
	| Google Datafeed Controller 
	|--------------------------------------------------------------------------
	|
	| This class is used for control the process of generating Google datafeed.
	|
	|
	*/

	require_once (__DIR__.'/DatafeedController.php');
	require_once (__DIR__.'./../../Services/Datafeed/GoogleAdwords/DatafeedGenerator.php');
    require_once (__DIR__.'./../../Config/Constants.php');
    require_once (__DIR__.'./../../Helpers/Helpers.php');


    class GoogleDatafeedController extends DatafeedController {
        
		protected $_datafeedGenerator;
		
        function __construct() 
        {
			$this->_datafeedGenerator = new DatafeedGenerator();
        }
        
        public function run()
        {
			$this->_datafeedGenerator->generateDatafeed();
        }

    }
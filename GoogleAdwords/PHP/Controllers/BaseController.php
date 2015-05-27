<?php 
	/*
	|--------------------------------------------------------------------------
	| Abstract Base Controller 
	|--------------------------------------------------------------------------
	|
	| This class is used for abstracting all controller classes.
	|
	|
	*/

    require_once (__DIR__.'./../Config/Constants.php');
    require_once (__DIR__.'./../Utilities/Helpers.php');


    class BaseController {
        
		protected $_mode = DEFAULT_MODE;

        function __construct() 
        {
            
        }
        
        public function run()
        {
			
        }

    }

?>
<?php
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/

	require_once (__DIR__.'/Controllers/Datafeed/GoogleDatafeedController.php');
	require_once (__DIR__.'/Config/Constants.php');
	
	/**
	 * Instantiate Controller and start running
	 */
	
	$controller = new GoogleDatafeedController();
	$controller->run();

?>
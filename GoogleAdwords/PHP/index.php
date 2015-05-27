<?php
	/*
	|--------------------------------------------------------------------------
	| Generate Datafeed for Google Adwords
	|--------------------------------------------------------------------------
	|
	| This script handles the process of generating new CSV datafeed.
	|
	|
	*/

	require_once (__DIR__.'/Controller/CommissionController.php');
	require_once (__DIR__.'/Utilities/Constants.php');
	
	/**
	 * Create a new authentication controller instance.
	 *
	 * @param  \Illuminate\Contracts\Auth\Guard  $auth
	 * @param  \Illuminate\Contracts\Auth\Registrar  $registrar
	 * @return void
	 */
	
	$controller = new DatafeedController();
	$controller->run();

?>
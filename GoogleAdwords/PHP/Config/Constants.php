<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/

	DEFINE('DATAFEED_TABLE_PREFIX', 'dev_');
	DEFINE('TABLE_PRODUCTS', DATAFEED_TABLE_PREFIX . 'products');
	DEFINE('TABLE_PRODUCT_CHANGES', DATAFEED_TABLE_PREFIX . 'product_changes');
	
	DEFINE('VALUE_TRUE', 1);
	DEFINE('VALUE_FALSE', 0);
	
	DEFINE('TYPE_OF_CHANGE_DELETED', 	'deleted');
	DEFINE('TYPE_OF_CHANGE_NEW', 		'new');
	DEFINE('TYPE_OF_CHANGE_UPDATED', 	'updated');

?>
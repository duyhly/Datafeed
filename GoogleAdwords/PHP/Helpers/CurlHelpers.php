<?php 

	require_once (__DIR__.'/Helpers.php');
	
	function execCurl($url) 
	{
		$ch = curl_init();
		
		curl_setopt_array(
		    $ch, array( 
		    CURLOPT_URL => $url,
		    CURLOPT_RETURNTRANSFER => true
		));
		 
		$output = curl_exec($ch);
		curl_close($ch);
		
		return $output;
	}
	
	function downloadFile($url, $storagePath, $fileName)
	{
		$fullFileName = generateFileName($fileName);
		$fullPath = __DIR__ . './../' . $storagePath . $fullFileName;
		
		$url = substr( $url, 0, 4 ) === "http" ? $url : 'http://'.$url;
	
		file_put_contents($fullPath, fopen($url, 'r'));
		
		return $fullPath;	
	}



?>
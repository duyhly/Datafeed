<?php 
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Author: Duy Ly & Isabel B. O.
	 * Description: 
	 * Date: 5/13/2015
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Returns the current day only.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getCurrentDay() 
	{
		return date('d');
	}

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Returns the locking date for ShareASale and 
	 * Commission Junction. If the current day is less than 
	 * 21, then set the report date to the previous month; 
	 * otherwise, set the report date to the current month.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getLockingDate($currentDay) 
	{
		if ($currentDay >= 21) {
			$lockingDate = date('Y-m')."-21";
		} else if ($currentDay < 21) {
			$lockingDate = date('Y-m', strtotime('first day of last month'))."-21";
		}

		return $lockingDate;
	}

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Returns the start date for the report.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getReportStartDate($lockingDate) 
	{
		$monthIni = new DateTime($lockingDate);
		$monthIni->modify("first day of last month");
		$startDate = $monthIni->format('Y-m-d');

		return $startDate;
	}

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Returns the end date for the report.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getReportEndDate($lockingDate) 
	{
		$monthEnd = new DateTime($lockingDate);
		$monthEnd->modify("last day of last month");
		$endDate = $monthEnd->format('Y-m-d');

		return $endDate;
	}

	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Returns the report month for the previous revenue field.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getPreviousRevenueMonth($reportMonth) 
	{
		$previousRevenueMonth = new DateTime($reportMonth);
		$previousRevenueMonth->modify("first day of last month");
		$previousRevenueMonth = $previousRevenueMonth->format('Y-m-d');

		return $previousRevenueMonth;
	}
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Check if report month is also the end of quarter
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function isQuarterEnding($reportMonth)
	{
		$month = intval(date('m', strtotime($reportMonth)));
		if ($month == 3 || $month == 6 || $month == 9 || $month == 12)
		{
			return true;
		}
		return false;
	}
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Get report months in quarter
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	function getMonthsInQuarter($reportMonth)
	{
		$month = intval(date('m', strtotime($reportMonth)));
		$year  = intval(date('Y', strtotime($reportMonth)));
		
		if ($month >= 1 && $month <= 3)
		{
			return array($year.'-01-01', $year.'-02-01', $year.'-03-01');
		}
		if ($month >= 4 && $month <= 6)
		{
			return array($year.'-04-01', $year.'-05-01', $year.'-06-01');
		}
		if ($month >= 7 && $month <= 9)
		{
			return array($year.'-07-01', $year.'-08-01', $year.'-09-01');
		}
		if ($month >= 10 && $month <= 12)
		{
			return array($year.'-10-01', $year.'-11-01', $year.'-12-01');
		}
		return false;
	}
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Convert a string/array to array
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	 function toArray($obj)
	 {
	 	return (!is_array($obj)) ? array($obj) : $obj;
	 }
	
	/*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Index an array by a key.
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
	 function arrayToDict($array, $key_name)
	 {
	 	$dict = array();
		$array_elem_keys = array();
		
	 	foreach ($array as $elem)
		{
			$key = $elem[$key_name];
			
			if (!array_key_exists($key, $dict))
			{
				$dict[$key] = $elem;
			}
			else
			{
				/* If this dictionary element is not an array yet, then transform into array. 
				Otherwise append new element into dictionary element */
				if (!in_array($key, $array_elem_keys))  
				{	
					$dict[$key] = array($dict[$key], $elem);
					$array_elem_keys[] = $key;
				}
				else 
				{
					$dict[$key][] = $elem;
				}
			}
		}
		return $dict;
	 }
    
    /*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
	 * Debug function
	 *.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*/
    function dd($obj)
    {
        echo '<pre>';
        print_r($obj);
        die();
    }
	
	function d($obj)
    {
        echo '<pre>';
        print_r($obj);
    }
	
	function vd($obj)
    {
       	var_dump($obj);
        die();
    }
	
	
	// generate file name
	function generateFileName($name)
	{
		return date('Ymd_His').'_'.$name;
	}
	
	function castObject($instance, $className) {
	    return unserialize(sprintf(
	        'O:%d:"%s"%s',
	        strlen($className),
	        $className,
	        strstr(strstr(serialize($instance), '"'), ':')
	    ));
	}

	    

?>
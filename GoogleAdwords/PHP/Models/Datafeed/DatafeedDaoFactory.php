<?php 
	/*
	|--------------------------------------------------------------------------
	| Author: Duy Ly - CompAndSave
	|--------------------------------------------------------------------------
	*/
	require_once(__DIR__.'/DAOs/MySQLProductDao.php');
	require_once(__DIR__.'/DAOs/MySQLProductChangeDao.php');
	
	class DatafeedDaoFactory
	{
		private static $_instance;
	 
		public function __construct()
		{
		}
	 
		/**
		 * Set the factory instance
		 * @param App_DaoFactory $f
		 */
		public static function setFactory(DatafeedDAOFactory $f)
		{
			self::$_instance = $f;
		}
	 
		/**
		 * Get a factory instance. 
		 * @return App_DaoFactory
		 */
		public static function getFactory()
		{
			if(!self::$_instance)
				self::$_instance = new self;
	 
			return self::$_instance;
		}
	 
		/**
		 * Get a Product DAO
		 * @return Product Interface
		 */
		public function getProductDao()
		{
			return new MySQLProductDao();
		}
		
		/**
		 * Get a ProductChange DAO
		 * @return ProductChange Interface
		 */
		public function getProductChangeDao()
		{
			return new MySQLProductChangeDao();
		}
	}
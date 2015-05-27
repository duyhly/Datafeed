<?php 

    define('CONFIG_FILE', 'config.ini');

    class Config {
        
        protected static $_instance;
        protected static $_config_array;
        
        private function __construct()
        {
            self::$_config_array = parse_ini_file(CONFIG_FILE, true);
            
        }
        
        public static function getInstance()
        {
            if (null === self::$_instance)
            {
                self::$_instance = new static();
            }
            
            return self::$_instance;
        }
        
        public static function load($section=null, $attribute=null)
        {
            if (null !== $section)
            {
                if (array_key_exists($section, self::$_config_array)) 
                {
                    if (null !== $attribute)  
                    {
                        if (array_key_exists($attribute, self::$_config_array[$section]))
                        {
                            return self::$_config_array[$section][$attribute];
                        }     
                    }
                    else
                    {
                        return self::$_config_array[$section];
                    }
                }
            }
            return null;
        }
    }

?>
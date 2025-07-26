package utils
{
   public class Parser
   {
      
      public function Parser()
      {
         super();
      }
      
      public static function parsePositiveNumber(obj:Object, defaultValue:Object = 0) : *
      {
         if(obj != null)
         {
            var value:* = Number(obj);
            if(!isNaN(value) && value > 0)
            {
               return value;
            }
         }
         return defaultValue;
      }
      
      public static function parseNumber(obj:Object, defaultValue:Object = 0) : *
      {
         if(obj != null)
         {
            var value:* = Number(obj);
            if(!isNaN(value))
            {
               return value;
            }
         }
         return defaultValue;
      }
      
      public static function parseHotkey(config:Object, defaultValue:Object) : *
      {
         if(config)
         {
            return parsePositiveNumber(config.hotkey,defaultValue);
         }
         return defaultValue;
      }
      
      public static function parseBoolean(obj:Object, defaultValue:Object = false) : *
      {
         if(obj != null)
         {
            return Boolean(obj);
         }
         return defaultValue;
      }
   }
}


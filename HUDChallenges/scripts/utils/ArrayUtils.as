package utils
{
   public class ArrayUtils
   {
       
      
      public function ArrayUtils()
      {
         super();
      }
      
      public static function indexOfCaseInsensitiveString(arr:Array, searchingFor:String, fromIndex:uint = 0) : int
      {
         var lowercaseSearchString:String = searchingFor.toLowerCase();
         var arrayLength:uint = arr.length;
         var index:uint = fromIndex;
         while(index < arrayLength)
         {
            var element:* = arr[index];
            if(element is String && lowercaseSearchString.indexOf(element.toLowerCase()) != -1)
            {
               return index;
            }
            index++;
         }
         return -1;
      }
      
      public static function findTargetIndex(arr:Array, searchingIn:String) : int
      {
         var x:int = 0;
         while(x < arr.length)
         {
            var magnet:RegExp = new RegExp(arr[x],"i");
            if(searchingIn.search(magnet) > -1)
            {
               return x;
            }
            x++;
         }
         return -1;
      }
   }
}

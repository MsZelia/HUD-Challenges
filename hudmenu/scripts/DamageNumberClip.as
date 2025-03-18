package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol576")]
   public class DamageNumberClip extends MovieClip
   {
       
      
      public var ParentObj:DamageNumbers;
      
      public var UniqueId:int;
      
      public var Base_mc:MovieClip;
      
      public var Crit_mc:MovieClip;
      
      public function DamageNumberClip()
      {
         super();
      }
      
      public function Destroy() : *
      {
         this.ParentObj.RemoveDamageNumber(this.UniqueId);
      }
   }
}

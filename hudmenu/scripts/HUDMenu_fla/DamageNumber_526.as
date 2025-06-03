package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol575")]
   public dynamic class DamageNumber_526 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumber_526()
      {
         super();
         addFrameScript(0,this.frame1,39,this.frame40);
         this.__setTab_Number_mc_DamageNumber_Number_mc_0();
      }
      
      internal function __setTab_Number_mc_DamageNumber_Number_mc_0() : *
      {
         this.Number_mc.tabIndex = 1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame40() : *
      {
         DamageNumberClip(this.parent).Destroy();
      }
   }
}

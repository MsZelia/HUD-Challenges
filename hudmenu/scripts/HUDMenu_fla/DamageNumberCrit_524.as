package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol572")]
   public dynamic class DamageNumberCrit_524 extends MovieClip
   {
       
      
      public var Number_mc:MovieClip;
      
      public function DamageNumberCrit_524()
      {
         super();
         addFrameScript(0,this.frame1,49,this.frame50);
         this.__setTab_Number_mc_DamageNumberCrit_Number_mc_0();
      }
      
      internal function __setTab_Number_mc_DamageNumberCrit_Number_mc_0() : *
      {
         this.Number_mc.tabIndex = 1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame50() : *
      {
         DamageNumberClip(this.parent).Destroy();
      }
   }
}

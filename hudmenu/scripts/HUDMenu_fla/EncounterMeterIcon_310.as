package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol976")]
   public dynamic class EncounterMeterIcon_310 extends MovieClip
   {
       
      
      public var BossIcon_mc:MovieClip;
      
      public function EncounterMeterIcon_310()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
      }
      
      internal function frame1() : *
      {
         stop();
         this.BossIcon_mc.transform.colorTransform = new ColorTransform(0.96,0.46,0.46,1,0,0,0,0);
      }
      
      internal function frame2() : *
      {
         stop();
         this.BossIcon_mc.transform.colorTransform = new ColorTransform(0.96,0.46,0.46,1,0,0,0,0);
      }
      
      internal function frame3() : *
      {
         stop();
      }
   }
}

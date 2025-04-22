package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1613")]
   public dynamic class GlowMeterGlowAnim_96 extends MovieClip
   {
       
      
      public function GlowMeterGlowAnim_96()
      {
         super();
         addFrameScript(0,this.frame1,48,this.frame49,96,this.frame97);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame49() : *
      {
         dispatchEvent(new Event("GlowRollOnComplete",true,true));
         stop();
      }
      
      internal function frame97() : *
      {
         dispatchEvent(new Event("GlowRollOffComplete",true,true));
      }
   }
}

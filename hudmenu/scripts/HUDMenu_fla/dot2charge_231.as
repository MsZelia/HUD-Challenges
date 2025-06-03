package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1342")]
   public dynamic class dot2charge_231 extends MovieClip
   {
       
      
      public var Left:MovieClip;
      
      public function dot2charge_231()
      {
         super();
         addFrameScript(0,this.frame1,13,this.frame14);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame14() : *
      {
         dispatchEvent(new Event("animationComplete"));
      }
   }
}

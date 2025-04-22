package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1317")]
   public dynamic class noneLoop_212 extends MovieClip
   {
       
      
      public function noneLoop_212()
      {
         super();
         addFrameScript(0,this.frame1,2,this.frame3);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         dispatchEvent(new Event("animationComplete"));
      }
   }
}

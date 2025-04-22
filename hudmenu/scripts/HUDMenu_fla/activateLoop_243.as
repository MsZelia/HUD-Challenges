package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1357")]
   public dynamic class activateLoop_243 extends MovieClip
   {
       
      
      public function activateLoop_243()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         dispatchEvent(new Event("animationComplete"));
      }
   }
}

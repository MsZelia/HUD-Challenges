package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1335")]
   public dynamic class none2activate_222 extends MovieClip
   {
       
      
      public function none2activate_222()
      {
         super();
         addFrameScript(0,this.frame1,6,this.frame7);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame7() : *
      {
         dispatchEvent(new Event("animationComplete"));
      }
   }
}

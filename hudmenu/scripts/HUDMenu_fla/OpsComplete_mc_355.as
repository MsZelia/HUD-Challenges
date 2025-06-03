package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol788")]
   public dynamic class OpsComplete_mc_355 extends MovieClip
   {
       
      
      public var OpsButtonHintBar_mc:BSButtonHintBar;
      
      public var OpsTextLeft_mc:MovieClip;
      
      public var OpsTextRight_mc:MovieClip;
      
      public function OpsComplete_mc_355()
      {
         super();
         addFrameScript(0,this.frame1,149,this.frame150);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame150() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowDOButtonHint",true));
         stop();
      }
   }
}

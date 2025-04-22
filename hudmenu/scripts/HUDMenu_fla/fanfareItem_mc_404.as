package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol896")]
   public dynamic class fanfareItem_mc_404 extends MovieClip
   {
       
      
      public var FanfareItemCatcher_mc:MovieClip;
      
      public var eraser_mc:MovieClip;
      
      public function fanfareItem_mc_404()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,10,this.frame11,32,this.frame33,74,this.frame75,104,this.frame105);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.eraser_mc.gotoAndPlay(1);
         dispatchEvent(new Event("HUDAnnounce::InitShowModel",true));
      }
      
      internal function frame11() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowModel",true));
      }
      
      internal function frame33() : *
      {
         stop();
      }
      
      internal function frame75() : *
      {
         this.eraser_mc.gotoAndPlay(1);
      }
      
      internal function frame105() : *
      {
         stop();
         dispatchEvent(new Event("HUDAnnounce::ClearModel",true));
      }
   }
}

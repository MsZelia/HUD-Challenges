package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol9")]
   public dynamic class healthBar_frame_52 extends MovieClip
   {
       
      
      public function healthBar_frame_52()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20,69,this.frame70);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame20() : *
      {
         gotoAndStop("static");
      }
      
      internal function frame70() : *
      {
         gotoAndPlay("StartDoTFlash");
      }
   }
}

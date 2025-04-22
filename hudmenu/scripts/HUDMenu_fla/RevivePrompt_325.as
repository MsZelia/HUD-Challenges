package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1829")]
   public dynamic class RevivePrompt_325 extends MovieClip
   {
       
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var reviveTimer:MovieClip;
      
      public var reviveTitle:MovieClip;
      
      public function RevivePrompt_325()
      {
         super();
         addFrameScript(0,this.frame1,99,this.frame100);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame100() : *
      {
         gotoAndPlay("idle");
      }
   }
}

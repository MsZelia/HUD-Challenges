package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol614")]
   public dynamic class QuestTrackerEntryTimer_501 extends MovieClip
   {
       
      
      public var Sizer_mc:MovieClip;
      
      public var Text_mc:MovieClip;
      
      public function QuestTrackerEntryTimer_501()
      {
         super();
         addFrameScript(0,this.frame1,35,this.frame36);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame36() : *
      {
         gotoAndPlay("warning");
      }
   }
}

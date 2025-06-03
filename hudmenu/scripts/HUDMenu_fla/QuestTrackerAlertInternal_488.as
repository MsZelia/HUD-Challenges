package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol642")]
   public dynamic class QuestTrackerAlertInternal_488 extends MovieClip
   {
       
      
      public var AlertText_mc:MovieClip;
      
      public var Backer_mc:MovieClip;
      
      public function QuestTrackerAlertInternal_488()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,34,this.frame35,63,this.frame64);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame35() : *
      {
         gotoAndPlay("AlertState2");
      }
      
      internal function frame64() : *
      {
         gotoAndPlay("AlertState3");
      }
   }
}

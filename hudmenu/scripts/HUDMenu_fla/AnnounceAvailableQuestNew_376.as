package HUDMenu_fla
{
   import Shared.AS3.BSButtonHintBar;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol864")]
   public dynamic class AnnounceAvailableQuestNew_376 extends MovieClip
   {
       
      
      public var BGBox_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var Desc_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var Title_mc:MovieClip;
      
      public function AnnounceAvailableQuestNew_376()
      {
         super();
         addFrameScript(0,this.frame1,70,this.frame71,109,this.frame110,140,this.frame141,157,this.frame158,167,this.frame168,177,this.frame178);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame71() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame110() : *
      {
         stop();
      }
      
      internal function frame141() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame158() : *
      {
         stop();
      }
      
      internal function frame168() : *
      {
         stop();
      }
      
      internal function frame178() : *
      {
         stop();
      }
   }
}

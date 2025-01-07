package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol836")]
   public dynamic class AnnouceMessageText_371 extends MovieClip
   {
       
      
      public var Text_mc:MovieClip;
      
      public function AnnouceMessageText_371()
      {
         super();
         addFrameScript(0,this.frame1,50,this.frame51,199,this.frame200,239,this.frame240);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame51() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame200() : *
      {
         stop();
      }
      
      internal function frame240() : *
      {
         stop();
      }
   }
}

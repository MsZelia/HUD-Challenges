package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1889")]
   public dynamic class LevelUpAnimation_435 extends MovieClip
   {
       
      
      public var LevelUpText:MovieClip;
      
      public function LevelUpAnimation_435()
      {
         super();
         addFrameScript(0,this.frame1,19,this.frame20);
      }
      
      internal function frame1() : *
      {
         dispatchEvent(new Event("HUD::LevelUpHidden",true));
         stop();
      }
      
      internal function frame20() : *
      {
         dispatchEvent(new Event("HUD::LevelUpVisible",true));
      }
   }
}

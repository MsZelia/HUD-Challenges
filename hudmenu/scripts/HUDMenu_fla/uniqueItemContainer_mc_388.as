package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol897")]
   public dynamic class uniqueItemContainer_mc_388 extends MovieClip
   {
       
      
      public var FanfareDescription_mc:MovieClip;
      
      public var FanfareInternal_mc:MovieClip;
      
      public var FanfareItem_mc:MovieClip;
      
      public var NewAnim_mc:MovieClip;
      
      public function uniqueItemContainer_mc_388()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,63,this.frame64,118,this.frame119,119,this.frame120,149,this.frame150);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         this.NewAnim_mc.gotoAndPlay("rollOn");
         this.FanfareInternal_mc.gotoAndPlay("rollOn");
      }
      
      internal function frame3() : *
      {
         this.FanfareItem_mc.gotoAndPlay("rollOn");
      }
      
      internal function frame64() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame119() : *
      {
         stop();
      }
      
      internal function frame120() : *
      {
         this.FanfareItem_mc.gotoAndPlay("rollOff");
      }
      
      internal function frame150() : *
      {
         stop();
         this.FanfareInternal_mc.gotoAndStop("off");
         this.NewAnim_mc.gotoAndStop("off");
      }
   }
}

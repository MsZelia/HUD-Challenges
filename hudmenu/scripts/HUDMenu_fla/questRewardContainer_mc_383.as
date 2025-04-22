package HUDMenu_fla
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol867")]
   public dynamic class questRewardContainer_mc_383 extends MovieClip
   {
       
      
      public var BonusFanfareName_mc1:MovieClip;
      
      public var BonusFanfareName_mc2:MovieClip;
      
      public var BonusFanfareName_mc3:MovieClip;
      
      public var BonusFanfareName_mc4:MovieClip;
      
      public var BonusFanfareName_mc5:MovieClip;
      
      public var BonusFanfareName_mc6:MovieClip;
      
      public var BonusFanfareType_mc:MovieClip;
      
      public var FanfareName_mc1:MovieClip;
      
      public var FanfareName_mc2:MovieClip;
      
      public var FanfareName_mc3:MovieClip;
      
      public var FanfareName_mc4:MovieClip;
      
      public var FanfareName_mc5:MovieClip;
      
      public var FanfareName_mc6:MovieClip;
      
      public var FanfareType_mc:MovieClip;
      
      public function questRewardContainer_mc_383()
      {
         super();
         addFrameScript(0,this.frame1,27,this.frame28,44,this.frame45,61,this.frame62,75,this.frame76,88,this.frame89,99,this.frame100,110,this.frame111,112,this.frame113,131,this.frame132,153,this.frame154,170,this.frame171,184,this.frame185,197,this.frame198,208,this.frame209,214,this.frame215,219,this.frame220,221,this.frame222,228,this.frame229,233,this.frame234,264,this.frame265);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame28() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame45() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound1",true));
      }
      
      internal function frame62() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound2",true));
      }
      
      internal function frame76() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound3",true));
      }
      
      internal function frame89() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound4",true));
      }
      
      internal function frame100() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound5",true));
      }
      
      internal function frame111() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestRewardSound6",true));
      }
      
      internal function frame113() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowCurrencyReward",true));
      }
      
      internal function frame132() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowXPReward",true));
      }
      
      internal function frame154() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound1",true));
      }
      
      internal function frame171() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound2",true));
      }
      
      internal function frame185() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound3",true));
      }
      
      internal function frame198() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound4",true));
      }
      
      internal function frame209() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound5",true));
      }
      
      internal function frame215() : *
      {
         dispatchEvent(new Event("HUDAnnounce::BonusRewardsComplete",true));
      }
      
      internal function frame220() : *
      {
         dispatchEvent(new Event("HUDAnnounce::PlayQuestBonusRewardSound6",true));
      }
      
      internal function frame222() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowCurrencyReward",true));
      }
      
      internal function frame229() : *
      {
         dispatchEvent(new Event("HUDAnnounce::ShowXPReward",true));
      }
      
      internal function frame234() : *
      {
         stop();
      }
      
      internal function frame265() : *
      {
         stop();
      }
   }
}

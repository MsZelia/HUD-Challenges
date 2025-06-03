package HUDMenu_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol806")]
   public dynamic class questCompleteContainer_mc_363 extends MovieClip
   {
       
      
      public var FanfareDescription_mc:MovieClip;
      
      public var FanfareName_mc:MovieClip;
      
      public var FanfareQuestCompleted_mc:MovieClip;
      
      public var FanfareType_mc:MovieClip;
      
      public var __setTabDict:Dictionary;
      
      public var __lastFrameTab:int = -1;
      
      public function questCompleteContainer_mc_363()
      {
         this.__setTabDict = new Dictionary(true);
         super();
         addFrameScript(0,this.frame1,17,this.frame18,18,this.frame19,59,this.frame60,79,this.frame80,80,this.frame81,132,this.frame133,173,this.frame174,214,this.frame215);
         addEventListener(Event.FRAME_CONSTRUCTED,this.__setTab_handler,false,0,true);
      }
      
      internal function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(param1:int) : *
      {
         if(this.FanfareType_mc != null && param1 >= 59 && param1 <= 60 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 59 && int(this.__setTabDict[this.FanfareType_mc]) <= 60)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      internal function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132() : *
      {
         if(this.__setTabDict[this.FanfareType_mc] == undefined || int(this.__setTabDict[this.FanfareType_mc]) != 133)
         {
            this.__setTabDict[this.FanfareType_mc] = 133;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      internal function __setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(param1:int) : *
      {
         if(this.FanfareType_mc != null && param1 >= 214 && param1 <= 215 && (this.__setTabDict[this.FanfareType_mc] == undefined || !(int(this.__setTabDict[this.FanfareType_mc]) >= 214 && int(this.__setTabDict[this.FanfareType_mc]) <= 215)))
         {
            this.__setTabDict[this.FanfareType_mc] = param1;
            this.FanfareType_mc.tabIndex = 2;
         }
      }
      
      internal function __setTab_handler(param1:Object) : *
      {
         var _loc2_:int = currentFrame;
         if(this.__lastFrameTab == _loc2_)
         {
            return;
         }
         this.__lastFrameTab = _loc2_;
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_58(_loc2_);
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_213(_loc2_);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame18() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame19() : *
      {
         stop();
      }
      
      internal function frame60() : *
      {
         stop();
      }
      
      internal function frame80() : *
      {
         dispatchEvent(new Event("HUDAnnouce::MarkFanfareAsDisplayed",true));
      }
      
      internal function frame81() : *
      {
         stop();
      }
      
      internal function frame133() : *
      {
         this.__setTab_FanfareType_mc_questCompleteContainer_mc_FanfareType_mc_132();
         stop();
      }
      
      internal function frame174() : *
      {
         stop();
      }
      
      internal function frame215() : *
      {
         stop();
      }
   }
}

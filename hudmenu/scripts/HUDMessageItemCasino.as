package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol278")]
   public class HUDMessageItemCasino extends HUDMessageItemBase
   {
       
      
      public var CasinoHUDWidget_mc:CasinoHUDWidget;
      
      public var CasinoFanfare_mc:CasinoFanfare;
      
      public function HUDMessageItemCasino()
      {
         super();
      }
      
      public function get casinoData() : Object
      {
         return data.data.casinoResults;
      }
      
      public function get hasValidData() : Boolean
      {
         return Boolean(data) && Boolean(data.data) && Boolean(data.data.casinoResults);
      }
      
      override public function get endAnimFrame() : int
      {
         return this.useCasinoHUDWidget() ? this.CasinoHUDWidget_mc.totalFrames : int(this.CasinoFanfare_mc.endAnimFrame);
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         addEventListener(HUDFadingListItem.EVENT_FADE_IN_COMPLETE,OnFadeInComplete);
         addEventListener(HUDFadingListItem.EVENT_FADE_OUT_COMPLETE,OnFadeOutComplete);
      }
      
      override public function onRemovedFromStage() : void
      {
         super.onRemovedFromStage();
         removeEventListener(HUDFadingListItem.EVENT_FADE_IN_COMPLETE,OnFadeInComplete);
         removeEventListener(HUDFadingListItem.EVENT_FADE_OUT_COMPLETE,OnFadeOutComplete);
      }
      
      override public function redrawUIComponent() : void
      {
         if(this.hasValidData)
         {
            if(this.useCasinoHUDWidget())
            {
               if(!this.CasinoHUDWidget_mc.isDataSet)
               {
                  this.CasinoHUDWidget_mc.init(this.casinoData);
               }
            }
            else if(!this.CasinoFanfare_mc.isDataSet)
            {
               this.CasinoFanfare_mc.init(this.casinoData);
            }
         }
      }
      
      override public function FadeIn() : *
      {
         if(!_fadeInStarted && this.hasValidData)
         {
            visible = true;
            _fadeInStarted = true;
            if(this.useCasinoHUDWidget())
            {
               this.CasinoHUDWidget_mc.fadeIn();
            }
            else
            {
               this.CasinoFanfare_mc.fadeIn();
            }
         }
      }
      
      override public function FadeOut() : *
      {
         _fadeOutStarted = true;
         if(this.useCasinoHUDWidget())
         {
            this.CasinoHUDWidget_mc.fadeOut();
         }
         else
         {
            this.CasinoFanfare_mc.fadeOut();
         }
      }
      
      override public function ResetFadeState() : *
      {
         if(this.useCasinoHUDWidget())
         {
            this.CasinoHUDWidget_mc.reset();
         }
         else
         {
            this.CasinoFanfare_mc.reset();
         }
         visible = false;
         _fadeInStarted = false;
         _fullyFadedIn = false;
         _fastFadeOutStarted = false;
         _fadeOutStarted = false;
         _fullyFadedOut = false;
      }
      
      private function useCasinoHUDWidget() : Boolean
      {
         return this.getFanfareClipFromGameType(this.casinoData.casinoGameType) is CasinoHUDWidget;
      }
      
      private function getFanfareClipFromGameType(param1:uint) : MovieClip
      {
         var _loc2_:MovieClip = null;
         switch(param1)
         {
            case CasinoShared.CASINO_GAME_TYPE_DERBY_RACE:
            case CasinoShared.CASINO_GAME_TYPE_SLOTS_1:
            case CasinoShared.CASINO_GAME_TYPE_SLOTS_2:
            case CasinoShared.CASINO_GAME_TYPE_SLOTS_BIG:
               _loc2_ = this.CasinoFanfare_mc;
               break;
            case CasinoShared.CASINO_GAME_TYPE_LUCKY_DICE:
            case CasinoShared.CASINO_GAME_TYPE_ROULETTE:
               _loc2_ = this.CasinoHUDWidget_mc;
         }
         return _loc2_;
      }
   }
}

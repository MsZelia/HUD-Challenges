package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class CasinoFanfare extends MovieClip
   {
       
      
      public var ThreeSlotsFanfare_mc:MovieClip;
      
      public var FiveSlotsFanfare_mc:MovieClip;
      
      public var DerbyFanfare_mc:MovieClip;
      
      public var LoseFanfare_mc:MovieClip;
      
      private var m_Data:Object = null;
      
      private var m_GameFanfareClip:MovieClip;
      
      public function CasinoFanfare()
      {
         super();
      }
      
      public function get isDataSet() : Boolean
      {
         return this.m_Data != null;
      }
      
      public function init(param1:Object) : void
      {
         if(param1)
         {
            this.m_Data = param1;
            switch(this.m_Data.casinoGameType)
            {
               case CasinoShared.CASINO_GAME_TYPE_DERBY_RACE:
                  gotoAndStop("Derby");
                  this.m_GameFanfareClip = this.DerbyFanfare_mc;
                  break;
               case CasinoShared.CASINO_GAME_TYPE_SLOTS_1:
               case CasinoShared.CASINO_GAME_TYPE_SLOTS_2:
                  gotoAndStop(this.m_Data.capsWon == 0 ? "SlotsLose" : "ThreeSlots");
                  this.m_GameFanfareClip = this.m_Data.capsWon == 0 ? this.LoseFanfare_mc : this.ThreeSlotsFanfare_mc;
                  break;
               case CasinoShared.CASINO_GAME_TYPE_SLOTS_BIG:
                  gotoAndStop(this.m_Data.capsWon == 0 ? "SlotsLose" : "FiveSlots");
                  this.m_GameFanfareClip = this.m_Data.capsWon == 0 ? this.LoseFanfare_mc : this.FiveSlotsFanfare_mc;
            }
         }
      }
      
      public function get endAnimFrame() : uint
      {
         return !!this.m_GameFanfareClip ? uint(this.m_GameFanfareClip.totalFrames) : 0;
      }
      
      public function fadeIn() : void
      {
         if(this.m_Data.casinoGameType == CasinoShared.CASINO_GAME_TYPE_DERBY_RACE)
         {
            this.DerbyFanfare_mc.gotoAndPlay(this.m_Data.capsWon == 0 ? "onLose" : "onWin");
         }
         else
         {
            this.m_GameFanfareClip.gotoAndPlay("rollOn");
         }
         GlobalFunc.PlayMenuSound(this.m_Data.capsWon == 0 ? "UICasinoLose" : "UICasinoWin");
      }
      
      public function fadeOut() : void
      {
         if(this.m_Data.casinoGameType == CasinoShared.CASINO_GAME_TYPE_DERBY_RACE)
         {
            this.DerbyFanfare_mc.gotoAndPlay(this.m_Data.capsWon == 0 ? "loseRollOff" : "winRollOff");
         }
         else
         {
            this.m_GameFanfareClip.gotoAndPlay("rollOff");
         }
      }
      
      public function reset() : void
      {
         gotoAndStop("off");
      }
   }
}

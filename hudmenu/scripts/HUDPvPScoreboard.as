package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1806")]
   public class HUDPvPScoreboard extends MovieClip
   {
      
      public static const TYPE_NONE:uint = 0;
      
      public static const TYPE_UNDERATTACK:uint = 1;
      
      public static const TYPE_ATTACKINGPLAYER:uint = 2;
      
      public static const TYPE_KILL:uint = 3;
      
      public static const TYPE_DEATH:uint = 4;
      
      public static const TYPE_MURDERED:uint = 5;
      
      public static const TYPE_TEAMKILL:uint = 6;
      
      public static const TYPE_TEAMDEATH:uint = 7;
      
      public static const TYPE_REVENGE_SEEKER:uint = 8;
      
      public static const TYPE_REVENGE_TARGET:uint = 9;
       
      
      private var m_ValidHudModes:Array;
      
      public var pvpScoreBoardsContainer_mc:MovieClip;
      
      public var pvpPlayerScoreBoard_mc:HUDPvPScoreboardPlayer;
      
      public var pvpTeamScoreBoard_mc:HUDPvPScoreboardTeam;
      
      public function HUDPvPScoreboard()
      {
         super();
         addFrameScript(0,this.frame1,349,this.frame350);
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.CAMP_PLACEMENT,HUDModes.VATS_MODE,HUDModes.MOVEMENT_DISABLED,HUDModes.DEATH_RESPAWN,HUDModes.AUTO_VANITY);
         this.pvpPlayerScoreBoard_mc = this.pvpScoreBoardsContainer_mc.pvpPlayerScoreBoard_mc;
         this.pvpTeamScoreBoard_mc = this.pvpScoreBoardsContainer_mc.pvpTeamScoreBoard_mc;
         BSUIDataManager.Subscribe("PVPScoreEventData",this.onDataUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
      }
      
      private function onDataUpdate(param1:FromClientDataEvent) : void
      {
         if(param1.data.resetDisplay)
         {
            gotoAndStop("off");
         }
         else if(param1.data.type > TYPE_NONE)
         {
            switch(param1.data.type)
            {
               case TYPE_UNDERATTACK:
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuPromptPlayerAttackedBy"}));
                  break;
               case TYPE_ATTACKINGPLAYER:
                  BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIMenuPromptPlayerAttacked"}));
            }
            var _loc2_:* = param1.data.type;
            switch(0)
            {
            }
            this.pvpScoreBoardsContainer_mc.gotoAndStop("pvpPlayerScoreBoard");
            this.pvpPlayerScoreBoard_mc.data = param1.data;
            gotoAndPlay("rollOn");
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         this.visible = this.m_ValidHudModes.indexOf(param1.data.hudMode) != -1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame350() : *
      {
         stop();
      }
   }
}

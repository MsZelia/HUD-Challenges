package
{
   import Overlay.PublicTeams.PublicTeamsBondMeter;
   import Overlay.PublicTeams.PublicTeamsIcon;
   import Overlay.PublicTeams.PublicTeamsShared;
   import Shared.AS3.BSScrollingListEntry;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.StyleSheet;
   import Shared.AS3.Styles.HUDPartyListStyle;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol913")]
   public dynamic class HUDTeamWidget extends BSUIComponent
   {
      
      public static const PUBLIC_TEAMS_HEADER_OFFSET:Number = 20;
      
      public static const PUBLIC_TEAMS_ICON_OFFSET:Number = 3;
      
      public static const AREA_VOICE_LIST_OFFSET:Number = 20;
      
      public static const TEAM_MAX_PLAYERS:uint = 4;
      
      public static const FLA_FPS:uint = 30;
      
      private static const EVENT_EXP_FLARE_ANIM_COMPLETE:String = "PartyListEntry::EmbarkAnimComplete";
      
      private static var _inPowerArmor:Boolean = false;
       
      
      public var PartyList:MenuListComponent;
      
      public var AreaVoiceList_mc:AreaVoiceList;
      
      public var PTPartyListHeader_mc:MovieClip;
      
      public var PTPartyHeaderTeamType_mc:MovieClip;
      
      public var PTPartyHeaderBonus_mc:MovieClip;
      
      public var PTHUDIcon_mc:PublicTeamsIcon;
      
      public var BonusMultiplier_tf:TextField;
      
      public var Bonus_tf:TextField;
      
      public var TeamType_tf:TextField;
      
      private var m_AreaVoiceListBaseY:Number;
      
      private var partyListData:Array;
      
      private var partyListMenuData:Array;
      
      private var m_HudMode:String = "All";
      
      private var m_TeamType:uint = 0;
      
      private var m_LoadingMenuOpen:Boolean = false;
      
      public function HUDTeamWidget()
      {
         this.partyListData = new Array();
         this.partyListMenuData = new Array();
         super();
         StyleSheet.apply(this.PartyList,false,HUDPartyListStyle);
         this.m_AreaVoiceListBaseY = this.AreaVoiceList_mc.y;
         this.PTPartyListHeader_mc.visible = false;
         this.PTPartyHeaderTeamType_mc = this.PTPartyListHeader_mc.PTPartyHeaderTeamType_mc;
         this.PTPartyHeaderBonus_mc = this.PTPartyListHeader_mc.PTPartyHeaderBonus_mc;
         this.PTHUDIcon_mc = this.PTPartyListHeader_mc.PTHUDIcon_mc;
         this.BonusMultiplier_tf = this.PTPartyHeaderBonus_mc.BonusMultiplier_tf;
         this.Bonus_tf = this.PTPartyHeaderBonus_mc.Bonus_tf;
         this.TeamType_tf = this.PTPartyHeaderTeamType_mc.TeamType_tf;
         TextFieldEx.setTextAutoSize(this.TeamType_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.BonusMultiplier_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.Bonus_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public static function get inPA() : Boolean
      {
         return _inPowerArmor;
      }
      
      public static function set inPA(param1:Boolean) : void
      {
         _inPowerArmor = param1;
      }
      
      override public function onAddedToStage() : void
      {
         BSUIDataManager.Subscribe("PartyMenuList",function(param1:FromClientDataEvent):*
         {
            m_TeamType = param1.data.teamType;
            partyListData = param1.data.members;
            var _loc2_:uint = partyListData.length;
            partyListMenuData.splice(0);
            var _loc3_:uint = 0;
            while(_loc3_ < TEAM_MAX_PLAYERS && _loc3_ < _loc2_)
            {
               if(partyListData[_loc3_] != null && partyListData[_loc3_].isVisible && partyListData[_loc3_].avatarId != "IconAddFriend" && Boolean(partyListData[_loc3_].isOnServer))
               {
                  partyListMenuData.push(partyListData[_loc3_]);
               }
               _loc3_++;
            }
            PartyList.List_mc.MenuListData = partyListMenuData;
            PartyList.addEventListener(PublicTeamsBondMeter.EVENT_BOND_METER_COMPLETE,onBondComplete);
            PartyList.SetIsDirty();
            PublicTeamsBondMeter.LAST_BOND_UPDATE_TIME = new Date().getTime() / 1000;
            SetIsDirty();
         });
         BSUIDataManager.Subscribe("HUDModeData",function(param1:FromClientDataEvent):*
         {
            m_HudMode = param1.data.hudMode;
            SetIsDirty();
         });
         BSUIDataManager.Subscribe("MenuStackData",function(param1:FromClientDataEvent):*
         {
            SetIsDirty();
         });
      }
      
      override public function redrawUIComponent() : void
      {
         var _loc6_:BSScrollingListEntry = null;
         var _loc7_:* = undefined;
         var _loc8_:PartyListEntry = null;
         var _loc9_:uint = 0;
         var _loc10_:PartyListEntry = null;
         this.PartyList.visible = this.determinePartyListVisibility();
         var _loc1_:Boolean = this.m_HudMode == HUDModes.CONTAINER_MODE || this.m_HudMode == HUDModes.WORKSHOP_MODE || this.m_HudMode == HUDModes.PIPBOY || this.m_HudMode == HUDModes.TERMINAL_MODE;
         this.PartyList.alpha = _loc1_ ? 0.5 : 1;
         this.PTPartyListHeader_mc.alpha = _loc1_ ? 0.5 : 1;
         var _loc2_:uint = this.partyListMenuData.length;
         this.UpdatePublicTeamsHeader();
         if(_loc2_ > 0)
         {
            _loc7_ = !!(_loc6_ = this.PartyList.List_mc.GetClipByIndex(0)).Sizer_mc ? _loc6_.Sizer_mc.height : _loc6_.height;
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY - this.PTPartyListHeader_mc.height - _loc7_ * _loc2_ - AREA_VOICE_LIST_OFFSET;
         }
         else
         {
            this.AreaVoiceList_mc.y = this.m_AreaVoiceListBaseY;
         }
         var _loc3_:uint = 0;
         var _loc4_:uint = 0;
         var _loc5_:uint = 0;
         while(_loc5_ < TEAM_MAX_PLAYERS)
         {
            if((_loc8_ = this.PartyList.List_mc.GetClipByIndex(_loc5_) as PartyListEntry) && _loc8_.BondMeter_mc && !_loc8_.visible && _loc8_.BondMeter_mc.bondMeterState == PublicTeamsBondMeter.BOND_METER_FILLING)
            {
               _loc8_.BondMeter_mc.bondMeterState = PublicTeamsBondMeter.BOND_METER_OFF;
            }
            if(Boolean(_loc8_) && (!_loc8_.visible || !this.PartyList.visible))
            {
               _loc8_.showExpeditionFlare = false;
            }
            if(Boolean(_loc8_) && _loc8_.visible)
            {
               if(_loc8_.isExpFlareAnimating)
               {
                  _loc3_++;
               }
               else if(_loc8_.showExpeditionFlare)
               {
                  _loc4_++;
               }
            }
            _loc5_++;
         }
         if(_loc3_ == 0 && _loc4_ > 0)
         {
            _loc9_ = 0;
            while(_loc9_ < TEAM_MAX_PLAYERS)
            {
               if((_loc10_ = this.PartyList.List_mc.GetClipByIndex(_loc9_) as PartyListEntry) && _loc10_.visible && _loc10_.showExpeditionFlare)
               {
                  _loc10_.animateExpFlare();
               }
               _loc9_++;
            }
            GlobalFunc.PlayMenuSound("UIXpdHudFlair");
         }
         if(this.PartyList.visible && (_loc3_ > 0 || _loc4_ > 0))
         {
            stage.addEventListener(EVENT_EXP_FLARE_ANIM_COMPLETE,this.onEmbarkAnimComplete);
         }
         else
         {
            stage.removeEventListener(EVENT_EXP_FLARE_ANIM_COMPLETE,this.onEmbarkAnimComplete);
         }
      }
      
      private function determinePartyListVisibility() : Boolean
      {
         var _loc2_:UIDataFromClient = null;
         var _loc3_:Boolean = false;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc1_:Boolean = true;
         if(this.partyListMenuData.length == 0)
         {
            _loc1_ = false;
         }
         if(_loc1_)
         {
            switch(this.m_HudMode)
            {
               case HUDModes.INSPECT_MODE:
               case HUDModes.CONTAINER_MODE:
               case HUDModes.PERKS_MODE:
               case HUDModes.LEGENDARY_PERKS_MODE:
               case HUDModes.MAP_MENU:
               case HUDModes.FURNITURE_ENTER_EXIT:
                  _loc1_ = false;
            }
         }
         if(_loc1_)
         {
            _loc2_ = BSUIDataManager.GetDataFromClient("MenuStackData");
            if(_loc2_ && _loc2_.data && Boolean(_loc2_.data.menuStackA))
            {
               _loc3_ = false;
               _loc4_ = _loc2_.data.menuStackA;
               while(_loc5_ < _loc4_.length)
               {
                  if(_loc4_[_loc5_].menuName == "ExamineMenu" || _loc4_[_loc5_].menuName == "MapMenu")
                  {
                     _loc1_ = false;
                  }
                  else if(_loc4_[_loc5_].menuName == "LoadingMenu")
                  {
                     _loc3_ = true;
                  }
                  _loc5_++;
               }
               if(!_loc3_ && this.m_LoadingMenuOpen)
               {
                  this.PartyList.SetIsDirty();
               }
               this.m_LoadingMenuOpen = _loc3_;
            }
         }
         return _loc1_;
      }
      
      private function UpdatePublicTeamsHeader() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:String = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:PartyListEntry = null;
         if(PublicTeamsShared.IsValidPublicTeamType(this.m_TeamType) && this.PartyList.visible)
         {
            _loc1_ = this.m_TeamType;
            _loc2_ = PublicTeamsShared.DecideTeamTypeString(_loc1_);
            this.TeamType_tf.text = GlobalFunc.LocalizeFormattedString("{1} {2}","$PT" + _loc2_,"$TEAM");
            this.PTHUDIcon_mc.setIconType(_loc1_);
            this.PTHUDIcon_mc.x = this.PTPartyHeaderTeamType_mc.x + this.TeamType_tf.textWidth + PUBLIC_TEAMS_ICON_OFFSET;
            _loc3_ = 0;
            _loc4_ = int(this.PartyList.List_mc.entryList.length);
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               if((_loc6_ = this.PartyList.List_mc.GetClipByIndex(_loc5_) as PartyListEntry).BondMeter_mc.isBonded)
               {
                  _loc3_++;
               }
               _loc5_++;
            }
            this.PTPartyHeaderBonus_mc.visible = true;
            this.BonusMultiplier_tf.text = "X" + (_loc3_ + 1).toString();
            if(_loc4_ > 0)
            {
               this.PTPartyListHeader_mc.y = this.PartyList.List_mc.GetClipByIndex(_loc4_ - 1).y - this.PTPartyListHeader_mc.height - PUBLIC_TEAMS_HEADER_OFFSET;
               this.PTPartyListHeader_mc.visible = true;
            }
         }
         else
         {
            this.PTPartyListHeader_mc.visible = false;
         }
      }
      
      private function onBondComplete(param1:Event) : void
      {
         this.UpdatePublicTeamsHeader();
      }
      
      public function onEmbarkAnimComplete(param1:Event) : void
      {
         var _loc2_:uint = 0;
         var _loc3_:PartyListEntry = null;
         if(this.PartyList.visible)
         {
            param1.stopPropagation();
            GlobalFunc.PlayMenuSound("UIXpdHudFlair");
            _loc2_ = 0;
            while(_loc2_ < TEAM_MAX_PLAYERS)
            {
               _loc3_ = this.PartyList.List_mc.GetClipByIndex(_loc2_) as PartyListEntry;
               if(_loc3_ && _loc3_.visible && _loc3_.showExpeditionFlare && !_loc3_.isExpFlareAnimating)
               {
                  _loc3_.animateExpFlare();
               }
               _loc2_++;
            }
         }
      }
   }
}

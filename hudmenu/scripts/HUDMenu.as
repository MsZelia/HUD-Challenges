package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.Events.NetworkedUIEvent;
   import Shared.AS3.Events.QuestEvent;
   import Shared.AS3.IMenu;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import fl.motion.AnimatorFactory3D;
   import fl.motion.MotionBase;
   import fl.motion.motion_internal;
   import flash.display.Loader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.UncaughtErrorEvent;
   import flash.filters.*;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.net.*;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.ui.Keyboard;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDMenu extends IMenu
   {
      
      public static const EVENT_LEVELUP_VISIBLE:String = "HUD::LevelUpVisible";
      
      public static const EVENT_LEVELUP_HIDDEN:String = "HUD::LevelUpHidden";
      
      public static const EVENT_LEVELUP_START:String = "HUD::LevelUpStart";
      
      public static var EVENT_SCOREBOARD_CATEGORY_CHANGE:String = "Scoreboard::StatFilterChanged";
      
      public static const CURRENCY_UPDATE_LEVELUP_OFFSETY:Number = -160;
      
      public static const CURRENCY_REPUTATION_CHANGE_OFFSETY:Number = -90;
      
      public static const WANTED_POWER_ARMOR_Y_OFFSET:Number = 175;
      
      public static const WANTED_SCOREBOARD_RANK_Y_OFFSET:Number = 6;
      
      private static const NOTIFICATION_OFFSET_Y_DIALOGUE:Number = 275;
      
      private static const NOTIFICATION_OFFSET_X_WORKSHOP:Number = 100;
      
      private static const NOTIFICATION_OFFSET_Y_WORKSHOP:Number = 35;
      
      private static const NOTIFICATION_OFFSET_Y_WORKSHOP_FREECAM:Number = 150;
      
      private static const NOTIFICATION_OFFSET_Y_CONTAINER:Number = 15;
      
      private static const NOTIFICATION_OFFSET_X_MAP:Number = -50;
      
      private static const NOTIFICATION_OFFSET_Y_MAP:Number = 250;
      
      private static const NOTIFICATION_OFFSET_X_MAP_MESSAGES:Number = -35;
      
      private static const NOTIFICATION_OFFSET_Y_MAP_MESSAGES:Number = 270;
      
      private static const NOTIFICATION_OFFSET_Y_MAP_SURVIVAL:Number = 225;
      
      public static const ON_STARTEDITTEXT:String = "ControlMap::StartEditText";
      
      public static const ON_ENDEDITTEXT:String = "ControlMap::EndEditText";
       
      
      public var __animFactory_SafeRect_mcaf1:AnimatorFactory3D;
      
      public var __animArray_SafeRect_mcaf1:Array;
      
      public var ____motion_SafeRect_mcaf1_mat3DVec__:Vector.<Number>;
      
      public var ____motion_SafeRect_mcaf1_matArray__:Array;
      
      public var __motion_SafeRect_mcaf1:MotionBase;
      
      public var FloatingQuestMarkerBase:MovieClip;
      
      public var TeammateMarkerBase:TeammateMarkersManager;
      
      public var networkIndicator_mc:MovieClip;
      
      public var HUDNotificationsGroup_mc:MovieClip;
      
      public var TopCenterGroup_mc:MovieClip;
      
      public var TopRightGroup_mc:MovieClip;
      
      public var HUDChatBase_mc:MovieClip;
      
      public var PartyResolutionContainer_mc:MovieClip;
      
      public var CenterGroup_mc:MovieClip;
      
      public var LeftMeters_mc:MovieClip;
      
      public var BottomCenterGroup_mc:BottomCenterGroup;
      
      public var RightMeters_mc:HUDRightMeters;
      
      public var SafeRect_mc:MovieClip;
      
      public var questMessagingQuest_mc:MovieClip;
      
      public var testItem_deleteME:MovieClip;
      
      public var fanfareItem_mc:MovieClip;
      
      public var uniqueItemContainer_mc:MovieClip;
      
      public var questRewardContainer_mc:MovieClip;
      
      public var dpadMapContainer:MovieClip;
      
      public var CompassWidget_mc:MovieClip;
      
      public var ScreenEdgeHitIndicator_mc:MovieClip;
      
      public var AnnounceEventWidget_mc:HUDAnnounceEventWidget;
      
      public var WorkshopMarkersBase_mc:HUDWorkshopMarkers;
      
      public var PvPScoreboard_mc:HUDPvPScoreboard;
      
      public var LevelUpAnimation_mc:MovieClip;
      
      public var YouAreWanted_mc:MovieClip;
      
      public var ScoreboardRank_mc:MovieClip;
      
      public var DamageNumbers_mc:DamageNumbers;
      
      public var ReputationUpdates_mc:HUDReputationUpdatesWidget;
      
      public var FrobberWidget_mc:HUDFrobberWidget;
      
      public var RightGroup_mc:MovieClip;
      
      public var PingMarkers_mc:MovieClip;
      
      public var FloatingTargetManager_mc:HUDFloatingTargetManager;
      
      public var AnnounceAvailableQuest_mc:MovieClip;
      
      public var QuestTracker:HUDQuestTracker;
      
      public var NewQuestTracker_mc:NewQuestTracker;
      
      private var m_EntityID:uint = 0;
      
      private var m_QuestTrackerBaseX:Number = 0;
      
      private var m_QuestTrackerBaseY:Number = 0;
      
      private var m_MessagesBaseX:Number = 0;
      
      private var m_MessagesBaseY:Number = 0;
      
      private var m_PromptMessageBaseX:Number = 0;
      
      private var m_PromptMessageBaseY:Number = 0;
      
      private var m_TutorialTextBaseX:Number = 0;
      
      private var m_TutorialTextBaseY:Number = 0;
      
      private var m_PartyListBaseX:Number = 0;
      
      private var m_PartyListBaseY:Number = 0;
      
      private var m_CompassBaseY:Number = 0;
      
      private var m_XPBarBaseY:Number = 0;
      
      private var m_CurrencyUpdateBaseY:Number = 0;
      
      private var m_ValidWantedHUDModes:Array;
      
      private var m_LastHUDMode:String = "All";
      
      private var m_IsWanted:Boolean = false;
      
      private var m_ValidWantedHUDMode:Boolean = false;
      
      private var m_LastPowerArmor:Boolean = false;
      
      private var m_WantedBaseY:Number = 0;
      
      private var m_RankBaseY:Number = 0;
      
      private var m_ScoreboardRank:Number = 0;
      
      private var m_ScoreboardValue:Number = 0;
      
      private var m_WorldType:uint = 0;
      
      private var m_LastBounty:Number = 0;
      
      private var m_ScoreboardFilterData:UIDataFromClient;
      
      private var m_ScoreboardFilterDataUpdated:Boolean = false;
      
      private var m_WorldRankFilterOverride:int = -1;
      
      private var m_LevelUpVisible:Boolean = false;
      
      private var m_RepLevelUpVisible:Boolean = false;
      
      private var m_RepChangeVisible:Boolean = false;
      
      private var m_FanfareAnimating:Boolean = false;
      
      private var m_IsFreeCamMode:Boolean = false;
      
      private var DpadMap_mc:MovieClip;
      
      public var BGSCodeObj:Object;
      
      private var ControlMapData:Object;
      
      private var CharacterInfoData:Object;
      
      private var ReviveButtonCallForHelp:BSButtonHintData;
      
      private var ReviveButtonGiveUp:BSButtonHintData;
      
      internal var hideTimeout:Number = -1;
      
      public var RequestUsername:String = "";
      
      private var LocalEmote_mc:EmoteWidget;
      
      public var RevivePrompt_mc:MovieClip;
      
      private var m_RevivePromptVisible:Boolean = false;
      
      private var m_PrevReviveTime:Number = -1;
      
      private var m_QuestAnnounceQueue:Vector.<QuestEvent>;
      
      private var m_QuestAnnounceBusy:Boolean = false;
      
      public var modLoader:Loader;
      
      public var __SFCodeObj:Object;
      
      private var errorMessage:TextField;
      
      public function HUDMenu()
      {
         var reviveButtonBar:BSButtonHintBar;
         var buttonHintDataV:Vector.<BSButtonHintData>;
         var RankPlayerIcon:ImageFixture;
         this.__SFCodeObj = new Object();
         this.displayFormat();
         this.ReviveButtonCallForHelp = new BSButtonHintData("$CALLFORHELP","$SPACEBAR","PSN_Y","Xenon_Y",1,null);
         this.ReviveButtonGiveUp = new BSButtonHintData("$GIVEUP","TAB","PSN_B","Xenon_B",1,null);
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
         this.BGSCodeObj = new Object();
         Extensions.enabled = true;
         Extensions.noInvisibleAdvance = true;
         this.resetChatMode();
         this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.addEventListener(KeyboardEvent.KEY_UP,this.chatEntryKeyUp);
         this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.addEventListener(FocusEvent.FOCUS_OUT,this.chatEntryFocusOut);
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStageEvent);
         this.QuestTracker = this.TopRightGroup_mc.QuestTracker;
         this.NewQuestTracker_mc = this.TopRightGroup_mc.NewQuestTracker_mc;
         BSUIDataManager.Subscribe("DeathReviveData",function(param1:FromClientDataEvent):*
         {
            var _loc4_:Number = NaN;
            var _loc2_:* = param1.data;
            var _loc3_:Boolean = false;
            if(_loc2_.isInBleedout)
            {
               if(!_loc2_.bleedoutDisabled)
               {
                  if(_loc2_.timeTillExpire > 0)
                  {
                     _loc3_ = true;
                     _loc4_ = Math.ceil(_loc2_.timeTillExpire);
                     RevivePrompt_mc.reviveTimer.reviveTime_tf.text = "[" + _loc4_ + "s]";
                     if(m_PrevReviveTime != _loc4_)
                     {
                        GlobalFunc.PlayMenuSound("UIMenuCriticallyInjuredCounterDecrement");
                        m_PrevReviveTime = _loc4_;
                     }
                  }
                  else
                  {
                     m_PrevReviveTime = -1;
                  }
               }
               else
               {
                  _loc3_ = true;
                  RevivePrompt_mc.reviveTimer.reviveTime_tf.text = "";
               }
            }
            if(_loc3_ != m_RevivePromptVisible)
            {
               if(_loc3_)
               {
                  RevivePrompt_mc.gotoAndPlay("rollOn");
               }
               else
               {
                  RevivePrompt_mc.gotoAndPlay("rollOff");
               }
            }
            m_RevivePromptVisible = _loc3_;
         });
         reviveButtonBar = this.RevivePrompt_mc.ButtonHintBar_mc;
         buttonHintDataV = new Vector.<BSButtonHintData>();
         buttonHintDataV.push(this.ReviveButtonCallForHelp);
         buttonHintDataV.push(this.ReviveButtonGiveUp);
         reviveButtonBar.SetButtonHintData(buttonHintDataV);
         addEventListener(QuestEvent.EVENT_AVAILABLE,this.onQuestAvailable);
         this.LocalEmote_mc = this.RightMeters_mc.LocalEmote_mc;
         this.LocalEmote_mc.align = EmoteWidget.ALIGN_RIGHT;
         this.LocalEmote_mc.scale = 1;
         BSUIDataManager.Subscribe("PVPData",function(param1:FromClientDataEvent):*
         {
            var _loc2_:* = param1.data;
            if(_loc2_.announcement.length > 0)
            {
               onPVPAnnounced(_loc2_);
            }
         });
         this.m_QuestAnnounceQueue = new Vector.<QuestEvent>();
         this.m_QuestTrackerBaseX = this.QuestTracker.x;
         this.m_QuestTrackerBaseY = this.QuestTracker.y;
         this.m_MessagesBaseX = this.HUDNotificationsGroup_mc.Messages_mc.x;
         this.m_MessagesBaseY = this.HUDNotificationsGroup_mc.Messages_mc.y;
         this.m_PromptMessageBaseX = this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.x;
         this.m_PromptMessageBaseY = this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.y;
         this.m_TutorialTextBaseX = this.HUDNotificationsGroup_mc.TutorialText_mc.x;
         this.m_TutorialTextBaseY = this.HUDNotificationsGroup_mc.TutorialText_mc.y;
         this.m_PartyListBaseX = this.HUDPartyListBase_mc.x;
         this.m_PartyListBaseY = this.HUDPartyListBase_mc.y;
         this.m_XPBarBaseY = this.HUDNotificationsGroup_mc.XPMeter_mc.y;
         this.m_CurrencyUpdateBaseY = this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y;
         this.m_WantedBaseY = this.YouAreWanted_mc.y;
         this.m_RankBaseY = this.ScoreboardRank_mc.y;
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("MenuStackData",this.onMenuStackDataUpdate);
         BSUIDataManager.Subscribe("WorkshopStateData",this.onWorkshopStateUpdate);
         this.DpadMap_mc = this.dpadMapContainer["DpadMap_mc"];
         this.CompassWidget_mc = this.BottomCenterGroup_mc.CompassWidget_mc;
         this.m_CompassBaseY = this.CompassWidget_mc.y;
         BSUIDataManager.Subscribe("RadialMenuStatus",this.onRadialMenuStatusUpdate);
         BSUIDataManager.Subscribe("ScreenResolutionData",this.onResolutionUpdate);
         addEventListener(HUDAnnounceEventWidget.EVENT_ACTIVE,this.onFanfareActive);
         addEventListener(HUDAnnounceEventWidget.EVENT_CLEARED,this.onFanfareCleared);
         addEventListener(EVENT_LEVELUP_VISIBLE,function(param1:Event):*
         {
            levelUpVisible = true;
         });
         addEventListener(EVENT_LEVELUP_HIDDEN,function(param1:Event):*
         {
            levelUpVisible = false;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_LEVELUP_VISIBLE,function(param1:Event):*
         {
            repLevelUpVisible = true;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_CHANGE_VISIBLE,function(param1:Event):*
         {
            repChangeVisible = true;
         });
         addEventListener(HUDReputationUpdatesWidget.EVENT_HIDDEN,function(param1:Event):*
         {
            repLevelUpVisible = false;
            repChangeVisible = false;
         });
         addEventListener(EVENT_LEVELUP_START,function(param1:CustomEvent):*
         {
            LevelUpAnimation_mc.LevelUpText.textField.text = param1.params.displayText;
            LevelUpAnimation_mc.gotoAndPlay("On");
         });
         this.m_ValidWantedHUDModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY);
         BSUIDataManager.Subscribe("AccountInfoData",this.onAccountInfoUpdate);
         RankPlayerIcon = this.ScoreboardRank_mc.AccountIcon_mc;
         RankPlayerIcon.clipWidth = RankPlayerIcon.width * (1 / RankPlayerIcon.scaleX);
         RankPlayerIcon.clipHeight = RankPlayerIcon.height * (1 / RankPlayerIcon.scaleY);
         BSUIDataManager.Subscribe("ScoreboardData",this.onLeaderboardDataUpdate);
         this.m_ScoreboardFilterData = BSUIDataManager.GetDataFromClient("ScoreboardFilterData");
         BSUIDataManager.Subscribe("ScoreboardFilterData",function(param1:FromClientDataEvent):*
         {
            if(param1.data.worldRankFilter.statType == GlobalFunc.STAT_TYPE_INVALID)
            {
               m_WorldRankFilterOverride = GlobalFunc.STAT_TYPE_SURVIVAL_SCORE;
            }
            else
            {
               m_WorldRankFilterOverride = -1;
            }
            if(!m_ScoreboardFilterDataUpdated)
            {
               revertScoreboardFilter();
               m_ScoreboardFilterDataUpdated = true;
            }
         });
         TextFieldEx.setTextAutoSize(this.YouAreWanted_mc.bountyAmount.bounty_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         addEventListener(Event.ADDED_TO_STAGE,this.__setPerspectiveProjection_);
         if(this.__animFactory_SafeRect_mcaf1 == null)
         {
            this.__animArray_SafeRect_mcaf1 = new Array();
            this.__motion_SafeRect_mcaf1 = new MotionBase();
            this.__motion_SafeRect_mcaf1.duration = 3;
            this.__motion_SafeRect_mcaf1.overrideTargetTransform();
            this.__motion_SafeRect_mcaf1.addPropertyArray("blendMode",["normal","normal","normal"]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("cacheAsBitmap",[false,false,false]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("opaqueBackground",[null,null,null]);
            this.__motion_SafeRect_mcaf1.addPropertyArray("visible",[false,false,false]);
            this.__motion_SafeRect_mcaf1.is3D = true;
            this.__motion_SafeRect_mcaf1.motion_internal::spanStart = 0;
            this.____motion_SafeRect_mcaf1_matArray__ = new Array();
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 960;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 540;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.664917;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 960;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 539.950012;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.____motion_SafeRect_mcaf1_mat3DVec__ = new Vector.<Number>(16);
            this.____motion_SafeRect_mcaf1_mat3DVec__[0] = 1.999985;
            this.____motion_SafeRect_mcaf1_mat3DVec__[1] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[2] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[3] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[4] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[5] = 1.5;
            this.____motion_SafeRect_mcaf1_mat3DVec__[6] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[7] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[8] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[9] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[10] = 1;
            this.____motion_SafeRect_mcaf1_mat3DVec__[11] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[12] = 959.950012;
            this.____motion_SafeRect_mcaf1_mat3DVec__[13] = 540;
            this.____motion_SafeRect_mcaf1_mat3DVec__[14] = 0;
            this.____motion_SafeRect_mcaf1_mat3DVec__[15] = 1;
            this.____motion_SafeRect_mcaf1_matArray__.push(new Matrix3D(this.____motion_SafeRect_mcaf1_mat3DVec__));
            this.__motion_SafeRect_mcaf1.addPropertyArray("matrix3D",this.____motion_SafeRect_mcaf1_matArray__);
            this.__animArray_SafeRect_mcaf1.push(this.__motion_SafeRect_mcaf1);
            this.__animFactory_SafeRect_mcaf1 = new AnimatorFactory3D(null,this.__animArray_SafeRect_mcaf1);
            this.__animFactory_SafeRect_mcaf1.sceneName = "Scene 1";
            this.__animFactory_SafeRect_mcaf1.addTargetInfo(this,"SafeRect_mc",0,true,0,true,null,-1);
         }
         this.modLoader = new Loader();
         addChild(this.modLoader);
         try
         {
            this.modLoader.load(new URLRequest("hudmodloader.swf"),new LoaderContext(false,ApplicationDomain.currentDomain));
            this.modLoader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         }
         catch(e:Error)
         {
            this.displayError("Error loading hudmodloader: " + e.toString());
         }
      }
      
      public function uncaughtErrorHandler(param1:UncaughtErrorEvent) : *
      {
         this.displayError(param1.toString());
      }
      
      private function displayFormat() : void
      {
         this.errorMessage = new TextField();
         this.errorMessage.width = 1600;
         GlobalFunc.SetText(this.errorMessage,"",false);
         TextFieldEx.setTextAutoSize(this.errorMessage,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.errorMessage.autoSize = TextFieldAutoSize.LEFT;
         this.errorMessage.wordWrap = true;
         this.errorMessage.multiline = true;
         var font:TextFormat = new TextFormat("Arial",18,16777215);
         this.errorMessage.defaultTextFormat = font;
         this.errorMessage.setTextFormat(font);
         this.errorMessage.visible = false;
         this.errorMessage.mouseEnabled = false;
      }
      
      public function displayError(param1:String) : void
      {
         GlobalFunc.SetText(this.errorMessage,this.errorMessage.text + "\n" + param1);
         this.errorMessage.visible = true;
         addChild(this.errorMessage);
      }
      
      public function __setPerspectiveProjection_(param1:Event) : void
      {
         root.transform.perspectiveProjection.fieldOfView = 1.002611;
         root.transform.perspectiveProjection.projectionCenter = new Point(960,540);
      }
      
      private function get HUDPartyListBase_mc() : HUDTeamWidget
      {
         return this.PartyResolutionContainer_mc.HUDPartyListBase_mc;
      }
      
      private function revertScoreboardFilter() : void
      {
         if(this.m_WorldRankFilterOverride >= 0)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCOREBOARD_CATEGORY_CHANGE,{"statTypeFilter":this.m_WorldRankFilterOverride}));
         }
         else if(this.m_ScoreboardFilterData && this.m_ScoreboardFilterData.data && Boolean(this.m_ScoreboardFilterData.data.worldRankFilter))
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_SCOREBOARD_CATEGORY_CHANGE,{"statTypeFilter":this.m_ScoreboardFilterData.data.worldRankFilter.statType}));
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:String = param1.data.hudMode;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:Number = 0;
         this.m_LastPowerArmor = Boolean(param1.data.inPowerArmor) && Boolean(param1.data.powerArmorHUDEnabled);
         switch(_loc2_)
         {
            case HUDModes.WORKSHOP_MODE:
               _loc3_ = 100;
               _loc5_ = -285;
               _loc6_ = 80;
               break;
            case HUDModes.INSPECT_MODE:
               _loc7_ = 133;
         }
         if(this.m_LastPowerArmor && _loc2_ != HUDModes.PHOTO_MODE && _loc2_ != HUDModes.MAP_MENU && _loc2_ != HUDModes.DIALOGUE_MODE)
         {
            _loc3_ = 205;
            _loc4_ = -226;
         }
         this.QuestTracker.x = this.m_QuestTrackerBaseX + _loc5_;
         this.QuestTracker.y = this.m_QuestTrackerBaseY + _loc6_;
         this.NewQuestTracker_mc.x = this.m_QuestTrackerBaseX + _loc5_;
         this.NewQuestTracker_mc.y = this.m_QuestTrackerBaseY + _loc6_;
         HUDTeamWidget.inPA = this.m_LastPowerArmor;
         this.HUDPartyListBase_mc.x = this.m_PartyListBaseX + _loc3_;
         this.HUDPartyListBase_mc.y = this.m_PartyListBaseY + _loc4_;
         this.HUDPartyListBase_mc.PartyList.SetIsDirty();
         this.HUDNotificationsGroup_mc.XPMeter_mc.y = this.m_XPBarBaseY + _loc7_;
         this.m_ValidWantedHUDMode = this.m_ValidWantedHUDModes.indexOf(_loc2_) != -1;
         if(_loc2_ != this.m_LastHUDMode && (this.m_LastHUDMode == HUDModes.MAP_MENU || this.m_LastHUDMode == HUDModes.PAUSE))
         {
            this.revertScoreboardFilter();
         }
         this.m_LastHUDMode = _loc2_;
         this.updateWantedVis();
         this.updateRankVis();
         this.LevelUpAnimation_mc.visible = _loc2_ != HUDModes.PERKS_MODE && _loc2_ != HUDModes.LEGENDARY_PERKS_MODE;
         this.updateHUDNotificationsOffset();
      }
      
      private function onMenuStackDataUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:int = 0;
         if(Boolean(param1.data) && Boolean(param1.data.menuStackA))
         {
            _loc2_ = false;
            if(Boolean(param1.data) && Boolean(param1.data.menuStackA))
            {
               _loc2_ = false;
               _loc3_ = param1.data.menuStackA.length - 1;
               while(_loc3_ > -1)
               {
                  if(param1.data.menuStackA[_loc3_].menuName == "MapMenu")
                  {
                     _loc2_ = true;
                     break;
                  }
                  _loc3_--;
               }
            }
            this.TeammateMarkerBase.hideMarkers = _loc2_;
         }
      }
      
      private function onWorkshopStateUpdate(param1:FromClientDataEvent) : void
      {
         this.m_IsFreeCamMode = param1.data.freeCamMode;
         this.updateHUDNotificationsOffset();
      }
      
      private function updateHUDNotificationsOffset() : void
      {
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Boolean = false;
         switch(this.m_LastHUDMode)
         {
            case HUDModes.DIALOGUE_MODE:
               _loc2_ = NOTIFICATION_OFFSET_Y_DIALOGUE;
               break;
            case HUDModes.WORKSHOP_MODE:
               _loc1_ = NOTIFICATION_OFFSET_X_WORKSHOP;
               _loc2_ = this.m_IsFreeCamMode ? NOTIFICATION_OFFSET_Y_WORKSHOP_FREECAM : NOTIFICATION_OFFSET_Y_WORKSHOP;
               break;
            case HUDModes.CONTAINER_MODE:
               _loc2_ = NOTIFICATION_OFFSET_Y_CONTAINER;
               break;
            case HUDModes.MAP_MENU:
               if(this.m_WorldType == GlobalFunc.WORLD_TYPE_SURVIVAL)
               {
                  _loc2_ = NOTIFICATION_OFFSET_Y_MAP_SURVIVAL;
               }
               else if(this.m_WorldType == GlobalFunc.WORLD_TYPE_NORMAL || this.m_WorldType == GlobalFunc.WORLD_TYPE_PRIVATE)
               {
                  _loc1_ = NOTIFICATION_OFFSET_X_MAP;
                  _loc2_ = NOTIFICATION_OFFSET_Y_MAP;
                  _loc3_ = true;
               }
         }
         this.HUDNotificationsGroup_mc.Messages_mc.x = this.m_MessagesBaseX + (_loc3_ ? NOTIFICATION_OFFSET_X_MAP_MESSAGES : _loc1_);
         this.HUDNotificationsGroup_mc.Messages_mc.y = this.m_MessagesBaseY + (_loc3_ ? NOTIFICATION_OFFSET_Y_MAP_MESSAGES : _loc2_);
         this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.x = this.m_PromptMessageBaseX + (_loc3_ ? NOTIFICATION_OFFSET_X_MAP_MESSAGES : _loc1_);
         this.HUDNotificationsGroup_mc.PromptMessageHolder_mc.y = this.m_PromptMessageBaseY + (_loc3_ ? NOTIFICATION_OFFSET_Y_MAP_MESSAGES : _loc2_);
         this.HUDNotificationsGroup_mc.TutorialText_mc.x = this.m_TutorialTextBaseX + _loc1_;
         this.HUDNotificationsGroup_mc.TutorialText_mc.y = this.m_TutorialTextBaseY + _loc2_;
         this.TopRightGroup_mc.enabled = !bNuclearWinterMode;
         this.TopRightGroup_mc.visible = !bNuclearWinterMode;
         this.AnnounceEventWidget_mc.enabled = !bNuclearWinterMode;
         this.AnnounceEventWidget_mc.visible = !bNuclearWinterMode;
         this.AnnounceAvailableQuest_mc.enabled = !bNuclearWinterMode;
         this.AnnounceAvailableQuest_mc.visible = !bNuclearWinterMode;
         var _loc4_:HUDCompassWidget;
         (_loc4_ = this.CompassWidget_mc as HUDCompassWidget).bNuclearWinterMode = bNuclearWinterMode;
      }
      
      private function updateRankVis() : void
      {
         var _loc1_:Boolean = this.m_ValidWantedHUDMode && this.m_WorldType == GlobalFunc.WORLD_TYPE_SURVIVAL && (this.m_ScoreboardRank > 1 || this.m_ScoreboardValue > 0);
         if(this.ScoreboardRank_mc.visible != _loc1_)
         {
            this.ScoreboardRank_mc.visible = _loc1_;
         }
         var _loc2_:Number = 0;
         if(this.m_IsWanted)
         {
            _loc2_ += this.YouAreWanted_mc.Sizer_mc.height + WANTED_SCOREBOARD_RANK_Y_OFFSET;
         }
         if(this.m_LastPowerArmor)
         {
            this.ScoreboardRank_mc.y = this.m_RankBaseY - WANTED_POWER_ARMOR_Y_OFFSET - _loc2_;
         }
         else
         {
            this.ScoreboardRank_mc.y = this.m_RankBaseY - _loc2_;
         }
      }
      
      private function updateWantedVis(param1:Number = 0) : void
      {
         var _loc2_:Boolean = this.m_ValidWantedHUDMode && this.m_IsWanted;
         if(this.YouAreWanted_mc.visible != _loc2_)
         {
            this.YouAreWanted_mc.visible = _loc2_;
            if(_loc2_)
            {
               this.YouAreWanted_mc.gotoAndPlay("rollOn");
            }
         }
         else if(_loc2_ && param1 > 0 && param1 > this.m_LastBounty)
         {
            this.YouAreWanted_mc.gotoAndPlay("update");
         }
         if(param1 > 0)
         {
            this.YouAreWanted_mc.bountyAmount.bounty_tf.text = param1;
            if(this.m_LastBounty == 0)
            {
               GlobalFunc.PlayMenuSound("UIBountyStingerRecipient");
            }
            this.m_LastBounty = param1;
         }
         if(this.m_LastPowerArmor)
         {
            this.YouAreWanted_mc.y = this.m_WantedBaseY - WANTED_POWER_ARMOR_Y_OFFSET;
         }
         else
         {
            this.YouAreWanted_mc.y = this.m_WantedBaseY;
         }
      }
      
      private function updateCurrencyUpdatesPos() : void
      {
         if(this.m_LevelUpVisible || this.m_RepLevelUpVisible)
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY + CURRENCY_UPDATE_LEVELUP_OFFSETY;
            GlobalFunc.PlayMenuSound("UIReputationLevelUp");
         }
         else if(this.m_RepChangeVisible)
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY + CURRENCY_REPUTATION_CHANGE_OFFSETY;
         }
         else
         {
            this.HUDNotificationsGroup_mc.CurrencyUpdates_mc.y = this.m_CurrencyUpdateBaseY;
         }
      }
      
      public function set levelUpVisible(param1:Boolean) : void
      {
         this.m_LevelUpVisible = param1;
         this.updateCurrencyUpdatesPos();
         if(param1)
         {
            this.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("levelup");
            this.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = false;
         }
         else
         {
            this.HUDNotificationsGroup_mc.XPMeter_mc.gotoAndStop("xp");
            this.HUDNotificationsGroup_mc.XPMeter_mc.NumberText.visible = true;
         }
      }
      
      public function set repLevelUpVisible(param1:Boolean) : void
      {
         this.m_RepLevelUpVisible = param1;
         this.updateCurrencyUpdatesPos();
      }
      
      public function set repChangeVisible(param1:Boolean) : void
      {
         this.m_RepChangeVisible = param1;
         this.updateCurrencyUpdatesPos();
      }
      
      private function onLeaderboardDataUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:* = param1.data.localScoreboardEntry;
         this.m_ScoreboardRank = _loc2_.rank;
         this.m_ScoreboardValue = _loc2_.value;
         this.ScoreboardRank_mc.LeaderBoardRank_mc.LeaderBoardRank_tf.text = this.m_ScoreboardRank;
         this.ScoreboardRank_mc.AccountIcon_mc.LoadInternal(GlobalFunc.GetAccountIconPath(_loc2_.iconPath),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
         if(this.m_ScoreboardRank >= 1 && this.m_ScoreboardRank <= 3)
         {
            this.ScoreboardRank_mc.RankPip_mc.visible = true;
            this.ScoreboardRank_mc.RankPip_mc.gotoAndStop(this.m_ScoreboardRank);
         }
         else
         {
            this.ScoreboardRank_mc.RankPip_mc.visible = false;
         }
         this.updateRankVis();
      }
      
      private function onAccountInfoUpdate(param1:FromClientDataEvent) : void
      {
         this.m_WorldType = param1.data.worldType;
         this.updateHUDNotificationsOffset();
         this.updateRankVis();
      }
      
      private function onResolutionUpdate(param1:FromClientDataEvent) : *
      {
         gotoAndStop(param1.data.AspectRatio);
      }
      
      private function onFanfareActive(param1:Event) : *
      {
         this.TopCenterGroup_mc.StealthMeter_mc.gotoAndPlay("rollOff");
         this.QuestTracker.SetAnimationBlocked(true);
         this.m_FanfareAnimating = true;
      }
      
      private function onFanfareCleared(param1:Event) : *
      {
         this.TopCenterGroup_mc.StealthMeter_mc.gotoAndPlay("rollOn");
         this.QuestTracker.SetAnimationBlocked(false);
         this.m_FanfareAnimating = false;
      }
      
      private function onRadialMenuStatusUpdate(param1:FromClientDataEvent) : void
      {
         this.CompassWidget_mc.y = !!param1.data.isShowing ? this.m_CompassBaseY + 1500 : this.m_CompassBaseY;
      }
      
      private function evaluateQuestAnnounceQueue() : void
      {
         var _loc1_:QuestEvent = null;
         if(!this.m_QuestAnnounceBusy && this.m_QuestAnnounceQueue.length > 0)
         {
            _loc1_ = this.m_QuestAnnounceQueue.shift();
            switch(_loc1_.type)
            {
               case QuestEvent.EVENT_AVAILABLE:
                  this.onQuestAvailable(_loc1_);
            }
         }
      }
      
      public function onDpadPress(param1:String) : *
      {
         var _loc2_:String = String(Math.max(BSUIDataManager.GetDataFromClient("CharacterInfoData").data.StimpakCount - 1,0));
         this.dpadMapContainer.DpadMap_mc.StimpakText_mc.StimpakText_tf.text = _loc2_;
         this.dpadMapContainer.gotoAndPlay("dPadOn");
         this.DpadMap_mc.gotoAndStop(param1);
      }
      
      public function onQuestAvailable(param1:QuestEvent) : void
      {
         if(this.m_QuestAnnounceBusy)
         {
            this.m_QuestAnnounceQueue.push(param1);
            return;
         }
         if(param1.pvpFlag)
         {
            this.onPVPAnnounced(param1.data);
         }
      }
      
      public function onPVPAnnounced(param1:Object) : void
      {
         var eData:Object = param1;
         if(this.m_QuestAnnounceBusy)
         {
            this.m_QuestAnnounceQueue.push(new QuestEvent(QuestEvent.EVENT_AVAILABLE,eData,true,false,true));
            return;
         }
         this.m_QuestAnnounceBusy = true;
         this.AnnounceAvailableQuest_mc.Name_mc.Name_tf.text = eData.announcement;
         this.AnnounceAvailableQuest_mc.Desc_mc.Desc_tf.text = "";
         this.AnnounceAvailableQuest_mc.Title_mc.visible = false;
         this.AnnounceAvailableQuest_mc.Prompt_mc.visible = false;
         this.AnnounceAvailableQuest_mc.gotoAndPlay("rollOn");
         setTimeout(function():*
         {
            AnnounceAvailableQuest_mc.gotoAndPlay("expand");
         },3000);
         setTimeout(function():*
         {
            AnnounceAvailableQuest_mc.gotoAndPlay("rollOff");
         },8000);
         setTimeout(function():*
         {
            m_QuestAnnounceBusy = false;
            evaluateQuestAnnounceQueue();
         },11000);
      }
      
      public function onAddedToStageEvent(param1:Event) : void
      {
         this.onAddedToStage();
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         this.CharacterInfoData = BSUIDataManager.GetDataFromClient("CharacterInfoData").data;
         this.ControlMapData = BSUIDataManager.GetDataFromClient("ControlMapData").data;
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoUpdate);
      }
      
      public function onCharacterInfoUpdate(param1:FromClientDataEvent) : void
      {
         this.LocalEmote_mc.entityID = param1.data.entityID;
         this.m_IsWanted = param1.data.wanted;
         if(param1.data.showNetworkIndicator)
         {
            this.networkIndicator_mc.visible = true;
         }
         else
         {
            this.networkIndicator_mc.visible = false;
         }
         this.updateWantedVis(param1.data.bounty);
         this.updateRankVis();
      }
      
      internal function enterChatMode() : *
      {
         this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.border = true;
         stage.focus = this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf;
         BSUIDataManager.dispatchEvent(new CustomEvent(ON_STARTEDITTEXT,{"tag":"Chat"}));
      }
      
      internal function resetChatMode() : *
      {
         this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.border = false;
         stage.focus = stage;
         this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.text = "";
         BSUIDataManager.dispatchEvent(new CustomEvent(ON_ENDEDITTEXT,{"tag":"Chat"}));
      }
      
      internal function chatEntryKeyUp(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ESCAPE)
         {
            this.resetChatMode();
         }
         if(param1.keyCode == Keyboard.ENTER)
         {
            this.sendChatMessage(this.HUDChatBase_mc.HUDChatEntryWidget_mc.ChatEntryText_tf.text);
            this.resetChatMode();
            BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":"UIGeneralTextPopUp"}));
         }
      }
      
      internal function chatEntryFocusOut(param1:FocusEvent) : void
      {
         this.resetChatMode();
      }
      
      public function sendChatMessage(param1:String) : *
      {
         var _loc2_:String = "NoUsername";
         if(this.CharacterInfoData)
         {
            _loc2_ = this.CharacterInfoData.name;
         }
         if(param1.length > 0 && param1 != "")
         {
            BSUIDataManager.dispatchEvent(new NetworkedUIEvent("networked::UIEVENT","ChatMessage",_loc2_,"All",param1));
         }
      }
      
      public function OnNetworkedUIEventReceived(param1:String, param2:String, param3:String, param4:String) : *
      {
         if(param1 == "ChatMessage")
         {
            this.HUDChatBase_mc.HUDChatWidget_mc.addChatMessage(param4,param2);
         }
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         this.m_FanfareAnimating = true;
         var _loc3_:Boolean = false;
         if(this.FrobberWidget_mc.show && !_loc3_)
         {
            _loc3_ = this.FrobberWidget_mc.ProcessUserEvent(param1,param2);
         }
         if(this.m_FanfareAnimating && !_loc3_)
         {
            _loc3_ = this.AnnounceEventWidget_mc.ProcessUserEvent(param1,param2);
         }
         if(!_loc3_ && !param2)
         {
            switch(param1)
            {
               case "TeamChat":
                  if(this.ControlMapData.textEntryMode == "")
                  {
                     this.enterChatMode();
                  }
                  _loc3_ = true;
            }
         }
         return _loc3_;
      }
      
      override protected function onSetSafeRect() : void
      {
         GlobalFunc.LockToSafeRect(this.CenterGroup_mc,"CC",SafeX,SafeY);
      }
      
      public function onCodeObjCreate() : *
      {
         (this.RightMeters_mc.PowerArmorLowBatteryWarning_mc.WarningTextHolder_mc as PAWarningText).codeObj = this.BGSCodeObj;
      }
      
      public function onCodeObjDestruction() : *
      {
         this.BGSCodeObj = null;
         (this.RightMeters_mc.PowerArmorLowBatteryWarning_mc.WarningTextHolder_mc as PAWarningText).codeObj = null;
      }
      
      private function handleTeamInviteAccept() : *
      {
         BSUIDataManager.dispatchEvent(new NetworkedUIEvent("networked::UIEVENT","TeamInviteAccepted",this.CharacterInfoData.name,this.RequestUsername,"NoData"));
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
   }
}

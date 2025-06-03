package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSButtonHintHoldTimer;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.VaultBoyImageLoader;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.utils.clearTimeout;
   import flash.utils.getQualifiedClassName;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol903")]
   public class HUDAnnounceEventWidget extends MovieClip
   {
      
      private static const LOC_DISCOVERED_ANIM_TIME_OFFSET:* = 2800;
      
      private static const FLA_FPS:Number = 30;
      
      private static const BONUS_REWARD_ANIM_TIME:Number = 3250;
      
      private static const HOLD_METER_TICK_AMOUNT:Number = 0.05;
      
      private static const MAX_STARS:Number = 4;
      
      public static const EVENT_CONSUME:String = "HUD::DiscardFanfare";
      
      public static const EVENT_CLEAR_COMPLETION_REWARD_FLAG:String = "HUD::ClearCompletionRewardsFlag";
      
      public static const EVENT_UPDATEMODEL:String = "HUD::UpdateInventory3DModel";
      
      public static const EVENT_PLAYITEMSOUND:String = "HUD::PlaySoundForItem";
      
      public static const EVENT_CURRENCYREWARD:String = "HUD::ShowCurrencyReward";
      
      public static const EVENT_XPREWARD:String = "HUD::ShowXPReward";
      
      public static const EVENT_LISTENFORACCEPT:String = "HUD::ListenForQuestTrack";
      
      public static const EVENT_ACCEPT:String = "HUD::AcceptFanfare";
      
      public static const EVENT_LOC_BUSY:String = "HUD::LocationBusy";
      
      public static const EVENT_SHOWDAILYOPSMODAL:String = "HUD::ShowDOModal";
      
      public static const EVENT_DO_COMPLETE:String = "HUD:DOCompleteFanfare";
      
      public static const EVENT_CLEAR_DO:String = "HUDNotificationsModel::ClearDOFanfare";
      
      public static const EVENT_BONUS_REWARDS_SHOWN:String = "HUDAnnounce::BonusRewardsComplete";
      
      public static const EVENT_TRACK_QUEST:String = "HUDNotificationsModel::TrackQuest";
      
      public static const EVENT_FADERMENU:String = "HUDNotificationsModel::FaderMenu";
      
      public static const EVENT_CLEARED:String = "HUDAnnounceEvent::Cleared";
      
      public static const EVENT_ACTIVE:String = "HUDAnnounceEvent::Active";
      
      public static const FANFARE_TYPE_QUESTCOMPLETE:uint = 0;
      
      public static const FANFARE_TYPE_QUESTFAILED:uint = 1;
      
      public static const FANFARE_TYPE_ITEMREWARD:uint = 2;
      
      public static const FANFARE_TYPE_QUESTAVAILABLE:uint = 3;
      
      public static const FANFARE_TYPE_QUESTACTIVE:uint = 4;
      
      public static const FANFARE_TYPE_FEATUREDITEM:uint = 5;
      
      public static const FANFARE_TYPE_LOCATIONDISCOVERED:uint = 6;
      
      public static const FANFARE_TYPE_MESSAGETEXT:uint = 7;
      
      public static const FANFARE_TYPE_QUICKPLAYANNOUNCE:uint = 8;
      
      public static const FANFARE_TYPE_COUNT:uint = 9;
      
      private static const MAX_QUEST_REWARDS:uint = 6;
      
      private static const COMPLETION_TO_REWARDS_FADE_TIME_MS:* = 1000;
       
      
      public var UniqueItemContainer_mc:MovieClip;
      
      public var QuestRewardContainer_mc:MovieClip;
      
      public var QuestCompleteContainer_mc:MovieClip;
      
      public var AnnounceAvailableQuest_mc:MovieClip;
      
      public var AnnounceActiveQuest_mc:MovieClip;
      
      public var AnnounceLocationDiscovered_mc:MovieClip;
      
      public var AnnounceMessage_mc:MovieClip;
      
      public var EventHUDNotification_mc:EventHUDNotification;
      
      public var MiscAvailableAnnounce_mc:MovieClip;
      
      private var m_ProcessedEventIDList:Array;
      
      private var m_IsBusy:Boolean = false;
      
      private var m_EventData:UIDataFromClient;
      
      private var m_CurEvent:Object;
      
      private var m_Active:Boolean = true;
      
      private var m_IsValidHudMode:Boolean = true;
      
      private var m_Enabled:Boolean = true;
      
      private var m_CurTimeout:int = -1;
      
      private var m_CurClip:MovieClip;
      
      private var m_ValidHudModes:Array;
      
      private var m_LastHudMode:String = "";
      
      private var m_LocationBusy:Boolean = false;
      
      private var m_LocationDiscoverAnimTime:Number = 5500;
      
      private var m_IsAnimating:Boolean = true;
      
      private var m_DOCompleteVisible:Boolean = false;
      
      private var m_DOCompleteID:uint = 0;
      
      private var m_WaitingForBonusRewards:Boolean = false;
      
      private var m_WaitingForFaderMenu:Boolean = false;
      
      private var m_AcceptButtonHint:BSButtonHintData;
      
      private var m_TrackButton:BSButtonHintData;
      
      private var m_ViewAndExitButtonHint:BSButtonHintData;
      
      private var m_HoldTimer:BSButtonHintHoldTimer;
      
      private var m_QuestTracked:Boolean = false;
      
      private const TRACK_BUTTON_PADDING:Rectangle = new Rectangle(-9,-7,18,14);
      
      public var DOHUDAnnounce_mc:MovieClip;
      
      public var SuppliesUnlocked_mc:MovieClip;
      
      public var OpsComplete_mc:MovieClip;
      
      public var HUDAnnounce_mc:MovieClip;
      
      public var AnnounceTextCenter_mc:MovieClip;
      
      public var OpsTextLeft_mc:MovieClip;
      
      public var OpsTextRight_mc:MovieClip;
      
      public var SuppliesTextLeft_mc:MovieClip;
      
      public var SuppliesTextRight_mc:MovieClip;
      
      public var OpsButtonHintBar_mc:BSButtonHintBar;
      
      public var EXPHUDAnnounce_mc:MovieClip;
      
      public var EXPComplete_mc:MovieClip;
      
      public var EXPAnnounceTextCenter_mc:MovieClip;
      
      public var EXPCompleteTextCenter_mc:MovieClip;
      
      public var EXPCompleteTextCenterShadow_mc:MovieClip;
      
      public var EXPCompleteUpdateText_mc:MovieClip;
      
      public function HUDAnnounceEventWidget()
      {
         this.m_ProcessedEventIDList = new Array();
         this.m_AcceptButtonHint = new BSButtonHintData("$RESET","T","PSN_Y","Xenon_Y",1,null);
         this.m_TrackButton = new BSButtonHintData("$TRACK","G","_DPad_Down","_DPad_Down",1,null);
         this.m_ViewAndExitButtonHint = new BSButtonHintData("$DO_VIEWEXIT","ESC","PSN_Start","Xenon_Start",1,this.onOpsViewAndExit);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         this.m_LocationDiscoverAnimTime = this.AnnounceLocationDiscovered_mc.totalFrames * 1000 / stage.frameRate - LOC_DISCOVERED_ANIM_TIME_OFFSET;
         this.OpsTextLeft_mc = this.OpsComplete_mc.OpsTextLeft_mc;
         this.OpsTextRight_mc = this.OpsComplete_mc.OpsTextRight_mc;
         this.AnnounceTextCenter_mc = this.HUDAnnounce_mc.AnnounceTextCenter_mc;
         this.SuppliesTextLeft_mc = this.SuppliesUnlocked_mc.SuppliesTextLeft_mc;
         this.SuppliesTextRight_mc = this.SuppliesUnlocked_mc.SuppliesTextRight_mc;
         this.EXPAnnounceTextCenter_mc = this.EXPHUDAnnounce_mc.EXPAnnounceTextCenter_mc;
         this.EXPCompleteTextCenter_mc = this.EXPComplete_mc.EXPCompleteTextCenter_mc;
         this.EXPCompleteTextCenterShadow_mc = this.EXPComplete_mc.EXPCompleteTextCenterShadow_mc;
         this.EXPCompleteUpdateText_mc = this.EXPComplete_mc.EXPCompleteUpdateText_mc;
         TextFieldEx.setTextAutoSize(this.AnnounceLocationDiscovered_mc.Area_mc.Area_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.m_ViewAndExitButtonHint.userEventMapping = "Map";
         this.m_ViewAndExitButtonHint.ButtonVisible = false;
         this.OpsButtonHintBar_mc = this.OpsComplete_mc.OpsButtonHintBar_mc;
         this.OpsButtonHintBar_mc.useBackground = false;
         this.OpsButtonHintBar_mc.SetButtonHintData(new <BSButtonHintData>[this.m_ViewAndExitButtonHint]);
      }
      
      private function updateIsAnimating() : void
      {
         var _loc1_:Boolean = this.m_IsBusy && this.m_Active;
         if(this.m_IsAnimating != _loc1_)
         {
            this.m_IsAnimating = _loc1_;
            if(this.m_IsAnimating)
            {
               dispatchEvent(new Event(EVENT_ACTIVE,true));
            }
            else
            {
               dispatchEvent(new Event(EVENT_CLEARED,true));
            }
         }
      }
      
      public function set isBusy(param1:Boolean) : void
      {
         if(param1 != this.m_IsBusy)
         {
            this.m_IsBusy = param1;
            this.updateIsAnimating();
         }
      }
      
      public function set active(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         var _loc3_:uint = 0;
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         if(param1 != this.m_Active)
         {
            this.m_Active = param1;
            this.updateIsAnimating();
            if(!this.m_Active)
            {
               if(this.m_CurTimeout != -1)
               {
                  clearTimeout(this.m_CurTimeout);
                  this.m_CurTimeout = -1;
               }
               this.QuestCompleteContainer_mc.gotoAndStop("off");
               this.QuestRewardContainer_mc.gotoAndStop("off");
               this.UniqueItemContainer_mc.gotoAndStop("off");
               this.AnnounceAvailableQuest_mc.gotoAndStop("off");
               this.MiscAvailableAnnounce_mc.gotoAndStop("off");
               this.AnnounceActiveQuest_mc.gotoAndStop("off");
               this.AnnounceMessage_mc.gotoAndStop("off");
               this.OpsComplete_mc.gotoAndStop("off");
               this.HUDAnnounce_mc.gotoAndStop("off");
               this.SuppliesUnlocked_mc.gotoAndStop("off");
               this.EXPHUDAnnounce_mc.gotoAndStop("off");
               this.EXPComplete_mc.gotoAndStop("off");
               this.EventHUDNotification_mc.gotoAndStop("off");
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LISTENFORACCEPT,{"isPlaying":false}));
               this.onClearModel(null);
               if(this.m_CurEvent && this.m_CurEvent.markedAsDisplay && Boolean(this.m_CurEvent.isCompletionRewards) && this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE)
               {
                  _loc2_ = this.m_EventData.data.fanfareEvents;
                  _loc3_ = _loc2_.length;
                  _loc5_ = 0;
                  while(_loc5_ < _loc3_)
                  {
                     if((_loc4_ = _loc2_[_loc5_]).questInstanceId == this.m_CurEvent.questInstanceId && _loc4_.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
                     {
                        BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CLEAR_COMPLETION_REWARD_FLAG,{"fanfareEventID":_loc4_.fanfareEventID}));
                     }
                     _loc5_++;
                  }
               }
               if(this.ShouldClearCurEvent())
               {
                  this.m_CurEvent = null;
                  this.m_CurClip = null;
               }
               this.onAnimEnd(false);
            }
         }
      }
      
      private function updateEnabled() : void
      {
         this.active = this.m_Enabled && this.m_IsValidHudMode;
      }
      
      private function onDataUpdate(param1:FromClientDataEvent) : void
      {
         this.m_ProcessedEventIDList = new Array();
         this.m_Enabled = param1.data.isFanfareEnabled;
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function isValidFanfareQuest(param1:String) : Boolean
      {
         var _loc4_:Object = null;
         var _loc5_:uint = 0;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:Object = BSUIDataManager.GetDataFromClient("QuestTrackerData").data;
         var _loc3_:Object = BSUIDataManager.GetDataFromClient("QuestTrackerProvider").data;
         if(_loc2_.active)
         {
            _loc5_ = 0;
            while(_loc2_.quests != null && _loc5_ < _loc2_.quests.length)
            {
               if((_loc4_ = _loc2_.quests[_loc5_]).questBaseID == param1)
               {
                  _loc6_ = 0;
                  while(_loc4_.objectives != null && _loc6_ < _loc4_.objectives.length)
                  {
                     if(_loc4_.objectives[_loc6_].isDisplayed)
                     {
                        return true;
                     }
                     _loc6_++;
                  }
               }
               _loc5_++;
            }
         }
         else if(_loc3_.active)
         {
            _loc7_ = 0;
            while(_loc3_.quests != null && _loc7_ < _loc3_.quests.length)
            {
               if((_loc4_ = _loc3_.quests[_loc7_]).questId == param1)
               {
                  return true;
               }
               _loc7_++;
            }
         }
         return false;
      }
      
      private function evaluateQueue(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:Boolean = false;
         if(this.m_Active && this.m_EventData.data.fanfareEvents != null)
         {
            _loc2_ = false;
            _loc3_ = Boolean(this.m_CurEvent) && Boolean(this.m_CurEvent.isCompletionRewards) && this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE;
            for each(_loc4_ in this.m_EventData.data.fanfareEvents)
            {
               if(this.m_ProcessedEventIDList.indexOf(_loc4_.fanfareEventID) == -1)
               {
                  _loc5_ = false;
                  _loc6_ = !_loc2_ && (!this.m_IsBusy || param1);
                  if(this.m_LastHudMode == HUDModes.INSPECT_MODE)
                  {
                     if(_loc4_.fanfareEventType != FANFARE_TYPE_FEATUREDITEM)
                     {
                        continue;
                     }
                  }
                  _loc6_ &&= !_loc3_ || _loc4_.isCompletionRewards && _loc4_.fanfareEventType == FANFARE_TYPE_ITEMREWARD && _loc4_.questInstanceId == this.m_CurEvent.questInstanceId;
                  switch(_loc4_.fanfareEventType)
                  {
                     case FANFARE_TYPE_LOCATIONDISCOVERED:
                        if(!this.m_LocationBusy && !this.m_WaitingForFaderMenu)
                        {
                           this.animateLocationDiscovered(_loc4_);
                           _loc5_ = true;
                        }
                        break;
                     case FANFARE_TYPE_QUESTAVAILABLE:
                     case FANFARE_TYPE_QUESTACTIVE:
                        if(_loc6_ && (_loc4_.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE || this.isValidFanfareQuest(_loc4_.questId)))
                        {
                           _loc2_ = this.animateEvent(_loc4_);
                           _loc5_ = _loc2_;
                        }
                        else if(Boolean(this.m_CurEvent) && this.m_CurEvent.questInstanceId == _loc4_.questInstanceId)
                        {
                           if(this.m_CurClip == this.AnnounceAvailableQuest_mc)
                           {
                              this.AnnounceAvailableQuest_mc.Desc_mc.Desc_tf.text = _loc4_.shortDescription;
                           }
                           else if(this.m_CurClip == this.AnnounceActiveQuest_mc)
                           {
                              this.AnnounceActiveQuest_mc.Desc_mc.Desc_tf.text = _loc4_.shortDescription;
                           }
                           _loc5_ = true;
                        }
                        break;
                     case FANFARE_TYPE_QUICKPLAYANNOUNCE:
                     case FANFARE_TYPE_QUESTCOMPLETE:
                     case FANFARE_TYPE_QUESTFAILED:
                     case FANFARE_TYPE_ITEMREWARD:
                     case FANFARE_TYPE_FEATUREDITEM:
                     case FANFARE_TYPE_MESSAGETEXT:
                        if(_loc6_)
                        {
                           _loc2_ = this.animateEvent(_loc4_);
                           _loc5_ = _loc2_;
                        }
                  }
                  if(_loc5_)
                  {
                     this.m_ProcessedEventIDList.push(_loc4_.fanfareEventID);
                  }
               }
            }
            if(param1)
            {
               this.isBusy = _loc2_;
            }
            else
            {
               this.isBusy = this.m_IsBusy || _loc2_;
            }
         }
      }
      
      private function getEventTypeData(param1:uint) : Object
      {
         return param1 < FANFARE_TYPE_COUNT ? this.m_EventData.data.fanfareTypes[param1] : null;
      }
      
      private function animateLocationDiscovered(param1:Object) : void
      {
         var titleTF:TextField;
         var discoverEvent:Object = param1;
         this.m_LocationBusy = true;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LOC_BUSY,{"isLocationBusy":true}));
         this.AnnounceLocationDiscovered_mc.Area_mc.Area_tf.text = discoverEvent.locationName;
         this.AnnounceLocationDiscovered_mc.gotoAndPlay("rollOn");
         if(Boolean(discoverEvent.soundName) && discoverEvent.soundName.length > 0)
         {
            GlobalFunc.PlayMenuSound(discoverEvent.soundName);
         }
         titleTF = this.AnnounceLocationDiscovered_mc.Title_mc.Title_tf;
         if(discoverEvent.isRegion)
         {
            GlobalFunc.PlayMenuSound("UIDiscoverRegion");
            titleTF.text = "$DiscoveredRegion";
         }
         else
         {
            GlobalFunc.PlayMenuSound("UIDiscoverLocation");
            titleTF.text = "$Discovered";
         }
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":discoverEvent.fanfareEventID}));
         setTimeout(function():*
         {
            m_LocationBusy = false;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LOC_BUSY,{"isLocationBusy":false}));
            evaluateQueue();
         },this.m_LocationDiscoverAnimTime);
      }
      
      private function IsSimpleType(param1:String) : Boolean
      {
         return param1 == "int" || param1 == "uint" || param1 == "Number" || param1 == "String" || param1 == "Boolean";
      }
      
      private function CloneKey(param1:String, param2:*, param3:*) : void
      {
         var _loc4_:String;
         if((_loc4_ = getQualifiedClassName(param3[param1])) == "Object")
         {
            param2[param1] = this.CloneObjectData(param3[param1]);
         }
         else if(_loc4_ == "Array")
         {
            param2[param1] = this.CloneArrayData(param3[param1]);
         }
         else
         {
            GlobalFunc.BSASSERT(this.IsSimpleType(_loc4_),"Can\'t clone non-basic types. Trying to clone a " + _loc4_);
            param2[param1] = param3[param1];
         }
      }
      
      private function CloneArrayData(param1:Array) : Array
      {
         var _loc2_:Array = new Array();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            this.CloneKey(_loc3_.toString(),_loc2_,param1);
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function CloneObjectData(param1:Object) : Object
      {
         var _loc3_:* = undefined;
         var _loc2_:Object = new Object();
         for(_loc3_ in param1)
         {
            this.CloneKey(_loc3_,_loc2_,param1);
         }
         return _loc2_;
      }
      
      private function ShouldCloneEvent(param1:Object) : Boolean
      {
         var _loc2_:Boolean = true;
         if(this.m_CurEvent && param1 && this.m_CurEvent.fanfareEventID == param1.fanfareEventID && Boolean(this.m_CurEvent.isDLOPComplete))
         {
            _loc2_ = false;
         }
         return _loc2_;
      }
      
      private function ShouldClearCurEvent() : Boolean
      {
         var _loc1_:Boolean = true;
         if(Boolean(this.m_CurEvent) && Boolean(this.m_CurEvent.isDLOPComplete))
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      private function animateEvent(param1:Object) : Boolean
      {
         var eventTypeData:Object;
         var startedAnim:Boolean;
         var eventClip:MovieClip = null;
         var vaultBoyImage:VaultBoyImageLoader = null;
         var description:String = null;
         var secondaryClip:MovieClip = null;
         var fanfareTitle:String = null;
         var name:String = null;
         var editorNewlinePattern:RegExp = null;
         var parsedDesc:String = null;
         var rewardIndex:int = 0;
         var tooManyRewards:Boolean = false;
         var reward:* = undefined;
         var nameText:String = null;
         var bonusRewardIndex:int = 0;
         var tooManyBonusRewards:Boolean = false;
         var bonusReward:* = undefined;
         var rewardText:String = null;
         var i:int = 0;
         var s:int = 0;
         var starsIndex:int = 0;
         var availableQuestHintBar:BSButtonHintBar = null;
         var dlopMarkupRemovedText:String = null;
         var xpdMarkupRemovedText:String = null;
         var aEvent:Object = param1;
         if(this.ShouldCloneEvent(aEvent))
         {
            this.m_CurEvent = this.CloneObjectData(aEvent);
         }
         eventTypeData = this.getEventTypeData(aEvent.fanfareEventType);
         GlobalFunc.BSASSERT(eventTypeData != null,"Event type data is null.");
         startedAnim = false;
         this.AnnounceActiveQuest_mc.EventMutationsBG_mc.gotoAndStop("off");
         this.m_TrackButton.ButtonVisible = false;
         switch(this.m_CurEvent.fanfareEventType)
         {
            case FANFARE_TYPE_QUESTCOMPLETE:
            case FANFARE_TYPE_QUESTFAILED:
               eventClip = this.QuestCompleteContainer_mc;
               fanfareTitle = !!this.m_CurEvent.isEvent ? "$$EVENT" : "$$QUEST";
               if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTFAILED)
               {
                  fanfareTitle += "FAILED";
                  GlobalFunc.PlayMenuSound("UIEventFail");
               }
               else
               {
                  fanfareTitle += "COMPLETED";
                  if(this.m_CurEvent.isEvent)
                  {
                     GlobalFunc.PlayMenuSound("UIEventComplete");
                  }
                  else
                  {
                     GlobalFunc.PlayMenuSound("UIQuestComplete");
                  }
               }
               description = this.m_CurEvent.shortDescription;
               if(description != null && description.length > 0)
               {
                  this.m_CurEvent.useDescAnim = true;
               }
               eventClip.FanfareType_mc.FanfareType_tf.text = this.m_CurEvent.sharedPlayerPrefix + fanfareTitle;
               eventClip.FanfareName_mc.FanfareName_tf.text = this.m_CurEvent.questTitle;
               TextFieldEx.setTextAutoSize(eventClip.FanfareName_mc.FanfareName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
               vaultBoyImage = eventClip.FanfareQuestCompleted_mc.QuestAnimCatcher_mc.ClipContainer_mc;
               eventClip.FanfareDescription_mc.FanfareDescription_tf.text = !!this.m_CurEvent.useDescAnim ? description : "";
               vaultBoyImage.ClipAlignment_Inspectable = "Center";
               vaultBoyImage.SWFLoad(this.m_CurEvent.swfName);
               break;
            case FANFARE_TYPE_ITEMREWARD:
               if(this.m_CurEvent.rewardsA.length > 0)
               {
                  eventClip = this.QuestRewardContainer_mc;
                  eventClip.FanfareType_mc.FanfareType_tf.text = "$$ITEMREWARD";
                  eventClip.FanfareType_mc.FanfareType_tf.text = this.m_CurEvent.sharedPlayerPrefix + eventClip.FanfareType_mc.FanfareType_tf.text;
                  rewardIndex = 1;
                  tooManyRewards = this.m_CurEvent.rewardsA.length > MAX_QUEST_REWARDS;
                  for each(reward in this.m_CurEvent.rewardsA)
                  {
                     if(tooManyRewards && rewardIndex == MAX_QUEST_REWARDS)
                     {
                        nameText = "...";
                     }
                     else
                     {
                        nameText = reward.strRewardName;
                        if(reward.uRewardCount > 1)
                        {
                           nameText = "(" + reward.uRewardCount + ") " + nameText;
                        }
                     }
                     eventClip["FanfareName_mc" + rewardIndex].FanfareName_tf.text = nameText;
                     eventClip["FanfareName_mc" + rewardIndex].visible = true;
                     rewardIndex++;
                     if(rewardIndex > MAX_QUEST_REWARDS)
                     {
                        break;
                     }
                  }
                  while(rewardIndex <= MAX_QUEST_REWARDS)
                  {
                     eventClip["FanfareName_mc" + rewardIndex].visible = false;
                     rewardIndex++;
                  }
                  if(this.m_CurEvent.mutatedRewards.length > 0)
                  {
                     eventClip.BonusFanfareType_mc.visible = true;
                     eventClip.BonusFanfareType_mc.FanfareType_tf.text = "$POTENTIALMUTATEDREWARDS";
                     bonusRewardIndex = 1;
                     tooManyBonusRewards = this.m_CurEvent.mutatedRewards.length > MAX_QUEST_REWARDS;
                     for each(bonusReward in this.m_CurEvent.mutatedRewards)
                     {
                        if(tooManyBonusRewards && bonusRewardIndex == MAX_QUEST_REWARDS)
                        {
                           rewardText = "...";
                        }
                        else
                        {
                           rewardText = bonusReward.strRewardName;
                           if(bonusReward.uRewardCount > 1)
                           {
                              rewardText = "(" + bonusReward.uRewardCount + ") " + rewardText;
                           }
                        }
                        eventClip["BonusFanfareName_mc" + bonusRewardIndex].FanfareName_tf.text = rewardText;
                        eventClip["BonusFanfareName_mc" + bonusRewardIndex].visible = true;
                        bonusRewardIndex++;
                        if(bonusRewardIndex > MAX_QUEST_REWARDS)
                        {
                           break;
                        }
                     }
                     while(bonusRewardIndex <= MAX_QUEST_REWARDS)
                     {
                        eventClip["BonusFanfareName_mc" + bonusRewardIndex].visible = false;
                        bonusRewardIndex++;
                     }
                     this.m_WaitingForBonusRewards = true;
                     eventTypeData.showTimer += BONUS_REWARD_ANIM_TIME;
                  }
                  else
                  {
                     this.m_WaitingForBonusRewards = false;
                     eventClip.BonusFanfareType_mc.visible = false;
                     i = 1;
                     while(i <= MAX_QUEST_REWARDS)
                     {
                        eventClip["BonusFanfareName_mc" + i].visible = false;
                        i++;
                     }
                  }
                  GlobalFunc.PlayMenuSound("UIQuestCompleteRewardItem");
               }
               else if(!this.m_CurEvent.isCompletionRewards)
               {
                  this.DisplaySimpleRewards(this.m_CurEvent);
               }
               break;
            case FANFARE_TYPE_FEATUREDITEM:
               eventClip = this.UniqueItemContainer_mc;
               name = this.m_CurEvent.featuredItem;
               editorNewlinePattern = /\r\n/g;
               parsedDesc = this.m_CurEvent.shortDescription.replace(editorNewlinePattern," \n");
               eventClip.FanfareDescription_mc.FanfareDescription_tf.text = parsedDesc;
               s = 1;
               while(s <= MAX_STARS)
               {
                  eventClip.FanfareInternal_mc["LegendaryStar0" + s + "_mc"].visible = s <= this.m_CurEvent.numLegendaryStars;
                  s++;
               }
               if(this.m_CurEvent.numLegendaryStars > 0)
               {
                  starsIndex = int(name.indexOf("¬"));
                  name = name.substr(0,starsIndex);
                  GlobalFunc.PlayMenuSound("UIFanfareLegendaryCrafted0" + this.m_CurEvent.numLegendaryStars);
               }
               eventClip.FanfareInternal_mc.Name_mc.Name_tf.text = name;
               break;
            case FANFARE_TYPE_QUESTAVAILABLE:
               if(!this.m_CurEvent.isMiscQuest)
               {
                  eventClip = this.AnnounceAvailableQuest_mc;
                  description = this.m_CurEvent.shortDescription;
                  this.m_CurEvent.useDescAnim = description != null && description.length > 0;
                  eventClip.Header_mc.gotoAndPlay("default");
                  eventClip.BGBox_mc.gotoAndStop(!!this.m_CurEvent.useDescAnim ? "default" : "noDesc");
                  TextFieldEx.setTextAutoSize(eventClip.Title_mc.Title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
                  TextFieldEx.setTextAutoSize(eventClip.Desc_mc.Desc_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
                  TextFieldEx.setTextAutoSize(eventClip.Header_mc.QuestAvailable_mc.QuestAvailable_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
                  TextFieldEx.setTextAutoSize(eventClip.Header_mc.TrackedText_mc.TrackedText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
                  eventClip.Title_mc.Title_tf.text = this.m_CurEvent.questTitle;
                  eventClip.Desc_mc.Desc_tf.text = description;
                  this.m_HoldTimer = null;
                  this.m_TrackButton.holdPercent = 0;
                  this.m_TrackButton.ButtonVisible = true;
                  this.m_QuestTracked = false;
                  availableQuestHintBar = eventClip.ButtonHintBar_mc as BSButtonHintBar;
                  availableQuestHintBar.paddingRect = this.TRACK_BUTTON_PADDING;
               }
               else
               {
                  eventClip = this.MiscAvailableAnnounce_mc;
                  this.m_CurEvent.shortDescription = null;
                  this.m_CurEvent.useDescAnim = false;
               }
               GlobalFunc.PlayMenuSound("UIQuestNewPopup");
               break;
            case FANFARE_TYPE_QUESTACTIVE:
               eventClip = this.AnnounceActiveQuest_mc;
               description = this.m_CurEvent.shortDescription;
               if(description == null || description.length == 0)
               {
                  description = "INVALID DESCRIPTION";
               }
               eventClip.Title_mc.Title_tf.text = "$QUESTSTARTED";
               eventClip.Name_mc.Name_tf.text = this.m_CurEvent.questTitle;
               eventClip.MutatedName_mc.Name_tf.text = this.m_CurEvent.questTitle;
               eventClip.Desc_mc.Desc_tf.text = description;
               this.m_AcceptButtonHint.ButtonText = "$TRACK";
               this.AnnounceActiveQuest_mc.EventMutationsBG_mc.gotoAndStop("off");
               this.m_AcceptButtonHint.ButtonVisible = !this.m_CurEvent.hideOptInPrompt;
               if(this.m_CurEvent.eventMutation)
               {
                  this.AnnounceActiveQuest_mc.EventMutationsBG_mc.MutationType_mc.gotoAndStop(this.m_CurEvent.eventMutation);
                  secondaryClip = this.AnnounceActiveQuest_mc.EventMutationsBG_mc;
               }
               this.AnnounceActiveQuest_mc.MutatedName_mc.visible = this.m_CurEvent.eventMutation;
               this.AnnounceActiveQuest_mc.Name_mc.visible = !this.m_CurEvent.eventMutation;
               vaultBoyImage = eventClip.QuestVaultBoy_mc;
               vaultBoyImage.ClipAlignment_Inspectable = "Center";
               vaultBoyImage.SWFLoad(this.m_CurEvent.swfName);
               if(this.m_CurEvent.isEvent)
               {
                  GlobalFunc.PlayMenuSound("UIEventStart");
               }
               else
               {
                  GlobalFunc.PlayMenuSound("UIQuestNew");
               }
               break;
            case FANFARE_TYPE_MESSAGETEXT:
               eventClip = this.AnnounceMessage_mc;
               eventClip.Text_mc.Text_tf.text = this.m_CurEvent.messageText;
               break;
            case FANFARE_TYPE_QUICKPLAYANNOUNCE:
               if(this.m_CurEvent.messageText.indexOf("[#DLOP_ANNOUNCE]") != -1)
               {
                  dlopMarkupRemovedText = this.m_CurEvent.messageText.replace("[#DLOP_ANNOUNCE]","");
                  this.AnnounceTextCenter_mc.textField_tf.text = dlopMarkupRemovedText;
                  eventTypeData.showTimer = this.HUDAnnounce_mc.totalFrames / FLA_FPS * 1000;
                  eventClip = this.HUDAnnounce_mc;
                  GlobalFunc.PlayMenuSound("UIDailyOpsHudAnnounce");
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
               }
               else if(this.m_CurEvent.messageText.indexOf("[#DLOP_COMPLETE]") != -1)
               {
                  eventClip = this.OpsComplete_mc;
                  this.m_DOCompleteID = this.m_CurEvent.fanfareEventID;
                  this.m_DOCompleteVisible = true;
                  eventTypeData.showTimer = this.OpsComplete_mc.totalFrames / FLA_FPS * 1000;
                  this.m_CurEvent.useCustomAnim = true;
                  if(!this.m_CurEvent.isDLOPComplete)
                  {
                     GlobalFunc.PlayMenuSound("UIDailyOpsHudComplete");
                     this.m_CurEvent.isDLOPComplete = true;
                     eventClip.gotoAndPlay("rollOn");
                  }
                  else if(this.m_CurEvent.markedAsDisplay)
                  {
                     this.clearDOFanfareEvents();
                  }
                  else
                  {
                     eventClip.gotoAndStop(eventClip.totalFrames);
                  }
                  dispatchEvent(new Event(EVENT_CLEARED,true));
               }
               else if(this.m_CurEvent.messageText.indexOf("[#DLOP_SUPPLY]") != -1)
               {
                  this.SuppliesTextLeft_mc.textField_tf.text = "$DO_SUPPLIES";
                  this.SuppliesTextRight_mc.textField_tf.text = "$DO_UNLOCKED";
                  eventTypeData.showTimer = this.SuppliesUnlocked_mc.totalFrames / FLA_FPS * 1000;
                  eventClip = this.SuppliesUnlocked_mc;
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
               }
               else if(this.m_CurEvent.messageText.indexOf("[#XPD_ANNOUNCE]") != -1)
               {
                  xpdMarkupRemovedText = this.m_CurEvent.messageText.replace("[#XPD_ANNOUNCE]","").toUpperCase();
                  this.EXPAnnounceTextCenter_mc.textField_tf.text = xpdMarkupRemovedText;
                  eventTypeData.showTimer = this.EXPHUDAnnounce_mc.totalFrames / FLA_FPS * 1000;
                  eventClip = this.EXPHUDAnnounce_mc;
                  GlobalFunc.PlayMenuSound("UIXpdHudFanfareSm");
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
               }
               else if(this.m_CurEvent.messageText.indexOf("[#XPD_COMPLETE]") != -1)
               {
                  eventTypeData.showTimer = this.EXPComplete_mc.totalFrames / FLA_FPS * 1000;
                  eventClip = this.EXPComplete_mc;
                  GlobalFunc.PlayMenuSound("UIXpdHudFanfareLg");
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
               }
               else if(this.m_CurEvent.messageText.indexOf("[#XPD_POSTMATCH]") != -1)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
                  BSUIDataManager.dispatchEvent(new Event("Expeditions::ShowPostMatch"));
               }
               else if(this.EventHUDNotification_mc.isEventNotification(this.m_CurEvent.messageText))
               {
                  eventClip = this.EventHUDNotification_mc;
                  eventTypeData.showTimer = this.EventHUDNotification_mc.totalFrames / FLA_FPS * 1000;
                  this.EventHUDNotification_mc.setData(this.m_CurEvent);
                  GlobalFunc.PlayMenuSound("UIEventNotification");
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
               }
               else
               {
                  eventClip = this.AnnounceMessage_mc;
                  eventClip.Text_mc.Text_tf.text = this.m_CurEvent.messageText;
               }
               if(this.m_CurEvent.soundId != 0)
               {
                  GlobalFunc.PlayMenuSoundWithFormID(this.m_CurEvent.soundId);
               }
         }
         if(eventClip != null && eventTypeData != null)
         {
            startedAnim = true;
            if(this.m_CurEvent.useDescAnim)
            {
               eventClip.gotoAndPlay("rollOnDesc");
            }
            else if(!this.m_CurEvent.useCustomAnim)
            {
               eventClip.gotoAndPlay("rollOn");
            }
            if(secondaryClip)
            {
               secondaryClip.gotoAndPlay("rollOn");
            }
            this.m_CurClip = eventClip;
            if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE && !this.m_CurEvent.isMiscQuest)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LISTENFORACCEPT,{
                  "fanfareEventID":this.m_CurEvent.fanfareEventID,
                  "isQuestPending":true,
                  "isPlaying":true
               }));
            }
            this.m_CurTimeout = setTimeout(function():*
            {
               if((m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTACTIVE || m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE) && m_AcceptButtonHint.holdPercent > 0)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_ACCEPT,{"fanfareEventID":m_CurEvent.fanfareEventID}));
               }
               if(!m_DOCompleteVisible)
               {
                  endFanfare();
               }
            },eventTypeData.showTimer);
         }
         else
         {
            this.m_CurClip = null;
         }
         return startedAnim;
      }
      
      private function DisplaySimpleRewards(param1:Object) : void
      {
         var xpDelay:Number;
         var xpReward:Number = NaN;
         var aEvent:Object = param1;
         this.ShowCurrencyReward(aEvent.currencyID,aEvent.currencyRewarded);
         xpDelay = 700;
         xpReward = Number(aEvent.xpRewarded);
         setTimeout(function():*
         {
            ShowXPReward(xpReward);
         },xpDelay);
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":aEvent.fanfareEventID}));
      }
      
      private function endFanfare() : void
      {
         var _loc1_:Object = null;
         var _loc2_:Number = NaN;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc6_:Object = null;
         if(this.m_CurClip != null)
         {
            _loc1_ = this.getEventTypeData(this.m_CurEvent.fanfareEventType);
            GlobalFunc.BSASSERT(_loc1_ != null,"Event type data is null.");
            _loc2_ = Number(_loc1_.gapTimer);
            _loc3_ = "RollOff";
            if(this.m_CurEvent.isCompletionRewards)
            {
               if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTCOMPLETE)
               {
                  _loc5_ = null;
                  for each(_loc6_ in this.m_EventData.data.fanfareEvents)
                  {
                     if(_loc6_.isCompletionRewards && _loc6_.fanfareEventType == FANFARE_TYPE_ITEMREWARD && _loc6_.questInstanceId == this.m_CurEvent.questInstanceId)
                     {
                        _loc5_ = _loc6_;
                        break;
                     }
                  }
                  if(_loc5_ != null && _loc5_.rewardsA.length > 0)
                  {
                     this.m_CurClip.gotoAndPlay("rollOffForRewards");
                     _loc2_ = COMPLETION_TO_REWARDS_FADE_TIME_MS;
                  }
                  else
                  {
                     this.m_CurClip.gotoAndPlay(_loc3_);
                     this.m_CurEvent.isCompletionRewards = false;
                     this.DisplaySimpleRewards(_loc5_);
                  }
               }
               else if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_ITEMREWARD)
               {
                  this.m_CurClip.gotoAndPlay(_loc3_);
                  this.QuestCompleteContainer_mc.gotoAndPlay("rollOffAfterRewards");
               }
               else
               {
                  trace("Finished showing fanfare marked as a completion reward, but it\'s niether an item reward or quest complete. Something is wrong with the data!");
                  trace(new Error().getStackTrace());
               }
            }
            else if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_QUESTAVAILABLE)
            {
               this.m_CurClip.gotoAndPlay(!!this.m_CurEvent.useDescAnim ? "rollOffDesc" : "rollOff");
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_LISTENFORACCEPT,{
                  "fanfareEventID":this.m_CurEvent.fanfareEventID,
                  "isQuestPending":true,
                  "isPlaying":false
               }));
            }
            else
            {
               this.m_CurClip.gotoAndPlay(!!this.m_CurEvent.useDescAnim ? "rollOffDesc" : _loc3_);
            }
            _loc4_ = 0;
            if(this.m_CurEvent.fanfareEventType == FANFARE_TYPE_FEATUREDITEM)
            {
               _loc4_ = this.m_CurEvent.itemHandle;
            }
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
            BSUIDataManager.dispatchEvent(new CustomEvent("FanfareEvent::FadeOut",{"fadedItemHandleID":_loc4_}));
            this.m_CurTimeout = setTimeout(this.onAnimEnd,_loc2_);
         }
         else
         {
            this.onAnimEnd();
         }
         this.m_AcceptButtonHint.holdPercent = 0;
      }
      
      public function onFarefanFullyDisplayed(param1:Event) : void
      {
         this.m_CurEvent.markedAsDisplay = true;
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
      }
      
      public function onShowModel(param1:Event) : void
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
            "itemHandle":this.m_CurEvent.itemHandle,
            "showingItem":true
         }));
      }
      
      public function onClearModel(param1:Event) : void
      {
         if(this.m_CurEvent)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_UPDATEMODEL,{
               "itemHandle":this.m_CurEvent.itemHandle,
               "showingItem":false
            }));
         }
      }
      
      private function GetOnPlayItemSoundFunc(param1:uint, param2:Boolean) : Function
      {
         var aItemIndex:uint = param1;
         var aBonusReward:Boolean = param2;
         return function():void
         {
            if(aBonusReward)
            {
               if(m_CurEvent.mutatedRewards.length > aItemIndex)
               {
                  BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PLAYITEMSOUND,{"uItemHandle":m_CurEvent.mutatedRewards[aItemIndex].uItemHandle}));
               }
            }
            else if(m_CurEvent.rewardsA.length > aItemIndex)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_PLAYITEMSOUND,{"uItemHandle":m_CurEvent.rewardsA[aItemIndex].uItemHandle}));
            }
         };
      }
      
      private function onShowXPReward(param1:Event) : void
      {
         if(!this.m_WaitingForBonusRewards)
         {
            this.ShowXPReward(this.m_CurEvent.xpRewarded);
         }
      }
      
      private function ShowXPReward(param1:Number) : void
      {
         if(param1)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_XPREWARD,{"xpRewarded":param1}));
         }
      }
      
      private function onShowCurrencyReward(param1:Event) : void
      {
         if(!this.m_WaitingForBonusRewards)
         {
            this.ShowCurrencyReward(this.m_CurEvent.currencyID,this.m_CurEvent.currencyRewarded);
         }
      }
      
      private function ShowCurrencyReward(param1:uint, param2:uint) : void
      {
         if(param2)
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CURRENCYREWARD,{
               "currencyID":param1,
               "currencyRewarded":param2
            }));
         }
      }
      
      private function onBonusRewardsShown(param1:Event) : void
      {
         this.m_WaitingForBonusRewards = false;
      }
      
      public function onAnimEnd(param1:Boolean = true) : void
      {
         this.m_CurTimeout = -1;
         this.m_ViewAndExitButtonHint.ButtonVisible = false;
         this.m_DOCompleteVisible = false;
         this.m_TrackButton.ButtonVisible = false;
         if(param1)
         {
            this.evaluateQueue(true);
         }
         else
         {
            this.isBusy = false;
         }
      }
      
      private function onQuestAcceptUpdate(param1:FromClientDataEvent) : void
      {
         if(param1.data.totalButtonHoldTime > 0)
         {
            this.m_AcceptButtonHint.holdPercent = Math.max(0,Math.min(1,param1.data.timeButtonHeld / param1.data.totalButtonHoldTime));
         }
         if(this.m_CurEvent != null && param1.data.fanfareEventID == this.m_CurEvent.fanfareEventID)
         {
            this.endFanfare();
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         this.m_LastHudMode = param1.data.hudMode;
         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(this.m_LastHudMode) != -1;
         if(this.m_DOCompleteVisible)
         {
            this.m_ProcessedEventIDList.pop();
         }
         this.updateEnabled();
         this.evaluateQueue();
      }
      
      private function onFFEvent(param1:FromClientDataEvent) : void
      {
         if(GlobalFunc.HasFFEvent(param1.data,EVENT_CLEAR_DO) && this.m_EventData.data.fanfareEvents != null)
         {
            this.clearDOFanfareEvents();
         }
      }
      
      private function clearDOFanfareEvents() : void
      {
         var _loc1_:Object = null;
         if(Boolean(this.m_CurEvent) && (this.m_CurEvent.isDLOPComplete || this.m_CurEvent.fanfareEventID == this.m_DOCompleteID))
         {
            this.OpsComplete_mc.gotoAndStop("off");
            this.isBusy = false;
            this.m_CurEvent.markedAsDisplay = true;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":this.m_CurEvent.fanfareEventID}));
         }
         for each(_loc1_ in this.m_EventData.data.fanfareEvents)
         {
            if(_loc1_.messageText.indexOf("[#DLOP_ANNOUNCE]") != -1 || _loc1_.messageText.indexOf("[#DLOP_COMPLETE]") != -1 || _loc1_.messageText.indexOf("[#DLOP_SUPPLY]") != -1)
            {
               BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_CONSUME,{"fanfareEventID":_loc1_.fanfareEventID}));
            }
         }
      }
      
      private function onQuestDataUpdate(param1:FromClientDataEvent) : void
      {
         if(!this.m_IsBusy)
         {
            this.evaluateQueue();
         }
      }
      
      public function onShowDOButtonHint(param1:Event) : void
      {
         BSUIDataManager.dispatchEvent(new Event(EVENT_DO_COMPLETE));
         this.m_ViewAndExitButtonHint.ButtonVisible = true;
      }
      
      public function ProcessUserEvent(param1:String, param2:Boolean) : Boolean
      {
         var _loc3_:Boolean = false;
         if(!_loc3_)
         {
            switch(param1)
            {
               case "Map":
                  if(!param2 && this.m_ViewAndExitButtonHint.ButtonVisible)
                  {
                     _loc3_ = true;
                     this.onOpsViewAndExit();
                  }
                  break;
               case "QuickkeyDown":
               case "Emotes":
                  if(Boolean(this.m_CurEvent) && this.m_TrackButton.ButtonVisible)
                  {
                     _loc3_ = true;
                     if(param2)
                     {
                        this.m_HoldTimer = new BSButtonHintHoldTimer(500);
                        addEventListener(Event.ENTER_FRAME,this.onEnterFrame);
                     }
                     else
                     {
                        this.m_HoldTimer = null;
                        this.m_TrackButton.holdPercent = 0;
                        removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
                     }
                  }
            }
         }
         return _loc3_;
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(this.m_HoldTimer)
         {
            this.m_TrackButton.holdPercent += HOLD_METER_TICK_AMOUNT;
            if(this.m_TrackButton.holdPercent >= 1)
            {
               removeEventListener(Event.ENTER_FRAME,this.onEnterFrame);
               this.onTrackQuest();
               this.m_HoldTimer = null;
            }
         }
      }
      
      private function onTrackQuest() : void
      {
         if(Boolean(this.m_CurEvent) && !this.m_QuestTracked)
         {
            this.m_QuestTracked = true;
            this.m_TrackButton.ButtonVisible = false;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_TRACK_QUEST,{"questInstanceId":this.m_CurEvent.questInstanceId}));
            this.m_CurClip.Header_mc.gotoAndPlay("Tracked");
            GlobalFunc.PlayMenuSound("UIQuestNewTrack");
         }
      }
      
      private function onOpsViewAndExit() : void
      {
         GlobalFunc.PlayMenuSound("UIMenuOK");
         this.OpsComplete_mc.gotoAndStop("off");
         BSUIDataManager.dispatchEvent(new Event(EVENT_SHOWDAILYOPSMODAL));
      }
      
      private function onMenuStackChange(param1:FromClientDataEvent) : void
      {
         var _loc5_:String = null;
         var _loc2_:Array = param1.data.menuStackA;
         var _loc3_:Boolean = false;
         var _loc4_:* = 0;
         while(_loc4_ < _loc2_.length)
         {
            if((_loc5_ = _loc2_[_loc4_].menuName) == "FaderMenu")
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         if(_loc3_ != this.m_WaitingForFaderMenu)
         {
            this.m_WaitingForFaderMenu = _loc3_;
            BSUIDataManager.dispatchEvent(new CustomEvent(EVENT_FADERMENU,{"isOpen":this.m_WaitingForFaderMenu}));
         }
         this.evaluateQueue();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.INSPECT_MODE,HUDModes.WORKSHOP_MODE,HUDModes.CAMP_PLACEMENT,HUDModes.FURNITURE_ENTER_EXIT,HUDModes.FISHING_MODE);
         BSUIDataManager.Subscribe("FireForgetEvent",this.onFFEvent);
         this.m_EventData = BSUIDataManager.GetDataFromClient("FanfareData");
         BSUIDataManager.Subscribe("FanfareData",this.onDataUpdate);
         addEventListener("HUDAnnouce::MarkFanfareAsDisplayed",this.onFarefanFullyDisplayed);
         addEventListener("HUDAnnounce::ShowModel",this.onShowModel);
         addEventListener("HUDAnnounce::ClearModel",this.onClearModel);
         addEventListener("HUDAnnounce::ShowDOButtonHint",this.onShowDOButtonHint);
         var _loc2_:uint = 0;
         while(_loc2_ < MAX_QUEST_REWARDS)
         {
            addEventListener("HUDAnnounce::PlayQuestRewardSound" + (_loc2_ + 1),this.GetOnPlayItemSoundFunc(_loc2_,false));
            addEventListener("HUDAnnounce::PlayQuestBonusRewardSound" + (_loc2_ + 1),this.GetOnPlayItemSoundFunc(_loc2_,true));
            _loc2_++;
         }
         addEventListener("HUDAnnounce::ShowXPReward",this.onShowXPReward);
         addEventListener("HUDAnnounce::ShowCurrencyReward",this.onShowCurrencyReward);
         addEventListener(EVENT_BONUS_REWARDS_SHOWN,this.onBonusRewardsShown);
         BSUIDataManager.Subscribe("FanfareQuestAcceptData",this.onQuestAcceptUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("QuestEventData",this.onQuestDataUpdate);
         BSUIDataManager.Subscribe("QuestTrackerProvider",this.onQuestDataUpdate);
         BSUIDataManager.Subscribe("MenuStackData",this.onMenuStackChange);
         var _loc3_:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         _loc3_.push(this.m_AcceptButtonHint);
         this.m_AcceptButtonHint.canHold = true;
         this.AnnounceActiveQuest_mc.ButtonHintBar_mc.SetButtonHintData(_loc3_);
         var _loc4_:Vector.<BSButtonHintData>;
         (_loc4_ = new Vector.<BSButtonHintData>()).push(this.m_TrackButton);
         this.m_TrackButton.canHold = true;
         this.AnnounceAvailableQuest_mc.ButtonHintBar_mc.SetButtonHintData(_loc4_);
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.UniqueItemContainer_mc.FanfareInternal_mc.Name_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Name_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceActiveQuest_mc.Title_mc.Title_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AnnounceTextCenter_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.OpsTextLeft_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.OpsTextRight_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.EXPAnnounceTextCenter_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.EXPCompleteTextCenter_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.EXPCompleteTextCenterShadow_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.EXPCompleteUpdateText_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
   }
}

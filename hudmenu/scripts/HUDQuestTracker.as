package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import fl.transitions.Tween;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.events.KeyboardEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1007")]
   public class HUDQuestTracker extends MovieClip
   {
      
      private static const DEFAULT_QUEST_SYNC_DELAY:Number = 60;
      
      public static const QUEST_STATE_INVALID:Number = 0;
      
      public static const QUEST_STATE_INPROGRESS:Number = 1;
      
      public static const QUEST_STATE_COMPLETE:Number = 2;
      
      public static const QUEST_STATE_FAILED:Number = 3;
      
      public static const EVENT_DURATION_QUEST_FADEINOUT:Number = 1200;
      
      public static const EVENT_DURATION_OBJECTIVE_UPDATE:Number = 500;
      
      public static const EVENT_DURATION_REARRANGE:Number = 350;
      
      public static const QUEST_EVENT_INVALID:uint = 0;
      
      public static const QUEST_EVENT_COMPLETE:uint = 1;
      
      public static const QUEST_EVENT_FAIL:uint = 2;
      
      public static const QUEST_EVENT_ACTIVE:uint = 3;
      
      public static const QUEST_EVENT_INACTIVE:uint = 4;
      
      public static const QUEST_EVENT_DISPLAYEDTOTEAM:uint = 5;
      
      public static const QUEST_EVENT_UNDISPLAYEDTOTEAM:uint = 6;
      
      public static const QUEST_EVENT_FORCEREARRANGE:Number = 500;
      
      public static const OBJECTIVE_EVENT_INVALID:uint = 0;
      
      public static const OBJECTIVE_EVENT_COMPLETE:uint = 1;
      
      public static const OBJECTIVE_EVENT_FAIL:uint = 2;
      
      public static const OBJECTIVE_EVENT_UPDATE:uint = 3;
      
      public static const OBJECTIVE_EVENT_REMOVE:uint = 4;
      
      public static const OBJECTIVE_MERGE_LEADER_CHANGE:uint = 5;
      
      public static const QUEST_SPACING:Number = 16;
      
      public static const TEST_MODE:Boolean = false;
      
      public static const ENTITY_ID_INVALID:Number = 4294967295;
      
      public static const DEBUG_SKIP_ANIMATIONS:Boolean = false;
      
      public static const FADE_DELAY_SHORT:Number = 10000;
       
      
      public var EventQuestDivider_mc:MovieClip;
      
      private var m_EventQuestDividerVisible:Boolean = false;
      
      private var m_EventQuestDividerTween:Tween = null;
      
      private var m_DisplayedQuests:Vector.<HUDQuestTrackerEntry>;
      
      private var m_HideTimeout:int = -1;
      
      private var m_FadeTween:Tween = null;
      
      private var m_QuestData:Array = null;
      
      private var m_updateTimeout:int = -1;
      
      private var m_testEnabled:Boolean = false;
      
      private var m_BusyAnimating:Boolean = false;
      
      private var m_AnimationsBlocked:Boolean = false;
      
      private var m_EventsQueued:Boolean = false;
      
      private var m_TempNewQuestEventData:Object;
      
      private var m_PendingQuestEvents:Array;
      
      private var m_PendingObjectiveEvents:Array;
      
      private var m_NeedReposition:Boolean = false;
      
      private var m_IsValidHudMode:Boolean = true;
      
      private var m_IsShortDelayHudMode:Boolean = false;
      
      private var m_Displayed:Boolean = true;
      
      private var m_ShouldDisplay:Boolean = false;
      
      private var m_ShouldAllQuestsBeTemp:Boolean = false;
      
      private var m_ForceConsolidateAllQuests:Boolean = false;
      
      private var m_QuestSyncTimer:Timer;
      
      private var m_AnimationPassedRearrange:Boolean = false;
      
      private var m_Initialized:Boolean = false;
      
      private var m_CurrentHUDMode:String = "";
      
      private var m_ValidHudModes:Array;
      
      private var m_IsActive:Boolean = true;
      
      private var m_LastNonFocusAlpha:* = 1;
      
      private var m_FocusFadeTween:Tween = null;
      
      private var m_TempObjectivesToRemove:Vector.<HUDQuestTrackerObjective>;
      
      private var m_TempQuestObjectiveUpdates:Boolean = false;
      
      public function HUDQuestTracker()
      {
         this.m_PendingQuestEvents = [];
         this.m_PendingObjectiveEvents = [];
         this.m_TempObjectivesToRemove = new Vector.<HUDQuestTrackerObjective>();
         super();
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.CAMP_PLACEMENT,HUDModes.PIPBOY,HUDModes.TERMINAL_MODE,HUDModes.INSPECT_MODE,HUDModes.DIALOGUE_MODE,HUDModes.MESSAGE_MODE);
         this.m_DisplayedQuests = new Vector.<HUDQuestTrackerEntry>();
         BSUIDataManager.Subscribe("MenuStackData",this.onMenuStackChange);
         BSUIDataManager.Subscribe("QuestEventData",this.onQuestEventsUpdate);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("QuestTrackerData",this.onQuestTrackerData);
         this.setDisplayed(false);
         this.m_QuestSyncTimer = new Timer(DEFAULT_QUEST_SYNC_DELAY * 1000);
         this.m_QuestSyncTimer.stop();
         if(TEST_MODE)
         {
            this.registerTestFunctionality();
         }
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         if(param1 != this.m_IsActive)
         {
            this.m_IsActive = param1;
            if(this.m_IsActive)
            {
               this.setDisplayed(true);
               this.m_QuestData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
               this.populateFull();
               this.m_Initialized = true;
            }
            else
            {
               this.setDisplayed(false);
            }
         }
      }
      
      private function eventQuestDividerPos(param1:Number, param2:Boolean = false) : *
      {
         if(this.m_EventQuestDividerTween != null)
         {
            this.m_EventQuestDividerTween.stop();
            this.m_EventQuestDividerTween = null;
         }
         this.m_EventQuestDividerTween = new Tween(this.EventQuestDivider_mc,"y",Regular.easeInOut,this.EventQuestDivider_mc.y,param1,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
      }
      
      public function requestRearrange() : void
      {
         if(this.m_AnimationPassedRearrange)
         {
            this.m_TempNewQuestEventData = {
               "questEvents":[{
                  "eventType":QUEST_EVENT_FORCEREARRANGE,
                  "questID":"999"
               }],
               "objectiveEvents":[]
            };
            this.processNewQuestEventData();
         }
         else
         {
            this.m_TempQuestObjectiveUpdates = true;
            this.m_NeedReposition = true;
         }
      }
      
      public function setDisplayed(param1:Boolean) : void
      {
         this.m_ShouldDisplay = param1;
         if(this.m_IsValidHudMode && this.isActive)
         {
            if(this.m_Displayed != this.m_ShouldDisplay)
            {
               if(this.m_ShouldDisplay)
               {
                  this.show();
               }
               else
               {
                  this.hide();
               }
            }
         }
         else if(this.m_Displayed)
         {
            this.hide();
         }
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         this.m_CurrentHUDMode = param1.data.hudMode;
         this.m_IsValidHudMode = this.m_ValidHudModes.indexOf(param1.data.hudMode) != -1;
         var _loc2_:* = this.m_CurrentHUDMode == HUDModes.DIALOGUE_MODE;
         if(_loc2_ != this.m_ShouldAllQuestsBeTemp)
         {
            this.m_ShouldAllQuestsBeTemp = _loc2_;
            this.m_ForceConsolidateAllQuests = true;
         }
         if(this.m_CurrentHUDMode == HUDModes.ALL)
         {
            this.setDisplayed(true);
         }
         else
         {
            this.setDisplayed(this.m_ShouldDisplay);
         }
         if(this.m_ForceConsolidateAllQuests)
         {
            this.processNewQuestEventData();
         }
      }
      
      private function onMenuStackChange(param1:FromClientDataEvent) : void
      {
         var _loc3_:* = undefined;
         var _loc2_:Boolean = false;
         if(param1.data.menuStackA.length > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < param1.data.menuStackA.length)
            {
               switch(param1.data.menuStackA[_loc3_].menuName)
               {
                  case "PerksMenu":
                  case "WorkshopMenu":
                  case "CampVendingMenu":
                  case "NPCVendingMenu":
                  case "ContainerMenu":
                     _loc2_ = true;
                     break;
               }
               _loc3_++;
            }
            if(_loc2_)
            {
               this.setDisplayed(false);
            }
            else
            {
               this.setDisplayed(true);
            }
         }
      }
      
      private function questDataHasDisplayedObjectives(param1:Object) : Boolean
      {
         var _loc2_:uint = uint(param1.objectives.length);
         var _loc3_:Boolean = false;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc2_)
         {
            if(Boolean(param1.objectives[_loc4_].isDisplayed) && Boolean(param1.objectives[_loc4_].isActive))
            {
               _loc3_ = true;
               break;
            }
            _loc4_++;
         }
         return _loc2_ > 0 && _loc3_;
      }
      
      private function questDataValidForDisplay(param1:Object) : Boolean
      {
         if(param1 != null)
         {
            return (param1.isActive || param1.isDisplayedToTeam) && param1.state == QUEST_STATE_INPROGRESS && this.questDataHasDisplayedObjectives(param1);
         }
         return false;
      }
      
      public function set nonFocusOpacity(param1:Number) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].focusQuest)
            {
               this.m_DisplayedQuests[_loc2_].alpha = 1;
            }
            else
            {
               this.m_DisplayedQuests[_loc2_].alpha = param1;
            }
            _loc2_++;
         }
         this.EventQuestDivider_mc.alpha = param1;
      }
      
      private function consolidateQuestEvents() : Object
      {
         var _loc2_:* = undefined;
         var _loc3_:Array = null;
         var _loc4_:uint = 0;
         var _loc1_:Object = null;
         if(this.m_ForceConsolidateAllQuests)
         {
            _loc2_ = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
            _loc3_ = [];
            _loc4_ = 0;
            while(_loc4_ < this.m_QuestData.length)
            {
               if(this.questDataValidForDisplay(_loc2_[_loc4_]))
               {
                  _loc3_.push({
                     "questID":_loc2_[_loc4_].questID,
                     "eventType":QUEST_EVENT_INVALID
                  });
               }
               _loc4_++;
            }
            _loc1_ = {
               "quests":_loc3_,
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
            this.m_ForceConsolidateAllQuests = false;
         }
         else
         {
            _loc1_ = {
               "quests":this.m_PendingQuestEvents.slice(),
               "objectives":this.m_PendingObjectiveEvents.slice()
            };
         }
         this.m_PendingQuestEvents.splice(0);
         this.m_PendingObjectiveEvents.splice(0);
         return _loc1_;
      }
      
      public function SetAnimationBlocked(param1:Boolean) : void
      {
         this.m_AnimationsBlocked = param1;
         if(this.CanAnimate() && this.m_EventsQueued)
         {
            this.processQuestUpdateEvents();
         }
      }
      
      public function CanAnimate() : Boolean
      {
         return !this.m_AnimationsBlocked && !this.m_BusyAnimating;
      }
      
      private function processNewQuestEventData() : void
      {
         if(!this.isActive)
         {
            return;
         }
         if(DEBUG_SKIP_ANIMATIONS)
         {
            this.populateFull();
            return;
         }
         this.m_PendingQuestEvents = this.m_PendingQuestEvents.concat(this.m_TempNewQuestEventData.questEvents);
         this.m_PendingObjectiveEvents = this.m_PendingObjectiveEvents.concat(this.m_TempNewQuestEventData.objectiveEvents);
         this.m_TempNewQuestEventData = {
            "questEvents":[],
            "objectiveEvents":[]
         };
         if(this.CanAnimate())
         {
            this.processQuestUpdateEvents();
         }
         else
         {
            this.m_EventsQueued = true;
            this.UpdateTitleText();
         }
      }
      
      private function UpdateTitleText() : void
      {
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc2_:Object = null;
         var _loc3_:HUDQuestTrackerObjective = null;
         var _loc4_:Object = null;
         for each(_loc1_ in this.m_DisplayedQuests)
         {
            for each(_loc2_ in this.m_QuestData)
            {
               if(_loc1_.questID == _loc2_.questID)
               {
                  _loc1_.title = _loc2_.title;
                  for each(_loc3_ in _loc1_.objectives)
                  {
                     for each(_loc4_ in _loc2_.objectives)
                     {
                        if(_loc3_.objectiveID == _loc4_.objectiveID && (_loc1_.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || _loc3_.contextQuestID == _loc4_.contextQuestID))
                        {
                           _loc3_.title = _loc4_.title;
                        }
                     }
                  }
                  break;
               }
            }
         }
      }
      
      private function onQuestTrackerData(param1:FromClientDataEvent) : void
      {
         var _loc2_:Boolean = false;
         if(Boolean(param1) && Boolean(param1.data))
         {
            this.isActive = true;
            if(this.isActive)
            {
               _loc2_ = Boolean(param1.data.shouldSyncQuestTracker);
               if(param1.data.questTrackerSyncDelay && this.m_QuestSyncTimer && param1.data.questTrackerSyncDelay * 1000 != this.m_QuestSyncTimer.delay)
               {
                  this.m_QuestSyncTimer.delay = param1.data.questTrackerSyncDelay * 1000;
               }
               if(_loc2_)
               {
                  this.m_QuestSyncTimer.reset();
                  this.m_QuestSyncTimer.start();
                  this.m_QuestSyncTimer.addEventListener(TimerEvent.TIMER,this.syncQuestTracker);
               }
               else if(!_loc2_ && this.m_QuestSyncTimer.running)
               {
                  this.m_QuestSyncTimer.stop();
                  this.m_QuestSyncTimer.removeEventListener(TimerEvent.TIMER,this.syncQuestTracker);
               }
            }
         }
      }
      
      private function onQuestEventsUpdate(param1:FromClientDataEvent) : void
      {
         if(!this.isActive)
         {
            return;
         }
         if(param1.data.testEnable == true && this.m_testEnabled == false)
         {
            this.registerTestFunctionality();
         }
         if(DEBUG_SKIP_ANIMATIONS)
         {
            this.populateFull();
            return;
         }
         var _loc2_:Array = [];
         var _loc3_:Array = [];
         this.m_QuestData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
         if(!this.m_Initialized && this.m_QuestData != null && this.m_QuestData.length > 0)
         {
            this.populateFull();
            this.m_Initialized = true;
         }
         var _loc4_:uint = 0;
         while(_loc4_ < param1.data.questEvents.length)
         {
            _loc2_.push({
               "questID":param1.data.questEvents[_loc4_].questID,
               "eventType":param1.data.questEvents[_loc4_].eventType
            });
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.data.objectiveEvents.length)
         {
            _loc3_.push({
               "questID":param1.data.objectiveEvents[_loc4_].questID,
               "objectiveID":param1.data.objectiveEvents[_loc4_].objectiveID,
               "eventType":param1.data.objectiveEvents[_loc4_].eventType,
               "contextQuestID":param1.data.objectiveEvents[_loc4_].contextQuestID
            });
            _loc4_++;
         }
         this.m_TempNewQuestEventData = {
            "questEvents":_loc2_,
            "objectiveEvents":_loc3_
         };
         if(this.m_Initialized)
         {
            this.processNewQuestEventData();
         }
         else
         {
            this.m_EventsQueued = true;
         }
      }
      
      public function show() : void
      {
         this.m_Displayed = true;
         this.clearTween();
         this.endHideTimeout();
         this.visible = true;
         this.alpha = 1;
      }
      
      public function fadeOut() : void
      {
         this.m_HideTimeout = -1;
         this.m_FadeTween = new Tween(this,"alpha",Regular.easeInOut,1,0,1,true);
         this.m_Displayed = false;
      }
      
      private function clearTween() : void
      {
         if(this.m_FadeTween != null)
         {
            this.m_FadeTween.stop();
            this.m_FadeTween = null;
         }
      }
      
      private function endHideTimeout() : void
      {
         if(this.m_HideTimeout != -1)
         {
            clearTimeout(this.m_HideTimeout);
            this.m_HideTimeout = -1;
         }
      }
      
      public function hide() : void
      {
         this.m_Displayed = false;
         this.endHideTimeout();
         this.clearTween();
         this.visible = false;
      }
      
      private function sortDisplayedQuests(param1:HUDQuestTrackerEntry, param2:HUDQuestTrackerEntry) : Number
      {
         if(param1.isEvent && !param2.isEvent)
         {
            return -1;
         }
         if(!param1.isEvent && param2.isEvent)
         {
            return 1;
         }
         if(!param1.tempDisplay && param2.tempDisplay)
         {
            return -1;
         }
         if(param1.tempDisplay && !param2.tempDisplay)
         {
            return 1;
         }
         return param1.sortIndex - param2.sortIndex;
      }
      
      private function eventQuestDividerVisible(param1:Boolean) : *
      {
         if(param1)
         {
            if(!this.m_EventQuestDividerVisible)
            {
               this.EventQuestDivider_mc.gotoAndPlay("rollOn");
            }
         }
         else if(this.m_EventQuestDividerVisible)
         {
            this.EventQuestDivider_mc.gotoAndPlay("rollOff");
         }
      }
      
      public function arrangeQuests(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         var _loc6_:HUDQuestTrackerEntry = null;
         _loc2_ = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc2_].sortIndex = _loc2_;
            if(this.m_DisplayedQuests[_loc2_].questDisplayType == GlobalFunc.QUEST_DISPLAY_TYPE_MISC)
            {
               this.m_DisplayedQuests[_loc2_].sortIndex = int.MAX_VALUE;
            }
            _loc2_++;
         }
         this.m_DisplayedQuests.sort(this.sortDisplayedQuests);
         var _loc3_:Boolean = false;
         var _loc4_:Boolean = false;
         var _loc5_:Number = 0;
         _loc2_ = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].isEvent)
            {
               _loc4_ = true;
            }
            else
            {
               if(_loc4_)
               {
                  if(param1)
                  {
                     this.eventQuestDividerPos(_loc5_);
                  }
                  else
                  {
                     this.EventQuestDivider_mc.y = _loc5_ + QUEST_SPACING;
                  }
                  _loc5_ += this.EventQuestDivider_mc.Sizer_mc.height + QUEST_SPACING;
                  _loc3_ = true;
               }
               _loc4_ = false;
            }
            (_loc6_ = this.m_DisplayedQuests[_loc2_]).setYPos(_loc5_,param1);
            _loc5_ = _loc5_ + _loc6_.fullHeight + QUEST_SPACING;
            _loc2_++;
         }
         this.eventQuestDividerVisible(_loc3_);
         this.m_EventQuestDividerVisible = _loc3_;
      }
      
      private function initializeObjective(param1:Object) : HUDQuestTrackerObjective
      {
         var _loc2_:HUDQuestTrackerObjective = new HUDQuestTrackerObjective();
         _loc2_.title = param1.title;
         _loc2_.state = param1.state;
         _loc2_.isOptional = param1.isOptional;
         _loc2_.objectiveID = param1.objectiveID;
         _loc2_.isOrObjective = param1.isOrObjective;
         _loc2_.isOffMap = param1.isOffMap;
         _loc2_.useProvider = true;
         _loc2_.timer = param1.timer;
         _loc2_.progress = param1.progressMeter;
         _loc2_.alertMessage = param1.announce;
         _loc2_.alertState = param1.announceState;
         _loc2_.contextQuestID = param1.contextQuestID;
         if(_loc2_.isOrObjective)
         {
            _loc2_.title = "$$QUEST_TRACKER_OBJECTIVE_OR_PREFIX " + _loc2_.title;
         }
         _loc2_.isMergedLeaderObjective = param1.isMergedLeaderObj;
         return _loc2_;
      }
      
      private function initializeQuest(param1:Object, param2:Boolean = false) : HUDQuestTrackerEntry
      {
         var _loc4_:HUDQuestTrackerObjective = null;
         var _loc5_:Object = null;
         var _loc6_:* = undefined;
         var _loc3_:HUDQuestTrackerEntry = new HUDQuestTrackerEntry();
         _loc3_.tracker = this;
         _loc3_.title = param1.title;
         _loc3_.questID = param1.questID;
         _loc3_.state = param1.state;
         _loc3_.isEvent = param1.isEventQuest;
         _loc3_.questDisplayType = param1.questDisplayType;
         _loc3_.isDisplayedToTeam = param1.isDisplayedToTeam;
         _loc3_.isShareable = param1.isShareable;
         _loc3_.useProvider = true;
         _loc3_.timer = param1.timer;
         for(_loc6_ in param1.objectives)
         {
            if((_loc5_ = param1.objectives[_loc6_]).state == QUEST_STATE_INPROGRESS && _loc5_.isDisplayed && Boolean(_loc5_.isActive))
            {
               (_loc4_ = this.initializeObjective(_loc5_)).questID = _loc3_.questID;
               _loc3_.addObjective(_loc4_);
               if(!param2)
               {
                  _loc4_.stateUpdate();
               }
            }
         }
         _loc3_.arrangeObjectives();
         return _loc3_;
      }
      
      private function populateFull() : void
      {
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc4_:Object = null;
         var _loc5_:HUDQuestTrackerEntry = null;
         this.m_BusyAnimating = false;
         var _loc2_:* = this.m_DisplayedQuests.length;
         while(_loc2_ > 0)
         {
            _loc1_ = this.m_DisplayedQuests.pop();
            _loc1_.useProvider = false;
            removeChild(_loc1_);
            _loc2_--;
         }
         this.setDisplayed(true);
         var _loc3_:uint = 0;
         while(_loc3_ < this.m_QuestData.length)
         {
            _loc4_ = this.m_QuestData[_loc3_];
            if(this.questDataValidForDisplay(_loc4_))
            {
               (_loc5_ = this.initializeQuest(_loc4_)).stateUpdate();
               this.m_DisplayedQuests.push(_loc5_);
               addChild(_loc5_);
            }
            _loc3_++;
         }
         this.arrangeQuests();
      }
      
      private function getQuestDataByID(param1:uint) : Object
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_QuestData.length)
         {
            if(this.m_QuestData[_loc2_].questID == param1)
            {
               return this.m_QuestData[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getQuestDataObjectiveByID(param1:Object, param2:uint, param3:uint) : *
      {
         var _loc4_:uint = 0;
         if(param1 != null)
         {
            _loc4_ = 0;
            while(_loc4_ < param1.objectives.length)
            {
               if(param1.objectives[_loc4_].objectiveID == param2 && (param1.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || param1.objectives[_loc4_].contextQuestID == param3))
               {
                  return param1.objectives[_loc4_];
               }
               _loc4_++;
            }
         }
         return null;
      }
      
      private function getDisplayedQuestByID(param1:uint) : HUDQuestTrackerEntry
      {
         var _loc2_:uint = 0;
         while(_loc2_ < this.m_DisplayedQuests.length)
         {
            if(this.m_DisplayedQuests[_loc2_].questID == param1)
            {
               return this.m_DisplayedQuests[_loc2_];
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getDisplayedObjectiveByID(param1:HUDQuestTrackerEntry, param2:uint, param3:uint) : HUDQuestTrackerObjective
      {
         var _loc4_:uint = 0;
         while(_loc4_ < param1.objectives.length)
         {
            if(param1.objectives[_loc4_].objectiveID == param2 && (param1.questDisplayType != GlobalFunc.QUEST_DISPLAY_TYPE_MISC || param1.objectives[_loc4_].contextQuestID == param3))
            {
               return param1.objectives[_loc4_];
            }
            _loc4_++;
         }
         return null;
      }
      
      private function animateUpdatedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : *
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].animateUpdate();
            _loc2_++;
         }
      }
      
      private function fadeDeletedQuests() : void
      {
         var _loc1_:int = int(this.m_DisplayedQuests.length - 1);
         while(_loc1_ >= 0)
         {
            if(this.m_DisplayedQuests[_loc1_].toRemove)
            {
               this.m_DisplayedQuests[_loc1_].fadeOut();
            }
            _loc1_--;
         }
      }
      
      private function fadeDeletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeOut();
            _loc2_++;
         }
      }
      
      private function removeDeletedQuests() : void
      {
         var _loc1_:int = int(this.m_DisplayedQuests.length - 1);
         while(_loc1_ >= 0)
         {
            if(this.m_DisplayedQuests[_loc1_].toRemove)
            {
               this.m_DisplayedQuests[_loc1_].useProvider = false;
               this.removeChild(this.m_DisplayedQuests[_loc1_]);
               this.m_DisplayedQuests.splice(_loc1_,1);
            }
            _loc1_--;
         }
      }
      
      private function removeDeletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            (param1[_loc2_].parent as HUDQuestTrackerEntry).deleteObjective(param1[_loc2_]);
            _loc2_++;
         }
      }
      
      private function animateCompletedQuests(param1:Vector.<HUDQuestTrackerEntry>) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].stateUpdate(true);
            _loc2_++;
         }
      }
      
      private function animateCompletedObjectives(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].stateUpdate(true);
            _loc2_++;
         }
      }
      
      private function animateObjectivesWithMergeLeaderChange(param1:Vector.<HUDQuestTrackerObjective>) : void
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].mergeStateUpdate();
            _loc2_++;
         }
      }
      
      private function fadeInQuests(param1:Vector.<HUDQuestTrackerEntry>) : *
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeIn();
            _loc2_++;
         }
      }
      
      private function fadeInObjectives(param1:Vector.<HUDQuestTrackerObjective>) : *
      {
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            param1[_loc2_].fadeIn();
            _loc2_++;
         }
      }
      
      private function focusQuestFade(param1:Number) : *
      {
         if(this.m_FocusFadeTween != null)
         {
            this.m_FocusFadeTween.stop();
            this.m_FocusFadeTween = null;
         }
         this.m_FocusFadeTween = new Tween(this,"nonFocusOpacity",None.easeNone,this.m_LastNonFocusAlpha,param1,HUDQuestTracker.EVENT_DURATION_QUEST_FADEINOUT / 1000,true);
         this.m_LastNonFocusAlpha = param1;
      }
      
      private function arrangeQuestsObjectives() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            if(true || this.m_DisplayedQuests[_loc1_].needArrangeObjectives)
            {
               this.m_DisplayedQuests[_loc1_].arrangeObjectives(false);
            }
            _loc1_++;
         }
      }
      
      private function clearQuestArrangeFlags() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc1_].needArrangeObjectives = false;
            _loc1_++;
         }
      }
      
      private function clearQuestFocusFlags() : void
      {
         var _loc1_:uint = 0;
         while(_loc1_ < this.m_DisplayedQuests.length)
         {
            this.m_DisplayedQuests[_loc1_].focusQuest = false;
            _loc1_++;
         }
      }
      
      public function queueRemoveQuestObjectives(param1:HUDQuestTrackerEntry, param2:Vector.<HUDQuestTrackerObjective>) : void
      {
         var _loc3_:* = 0;
         while(_loc3_ < param1.objectives.length)
         {
            if(!param1.objectives[_loc3_].toRemove)
            {
               param1.objectives[_loc3_].toRemove = true;
               param2.push(param1.objectives[_loc3_]);
            }
            _loc3_++;
         }
      }
      
      private function queueRemoveObjectiveFromTracker(param1:HUDQuestTrackerObjective, param2:HUDQuestTrackerEntry) : void
      {
         if(!param1.toRemove)
         {
            param1.toRemove = true;
            this.m_TempObjectivesToRemove.push(param1);
            param2.needArrangeObjectives = true;
            this.m_TempQuestObjectiveUpdates = true;
         }
      }
      
      private function queueAddNewQuestToTracker(param1:Object, param2:Vector.<HUDQuestTrackerEntry>, param3:Vector.<HUDQuestTrackerObjective>, param4:Boolean = false) : HUDQuestTrackerEntry
      {
         var _loc5_:HUDQuestTrackerEntry;
         (_loc5_ = this.initializeQuest(param1,true)).tempDisplay = param4;
         var _loc6_:int = 0;
         while(_loc6_ < _loc5_.objectives.length)
         {
            param3.push(_loc5_.objectives[_loc6_]);
            _loc6_++;
         }
         param2.push(_loc5_);
         this.m_DisplayedQuests.push(_loc5_);
         addChild(_loc5_);
         return _loc5_;
      }
      
      private function initializeUpdateEventInfo(param1:String, param2:Object) : Object
      {
         return {
            "questID":param1,
            "data":param2,
            "objectiveUpdates":new Array(),
            "tracked":(param2 != null ? this.questDataValidForDisplay(param2) : false)
         };
      }
      
      private function processQuestUpdateEvents() : void
      {
         var delayMS:uint;
         this.m_BusyAnimating = true;
         this.m_AnimationPassedRearrange = false;
         delayMS = 0;
         try
         {
            delayMS = this.doProcessQuestUpdateEvents();
         }
         catch(e:Error)
         {
            GlobalFunc.BSASSERT(false,e.getStackTrace().toString());
         }
         this.m_AnimationPassedRearrange = true;
         setTimeout(function():void
         {
            m_BusyAnimating = false;
            if(CanAnimate() && m_EventsQueued)
            {
               processQuestUpdateEvents();
            }
         },delayMS);
      }
      
      private function doProcessQuestUpdateEvents() : uint
      {
         var questsToRemove:Boolean;
         var focusQuestCount:uint;
         var updateEventInfo:Array;
         var findQuestEventByID:*;
         var findObjEventByID:*;
         var updateMatchObj:Object;
         var questEventIdx:uint;
         var objEventIdx:uint;
         var questFocusAnim:*;
         var tempQuestData:Object = null;
         var tempObjectiveData:Object = null;
         var newQuests:Vector.<HUDQuestTrackerEntry> = null;
         var objectivesUpdated:Vector.<HUDQuestTrackerObjective> = null;
         var newObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var questsCompleted:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayQuests:Vector.<HUDQuestTrackerEntry> = null;
         var tempDisplayObjectives:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesCompleted:Vector.<HUDQuestTrackerObjective> = null;
         var objectivesMergeChanged:Vector.<HUDQuestTrackerObjective> = null;
         var questEvent:Object = null;
         var objectiveEvent:Object = null;
         var questEventData:Object = null;
         var showingEventQuests:Boolean = false;
         var questTrackerEntry:HUDQuestTrackerEntry = null;
         var delayMS:uint = 0;
         var trackerQuest:HUDQuestTrackerEntry = null;
         var objectiveEventData:Object = null;
         var trackerObjective:HUDQuestTrackerObjective = null;
         var sortedEvents:Object = this.consolidateQuestEvents();
         this.m_EventsQueued = false;
         this.m_NeedReposition = false;
         newQuests = new Vector.<HUDQuestTrackerEntry>();
         objectivesUpdated = new Vector.<HUDQuestTrackerObjective>();
         this.m_TempQuestObjectiveUpdates = false;
         newObjectives = new Vector.<HUDQuestTrackerObjective>();
         questsToRemove = false;
         this.m_TempObjectivesToRemove.splice(0,this.m_TempObjectivesToRemove.length);
         questsCompleted = new Vector.<HUDQuestTrackerEntry>();
         tempDisplayQuests = new Vector.<HUDQuestTrackerEntry>();
         tempDisplayObjectives = new Vector.<HUDQuestTrackerObjective>();
         objectivesCompleted = new Vector.<HUDQuestTrackerObjective>();
         objectivesMergeChanged = new Vector.<HUDQuestTrackerObjective>();
         focusQuestCount = 0;
         this.clearQuestFocusFlags();
         updateEventInfo = new Array();
         findQuestEventByID = function(param1:*, param2:int, param3:Array):Boolean
         {
            if(param1.questID == this.ID)
            {
               this.matchIndex = param2;
               return true;
            }
            return false;
         };
         findObjEventByID = function(param1:*, param2:int, param3:Array):Boolean
         {
            if(param1.objectiveID == this.ID && param1.contextQuestID == this.contextQuestID)
            {
               this.matchIndex = param2;
               return true;
            }
            return false;
         };
         updateMatchObj = {
            "ID":0,
            "contextQuestID":0,
            "matchIndex":uint.MAX_VALUE
         };
         questEventIdx = uint.MAX_VALUE;
         objEventIdx = uint.MAX_VALUE;
         for each(questEvent in sortedEvents.quests)
         {
            tempQuestData = this.getQuestDataByID(questEvent.questID);
            updateMatchObj.ID = questEvent.questID;
            if(!updateEventInfo.some(findQuestEventByID,updateMatchObj))
            {
               questEventIdx = updateEventInfo.length;
               updateEventInfo.push(this.initializeUpdateEventInfo(questEvent.questID,tempQuestData));
            }
            else
            {
               questEventIdx = uint(updateMatchObj.matchIndex);
            }
            switch(questEvent.eventType)
            {
               case QUEST_EVENT_FORCEREARRANGE:
                  this.m_NeedReposition = true;
                  this.m_TempQuestObjectiveUpdates = true;
                  break;
               case QUEST_EVENT_FAIL:
                  updateEventInfo[questEventIdx].failed = true;
               case QUEST_EVENT_COMPLETE:
                  updateEventInfo[questEventIdx].completed = true;
                  break;
               case QUEST_EVENT_INACTIVE:
                  updateEventInfo[questEventIdx].updated = tempQuestData == null || tempQuestData.isActive == true;
                  break;
               case QUEST_EVENT_DISPLAYEDTOTEAM:
               case QUEST_EVENT_UNDISPLAYEDTOTEAM:
                  updateEventInfo[questEventIdx].updated = tempQuestData == null || tempQuestData.isDisplayedToTeam == true;
                  break;
            }
            updateEventInfo[questEventIdx].updated = true;
         }
         for each(objectiveEvent in sortedEvents.objectives)
         {
            tempQuestData = this.getQuestDataByID(objectiveEvent.questID);
            tempObjectiveData = this.getQuestDataObjectiveByID(tempQuestData,objectiveEvent.objectiveID,objectiveEvent.contextQuestID);
            updateMatchObj.ID = objectiveEvent.questID;
            if(!updateEventInfo.some(findQuestEventByID,updateMatchObj))
            {
               questEventIdx = updateEventInfo.length;
               updateEventInfo.push(this.initializeUpdateEventInfo(objectiveEvent.questID,tempQuestData));
            }
            else
            {
               questEventIdx = uint(updateMatchObj.matchIndex);
            }
            updateMatchObj.ID = objectiveEvent.objectiveID;
            updateMatchObj.contextQuestID = objectiveEvent.contextQuestID;
            if(!updateEventInfo[questEventIdx].objectiveUpdates.some(findObjEventByID,updateMatchObj))
            {
               objEventIdx = uint(updateEventInfo[questEventIdx].objectiveUpdates.length);
               updateEventInfo[questEventIdx].objectiveUpdates.push({
                  "questID":objectiveEvent.questID,
                  "objectiveID":objectiveEvent.objectiveID,
                  "contextQuestID":objectiveEvent.contextQuestID,
                  "data":tempObjectiveData
               });
            }
            else
            {
               objEventIdx = uint(updateMatchObj.matchIndex);
            }
            switch(objectiveEvent.eventType)
            {
               case OBJECTIVE_EVENT_FAIL:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].failed = true;
               case OBJECTIVE_EVENT_COMPLETE:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].completed = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].remove = true;
                  break;
               case OBJECTIVE_EVENT_UPDATE:
                  updateEventInfo[questEventIdx].updated = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].updated = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].remove = false;
                  break;
               case OBJECTIVE_EVENT_REMOVE:
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].remove = true;
                  break;
               case OBJECTIVE_MERGE_LEADER_CHANGE:
                  updateEventInfo[questEventIdx].updated = true;
                  updateEventInfo[questEventIdx].objectiveUpdates[objEventIdx].mergeChange = true;
                  break;
            }
            updateEventInfo[questEventIdx].updated = true;
         }
         for each(questEventData in updateEventInfo)
         {
            tempQuestData = this.getQuestDataByID(questEventData.questID);
            trackerQuest = this.getDisplayedQuestByID(questEventData.questID);
            if(tempQuestData != null && !tempQuestData.isPending)
            {
               if(trackerQuest == null && (questEventData.updated || questEventData.tracked || this.m_ShouldAllQuestsBeTemp))
               {
                  if(Boolean(questEventData.tracked) && !this.m_ShouldAllQuestsBeTemp)
                  {
                     questEventData.nowTracked = true;
                     trackerQuest = this.queueAddNewQuestToTracker(tempQuestData,newQuests,newObjectives);
                  }
                  else if(this.questDataHasDisplayedObjectives(tempQuestData))
                  {
                     trackerQuest = this.queueAddNewQuestToTracker(tempQuestData,tempDisplayQuests,tempDisplayObjectives,true);
                  }
               }
            }
            if(trackerQuest != null)
            {
               if(Boolean(questEventData.updated) && !questEventData.nowTracked)
               {
                  if(tempQuestData != null)
                  {
                     trackerQuest.title = tempQuestData.title;
                     trackerQuest.isDisplayedToTeam = tempQuestData.isDisplayedToTeam;
                  }
                  trackerQuest.focusQuest = true;
                  focusQuestCount++;
               }
               if(questEventData.completed)
               {
                  questsCompleted.push(trackerQuest);
               }
               if(tempQuestData != null && !questEventData.nowTracked && questEventData.eventType != QUEST_EVENT_INVALID)
               {
                  for each(objectiveEventData in questEventData.objectiveUpdates)
                  {
                     tempObjectiveData = this.getQuestDataObjectiveByID(tempQuestData,objectiveEventData.objectiveID,objectiveEventData.contextQuestID);
                     trackerObjective = this.getDisplayedObjectiveByID(trackerQuest,objectiveEventData.objectiveID,objectiveEventData.contextQuestID);
                     if(tempObjectiveData != null && this.m_testEnabled && Boolean(objectiveEventData.completed))
                     {
                        tempObjectiveData.state = !!objectiveEventData.failed ? QUEST_STATE_FAILED : QUEST_STATE_COMPLETE;
                     }
                     if(trackerObjective)
                     {
                        if(tempObjectiveData != null)
                        {
                           trackerObjective.state = tempObjectiveData.state;
                        }
                        if(Boolean(objectiveEventData.updated) && tempObjectiveData != null)
                        {
                           trackerObjective.title = tempObjectiveData.title;
                           if(Boolean(tempObjectiveData.isDisplayed) && Boolean(tempObjectiveData.isActive))
                           {
                              objectivesUpdated.push(trackerObjective);
                           }
                           else
                           {
                              this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                           }
                        }
                        if(objectiveEventData.completed)
                        {
                           objectivesCompleted.push(trackerObjective);
                        }
                        if(objectiveEventData.remove)
                        {
                           this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                        }
                        if(objectiveEventData.mergeChange)
                        {
                           objectivesMergeChanged.push(trackerObjective);
                        }
                     }
                     else if(tempObjectiveData != null && (tempObjectiveData.state == QUEST_STATE_INPROGRESS || objectiveEventData.completed) && Boolean(tempObjectiveData.isDisplayed) && Boolean(tempObjectiveData.isActive))
                     {
                        trackerObjective = this.initializeObjective(tempObjectiveData);
                        trackerQuest.addObjective(trackerObjective);
                        trackerQuest.needArrangeObjectives = true;
                        this.m_TempQuestObjectiveUpdates = true;
                        if(objectiveEventData.completed)
                        {
                           trackerQuest.focusQuest = true;
                           focusQuestCount++;
                           tempDisplayObjectives.push(trackerObjective);
                           objectivesCompleted.push(trackerObjective);
                           this.queueRemoveObjectiveFromTracker(trackerObjective,trackerQuest);
                        }
                        else
                        {
                           newObjectives.push(trackerObjective);
                        }
                     }
                  }
               }
               if(tempQuestData == null || !questEventData.tracked || this.m_ShouldAllQuestsBeTemp)
               {
                  trackerQuest.toRemove = true;
                  questsToRemove = true;
               }
            }
         }
         showingEventQuests = false;
         for each(questTrackerEntry in this.m_DisplayedQuests)
         {
            if(questTrackerEntry.toRemove)
            {
               this.queueRemoveQuestObjectives(questTrackerEntry,this.m_TempObjectivesToRemove);
            }
            if(questTrackerEntry.isEvent)
            {
               showingEventQuests = true;
            }
         }
         this.setDisplayed(true);
         delayMS = 0;
         if(tempDisplayQuests.length > 0 || tempDisplayObjectives.length > 0)
         {
            setTimeout(function():void
            {
               if(tempDisplayObjectives.length > 0)
               {
                  arrangeQuestsObjectives();
               }
               arrangeQuests(true);
               clearQuestArrangeFlags();
            },delayMS);
            delayMS += EVENT_DURATION_REARRANGE;
            setTimeout(function():void
            {
               fadeInQuests(tempDisplayQuests);
               fadeInObjectives(tempDisplayObjectives);
            },delayMS);
            delayMS += EVENT_DURATION_QUEST_FADEINOUT + EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         questFocusAnim = focusQuestCount && focusQuestCount != this.m_DisplayedQuests.length;
         if(questFocusAnim)
         {
            setTimeout(function():void
            {
               focusQuestFade(0.5);
            },delayMS);
            delayMS += EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesUpdated.length > 0)
         {
            setTimeout(function():void
            {
               animateUpdatedObjectives(objectivesUpdated);
            },delayMS);
            delayMS += EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questsCompleted.length > 0 || objectivesCompleted.length > 0)
         {
            setTimeout(function():void
            {
               animateCompletedQuests(questsCompleted);
               animateCompletedObjectives(objectivesCompleted);
            },delayMS);
            delayMS += EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(objectivesMergeChanged.length > 0)
         {
            setTimeout(function():void
            {
               animateObjectivesWithMergeLeaderChange(objectivesMergeChanged);
            },delayMS);
            delayMS += EVENT_DURATION_OBJECTIVE_UPDATE;
         }
         if(questFocusAnim)
         {
            setTimeout(function():void
            {
               focusQuestFade(1);
            },delayMS);
            delayMS += EVENT_DURATION_QUEST_FADEINOUT;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():void
            {
               fadeDeletedObjectives(m_TempObjectivesToRemove);
               fadeDeletedQuests();
            },delayMS);
            delayMS += EVENT_DURATION_QUEST_FADEINOUT;
            this.m_NeedReposition = true;
         }
         if(questsToRemove || this.m_TempObjectivesToRemove.length > 0)
         {
            setTimeout(function():void
            {
               removeDeletedObjectives(m_TempObjectivesToRemove);
               removeDeletedQuests();
            },delayMS);
         }
         if(newQuests.length > 0 || newObjectives.length > 0)
         {
            this.m_NeedReposition = true;
         }
         if(this.m_TempQuestObjectiveUpdates)
         {
            setTimeout(function():void
            {
               arrangeQuestsObjectives();
            },delayMS);
            delayMS += EVENT_DURATION_REARRANGE;
         }
         if(this.m_NeedReposition || newQuests.length > 0 || newObjectives.length > 0)
         {
            setTimeout(function():void
            {
               if(m_TempQuestObjectiveUpdates)
               {
                  arrangeQuestsObjectives();
               }
               arrangeQuests(true);
               clearQuestArrangeFlags();
               fadeInQuests(newQuests);
               fadeInObjectives(newObjectives);
            },delayMS);
            if(newQuests.length > 0 || newObjectives.length > 0)
            {
               delayMS += EVENT_DURATION_QUEST_FADEINOUT;
            }
            else
            {
               delayMS += EVENT_DURATION_REARRANGE;
            }
         }
         return delayMS;
      }
      
      private function syncQuestTracker() : void
      {
         var _loc1_:Array = null;
         var _loc2_:uint = 0;
         var _loc3_:Object = null;
         if(this.m_PendingObjectiveEvents.length == 0 && this.CanAnimate())
         {
            _loc1_ = new Array();
            this.m_QuestData = BSUIDataManager.GetDataFromClient("QuestTrackerData").data.quests;
            _loc2_ = 0;
            while(_loc2_ < this.m_DisplayedQuests.length)
            {
               _loc3_ = this.getQuestDataByID(this.m_DisplayedQuests[_loc2_].questID);
               if(!_loc3_ || _loc3_ && !this.questDataValidForDisplay(_loc3_))
               {
                  _loc1_.push({
                     "questID":this.m_DisplayedQuests[_loc2_].questID,
                     "eventType":QUEST_EVENT_INACTIVE
                  });
               }
               _loc2_++;
            }
            if(_loc1_.length > 0)
            {
               this.m_PendingQuestEvents = this.m_PendingQuestEvents.concat(_loc1_);
               if(this.m_Initialized)
               {
                  this.processNewQuestEventData();
               }
            }
            this.m_QuestSyncTimer.stop();
         }
         else
         {
            this.m_QuestSyncTimer.reset();
            this.m_QuestSyncTimer.start();
         }
      }
      
      private function test_onKeyDown(param1:KeyboardEvent) : void
      {
         switch(param1.keyCode)
         {
            case 116:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_questRemove();
                  }
                  else
                  {
                     this.test_questAdd();
                  }
               }
               else
               {
                  this.test_questComplete(param1.shiftKey);
               }
               break;
            case 117:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_objectiveRemove();
                  }
                  else
                  {
                     this.test_objectiveAdd();
                  }
               }
               else
               {
                  this.test_objectiveComplete(param1.shiftKey);
               }
               break;
            case 118:
               if(param1.shiftKey)
               {
                  this.test_questStateUpdate("isActive",false,QUEST_EVENT_INACTIVE);
               }
               else
               {
                  this.test_questStateUpdate("isActive",true,QUEST_EVENT_ACTIVE);
               }
               break;
            case 119:
               if(param1.shiftKey)
               {
                  this.test_questStateUpdate("isDisplayedToTeam",false,QUEST_EVENT_UNDISPLAYEDTOTEAM);
               }
               else
               {
                  this.test_questStateUpdate("isDisplayedToTeam",true,QUEST_EVENT_DISPLAYEDTOTEAM);
               }
               break;
            case 123:
               if(param1.shiftKey)
               {
                  this.test_objectiveTimerChange();
               }
               else
               {
                  this.test_questTimerChange();
               }
               break;
            case 114:
               if(param1.ctrlKey)
               {
                  if(param1.shiftKey)
                  {
                     this.test_objectiveAlertChange();
                  }
                  else
                  {
                     this.test_objectiveProgressChange();
                  }
               }
               else
               {
                  this.test_objectiveCountUpdate(param1.shiftKey);
               }
         }
      }
      
      private function registerTestFunctionality() : void
      {
         this.m_testEnabled = true;
         stage.addEventListener(KeyboardEvent.KEY_DOWN,this.test_onKeyDown);
      }
      
      private function test_forceQuestUpdateCallbacks() : *
      {
         var _loc1_:HUDQuestTrackerEntry = null;
         var _loc2_:HUDQuestTrackerObjective = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < this.m_DisplayedQuests.length)
         {
            _loc1_ = this.m_DisplayedQuests[_loc3_];
            _loc1_.onQuestDataChange(this.m_QuestData);
            _loc4_ = 0;
            while(_loc4_ < _loc1_.objectives.length)
            {
               _loc2_ = _loc1_.objectives[_loc4_];
               _loc2_.onQuestDataChange(this.m_QuestData);
               _loc4_++;
            }
            _loc3_++;
         }
      }
      
      private function test_objectiveProgressChange() : *
      {
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newProgress:Number = NaN;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.progressMax > 0)
                  {
                     foundObjective = true;
                  }
                  j++;
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("test_objectiveProgressChange : Could not find objective with usable progress.");
            }
            newProgress = Math.random() * 0.9 + 0.1;
            trace("TEST | Progress for quest " + objectiveData.questID + " objective " + objectiveData.objectiveID + " set to " + newProgress);
            objectiveData.progressMeter = newProgress;
            this.test_forceQuestUpdateCallbacks();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveTimerChange() : *
      {
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.timer > 0)
                  {
                     foundObjective = true;
                     break;
                  }
                  j++;
               }
               if(foundObjective)
               {
                  break;
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("test_objectiveTimerChange : Could not find objective with usable timer.");
            }
            newTimer = Math.random() * 2000 + 5;
            trace("TEST | Timer for quest " + objectiveData.questID + " objective " + objectiveData.objectiveID + " set to " + newTimer);
            objectiveData.timer = newTimer;
            this.test_forceQuestUpdateCallbacks();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questTimerChange() : *
      {
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         var newTimer:Number = NaN;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               if(questData.timer > 0)
               {
                  foundQuest = true;
                  break;
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("test_objectiveTimerChange : Could not find quest with usable timer.");
            }
            newTimer = Math.random() * 2000 + 5;
            trace("TEST | Timer for quest " + questData.questID + " set to " + newTimer);
            questData.timer = newTimer;
            this.test_forceQuestUpdateCallbacks();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveAlertChange() : *
      {
         var foundObjective:Boolean = false;
         var questData:Object = null;
         var objectiveData:Object = null;
         var i:uint = 0;
         var j:uint = 0;
         var newState:uint = 0;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               j = 0;
               while(j < questData.objectives.length)
               {
                  objectiveData = questData.objectives[j];
                  if(objectiveData.announce.length > 0)
                  {
                     foundObjective = true;
                     break;
                  }
                  j++;
               }
               if(foundObjective)
               {
                  break;
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("test_objectiveAlertChange - could not find valid objective to change alert state");
            }
            newState = Math.floor(Math.random() * 3) + 1;
            objectiveData.announceState = newState;
            this.test_forceQuestUpdateCallbacks();
            trace("TEST | Alert state for quest " + questData.questID + " objective " + objectiveData.objectiveID + " set to " + newState);
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questStateUpdate(param1:String, param2:Boolean, param3:uint) : *
      {
         var foundQuest:Boolean = false;
         var questID:String = null;
         var questData:Object = null;
         var i:uint = 0;
         var aStateType:String = param1;
         var aStateEnabled:Boolean = param2;
         var aEventType:uint = param3;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               questData = this.m_QuestData[i];
               if(questData[aStateType] != aStateEnabled)
               {
                  questData[aStateType] = aStateEnabled;
                  foundQuest = true;
                  questID = questData.questID;
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Could not find quest to change state type \'" + aStateType + "\' to " + aStateEnabled + ", event type " + aEventType);
            }
            trace("TEST | Quest " + questID + " state \'" + aStateType + "\' to " + aStateEnabled + ", event type " + aEventType + " (" + questData.title + ")");
            this.m_TempNewQuestEventData = {
               "questEvents":[{
                  "eventType":aEventType,
                  "questID":questID
               }],
               "objectiveEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_questComplete(param1:Boolean = false) : *
      {
         var foundQuest:Boolean = false;
         var questData:Object = null;
         var i:uint = 0;
         var aFailed:Boolean = param1;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               if(this.m_QuestData[i].state > QUEST_STATE_INVALID)
               {
                  if(this.m_QuestData[i].state == QUEST_STATE_INPROGRESS && this.m_QuestData[i].state != (aFailed ? QUEST_STATE_FAILED : QUEST_STATE_COMPLETE))
                  {
                     questData = this.m_QuestData[i];
                     foundQuest = true;
                     break;
                  }
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Unable to find incomplete quest.");
            }
            trace("TEST | Quest marked as " + (aFailed ? "failed" : "completed") + " : " + questData.title);
            questData.state = aFailed ? QUEST_STATE_FAILED : QUEST_STATE_COMPLETE;
            this.m_TempNewQuestEventData = {
               "questEvents":[{
                  "eventType":(aFailed ? QUEST_EVENT_FAIL : QUEST_EVENT_COMPLETE),
                  "questID":questData.questID
               }],
               "objectiveEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_createObjective() : Object
      {
         var _loc1_:uint = Math.floor(1 + Math.random() * 19);
         var _loc2_:* = Math.random() > 0.5;
         var _loc3_:Number = QUEST_STATE_INPROGRESS;
         return {
            "title":"Test objective " + Math.floor(Math.random() * 256),
            "objectiveID":"tobj" + Math.floor(Math.random() * 256),
            "isOptional":(Math.random() > 0.9 ? true : false),
            "countMax":(_loc2_ ? _loc1_ : 0),
            "count":Math.floor(Math.random() * _loc1_),
            "state":_loc3_,
            "timer":(Math.random() > 0.9 ? Math.floor(Math.random() * 250) : false),
            "progressMeter":(Math.random() > 0.8 ? Math.random() : -1),
            "announce":"WARNING",
            "announceState":(Math.random() > 0.9 ? Math.floor(Math.random() * 3) + 1 : 0),
            "isDisplayed":true,
            "isActive":true
         };
      }
      
      private function test_questAdd() : *
      {
         var _loc1_:String = "tquest" + Math.floor(Math.random() * 256);
         var _loc2_:* = Math.random() > 0.4 ? true : false;
         var _loc3_:* = Math.random() > 0.4 ? _loc2_ : false;
         var _loc4_:Object = {
            "title":"Test Quest " + Math.floor(Math.random() * 256),
            "questID":_loc1_,
            "state":QUEST_STATE_INPROGRESS,
            "sharedByID":(Math.random() > 0.5 ? 1234 : ENTITY_ID_INVALID),
            "objectives":[],
            "stage":100,
            "rewardXP":Math.floor(Math.random() * 240) + 5,
            "rewardCaps":Math.floor(Math.random() * 200) + 1,
            "isActive":true,
            "isDisplayedToTeam":_loc3_,
            "isEventQuest":(Math.random() > 0.4 ? true : false),
            "isShareable":_loc2_,
            "timer":(Math.random() > 0.25 ? Math.floor(Math.random() * 250) : false)
         };
         var _loc5_:uint = 0;
         while(_loc5_ < Math.floor(Math.random() * 2) + 1)
         {
            _loc4_.objectives.push(this.test_createObjective());
            _loc5_++;
         }
         this.m_TempNewQuestEventData = {
            "objectiveEvents":[],
            "questEvents":[]
         };
         _loc5_ = 0;
         while(_loc5_ < _loc4_.objectives.length)
         {
            this.m_TempNewQuestEventData.objectiveEvents.push({
               "eventType":OBJECTIVE_EVENT_UPDATE,
               "questID":_loc4_.questID,
               "objectiveID":_loc4_.objectives[_loc5_].objectiveID
            });
            _loc5_++;
         }
         this.m_QuestData.push(_loc4_);
         this.processNewQuestEventData();
      }
      
      private function test_questRemove() : void
      {
         var removedQuest:Boolean = false;
         var quest:Object = null;
         var i:int = 0;
         try
         {
            removedQuest = false;
            i = int(this.m_QuestData.length - 1);
            while(i >= 0)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && this.getDisplayedQuestByID(quest.questID) != null)
               {
                  trace("TEST | removing quest " + i + " : " + quest.title);
                  this.m_QuestData.splice(i,1);
                  removedQuest = true;
                  break;
               }
               i--;
            }
            if(!removedQuest)
            {
               throw new Error("Unable to remove quest.");
            }
            trace("TEST | removed quest event....");
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[],
               "questEvents":[]
            };
            i = 0;
            while(i < quest.objectives.length)
            {
               this.m_TempNewQuestEventData.objectiveEvents.push({
                  "eventType":OBJECTIVE_EVENT_REMOVE,
                  "questID":quest.questID,
                  "objectiveID":quest.objectives[i].objectiveID
               });
               i++;
            }
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveCountUpdate(param1:Boolean = true) : *
      {
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         var oIndex:uint = 0;
         var aAdd:Boolean = param1;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(quest.objectives.length > 0 && (Boolean(quest.isActive) || Boolean(quest.isEventQuest) || Boolean(quest.isDisplayedToTeam)))
               {
                  oIndex = 0;
                  while(oIndex < quest.objectives.length)
                  {
                     if(quest.objectives[oIndex].countMax > 0)
                     {
                        objective = quest.objectives[oIndex];
                        foundObjective = true;
                        trace("TEST | changing objective " + oIndex + " count for quest:: " + quest.title);
                        if(aAdd)
                        {
                           if(objective.count > 0)
                           {
                              --objective.count;
                           }
                        }
                        else if(objective.count < objective.countMax)
                        {
                           ++objective.count;
                        }
                        break;
                     }
                     oIndex++;
                  }
                  if(foundObjective)
                  {
                     break;
                  }
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("Could not find a valid quest + objective w/count.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_UPDATE,
                  "questID":quest.questID,
                  "objectiveID":objective.objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveRemove() : *
      {
         var foundObjective:Boolean = false;
         var quest:Object = null;
         var objectiveID:String = null;
         var i:uint = 0;
         try
         {
            foundObjective = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest))
               {
                  if(quest.objectives.length > 0)
                  {
                     objectiveID = quest.objectives[quest.objectives.length - 1].objectiveID;
                     quest.objectives.splice(-1);
                     foundObjective = true;
                     break;
                  }
               }
               i++;
            }
            if(!foundObjective)
            {
               throw new Error("Could not find a quest with an objective to remove.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_REMOVE,
                  "questID":quest.questID,
                  "objectiveID":objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveAdd() : *
      {
         var foundQuest:Boolean = false;
         var quest:Object = null;
         var objective:Object = null;
         var i:uint = 0;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(quest.isActive)
               {
                  trace("TEST | quest name is" + quest.title);
                  objective = this.test_createObjective();
                  quest.objectives.push(objective);
                  foundQuest = true;
                  break;
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Could not find a valid quest.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":OBJECTIVE_EVENT_UPDATE,
                  "questID":quest.questID,
                  "objectiveID":objective.objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
      
      private function test_objectiveComplete(param1:Boolean = false) : *
      {
         var foundQuest:Boolean = false;
         var quest:Object = null;
         var objectiveID:String = null;
         var i:uint = 0;
         var newState:Number = NaN;
         var oIndex:uint = 0;
         var tempQuest:HUDQuestTrackerEntry = null;
         var tempObjective:HUDQuestTrackerObjective = null;
         var aFailed:Boolean = param1;
         try
         {
            foundQuest = false;
            i = 0;
            while(i < this.m_QuestData.length)
            {
               quest = this.m_QuestData[i];
               if(this.questDataValidForDisplay(quest) && quest.objectives.length > 0)
               {
                  newState = aFailed ? QUEST_STATE_FAILED : QUEST_STATE_COMPLETE;
                  oIndex = 0;
                  while(oIndex < quest.objectives.length)
                  {
                     if(quest.objectives[oIndex].state == QUEST_STATE_INPROGRESS && quest.objectives[oIndex].isDisplayed && Boolean(quest.objectives[oIndex].isActive))
                     {
                        foundQuest = true;
                        trace("TEST | state changed " + quest.objectives[oIndex].state + " -> " + newState);
                        quest.objectives[oIndex].state = newState;
                        objectiveID = quest.objectives[oIndex].objectiveID;
                        tempQuest = this.getDisplayedQuestByID(quest.questID);
                        tempObjective = this.getDisplayedObjectiveByID(tempQuest,quest.objectives[oIndex].objectiveID,quest.objectives[oIndex].contextQuestID);
                        tempObjective.state = newState;
                        break;
                     }
                     oIndex++;
                  }
                  if(foundQuest)
                  {
                     break;
                  }
               }
               i++;
            }
            if(!foundQuest)
            {
               throw new Error("Could not find a valid quest with an objective to modify.");
            }
            this.m_TempNewQuestEventData = {
               "objectiveEvents":[{
                  "eventType":(aFailed ? OBJECTIVE_EVENT_FAIL : OBJECTIVE_EVENT_COMPLETE),
                  "questID":quest.questID,
                  "objectiveID":objectiveID
               }],
               "questEvents":[]
            };
            this.processNewQuestEventData();
         }
         catch(e:Error)
         {
            trace(e.getStackTrace());
         }
      }
   }
}

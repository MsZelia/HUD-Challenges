package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.setTimeout;
   
   public class NewQuestTracker extends MovieClip
   {
      
      private static const QUEST_TRACKER_PROVIDER:String = "QuestTrackerProvider";
      
      private static const REMOVE_TIMEOUT_MS:Number = 500;
      
      public static const QUEST_STATE_INVALID:Number = 0;
      
      public static const QUEST_STATE_INPROGRESS:Number = 1;
      
      public static const QUEST_STATE_COMPLETE:Number = 2;
      
      public static const QUEST_STATE_FAILED:Number = 3;
      
      public static const QUEST_SPACING:Number = 16;
       
      
      public var EventQuestDivider_mc:MovieClip;
      
      private var m_DisplayedQuests:Dictionary;
      
      private var m_ValidHudModes:Array;
      
      private var m_QuestsToRemove:Vector.<HUDQuestTrackerEntry>;
      
      private var m_ObjectivesToRemove:Vector.<RemoveObjectiveData>;
      
      private var m_Initialized:Boolean = false;
      
      private var m_IsValidHudMode:Boolean = true;
      
      private var m_Displayed:Boolean = true;
      
      private var m_ShouldDisplay:Boolean = false;
      
      private var m_EventQuestDividerVisible:Boolean = false;
      
      private var m_IsActive:Boolean = true;
      
      private var m_BusyAnimating:Boolean = false;
      
      private var m_DataUpdateQueued:Boolean = false;
      
      private var m_HasTimers:Boolean = false;
      
      private var m_PreviousTime:Number;
      
      public function NewQuestTracker()
      {
         super();
         this.m_ValidHudModes = new Array(HUDModes.ALL,HUDModes.ACTIVATE_TYPE,HUDModes.SIT_WAIT_MODE,HUDModes.VERTIBIRD_MODE,HUDModes.POWER_ARMOR,HUDModes.IRON_SIGHTS,HUDModes.SCOPE_MENU,HUDModes.INSIDE_MEMORY,HUDModes.CAMP_PLACEMENT,HUDModes.PIPBOY,HUDModes.TERMINAL_MODE,HUDModes.INSPECT_MODE,HUDModes.DIALOGUE_MODE,HUDModes.MESSAGE_MODE,HUDModes.FISHING_MODE);
         this.m_DisplayedQuests = new Dictionary();
         this.m_QuestsToRemove = new Vector.<HUDQuestTrackerEntry>();
         this.m_ObjectivesToRemove = new Vector.<RemoveObjectiveData>();
         BSUIDataManager.Subscribe("MenuStackData",this.onMenuStackChange);
         BSUIDataManager.Subscribe("HUDModeData",this.onHUDModeUpdate);
         BSUIDataManager.Subscribe("QuestTrackerProvider",this.onQuestTrackerData);
         this.setDisplayed(false);
      }
      
      public function get isActive() : Boolean
      {
         return this.m_IsActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         var _loc2_:Array = null;
         if(param1 != this.m_IsActive)
         {
            this.m_IsActive = param1;
            if(this.m_IsActive)
            {
               _loc2_ = BSUIDataManager.GetDataFromClient(QUEST_TRACKER_PROVIDER).data.quests;
               this.initializeQuestTracker(_loc2_);
               this.setDisplayed(true);
            }
            else
            {
               this.setDisplayed(false);
            }
         }
      }
      
      public function setDisplayed(param1:Boolean) : void
      {
         this.m_ShouldDisplay = param1;
         if(this.m_IsValidHudMode && this.isActive && this.m_ShouldDisplay)
         {
            this.m_Displayed = true;
            this.visible = true;
            this.alpha = 1;
         }
         else
         {
            this.m_Displayed = false;
            this.visible = false;
         }
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
         this.m_EventQuestDividerVisible = param1;
      }
      
      private function updateQuestTracker(param1:Array) : void
      {
         var _loc4_:String = null;
         var _loc5_:Object = null;
         var _loc6_:HUDQuestTrackerEntry = null;
         var _loc7_:Dictionary = null;
         var _loc8_:uint = 0;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         var _loc11_:HUDQuestTrackerObjective = null;
         var _loc12_:HUDQuestTrackerObjective = null;
         var _loc13_:HUDQuestTrackerObjective = null;
         var _loc14_:HUDQuestTrackerEntry = null;
         var _loc15_:HUDQuestTrackerObjective = null;
         var _loc2_:Dictionary = new Dictionary();
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            _loc5_ = param1[_loc3_];
            if(_loc6_ = this.m_DisplayedQuests[_loc5_.questId])
            {
               this.initializeQuest(_loc5_,_loc6_,false);
               _loc6_.stateUpdate();
               _loc7_ = new Dictionary();
               _loc8_ = 0;
               while(_loc8_ < _loc5_.objectives.length)
               {
                  if((_loc10_ = _loc6_.getObjectiveIndexById(_loc5_.objectives[_loc8_].objectiveId)) < _loc6_.objectives.length)
                  {
                     _loc11_ = _loc6_.objectives[_loc10_];
                     this.initializeObjective(_loc5_.objectives[_loc8_],_loc11_);
                     _loc11_.displayIndex = _loc8_;
                     _loc7_[_loc11_.objectiveID] = _loc11_;
                  }
                  else
                  {
                     _loc12_ = new HUDQuestTrackerObjective();
                     _loc6_.addObjective(_loc12_);
                     this.initializeObjective(_loc5_.objectives[_loc8_],_loc12_);
                     _loc12_.displayIndex = _loc8_;
                     _loc12_.fadeIn();
                     _loc7_[_loc12_.objectiveID] = _loc12_;
                  }
                  _loc8_++;
               }
               _loc9_ = 0;
               while(_loc9_ < _loc6_.objectives.length)
               {
                  if(!_loc7_[_loc6_.objectives[_loc9_].objectiveID])
                  {
                     (_loc13_ = _loc6_.objectives[_loc9_]).fadeOut(true);
                     this.m_ObjectivesToRemove.push(new RemoveObjectiveData(_loc13_,_loc6_));
                  }
                  _loc9_++;
               }
               _loc6_.newArrangeObjectives();
            }
            else
            {
               _loc6_ = this.addQuest(_loc5_,true);
            }
            _loc2_[_loc5_.questId] = _loc6_;
            _loc3_++;
         }
         for(_loc4_ in this.m_DisplayedQuests)
         {
            if(!_loc2_[_loc4_])
            {
               if(_loc14_ = this.m_DisplayedQuests[_loc4_])
               {
                  _loc14_.fadeOut(true);
                  for each(_loc15_ in _loc14_.objectives)
                  {
                     _loc15_.fadeOut(true);
                  }
                  this.m_QuestsToRemove.push(_loc14_);
               }
            }
         }
         this.arrangeQuests(true);
         if(this.m_QuestsToRemove.length > 0 || this.m_ObjectivesToRemove.length > 0)
         {
            this.m_BusyAnimating = true;
            setTimeout(this.onRemoveTimeout,REMOVE_TIMEOUT_MS);
         }
         this.m_DataUpdateQueued = false;
      }
      
      private function initializeQuestTracker(param1:Array) : void
      {
         this.m_BusyAnimating = false;
         this.clearQuestTracker();
         this.setDisplayed(true);
         var _loc2_:uint = 0;
         while(_loc2_ < param1.length)
         {
            this.addQuest(param1[_loc2_]);
            _loc2_++;
         }
         this.arrangeQuests();
         this.m_Initialized = true;
      }
      
      private function addQuest(param1:Object, param2:Boolean = false) : HUDQuestTrackerEntry
      {
         var _loc3_:HUDQuestTrackerEntry = new HUDQuestTrackerEntry();
         this.initializeQuest(param1,_loc3_,true);
         _loc3_.isNew = true;
         _loc3_.stateUpdate();
         this.m_DisplayedQuests[param1.questId] = _loc3_;
         addChild(_loc3_);
         if(param2)
         {
            _loc3_.fadeIn();
         }
         return _loc3_;
      }
      
      private function clearQuestTracker() : void
      {
         var _loc1_:String = null;
         for(_loc1_ in this.m_DisplayedQuests)
         {
            this.removeQuest(this.m_DisplayedQuests[_loc1_]);
         }
      }
      
      private function removeQuest(param1:HUDQuestTrackerEntry) : void
      {
         if(param1)
         {
            removeChild(param1);
            delete this.m_DisplayedQuests[param1.questID];
         }
      }
      
      private function arrangeQuests(param1:Boolean = false) : void
      {
         var _loc7_:HUDQuestTrackerEntry = null;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:Number = 0;
         var _loc5_:Array = BSUIDataManager.GetDataFromClient("QuestTrackerProvider").data.quests;
         var _loc6_:uint = 0;
         while(_loc6_ < _loc5_.length)
         {
            if(_loc7_ = this.m_DisplayedQuests[_loc5_[_loc6_].questId])
            {
               if(_loc7_.isEvent)
               {
                  _loc3_ = true;
               }
               else
               {
                  if(_loc3_)
                  {
                     this.EventQuestDivider_mc.y = _loc4_ + QUEST_SPACING;
                     _loc4_ += this.EventQuestDivider_mc.Sizer_mc.height + QUEST_SPACING;
                     _loc2_ = true;
                  }
                  _loc3_ = false;
               }
               _loc7_.setYPos(_loc4_,param1 && !_loc7_.isNew);
               _loc4_ = _loc4_ + _loc7_.fullHeight + QUEST_SPACING;
               _loc7_.isNew = false;
            }
            _loc6_++;
         }
         this.eventQuestDividerVisible(_loc2_);
      }
      
      private function addTimer(param1:Number, param2:Boolean) : *
      {
         if(param1 > 0 && param2 || !param2)
         {
            if(!this.m_HasTimers)
            {
               this.m_PreviousTime = new Date().getTime() / 1000;
               addEventListener(Event.ENTER_FRAME,this.onUpdateTimers);
               this.m_HasTimers = true;
            }
         }
      }
      
      private function initializeObjective(param1:Object, param2:HUDQuestTrackerObjective) : void
      {
         param2.title = param1.title;
         param2.state = param1.state;
         param2.isOptional = param1.isOptional;
         param2.objectiveID = param1.objectiveId;
         param2.questID = param1.questId;
         param2.isOrObjective = param1.isOrObjective;
         param2.isOffMap = param1.isOffMap;
         param2.useProvider = false;
         param2.timer = param1.timer.total_time;
         param2.useCountdownTimer = param1.timer.count_down;
         param2.isTimerPaused = param1.timer.is_paused;
         param2.progress = param1.progress;
         param2.alertMessage = param1.announce;
         param2.alertState = param1.announceState;
         param2.contextQuestID = param1.contextQuestID;
         param2.meterType = !!param1.isTwoWayProgressMeter ? HUDQuestTrackerObjective.METER_TYPE_TWO_WAY : HUDQuestTrackerObjective.METER_TYPE_DEFAULT;
         param2.isProximityTracker = param1.isProximityTracker;
         if(!param2.isProximityTracker)
         {
            param2.progress = param1.progress;
         }
         if(!param2.isTimerPaused)
         {
            this.addTimer(param2.timer,param2.useCountdownTimer);
         }
         if(param2.isOrObjective)
         {
            param2.title = "$$QUEST_TRACKER_OBJECTIVE_OR_PREFIX " + param2.title;
         }
         param2.isMergedLeaderObjective = param1.isMergedLeaderObj;
         param2.stateUpdate();
      }
      
      private function initializeQuest(param1:Object, param2:HUDQuestTrackerEntry, param3:Boolean) : void
      {
         var _loc4_:Object = null;
         var _loc5_:* = undefined;
         var _loc6_:HUDQuestTrackerObjective = null;
         param2.title = param1.title;
         param2.questID = param1.questId;
         param2.state = param1.state;
         param2.isEvent = param1.displayType == GlobalFunc.QUEST_DISPLAY_TYPE_EVENT;
         param2.questDisplayType = param1.displayType;
         param2.isDisplayedToTeam = param1.isDisplayedToTeam;
         param2.isShareable = param1.isShareable;
         param2.useProvider = false;
         param2.timer = param1.startTime.total_time;
         param2.useCountdownTimer = param1.startTime.count_down;
         param2.isTimerPaused = param1.startTime.is_paused;
         if(!param2.isTimerPaused)
         {
            this.addTimer(param2.timer,param2.useCountdownTimer);
         }
         if(param3)
         {
            for(_loc5_ in param1.objectives)
            {
               _loc6_ = new HUDQuestTrackerObjective();
               _loc4_ = param1.objectives[_loc5_];
               param2.addObjective(_loc6_);
               this.initializeObjective(_loc4_,_loc6_);
               _loc6_.displayIndex = _loc5_;
               _loc6_.stateUpdate();
            }
            param2.arrangeObjectivesNoSort();
         }
      }
      
      private function isValidHUDMode(param1:String) : Boolean
      {
         return this.m_ValidHudModes.indexOf(param1) != -1;
      }
      
      private function onHUDModeUpdate(param1:FromClientDataEvent) : void
      {
         this.m_IsValidHudMode = this.isValidHUDMode(param1.data.hudMode);
         if(param1.data.hudMode == HUDModes.ALL)
         {
            this.setDisplayed(true);
         }
         else
         {
            this.setDisplayed(this.m_ShouldDisplay);
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
                  case "MapMenu":
                  case "NewPlayerLoadoutsMenu":
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
      
      private function onQuestTrackerData(param1:FromClientDataEvent) : void
      {
         if(Boolean(param1) && Boolean(param1.data))
         {
            this.isActive = param1.data.active;
            if(this.isActive && Boolean(param1.data.quests))
            {
               if(!this.m_Initialized)
               {
                  this.initializeQuestTracker(param1.data.quests);
                  this.m_Initialized = true;
               }
               else if(!this.m_BusyAnimating)
               {
                  this.updateQuestTracker(param1.data.quests);
               }
               else
               {
                  this.m_DataUpdateQueued = true;
               }
            }
         }
      }
      
      private function onUpdateTimers(param1:Event) : void
      {
         var _loc3_:uint = 0;
         var _loc4_:Number = NaN;
         var _loc5_:HUDQuestTrackerEntry = null;
         var _loc6_:uint = 0;
         var _loc2_:Number = new Date().getTime() / 1000;
         if(this.m_PreviousTime < _loc2_)
         {
            _loc3_ = 0;
            _loc4_ = _loc2_ - this.m_PreviousTime;
            if(this.m_HasTimers)
            {
               for each(_loc5_ in this.m_DisplayedQuests)
               {
                  if(!_loc5_.isTimerPaused)
                  {
                     if(_loc5_.timer > 0 && _loc5_.useCountdownTimer)
                     {
                        _loc3_++;
                        _loc5_.timer -= _loc4_;
                     }
                     else if(!_loc5_.useCountdownTimer)
                     {
                        _loc3_++;
                        _loc5_.timer += _loc4_;
                     }
                  }
                  _loc6_ = 0;
                  while(_loc6_ < _loc5_.objectives.length)
                  {
                     if(!_loc5_.objectives[_loc6_].isTimerPaused)
                     {
                        if(_loc5_.objectives[_loc6_].timer > 0 && _loc5_.objectives[_loc6_].useCountdownTimer)
                        {
                           _loc3_++;
                           _loc5_.objectives[_loc6_].timer -= _loc4_;
                        }
                        else if(!_loc5_.objectives[_loc6_].useCountdownTimer)
                        {
                           _loc3_++;
                           _loc5_.objectives[_loc6_].timer += _loc4_;
                        }
                     }
                     _loc6_++;
                  }
               }
            }
            if(_loc3_ == 0)
            {
               removeEventListener(Event.ENTER_FRAME,this.onUpdateTimers);
               this.m_HasTimers = false;
            }
            this.m_PreviousTime = _loc2_;
         }
      }
      
      private function onRemoveTimeout() : void
      {
         var _loc1_:RemoveObjectiveData = null;
         var _loc2_:HUDQuestTrackerEntry = null;
         var _loc3_:uint = 0;
         while(this.m_ObjectivesToRemove.length > 0)
         {
            _loc1_ = this.m_ObjectivesToRemove.pop();
            _loc2_ = _loc1_.owningQuest;
            if(Boolean(_loc1_) && Boolean(_loc2_))
            {
               _loc2_.deleteObjective(_loc1_.objectiveToRemove);
               _loc2_.arrangeObjectivesNoSort(true);
            }
            _loc3_ = 0;
            while(_loc3_ < _loc2_.objectives.length)
            {
               _loc2_.objectives[_loc3_].displayIndex = _loc3_;
               _loc3_++;
            }
         }
         while(this.m_QuestsToRemove.length > 0)
         {
            this.removeQuest(this.m_QuestsToRemove.pop());
         }
         this.arrangeQuests(true);
         this.m_BusyAnimating = false;
         if(this.m_DataUpdateQueued)
         {
            this.updateQuestTracker(BSUIDataManager.GetDataFromClient(QUEST_TRACKER_PROVIDER).data.quests);
         }
      }
   }
}

package
{
   import Shared.AS3.BSDisplayObject;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import fl.transitions.Tween;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol645")]
   public class HUDQuestTrackerObjective extends BSDisplayObject
   {
      
      public static const ALERT_STATE_NONE:uint = 0;
      
      public static const METER_TYPE_DEFAULT:uint = 0;
      
      public static const METER_TYPE_TWO_WAY:uint = 1;
       
      
      public var Icon_mc:MovieClip;
      
      public var CompletedIcon_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      public var Title_mc:HUDQuestTrackerObjectiveTitle;
      
      public var TitleCompleted_mc:HUDQuestTrackerObjectiveTitle;
      
      public var Count_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var Alert_mc:MovieClip;
      
      public var MergedLeaderIcon_mc:MovieClip;
      
      public var VertiibirdIcon_mc:MovieClip;
      
      private var m_State:Number;
      
      private var m_IsOptional:Boolean;
      
      private var m_Title:String;
      
      private var m_Count:Number = 0;
      
      private var m_CountMax:Number = 0;
      
      private var m_ObjectiveID:uint;
      
      private var m_IsOrObjective:Boolean;
      
      private var m_IsOffMap:Boolean;
      
      private var m_TitleBaseX:Number = 0;
      
      private var m_QuestID:uint;
      
      private var m_ToRemove:Boolean = false;
      
      private var m_Timer:Number = -1;
      
      private var m_UseCountdownTimer:Boolean = true;
      
      private var m_IsTimerPaused:Boolean = false;
      
      private var m_Progress:Number = -1;
      
      private var m_MeterFrames:int = 100;
      
      private var m_AlertState:int = 0;
      
      private var m_AlertMessage:String = "";
      
      private var m_AlertSizeBuffer:Number = 0;
      
      private var m_IsMergedLeaderObjective:Boolean = false;
      
      private var m_UseProvider:Boolean = false;
      
      private var m_ProviderCallback:Function;
      
      private var m_ContextQuestID:uint;
      
      private var m_MeterType:uint = 0;
      
      private var m_MeterTextLeft:String = "";
      
      private var m_MeterTextRight:String = "";
      
      private var m_posTween:Tween;
      
      private var m_DisplayIndex:int = 0;
      
      private var m_IsProximityTracker:Boolean = false;
      
      public function HUDQuestTrackerObjective()
      {
         addFrameScript(0,this.frame1,15,this.frame16,38,this.frame39,43,this.frame44,115,this.frame116,167,this.frame168,171,this.frame172,204,this.frame205,238,this.frame239,253,this.frame254,268,this.frame269);
         super();
         this.m_TitleBaseX = this.Title_mc.Sizer_mc.x;
         this.m_MeterFrames = this.Meter_mc.Internal_mc.totalFrames;
         this.Meter_mc.visible = false;
         Extensions.enabled = true;
      }
      
      public function onQuestDataChange(param1:Array) : void
      {
         var _loc2_:Object = null;
         var _loc4_:uint = 0;
         var _loc3_:uint = 0;
         while(_loc3_ < param1.length)
         {
            if(param1[_loc3_].questID == this.m_QuestID)
            {
               _loc4_ = 0;
               while(param1[_loc3_].objectives.length)
               {
                  _loc2_ = param1[_loc3_].objectives[_loc4_];
                  if(_loc2_.contextQuestID == this.m_ContextQuestID && _loc2_.objectiveID == this.m_ObjectiveID)
                  {
                     this.meterType = !!_loc2_.isTwoWayProgressMeter ? METER_TYPE_TWO_WAY : METER_TYPE_DEFAULT;
                     this.meterTextLeft = _loc2_.twoWayProgressMeterTextLeft;
                     this.meterTextRight = _loc2_.twoWayProgressMeterTextRight;
                     this.progress = _loc2_.progressMeter;
                     this.timer = _loc2_.timer;
                     this.alertState = _loc2_.announceState;
                     this.alertMessage = _loc2_.announce;
                     this.isMergedLeaderObjective = _loc2_.isMergedLeaderObj;
                     return;
                  }
                  _loc4_++;
               }
            }
            _loc3_++;
         }
      }
      
      private function onProviderUpdate(param1:FromClientDataEvent) : *
      {
         var _loc2_:Array = param1.data.quests;
         this.onQuestDataChange(_loc2_);
      }
      
      override public function onRemovedFromStage() : void
      {
         if(this.isProximityTracker)
         {
            BSUIDataManager.Unsubscribe("ProximityTrackersProvider",this.onProximityTrackersData);
         }
      }
      
      private function onProximityTrackersData(param1:FromClientDataEvent) : *
      {
         var _loc2_:uint = 0;
         if(this.isProximityTracker && param1 && param1.data && Boolean(param1.data.proximityTrackers))
         {
            _loc2_ = 0;
            while(_loc2_ < param1.data.proximityTrackers.length)
            {
               if(param1.data.proximityTrackers[_loc2_].questId == this.questID && param1.data.proximityTrackers[_loc2_].objectiveId == this.objectiveID)
               {
                  this.progress = Math.max(param1.data.proximityTrackers[_loc2_].progress,0);
                  break;
               }
               _loc2_++;
            }
         }
      }
      
      public function set useProvider(param1:Boolean) : void
      {
         if(param1 != this.m_UseProvider)
         {
            this.m_UseProvider = param1;
            if(this.m_ProviderCallback != null)
            {
               BSUIDataManager.Unsubscribe("QuestTrackerData",this.m_ProviderCallback);
            }
            if(this.m_UseProvider)
            {
               this.m_ProviderCallback = BSUIDataManager.Subscribe("QuestTrackerData",this.onProviderUpdate);
            }
         }
      }
      
      public function set alertState(param1:int) : void
      {
         var _loc2_:Array = null;
         var _loc3_:String = null;
         var _loc4_:* = undefined;
         if(param1 != this.m_AlertState)
         {
            this.m_AlertState = param1;
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.visible = true;
               _loc2_ = this.Alert_mc.Internal_mc.currentLabels;
               _loc3_ = "AlertState1";
               _loc4_ = 0;
               while(_loc4_ < _loc2_.length)
               {
                  if(_loc2_[_loc4_].name == "AlertState" + this.m_AlertState)
                  {
                     _loc3_ = _loc2_[_loc4_].name;
                     break;
                  }
                  _loc4_++;
               }
               this.Alert_mc.Internal_mc.gotoAndPlay(_loc3_);
               this.updateAlertPos();
            }
            else
            {
               this.Alert_mc.Internal_mc.visible = false;
            }
         }
      }
      
      public function set alertMessage(param1:String) : void
      {
         this.m_AlertMessage = param1;
         var _loc2_:TextField = this.Alert_mc.Internal_mc.AlertText_mc.AlertText_tf;
         _loc2_.text = this.m_AlertMessage;
      }
      
      public function set isMergedLeaderObjective(param1:Boolean) : void
      {
         if(this.m_IsMergedLeaderObjective != param1)
         {
            this.m_IsMergedLeaderObjective = param1;
            this.handleIconVisibility();
         }
      }
      
      public function get timer() : Number
      {
         return this.m_Timer;
      }
      
      public function set timer(param1:Number) : void
      {
         this.m_Timer = param1;
         this.updateTitle();
      }
      
      public function get useCountdownTimer() : Boolean
      {
         return this.m_UseCountdownTimer;
      }
      
      public function set useCountdownTimer(param1:Boolean) : void
      {
         this.m_UseCountdownTimer = param1;
      }
      
      public function get isTimerPaused() : Boolean
      {
         return this.m_IsTimerPaused;
      }
      
      public function set isTimerPaused(param1:Boolean) : void
      {
         this.m_IsTimerPaused = param1;
      }
      
      public function set meterType(param1:uint) : void
      {
         if(param1 != this.m_MeterType)
         {
            this.m_MeterType = param1;
            switch(this.m_MeterType)
            {
               case METER_TYPE_TWO_WAY:
                  this.Meter_mc.gotoAndStop("twoWay");
                  break;
               default:
                  this.Meter_mc.gotoAndStop("plain");
            }
            this.updateProgress();
            if(param1 == METER_TYPE_TWO_WAY)
            {
               this.updateMeterText();
            }
         }
      }
      
      public function set meterTextLeft(param1:String) : void
      {
         if(param1 != this.m_MeterTextLeft)
         {
            this.m_MeterTextLeft = param1;
            this.updateMeterText();
         }
      }
      
      public function set meterTextRight(param1:String) : void
      {
         if(param1 != this.m_MeterTextRight)
         {
            this.m_MeterTextRight = param1;
            this.updateMeterText();
         }
      }
      
      private function updateMeterText() : void
      {
         if(this.m_MeterType == METER_TYPE_TWO_WAY)
         {
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.LeftLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            TextFieldEx.setTextAutoSize(this.Meter_mc.Internal_mc.RightLabel_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.Meter_mc.Internal_mc.LeftLabel_tf.text = this.m_MeterTextLeft;
            this.Meter_mc.Internal_mc.RightLabel_tf.text = this.m_MeterTextRight;
         }
      }
      
      public function set progress(param1:Number) : void
      {
         this.m_Progress = param1;
         this.updateProgress();
      }
      
      private function updateProgress() : void
      {
         var _loc1_:HUDQuestTrackerEntry = null;
         if(this.m_Progress >= 0)
         {
            this.Meter_mc.visible = true;
            if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
            {
               this.Meter_mc.Internal_mc.gotoAndStop(this.m_MeterFrames);
            }
            else
            {
               this.Meter_mc.Internal_mc.gotoAndStop(Math.floor(this.m_Progress * this.m_MeterFrames));
            }
            _loc1_ = this.parent as HUDQuestTrackerEntry;
            if(_loc1_ != null)
            {
               _loc1_.arrangeObjectives();
            }
         }
         else
         {
            this.Meter_mc.visible = false;
         }
      }
      
      public function get isProximityTracker() : Boolean
      {
         return this.m_IsProximityTracker;
      }
      
      public function set isProximityTracker(param1:Boolean) : void
      {
         if(this.m_IsProximityTracker != param1)
         {
            this.m_IsProximityTracker = param1;
            if(this.m_IsProximityTracker)
            {
               BSUIDataManager.Subscribe("ProximityTrackersProvider",this.onProximityTrackersData);
            }
            else
            {
               BSUIDataManager.Unsubscribe("ProximityTrackersProvider",this.onProximityTrackersData);
            }
         }
      }
      
      public function set toRemove(param1:Boolean) : *
      {
         this.m_ToRemove = param1;
      }
      
      public function get toRemove() : Boolean
      {
         return this.m_ToRemove;
      }
      
      public function get displayIndex() : int
      {
         return this.m_DisplayIndex;
      }
      
      public function set displayIndex(param1:int) : void
      {
         this.m_DisplayIndex = param1;
      }
      
      private function updateAlertPos() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:MovieClip = null;
         if(this.m_AlertState > ALERT_STATE_NONE || this.m_IsMergedLeaderObjective == true)
         {
            _loc1_ = 0;
            if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
            {
               _loc2_ = this.TitleCompleted_mc;
            }
            else
            {
               _loc2_ = this.Title_mc;
            }
            _loc1_ = Number(_loc2_.textField.getLineMetrics(0).width);
            if(this.m_AlertState > ALERT_STATE_NONE)
            {
               this.Alert_mc.Internal_mc.x = _loc2_.x - _loc1_;
            }
         }
      }
      
      private function updateTitle() : void
      {
         var _loc1_:* = "";
         var _loc2_:* = "";
         if(this.m_Timer > 0)
         {
            _loc2_ = GlobalFunc.FormatTimeString(this.m_Timer) + " ";
         }
         if(this.m_CountMax > 0)
         {
            _loc1_ = " (" + this.m_Count + "/" + this.m_CountMax + ")";
         }
         if(this.m_IsOptional)
         {
            this.Title_mc.setTitleData("$$QuestTrackerState_Optional " + _loc2_ + this.m_Title + _loc1_);
         }
         else
         {
            this.Title_mc.setTitleData(_loc2_ + this.m_Title + _loc1_);
         }
         if(this.m_State == HUDQuestTracker.QUEST_STATE_FAILED)
         {
            this.TitleCompleted_mc.setTitleData("$$QuestTrackerState_Failed " + _loc2_ + this.m_Title + _loc1_);
         }
         else
         {
            this.TitleCompleted_mc.setTitleData("$$QuestTrackerState_Completed " + _loc2_ + this.m_Title + _loc1_);
         }
         this.updateAlertPos();
      }
      
      public function set questID(param1:uint) : void
      {
         this.m_QuestID = param1;
      }
      
      public function get questID() : uint
      {
         return this.m_QuestID;
      }
      
      public function set objectiveID(param1:uint) : void
      {
         this.m_ObjectiveID = param1;
      }
      
      public function get objectiveID() : uint
      {
         return this.m_ObjectiveID;
      }
      
      public function set isOrObjective(param1:Boolean) : void
      {
         this.m_IsOrObjective = param1;
      }
      
      public function get isOrObjective() : Boolean
      {
         return this.m_IsOrObjective;
      }
      
      public function set isOffMap(param1:Boolean) : void
      {
         this.m_IsOffMap = param1;
         this.handleIconVisibility();
      }
      
      public function get isOffMap() : Boolean
      {
         return this.m_IsOffMap;
      }
      
      private function handleIconVisibility() : void
      {
         if(this.m_IsOffMap && this.m_IsMergedLeaderObjective)
         {
            this.MergedLeaderIcon_mc.Internal_mc.visible = false;
            this.VertiibirdIcon_mc.Internal_mc.visible = true;
         }
         else
         {
            this.VertiibirdIcon_mc.Internal_mc.visible = this.m_IsOffMap;
            this.MergedLeaderIcon_mc.Internal_mc.visible = this.m_IsMergedLeaderObjective;
         }
      }
      
      public function set contextQuestID(param1:uint) : void
      {
         this.m_ContextQuestID = param1;
      }
      
      public function get contextQuestID() : uint
      {
         return this.m_ContextQuestID;
      }
      
      public function get count() : Number
      {
         return this.m_Count;
      }
      
      public function set count(param1:Number) : void
      {
         this.m_Count = param1;
         this.updateTitle();
      }
      
      public function set countMax(param1:Number) : void
      {
         this.m_CountMax = param1;
         this.updateTitle();
      }
      
      public function set state(param1:Number) : *
      {
         this.m_State = param1;
         this.updateTitle();
      }
      
      public function get state() : Number
      {
         return this.m_State;
      }
      
      public function fadeIn() : void
      {
         var _loc1_:Number = Math.floor(Math.random() * (5 - 0 + 1)) + 0;
         gotoAndPlay(2 + _loc1_);
      }
      
      public function fadeOut(param1:Boolean = false) : void
      {
         if(this.m_State >= HUDQuestTracker.QUEST_STATE_COMPLETE)
         {
            gotoAndPlay(param1 ? "FadeOutFast" : "FadeOut");
         }
         else
         {
            gotoAndPlay(param1 ? "FadeOutIncompleteFast" : "FadeOutIncomplete");
         }
      }
      
      public function stateUpdate(param1:Boolean = false) : void
      {
         var _loc2_:Boolean = this.m_State == HUDQuestTracker.QUEST_STATE_COMPLETE || this.m_State == HUDQuestTracker.QUEST_STATE_FAILED;
         if(_loc2_)
         {
            if(param1)
            {
               gotoAndPlay("Complete");
            }
            else
            {
               gotoAndPlay("CompleteIdle");
            }
         }
         else
         {
            gotoAndPlay("Idle");
         }
      }
      
      public function animateUpdate() : void
      {
         gotoAndPlay("Update");
      }
      
      public function mergeStateUpdate() : void
      {
         gotoAndPlay("MergeLeaderChange");
      }
      
      public function set isOptional(param1:Boolean) : *
      {
         this.m_IsOptional = param1;
         this.updateTitle();
      }
      
      public function set title(param1:String) : *
      {
         this.m_Title = param1;
         this.updateTitle();
      }
      
      public function get title() : String
      {
         return this.m_Title;
      }
      
      public function setYPos(param1:Number, param2:Boolean = false) : void
      {
         this.clearTween();
         if(param2 && visible)
         {
            this.m_posTween = new Tween(this,"y",Regular.easeInOut,this.y,param1,HUDQuestTracker.EVENT_DURATION_REARRANGE / 1000,true);
         }
         else
         {
            this.y = param1;
         }
      }
      
      private function clearTween() : void
      {
         if(this.m_posTween != null)
         {
            this.m_posTween.stop();
            this.m_posTween = null;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         stop();
      }
      
      internal function frame39() : *
      {
         stop();
      }
      
      internal function frame44() : *
      {
         stop();
      }
      
      internal function frame116() : *
      {
         stop();
      }
      
      internal function frame168() : *
      {
         stop();
      }
      
      internal function frame172() : *
      {
         stop();
      }
      
      internal function frame205() : *
      {
         stop();
      }
      
      internal function frame239() : *
      {
         stop();
      }
      
      internal function frame254() : *
      {
         stop();
      }
      
      internal function frame269() : *
      {
         stop();
      }
   }
}

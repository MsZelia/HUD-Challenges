package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol686")]
   public class HUDFloatingTargetManager extends MovieClip
   {
      
      private static const AimInnerDistanceThreshold:Number = 20;
       
      
      private var m_Targets:Array;
      
      private var HUDModes:Array;
      
      private var m_AimOuterDistanceThreshold:Number = 100;
      
      public function HUDFloatingTargetManager()
      {
         super();
         this.m_Targets = new Array();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : *
      {
         this.HUDModes = new Array(Shared.HUDModes.ALL,Shared.HUDModes.ACTIVATE_TYPE,Shared.HUDModes.SIT_WAIT_MODE,Shared.HUDModes.VERTIBIRD_MODE,Shared.HUDModes.POWER_ARMOR,Shared.HUDModes.IRON_SIGHTS,Shared.HUDModes.SCOPE_MENU,Shared.HUDModes.INSIDE_MEMORY,Shared.HUDModes.WORKSHOP_MODE,Shared.HUDModes.CAMP_PLACEMENT,Shared.HUDModes.CROSSHAIR_AND_ACTIVATE_ONLY);
         BSUIDataManager.Subscribe("MapMenuDataChanges",this.onFloatingTargetChange);
         BSUIDataManager.Subscribe("HotMapMarkerData",this.onHotMapMenuData);
         BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);
         BSUIDataManager.Subscribe("ReconMarkerData",this.onReconMarkerData);
      }
      
      private function onHudModeDataChange(param1:FromClientDataEvent) : *
      {
         this.visible = param1.data.showFloatingMarkers == true && this.HUDModes.indexOf(param1.data.hudMode) != -1;
      }
      
      private function onHotMapMenuData(param1:FromClientDataEvent) : *
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = BSUIDataManager.GetDataFromClient("MapMenuData").data.MarkerData;
         var _loc3_:Array = param1.data.updates;
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_.length)
         {
            if((_loc5_ = this.getTargetByID(this.m_Targets,_loc3_[_loc4_].markerID)) != uint.MAX_VALUE)
            {
               this.updateTargetHot(this.m_Targets[_loc5_],_loc3_[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      private function onFloatingTargetChange(param1:FromClientDataEvent) : *
      {
         var _loc5_:* = undefined;
         var _loc6_:* = undefined;
         var _loc7_:* = undefined;
         var _loc8_:uint = 0;
         var _loc9_:* = undefined;
         var _loc10_:* = undefined;
         var _loc11_:uint = 0;
         var _loc2_:Array = BSUIDataManager.GetDataFromClient("MapMenuData").data.MarkerData;
         var _loc3_:Array = param1.data.MarkerChanges;
         var _loc4_:uint = 0;
         for(; _loc4_ < _loc3_.length; _loc4_++)
         {
            _loc5_ = _loc3_[_loc4_].index;
            _loc6_ = _loc3_[_loc4_].type;
            _loc7_ = _loc3_[_loc4_].markerID;
            if(_loc6_ == "RemoveMarker")
            {
               if((_loc8_ = this.getTargetByID(this.m_Targets,_loc7_)) != uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[_loc8_]);
                  this.m_Targets.splice(_loc8_,1);
               }
               continue;
            }
            if(_loc5_ >= _loc2_.length)
            {
               continue;
            }
            if((_loc9_ = _loc2_[_loc5_]).markerType != "ActiveQuest" && _loc9_.markerType != "InactiveQuest" && _loc9_.markerType != "SharedQuest" && _loc9_.markerType != "MainActiveQuest")
            {
               continue;
            }
            _loc10_ = _loc9_.markerID;
            _loc11_ = this.getTargetByID(this.m_Targets,_loc10_);
            switch(_loc6_)
            {
               case "AddMarker":
                  if(_loc11_ != uint.MAX_VALUE)
                  {
                     this.updateTarget(this.m_Targets[_loc11_],_loc9_);
                  }
                  else
                  {
                     this.addTarget(_loc9_);
                  }
                  break;
               case "UpdateMarker":
               case "UpdateScreenCoords":
                  if(_loc11_ != uint.MAX_VALUE)
                  {
                     this.updateTarget(this.m_Targets[_loc11_],_loc9_);
                  }
                  else
                  {
                     this.addTarget(_loc9_);
                  }
                  break;
            }
         }
      }
      
      private function IsReconMarker(param1:HUDFloatingTarget) : Boolean
      {
         return param1.markerType == "Recon" || param1.markerType == "EnemyTargeted";
      }
      
      private function onReconMarkerData(param1:FromClientDataEvent) : *
      {
         var _loc5_:Boolean = false;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc2_:Array = param1.data.reconMarkers;
         var _loc3_:Array = new Array();
         var _loc4_:uint = 0;
         while(_loc4_ < this.m_Targets.length)
         {
            _loc5_ = false;
            if(this.IsReconMarker(this.m_Targets[_loc4_]))
            {
               if((_loc6_ = this.getTargetByID(_loc2_,this.m_Targets[_loc4_].markerID)) == uint.MAX_VALUE)
               {
                  removeChild(this.m_Targets[_loc4_]);
                  this.m_Targets.splice(_loc4_,1);
                  _loc5_ = true;
               }
            }
            if(!_loc5_)
            {
               _loc4_++;
            }
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            if((_loc7_ = this.getTargetByID(this.m_Targets,_loc2_[_loc4_].markerID)) != uint.MAX_VALUE)
            {
               if(this.IsReconMarker(this.m_Targets[_loc7_]))
               {
                  this.updateTarget(this.m_Targets[_loc7_],_loc2_[_loc4_]);
               }
            }
            else
            {
               this.addTarget(_loc2_[_loc4_]);
            }
            _loc4_++;
         }
      }
      
      private function getTargetByID(param1:Array, param2:uint) : uint
      {
         var _loc3_:Boolean = false;
         var _loc4_:uint = uint.MAX_VALUE;
         var _loc5_:uint = 0;
         while(!_loc3_ && _loc5_ < param1.length)
         {
            if(param1[_loc5_].markerID == param2)
            {
               _loc4_ = _loc5_;
               _loc3_ = true;
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      private function updateTargetHot(param1:HUDFloatingTarget, param2:Object) : *
      {
         param1.distanceFromPlayer = param2.distanceFromPlayer;
         param1.visible = true;
         param1.markerID = param2.markerID;
         param1.x = param2.screenX;
         param1.y = param2.screenY;
         param1.showLabel = param2.showLabel;
         param1.midDistance = param2.midDistance;
         param1.forceShow = param2.midDistance;
      }
      
      private function updateTarget(param1:HUDFloatingTarget, param2:Object) : *
      {
         param1.distanceFromPlayer = param2.distanceFromPlayer;
         param1.isOnScreen = param2.onScreen;
         param1.visible = param2.onScreen;
         param1.markerID = param2.markerID;
         param1.markerType = param2.markerType;
         param1.isAI = param2.isAI;
         param1.label = param2.text;
         param1.showMeter = param2.showMeter;
         param1.meterValue = param2.meterValue;
         param1.alertState = param2.announceState;
         param1.alertMessage = param2.announce;
         param1.questDisplayType = param2.questDisplayType;
      }
      
      private function addTarget(param1:Object) : HUDFloatingTarget
      {
         var _loc2_:HUDFloatingTarget = new HUDFloatingTarget();
         addChild(_loc2_);
         this.m_Targets.push(_loc2_);
         this.updateTarget(_loc2_,param1);
         return _loc2_;
      }
   }
}

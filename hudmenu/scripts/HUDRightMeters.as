package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.display.MovieClip;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1723")]
   public class HUDRightMeters extends MovieClip
   {
      
      public static const FADE_DELAY:Number = 10000;
       
      
      public var PowerArmorLowBatteryWarning_mc:MovieClip;
      
      public var LocalEmote_mc:EmoteWidget;
      
      public var FlashLightWidget_mc:MovieClip;
      
      public var ExplosiveAmmoCount_mc:MovieClip;
      
      public var AmmoCount_mc:MovieClip;
      
      public var FatigueWarning_mc:MovieClip;
      
      public var ActionPointMeter_mc:MovieClip;
      
      public var OverheatMeter_mc:MovieClip;
      
      public var HUDActiveEffectsWidget_mc:HUDActiveEffectsWidget;
      
      public var HUDHungerMeter_mc:MovieClip;
      
      public var HUDThirstMeter_mc:MovieClip;
      
      public var FeralMeter_mc:MovieClip;
      
      public var HUDFusionCoreMeter_mc:MovieClip;
      
      private var bShowHunger:Boolean = false;
      
      private var bShowThirst:Boolean = false;
      
      private var bShowFusionCore:Boolean = false;
      
      private var bShowFeral:Boolean = false;
      
      private var m_FusionCorePercent:Number = 0;
      
      private var m_FusionCoreWarnPercent:Number = 0;
      
      private var m_FusionCoreCount:uint = 0;
      
      private var m_InPowerArmor:Boolean = false;
      
      private var m_PowerArmorHUDEnabled:Boolean = true;
      
      private var fHungerPercent:Number = -1;
      
      private var fThirstPercent:Number = -1;
      
      private var fFeralPercent:Number = -1;
      
      private var bHungerVisible:Boolean = false;
      
      private var bThirstVisible:Boolean = false;
      
      private var bFeralVisible:Boolean = false;
      
      private var HungerTimeout:int = -1;
      
      private var ThirstTimeout:int = -1;
      
      private const PercentIndefiniteShow:Number = 0.2;
      
      private const PercentChangeVal:Number = 0.03;
      
      private const PercentMax:Number = 1;
      
      private var HUDModes:Array;
      
      private var bIsPip:Boolean = false;
      
      private var oldHudMode:* = "All";
      
      public function HUDRightMeters()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         BSUIDataManager.Subscribe("HUDRightMetersData",this.onStateUpdate);
         this.HUDModes = new Array(Shared.HUDModes.ALL,Shared.HUDModes.ACTIVATE_TYPE,Shared.HUDModes.IRON_SIGHTS,Shared.HUDModes.POWER_ARMOR,Shared.HUDModes.PIPBOY,Shared.HUDModes.SCOPE_MENU,Shared.HUDModes.VERTIBIRD_MODE,Shared.HUDModes.SIT_WAIT_MODE,Shared.HUDModes.VATS_MODE);
         BSUIDataManager.Subscribe("HUDModeData",this.onHudModeDataChange);
         BSUIDataManager.Subscribe("PowerArmorInfoData",this.onPowerArmorInfoUpdate);
         gotoAndStop("defaultHUD");
         this.HUDHungerMeter_mc.gotoAndStop("off");
         this.HUDThirstMeter_mc.gotoAndStop("off");
         this.HUDFusionCoreMeter_mc.gotoAndStop("off");
         this.FeralMeter_mc.gotoAndStop("off");
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.AmmoCount_mc.ClipCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.AmmoCount_mc.ReserveCount_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.OverheatMeter_mc.visible = false;
         this.SetOverheatMeterPercent(0);
      }
      
      public function set showFusionCoreMeter(param1:Boolean) : void
      {
         if(param1 != this.bShowFusionCore)
         {
            this.bShowFusionCore = param1;
            if(param1)
            {
               this.HUDFusionCoreMeter_mc.gotoAndPlay("rollOn");
            }
            else
            {
               this.HUDFusionCoreMeter_mc.gotoAndPlay("rollOff");
            }
         }
      }
      
      private function updateFusionCoreMeter() : void
      {
         var _loc1_:Number = GlobalFunc.Clamp(this.m_FusionCorePercent,0,this.PercentMax) / this.PercentMax;
         var _loc2_:int = Math.ceil(_loc1_ * this.HUDFusionCoreMeter_mc.Meter_mc.totalFrames);
         this.HUDFusionCoreMeter_mc.Meter_mc.gotoAndStop(_loc2_);
         var _loc3_:uint = GlobalFunc.Clamp(this.m_FusionCoreCount,0,9);
         this.HUDFusionCoreMeter_mc.CoreCount_mc.CoreCount_tf.text = "x" + this.m_FusionCoreCount;
         if(this.m_FusionCoreCount == 0 && this.m_FusionCorePercent < this.m_FusionCoreWarnPercent)
         {
            this.HUDFusionCoreMeter_mc.survivalMeterIcon_mc.gotoAndStop("coreNegative");
         }
         else
         {
            this.HUDFusionCoreMeter_mc.survivalMeterIcon_mc.gotoAndStop("corePositive");
         }
      }
      
      private function onPowerArmorInfoUpdate(param1:FromClientDataEvent) : void
      {
         this.m_FusionCorePercent = param1.data.fusionCorePercent;
         this.m_FusionCoreWarnPercent = param1.data.fusionCoreWarnPercent;
         this.m_FusionCoreCount = param1.data.fusionCoreCount;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
      }
      
      private function onHudModeDataChange(param1:FromClientDataEvent) : *
      {
         this.visible = this.HUDModes.indexOf(param1.data.hudMode) != -1;
         this.m_InPowerArmor = param1.data.inPowerArmor;
         this.m_PowerArmorHUDEnabled = param1.data.powerArmorHUDEnabled;
         this.showFusionCoreMeter = this.m_InPowerArmor && !this.m_PowerArmorHUDEnabled;
         if(this.bShowFusionCore)
         {
            this.updateFusionCoreMeter();
         }
         var _loc2_:Boolean = this.bIsPip;
         this.bIsPip = param1.data.hudMode == Shared.HUDModes.PIPBOY;
         if(this.bIsPip)
         {
            if(this.fHungerPercent >= 0 && this.bHungerVisible)
            {
               this.endHungerHideTimeout();
               this.fadeInHunger();
            }
            if(this.fThirstPercent >= 0 && this.bThirstVisible)
            {
               this.endThirstHideTimeout();
               this.fadeInThirst();
            }
            if(this.fFeralPercent >= 0 && this.bFeralVisible)
            {
               this.fadeInFeral();
            }
         }
         else if(this.visible && _loc2_)
         {
            if(this.HungerTimeout == -1 && this.fHungerPercent >= this.PercentIndefiniteShow)
            {
               this.HungerTimeout = setTimeout(this.fadeOutHunger,FADE_DELAY);
            }
            if(this.ThirstTimeout == -1 && this.fThirstPercent >= this.PercentIndefiniteShow)
            {
               this.ThirstTimeout = setTimeout(this.fadeOutThirst,FADE_DELAY);
            }
         }
         if(Boolean(param1.data.inPowerArmor) && Boolean(param1.data.powerArmorHUDEnabled))
         {
            gotoAndStop("powerArmorHUD");
         }
         else
         {
            gotoAndStop("defaultHUD");
         }
         this.oldHudMode = param1.data.hudMode;
      }
      
      private function onStateUpdate(param1:FromClientDataEvent) : *
      {
         var _loc6_:int = 0;
         var _loc7_:Number = NaN;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc2_:Object = param1.data;
         this.HUDActiveEffectsWidget_mc.onDataUpdate(_loc2_.activeEffects);
         var _loc3_:Number = Number(_loc2_.hungerPercent);
         var _loc4_:Number = Number(_loc2_.thirstPercent);
         var _loc5_:Number = Number(_loc2_.feralPercent);
         this.bHungerVisible = _loc2_.hungerVisible;
         this.bThirstVisible = _loc2_.thirstVisible;
         this.bFeralVisible = _loc2_.feralVisible;
         if(this.bHungerVisible)
         {
            if(_loc3_ < this.PercentIndefiniteShow)
            {
               this.endHungerHideTimeout();
               this.fadeInHunger();
            }
            else if(!GlobalFunc.CloseToNumber(this.fHungerPercent,_loc3_,this.PercentChangeVal) || _loc3_ > this.fHungerPercent)
            {
               this.endHungerHideTimeout();
               this.fadeInHunger();
               this.HungerTimeout = setTimeout(this.fadeOutHunger,FADE_DELAY);
            }
            this.fHungerPercent = _loc3_;
            _loc3_ = GlobalFunc.Clamp(_loc3_,0,this.PercentMax) / this.PercentMax;
            _loc6_ = Math.ceil(_loc3_ * this.HUDHungerMeter_mc.Meter_mc.totalFrames);
            this.HUDHungerMeter_mc.Meter_mc.gotoAndStop(_loc6_);
            this.HUDHungerMeter_mc.survivalMeterIcon_mc.gotoAndStop("foodPositive");
            if(_loc2_.hunger_RestorePct is Number && _loc2_.hunger_RestorePct > 0)
            {
               _loc7_ = GlobalFunc.Clamp(this.fHungerPercent + _loc2_.hunger_RestorePct,0,this.PercentMax) / this.PercentMax;
               _loc8_ = Math.ceil(_loc7_ * this.HUDHungerMeter_mc.GhostMeter_mc.totalFrames);
               this.HUDHungerMeter_mc.GhostMeter_mc.gotoAndStop(_loc8_);
               this.HUDHungerMeter_mc.GhostMeter_mc.visible = true;
            }
            else
            {
               this.HUDHungerMeter_mc.GhostMeter_mc.visible = false;
            }
         }
         else if(this.bShowHunger)
         {
            this.setHungerOff();
         }
         if(this.bThirstVisible)
         {
            if(_loc4_ < this.PercentIndefiniteShow)
            {
               this.endThirstHideTimeout();
               this.fadeInThirst();
            }
            else if(!GlobalFunc.CloseToNumber(this.fThirstPercent,_loc4_,this.PercentChangeVal) || _loc4_ > this.fThirstPercent)
            {
               this.endThirstHideTimeout();
               this.fadeInThirst();
               this.ThirstTimeout = setTimeout(this.fadeOutThirst,FADE_DELAY);
            }
            this.fThirstPercent = _loc4_;
            _loc4_ = GlobalFunc.Clamp(_loc4_,0,this.PercentMax) / this.PercentMax;
            _loc9_ = Math.ceil(_loc4_ * this.HUDThirstMeter_mc.Meter_mc.totalFrames);
            this.HUDThirstMeter_mc.Meter_mc.gotoAndStop(_loc9_);
            this.HUDThirstMeter_mc.survivalMeterIcon_mc.gotoAndStop("thirstPositive");
            if(_loc2_.thirst_RestorePct is Number && _loc2_.thirst_RestorePct > 0)
            {
               _loc10_ = GlobalFunc.Clamp(this.fThirstPercent + _loc2_.thirst_RestorePct,0,this.PercentMax) / this.PercentMax;
               _loc11_ = Math.ceil(_loc10_ * this.HUDThirstMeter_mc.GhostMeter_mc.totalFrames);
               this.HUDThirstMeter_mc.GhostMeter_mc.gotoAndStop(_loc11_);
               this.HUDThirstMeter_mc.GhostMeter_mc.visible = true;
            }
            else
            {
               this.HUDThirstMeter_mc.GhostMeter_mc.visible = false;
            }
         }
         else if(this.bShowThirst)
         {
            this.setThirstOff();
         }
         if(this.bFeralVisible)
         {
            this.fadeInFeral();
            this.fFeralPercent = _loc5_;
            if((_loc5_ = GlobalFunc.Clamp(_loc5_,0,this.PercentMax) / this.PercentMax) == 0 && (this.FeralMeter_mc.FeralMeterInternal_mc.currentLabel != "empty" && this.FeralMeter_mc.FeralMeterInternal_mc.currentLabel != "emptyAnim"))
            {
               this.FeralMeter_mc.FeralMeterInternal_mc.gotoAndPlay("emptyAnim");
            }
            else if(_loc5_ != 0)
            {
               this.FeralMeter_mc.FeralMeterInternal_mc.gotoAndStop((1 - _loc5_) * 100);
            }
         }
         else if(this.bShowFeral)
         {
            this.setFeralOff();
         }
         if(Boolean(_loc2_.overheatWeaponEquipped) && !_loc2_.currentWeaponSheathed)
         {
            this.OverheatMeter_mc.visible = true;
            this.SetOverheatMeterPercent(_loc2_.overheatPercent);
         }
         else
         {
            this.OverheatMeter_mc.visible = false;
         }
      }
      
      public function fadeInHunger() : void
      {
         if(!this.bShowHunger)
         {
            this.bShowHunger = true;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutHunger() : void
      {
         if(this.bShowHunger && !this.bIsPip)
         {
            this.HungerTimeout = -1;
            this.bShowHunger = false;
            this.HUDHungerMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      public function setHungerOff() : *
      {
         if(this.bShowHunger && !this.bIsPip)
         {
            this.HungerTimeout = -1;
            this.bShowHunger = false;
            this.HUDHungerMeter_mc.gotoAndStop("off");
         }
      }
      
      private function endHungerHideTimeout() : void
      {
         if(this.HungerTimeout != -1)
         {
            clearTimeout(this.HungerTimeout);
            this.HungerTimeout = -1;
         }
      }
      
      public function fadeInThirst() : void
      {
         if(!this.bShowThirst)
         {
            this.bShowThirst = true;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutThirst() : void
      {
         if(this.bShowThirst && !this.bIsPip)
         {
            this.ThirstTimeout = -1;
            this.bShowThirst = false;
            this.HUDThirstMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      public function setThirstOff() : *
      {
         if(this.bShowThirst && !this.bIsPip)
         {
            this.ThirstTimeout = -1;
            this.bShowThirst = false;
            this.HUDThirstMeter_mc.gotoAndStop("off");
         }
      }
      
      private function endThirstHideTimeout() : void
      {
         if(this.ThirstTimeout != -1)
         {
            clearTimeout(this.ThirstTimeout);
            this.ThirstTimeout = -1;
         }
      }
      
      public function fadeInFeral() : void
      {
         if(!this.bShowFeral)
         {
            this.bShowFeral = true;
            this.FeralMeter_mc.gotoAndPlay("rollOn");
         }
      }
      
      public function fadeOutFeral() : void
      {
         if(this.bShowFeral && !this.bIsPip)
         {
            this.bShowFeral = false;
            this.FeralMeter_mc.gotoAndPlay("rollOff");
         }
      }
      
      public function setFeralOff() : *
      {
         if(this.bShowFeral && !this.bIsPip)
         {
            this.bShowFeral = false;
            this.FeralMeter_mc.gotoAndStop("off");
         }
      }
      
      public function SetOverheatMeterPercent(param1:Number) : *
      {
         this.OverheatMeter_mc.MeterBar_mc.Percent = param1;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

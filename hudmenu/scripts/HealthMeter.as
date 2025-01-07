package
{
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class HealthMeter extends BSUIComponent
   {
      
      private static const ICON_OFFSET:* = 115;
       
      
      public var MeterBar_mc:MovieClip;
      
      public var MeterBarEnemy_mc:MovieClip;
      
      public var MeterBarFriendly_mc:MovieClip;
      
      public var MeterFrame_mc:MovieClip;
      
      public var Optional_mc:MovieClip;
      
      public var DisplayText_mc:MovieClip;
      
      public var LegendaryIcon_mc:MovieClip;
      
      public var RadsBar_mc:MovieClip;
      
      public var EncounterMeterIcon_mc:MovieClip;
      
      public var CampRepairIcon_mc:MovieClip;
      
      public var LevelText_mc:MovieClip;
      
      public var SkullIcon_mc:MovieClip;
      
      public var OwnerInfo_mc:MovieClip;
      
      public var DoTIconsManager_mc:DoTIconsManager;
      
      public var HealthBarFrame_mc:MovieClip;
      
      public var BossIcon_mc:MovieClip;
      
      private var DisplayText_tf:TextField;
      
      private var _IsHostile:Boolean = true;
      
      private var _IsFriendly:Boolean = true;
      
      private var _OwningPlayerName:String = "";
      
      private var _AvatarID:String = "";
      
      private var _IsBoss:Boolean = false;
      
      private var _IsAI:Boolean = false;
      
      private var _TargetLevel:int = 0;
      
      private var _Bounty:int = 0;
      
      private var _Wanted:Boolean = false;
      
      private var m_DoTDamage:Boolean = false;
      
      private var m_EncounterSkullIconIndex:int = 0;
      
      private var m_ShowPassiveRepairIcon:Boolean = false;
      
      private var m_PassiveRepairIconIndex:int = 0;
      
      public function HealthMeter()
      {
         super();
         Extensions.enabled = true;
         if(this.OwnerInfo_mc)
         {
            TextFieldEx.setTextAutoSize(this.OwnerInfo_mc.Name_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.OwnerInfo_mc.AccountIcon_mc.clipWidth = this.OwnerInfo_mc.AccountIcon_mc.width * (1 / this.OwnerInfo_mc.AccountIcon_mc.scaleX);
            this.OwnerInfo_mc.AccountIcon_mc.clipHeight = this.OwnerInfo_mc.AccountIcon_mc.height * (1 / this.OwnerInfo_mc.AccountIcon_mc.scaleY);
         }
         if(Boolean(this.LevelText_mc) && Boolean(this.LevelText_mc.LevelText_tf))
         {
            TextFieldEx.setTextAutoSize(this.LevelText_mc.LevelText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
         if(Boolean(this.DisplayText_mc) && Boolean(this.DisplayText_mc.DisplayText_tf))
         {
            TextFieldEx.setTextAutoSize(this.DisplayText_mc.DisplayText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         }
         if(this.DoTIconsManager_mc)
         {
            this.DoTIconsManager_mc.alignment = DoTIconsManager.ALIGNMENT_CENTER;
            this.DoTIconsManager_mc.SetStealthMeterAwareness(true);
            addEventListener(DoTIconsManager.EVENT_DOT_COMPLETE,this.onDamageComplete);
         }
         if(this.CampRepairIcon_mc)
         {
            this.CampRepairIcon_mc.alpha = 1;
         }
      }
      
      public function set IsHostile(param1:Boolean) : *
      {
         if(this._IsHostile != param1)
         {
            this._IsHostile = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsFriendly(param1:Boolean) : *
      {
         if(this._IsFriendly != param1)
         {
            this._IsFriendly = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set OwningPlayerName(param1:String) : void
      {
         if(param1 != this._OwningPlayerName)
         {
            this._OwningPlayerName = param1;
            SetIsDirty();
         }
      }
      
      public function set AvatarID(param1:String) : void
      {
         if(param1 != this._AvatarID)
         {
            this._AvatarID = param1;
            SetIsDirty();
         }
      }
      
      public function set IsBoss(param1:Boolean) : *
      {
         if(this._IsBoss != param1)
         {
            this._IsBoss = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set IsAI(param1:Boolean) : *
      {
         if(this._IsAI != param1)
         {
            this._IsAI = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set TargetLevel(param1:int) : *
      {
         if(this._TargetLevel != param1)
         {
            this._TargetLevel = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Bounty(param1:int) : *
      {
         if(this._Bounty != param1)
         {
            this._Bounty = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set Wanted(param1:Boolean) : *
      {
         if(this._Wanted != param1)
         {
            this._Wanted = param1;
            this.UpdateBarFlag();
            SetIsDirty();
         }
      }
      
      public function set DoTDamage(param1:Boolean) : *
      {
         if(this.m_DoTDamage != param1)
         {
            this.m_DoTDamage = param1;
            this.UpdateBarFlag();
            this.DoTIconsManager_mc.reset();
            SetIsDirty();
         }
      }
      
      public function set EncounterSkullIconIndex(param1:int) : *
      {
         if(this.m_EncounterSkullIconIndex != param1)
         {
            this.AssignEncounterSkullIconIndex(param1);
            SetIsDirty();
         }
         if(!this.EncounterMeterIcon_mc.hasEventListener(Event.ENTER_FRAME))
         {
            this.EncounterMeterIcon_mc.addEventListener(Event.ENTER_FRAME,this.onSetEncounterSkullIconIndex);
         }
      }
      
      public function set DoTDamageList(param1:Array) : *
      {
         if(this.DoTIconsManager_mc)
         {
            this.DoTDamage = this.DoTIconsManager_mc.populateIcons(param1);
         }
      }
      
      public function SetStealthVisible(param1:Boolean) : void
      {
         if(this.DoTIconsManager_mc)
         {
            this.DoTIconsManager_mc.SetStealthMeterStatus(param1);
         }
      }
      
      private function onDamageComplete(param1:Event) : void
      {
         if(this.DoTIconsManager_mc)
         {
            if(!this.DoTIconsManager_mc.isActive() && this.m_DoTDamage)
            {
               this.DoTDamage = false;
            }
         }
      }
      
      private function UpdateBarFlag() : *
      {
         if(this._IsHostile || this._Wanted)
         {
            gotoAndStop("Hostile");
         }
         else
         {
            gotoAndStop(this._IsFriendly ? "Friendly" : "Nonhostile");
         }
         if(this.m_DoTDamage)
         {
            this.HealthBarFrame_mc.gotoAndPlay("StartDoTFlash");
         }
         else
         {
            this.HealthBarFrame_mc.gotoAndStop("static");
         }
         this.LevelText_mc.gotoAndStop(this._IsBoss ? "star" : "square");
         this.LevelText_mc.LevelText_tf.text = this._TargetLevel.toString();
      }
      
      public function SetMeterPercent(param1:Number) : *
      {
         this.MeterBar_mc.Percent = param1 / 100;
      }
      
      override public function redrawUIComponent() : void
      {
         if(this.OwnerInfo_mc)
         {
            if(this._OwningPlayerName.length > 0)
            {
               this.OwnerInfo_mc.visible = true;
               this.OwnerInfo_mc.Name_tf.text = this._OwningPlayerName;
               (this.OwnerInfo_mc.AccountIcon_mc as ImageFixture).LoadExternal(GlobalFunc.GetAccountIconPath(this._AvatarID),GlobalFunc.PLAYER_ICON_TEXTURE_BUFFER);
               this.OwnerInfo_mc.x = this.LevelText_mc.x - this.LevelText_mc.width - this.OwnerInfo_mc.width;
            }
            else
            {
               this.OwnerInfo_mc.visible = false;
            }
         }
      }
      
      public function SetDamageList(param1:Array) : void
      {
         if(this.DoTIconsManager_mc)
         {
            this.DoTDamage = this.DoTIconsManager_mc.populateIcons(param1);
         }
      }
      
      public function AssignEncounterSkullIconIndex(param1:uint) : void
      {
         this.m_EncounterSkullIconIndex = param1;
         if(param1 > 0)
         {
            this.EncounterMeterIcon_mc.gotoAndStop(this.GetEncounterSkullFrameLabel());
            this.EncounterMeterIcon_mc.BossIcon_mc.visible = this._IsBoss;
         }
      }
      
      private function onSetEncounterSkullIconIndex() : *
      {
         if(this.m_EncounterSkullIconIndex > 0)
         {
            this.EncounterMeterIcon_mc.visible = true;
         }
         else
         {
            this.EncounterMeterIcon_mc.visible = false;
         }
         this.EncounterMeterIcon_mc.x = this.LevelText_mc.x;
         this.EncounterMeterIcon_mc.removeEventListener(Event.ENTER_FRAME,this.onSetEncounterSkullIconIndex);
      }
      
      private function GetEncounterSkullFrameLabel() : String
      {
         switch(this.m_EncounterSkullIconIndex)
         {
            case 1:
               return "Easy";
            case 2:
               return "Medium";
            case 3:
               return "Difficult";
            default:
               return "";
         }
      }
      
      public function set ShowPassiveRepairIcon(param1:Boolean) : *
      {
         if(this.m_ShowPassiveRepairIcon != param1)
         {
            this.m_ShowPassiveRepairIcon = param1;
            SetIsDirty();
         }
         if(this.m_ShowPassiveRepairIcon)
         {
            this.PassiveRepairIconIndex = this.SkullIcon_mc.visible ? 1 : 0;
         }
         if(!this.CampRepairIcon_mc.hasEventListener(Event.ENTER_FRAME))
         {
            this.CampRepairIcon_mc.addEventListener(Event.ENTER_FRAME,this.onSetShowPassiveRepairIcon);
         }
      }
      
      private function onSetShowPassiveRepairIcon() : *
      {
         this.CampRepairIcon_mc.visible = this.m_ShowPassiveRepairIcon;
         this.CampRepairIcon_mc.removeEventListener(Event.ENTER_FRAME,this.onSetShowPassiveRepairIcon);
         SetIsDirty();
      }
      
      public function set PassiveRepairIconIndex(param1:int) : *
      {
         if(this.m_PassiveRepairIconIndex != param1)
         {
            this.AssignPassiveRepairIconIndex(param1);
            SetIsDirty();
         }
      }
      
      public function AssignPassiveRepairIconIndex(param1:uint) : void
      {
         this.m_PassiveRepairIconIndex = param1;
         this.CampRepairIcon_mc.gotoAndStop(this.GetPassiveRepairFrameLabel());
      }
      
      private function GetPassiveRepairFrameLabel() : String
      {
         switch(this.m_PassiveRepairIconIndex)
         {
            case 1:
               return "ActiveSkull";
            default:
               return "default";
         }
      }
   }
}

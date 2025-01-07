package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   public class EncounterMeter extends BSUIComponent
   {
      
      private static const ICON_OFFSET:* = 115;
       
      
      public var MeterBar_mc:MeterBarWidget;
      
      public var MeterBarNonhostile_mc:MeterBarWidget;
      
      public var MeterFrame_mc:MovieClip;
      
      public var DisplayText_mc:MovieClip;
      
      public var DoTIconsManager_mc:DoTIconsManager;
      
      public var EncounterMeterIcon_mc:MovieClip;
      
      private var DisplayText_tf:TextField;
      
      private var m_IconIndex:uint = 0;
      
      private var m_DoTDamage:Boolean = false;
      
      private var m_Hostile:Boolean = true;
      
      private var m_ActiveMeter:MeterBarWidget;
      
      public function EncounterMeter()
      {
         super();
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.DisplayText_mc.DisplayText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.DoTIconsManager_mc.alignment = DoTIconsManager.ALIGNMENT_RIGHT;
         visible = false;
         this.m_ActiveMeter = this.MeterBar_mc;
         if(this.DisplayText_mc)
         {
            this.DisplayText_tf = this.DisplayText_mc.DisplayText_tf as TextField;
         }
      }
      
      public function SetMeterPercent(param1:Number) : *
      {
         if(param1 >= 0)
         {
            this.m_ActiveMeter.Percent = param1;
            visible = true;
         }
         else
         {
            this.m_ActiveMeter.Percent = -1;
            visible = false;
         }
      }
      
      public function SetMeterName(param1:String) : *
      {
         this.DisplayText_mc.DisplayText_tf.text = param1.toUpperCase();
      }
      
      public function ResetDamageList() : void
      {
         if(this.m_DoTDamage)
         {
            if(Boolean(this.DoTIconsManager_mc) && this.DoTIconsManager_mc.isActive())
            {
               this.DoTIconsManager_mc.reset();
            }
         }
      }
      
      public function SetDamageList(param1:Array) : void
      {
         if(this.DoTIconsManager_mc)
         {
            this.DoTIconsManager_mc.populateIcons(param1);
         }
      }
      
      public function SetSkullIcon(param1:uint) : void
      {
         this.m_IconIndex = param1;
         if(param1 > 0)
         {
            this.EncounterMeterIcon_mc.visible = true;
            this.EncounterMeterIcon_mc.gotoAndStop(this.GetSkullFrameLabel());
            addEventListener(Event.ENTER_FRAME,this.onSetIconPosition);
         }
         else
         {
            this.EncounterMeterIcon_mc.visible = false;
         }
      }
      
      private function onSetIconPosition() : *
      {
         var _loc1_:Point = this.DisplayText_tf.localToGlobal(new Point(this.DisplayText_tf.getLineMetrics(0).x,0));
         this.EncounterMeterIcon_mc.x = this.globalToLocal(_loc1_).x + ICON_OFFSET - this.EncounterMeterIcon_mc.width * 0.5;
         removeEventListener(Event.ENTER_FRAME,this.onSetIconPosition);
      }
      
      private function GetSkullFrameLabel() : String
      {
         switch(this.m_IconIndex)
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
      
      public function SetMeterHostile(param1:Boolean) : *
      {
         if(param1 != this.m_Hostile)
         {
            this.m_Hostile = param1;
            gotoAndStop(param1 ? "Hostile" : "Nonhostile");
            this.m_ActiveMeter = this.m_Hostile ? this.MeterBar_mc : this.MeterBarNonhostile_mc;
         }
      }
   }
}

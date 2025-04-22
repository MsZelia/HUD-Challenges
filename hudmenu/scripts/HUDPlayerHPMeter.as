package
{
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1621")]
   public class HUDPlayerHPMeter extends HealthMeter
   {
      
      private static const EVENT_GLOW_ROLLON_COMPLETE:String = "GlowRollOnComplete";
      
      private static const EVENT_GLOW_ROLLOFF_COMPLETE:String = "GlowRollOffComplete";
      
      private static const MIN_METER_X:Number = 0;
      
      private static const METER_X_DIFFERENCE:Number = 312;
      
      private static const ANIM_TIME:Number = 150;
       
      
      public var GlowMeter_mc:MovieClip;
      
      private var m_GlowMeterPercent:Number = 0;
      
      private var m_MeterTween:Tween;
      
      public function HUDPlayerHPMeter()
      {
         super();
         this.GlowMeter_mc.visible = false;
         this.__setProp_Optional_mc_HPMeter_Optional_mc_0();
         this.__setProp_RadsBar_mc_HPMeter_RadsBar_mc_0();
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         addEventListener(EVENT_GLOW_ROLLOFF_COMPLETE,this.onGlowRollOffComplete);
      }
      
      public function updateGlowMeter(param1:Number) : void
      {
         if(!this.GlowMeter_mc.visible && param1 == 0)
         {
            return;
         }
         this.m_GlowMeterPercent = Math.max(0,param1);
         if(!this.GlowMeter_mc.visible)
         {
            this.GlowMeter_mc.visible = true;
            this.GlowMeter_mc.Glow_mc.gotoAndPlay("rollOn");
            this.m_MeterTween = new Tween(this.GlowMeter_mc.Meter_mc.Fill_mc,"x",None.easeNone,MIN_METER_X,MIN_METER_X + METER_X_DIFFERENCE * this.m_GlowMeterPercent,ANIM_TIME / 1000,true);
         }
         else if(param1 == 0)
         {
            this.m_MeterTween = new Tween(this.GlowMeter_mc.Meter_mc.Fill_mc,"x",None.easeNone,this.GlowMeter_mc.Meter_mc.Fill_mc.x,MIN_METER_X,ANIM_TIME / 1000,true);
            this.m_MeterTween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
         }
         else if(this.m_MeterTween)
         {
            this.m_MeterTween.continueTo(MIN_METER_X + METER_X_DIFFERENCE * this.m_GlowMeterPercent,ANIM_TIME / 1000);
         }
         else
         {
            this.m_MeterTween = new Tween(this.GlowMeter_mc.Meter_mc.Fill_mc,"x",None.easeNone,this.GlowMeter_mc.Meter_mc.Fill_mc.x,MIN_METER_X + METER_X_DIFFERENCE * this.m_GlowMeterPercent,ANIM_TIME / 1000,true);
         }
      }
      
      private function onGlowRollOffComplete(param1:Event) : void
      {
         this.GlowMeter_mc.visible = false;
      }
      
      private function onTweenFinish(param1:TweenEvent) : *
      {
         this.m_MeterTween.removeEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
         this.GlowMeter_mc.Glow_mc.gotoAndPlay("rollOff");
      }
      
      internal function __setProp_Optional_mc_HPMeter_Optional_mc_0() : *
      {
         try
         {
            Optional_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         Optional_mc.BarAlpha = 0.5;
         Optional_mc.bracketCornerLength = 6;
         Optional_mc.bracketLineWidth = 1.5;
         Optional_mc.bracketPaddingX = 0;
         Optional_mc.bracketPaddingY = 0;
         Optional_mc.BracketStyle = "horizontal";
         Optional_mc.bShowBrackets = false;
         Optional_mc.bUseShadedBackground = false;
         Optional_mc.Justification = "left";
         Optional_mc.Percent = 0;
         Optional_mc.ShadedBackgroundMethod = "Shader";
         Optional_mc.ShadedBackgroundType = "normal";
         try
         {
            Optional_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_RadsBar_mc_HPMeter_RadsBar_mc_0() : *
      {
         try
         {
            RadsBar_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         RadsBar_mc.BarAlpha = 1;
         RadsBar_mc.bracketCornerLength = 6;
         RadsBar_mc.bracketLineWidth = 1.5;
         RadsBar_mc.bracketPaddingX = 0;
         RadsBar_mc.bracketPaddingY = 0;
         RadsBar_mc.BracketStyle = "horizontal";
         RadsBar_mc.bShowBrackets = false;
         RadsBar_mc.bUseShadedBackground = false;
         RadsBar_mc.Justification = "right";
         RadsBar_mc.Percent = 1;
         RadsBar_mc.ShadedBackgroundMethod = "Flash";
         RadsBar_mc.ShadedBackgroundType = "normal";
         try
         {
            RadsBar_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

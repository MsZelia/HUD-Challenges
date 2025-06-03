package HUDMenu_fla
{
   import adobe.utils.*;
   import flash.accessibility.*;
   import flash.desktop.*;
   import flash.display.*;
   import flash.errors.*;
   import flash.events.*;
   import flash.external.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.globalization.*;
   import flash.media.*;
   import flash.net.*;
   import flash.net.drm.*;
   import flash.printing.*;
   import flash.profiler.*;
   import flash.sampler.*;
   import flash.sensors.*;
   import flash.system.*;
   import flash.text.*;
   import flash.text.engine.*;
   import flash.text.ime.*;
   import flash.ui.*;
   import flash.utils.*;
   import flash.xml.*;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol225")]
   public dynamic class HUDReputationMeterInternal_720 extends MovieClip
   {
       
      
      public var FactionIcon_mc:MovieClip;
      
      public var Header_mc:MovieClip;
      
      public var LeftStatusIcon_mc:MovieClip;
      
      public var LeftStatusText_mc:MovieClip;
      
      public var Meter_mc:MovieClip;
      
      public var RightStatusIcon_mc:MovieClip;
      
      public var RightStatusText_mc:MovieClip;
      
      public var UpwardIndicator_mc:MovieClip;
      
      public function HUDReputationMeterInternal_720()
      {
         super();
         this.__setProp_Meter_mc_HUDReputationMeterInternal_Meter_mc_0();
      }
      
      internal function __setProp_Meter_mc_HUDReputationMeterInternal_Meter_mc_0() : *
      {
         try
         {
            this.Meter_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Meter_mc.BarAlpha = 0.5;
         this.Meter_mc.bracketCornerLength = 6;
         this.Meter_mc.bracketLineWidth = 1.5;
         this.Meter_mc.bracketPaddingX = 0;
         this.Meter_mc.bracketPaddingY = 0;
         this.Meter_mc.BracketStyle = "horizontal";
         this.Meter_mc.bShowBrackets = false;
         this.Meter_mc.bUseShadedBackground = false;
         this.Meter_mc.Justification = "left";
         this.Meter_mc.Percent = 0;
         this.Meter_mc.ShadedBackgroundMethod = "Shader";
         this.Meter_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Meter_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

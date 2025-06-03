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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1654")]
   public dynamic class OverheatMeter_66 extends MovieClip
   {
       
      
      public var APBarFrame_mc:MovieClip;
      
      public var ActionPointSegments_mc:MovieClip;
      
      public var MeterBar_mc:MeterBar;
      
      public var Optional_mc:RadsBar;
      
      public var OverheatIcon_mc:OverheatIcon;
      
      public function OverheatMeter_66()
      {
         super();
         this.__setProp_Optional_mc_OverheatMeter_Optional_mc_0();
         this.__setProp_MeterBar_mc_OverheatMeter_MeterBar_mc_0();
      }
      
      internal function __setProp_Optional_mc_OverheatMeter_Optional_mc_0() : *
      {
         try
         {
            this.Optional_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.Optional_mc.BarAlpha = 1;
         this.Optional_mc.bracketCornerLength = 6;
         this.Optional_mc.bracketLineWidth = 1.5;
         this.Optional_mc.bracketPaddingX = 0;
         this.Optional_mc.bracketPaddingY = 0;
         this.Optional_mc.BracketStyle = "horizontal";
         this.Optional_mc.bShowBrackets = false;
         this.Optional_mc.bUseShadedBackground = false;
         this.Optional_mc.Justification = "left";
         this.Optional_mc.Percent = 0;
         this.Optional_mc.ShadedBackgroundMethod = "Shader";
         this.Optional_mc.ShadedBackgroundType = "normal";
         try
         {
            this.Optional_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
      
      internal function __setProp_MeterBar_mc_OverheatMeter_MeterBar_mc_0() : *
      {
         try
         {
            this.MeterBar_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.MeterBar_mc.BarAlpha = 1;
         this.MeterBar_mc.bracketCornerLength = 6;
         this.MeterBar_mc.bracketLineWidth = 1.5;
         this.MeterBar_mc.bracketPaddingX = 0;
         this.MeterBar_mc.bracketPaddingY = 0;
         this.MeterBar_mc.BracketStyle = "horizontal";
         this.MeterBar_mc.bShowBrackets = false;
         this.MeterBar_mc.bUseShadedBackground = false;
         this.MeterBar_mc.Justification = "right";
         this.MeterBar_mc.Percent = 1;
         this.MeterBar_mc.ShadedBackgroundMethod = "Shader";
         this.MeterBar_mc.ShadedBackgroundType = "normal";
         try
         {
            this.MeterBar_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

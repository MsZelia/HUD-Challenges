package
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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1626")]
   public dynamic class HUDPlayerHPMeter extends HealthMeter
   {
       
      
      public function HUDPlayerHPMeter()
      {
         super();
         this.__setProp_Optional_mc_HPMeter_Optional_mc_0();
         this.__setProp_RadsBar_mc_HPMeter_RadsBar_mc_0();
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

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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1813")]
   public dynamic class BottomCenterGroup_110 extends MovieClip
   {
       
      
      public var CompassWidget_mc:HUDCompassWidget;
      
      public var CritMeter_mc:CritMeter;
      
      public var EncounterHealthMeterContainer_mc:EncounterHealthMeterContainer;
      
      public var PerkVaultBoy_mc:PerkVaultBoy;
      
      public var SubtitleText_mc:Subtitles;
      
      public function BottomCenterGroup_110()
      {
         super();
         this.__setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0();
      }
      
      internal function __setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0() : *
      {
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.PerkVaultBoy_mc.bPlayClipOnce = true;
         this.PerkVaultBoy_mc.bracketCornerLength = 6;
         this.PerkVaultBoy_mc.bracketLineWidth = 1.5;
         this.PerkVaultBoy_mc.bracketPaddingX = 0;
         this.PerkVaultBoy_mc.bracketPaddingY = 0;
         this.PerkVaultBoy_mc.BracketStyle = "horizontal";
         this.PerkVaultBoy_mc.bShowBrackets = false;
         this.PerkVaultBoy_mc.bUseFixedQuestStageSize = false;
         this.PerkVaultBoy_mc.bUseShadedBackground = false;
         this.PerkVaultBoy_mc.ClipAlignment = "Center";
         this.PerkVaultBoy_mc.DefaultBoySwfName = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
         this.PerkVaultBoy_mc.maxClipHeight = 128;
         this.PerkVaultBoy_mc.questAnimStageHeight = 400;
         this.PerkVaultBoy_mc.questAnimStageWidth = 550;
         this.PerkVaultBoy_mc.ShadedBackgroundMethod = "Shader";
         this.PerkVaultBoy_mc.ShadedBackgroundType = "normal";
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

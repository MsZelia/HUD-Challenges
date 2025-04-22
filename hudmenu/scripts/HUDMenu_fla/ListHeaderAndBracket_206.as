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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1518")]
   public dynamic class ListHeaderAndBracket_206 extends MovieClip
   {
       
      
      public var BracketPairHolder_mc:BracketPairFadeHolder;
      
      public var ContainerName_mc:MovieClip;
      
      public function ListHeaderAndBracket_206()
      {
         super();
         this.__setProp_BracketPairHolder_mc_ListHeaderAndBracket_BracketPairHolder_mc_0();
      }
      
      internal function __setProp_BracketPairHolder_mc_ListHeaderAndBracket_BracketPairHolder_mc_0() : *
      {
         try
         {
            this.BracketPairHolder_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.BracketPairHolder_mc.bracketCornerLength = 6;
         this.BracketPairHolder_mc.bracketLineWidth = 1.5;
         this.BracketPairHolder_mc.bracketPaddingX = 0;
         this.BracketPairHolder_mc.bracketPaddingY = 0;
         this.BracketPairHolder_mc.BracketStyle = "horizontal";
         this.BracketPairHolder_mc.bShowBrackets = false;
         this.BracketPairHolder_mc.bUseShadedBackground = true;
         this.BracketPairHolder_mc.ShadedBackgroundMethod = "Shader";
         this.BracketPairHolder_mc.ShadedBackgroundType = "normal";
         try
         {
            this.BracketPairHolder_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

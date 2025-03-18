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
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1561")]
   public dynamic class EncounterMeterBarInternal_136 extends MovieClip
   {
       
      
      public var Contents:MovieClip;
      
      public function EncounterMeterBarInternal_136()
      {
         super();
         addFrameScript(0,this.frame1,5,this.frame6,10,this.frame11,15,this.frame16,20,this.frame21,25,this.frame26,30,this.frame31,35,this.frame36,39,this.frame40);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
      
      internal function frame11() : *
      {
         this["onBarFlashedDark"]();
      }
      
      internal function frame16() : *
      {
         this["onBarFlashedBright"]();
      }
      
      internal function frame21() : *
      {
         this["onBarFlashedDark"]();
      }
      
      internal function frame26() : *
      {
         this["onBarFlashedBright"]();
      }
      
      internal function frame31() : *
      {
         this["onBarFlashedDark"]();
      }
      
      internal function frame36() : *
      {
         this["onBarFlashedBright"]();
      }
      
      internal function frame40() : *
      {
         this["onBarFlashingDone"]();
      }
   }
}

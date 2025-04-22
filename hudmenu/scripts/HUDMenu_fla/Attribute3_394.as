package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol893")]
   public dynamic class Attribute3_394 extends MovieClip
   {
       
      
      public var LegendaryStar01_mc:MovieClip;
      
      public var LegendaryStar02_mc:MovieClip;
      
      public var LegendaryStar03_mc:MovieClip;
      
      public var LegendaryStar04_mc:MovieClip;
      
      public var Name_mc:MovieClip;
      
      public function Attribute3_394()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,63,this.frame64);
      }
      
      internal function frame1() : *
      {
         stop();
         this.LegendaryStar01_mc.gotoAndStop("off");
         this.LegendaryStar02_mc.gotoAndStop("off");
         this.LegendaryStar03_mc.gotoAndStop("off");
      }
      
      internal function frame2() : *
      {
         this.LegendaryStar01_mc.gotoAndPlay("rollOn");
         this.LegendaryStar02_mc.gotoAndPlay("rollOn");
         this.LegendaryStar03_mc.gotoAndPlay("rollOn");
      }
      
      internal function frame64() : *
      {
         stop();
      }
   }
}

package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol718")]
   public dynamic class XPMeterBar extends MeterBarWidget
   {
       
      
      public function XPMeterBar()
      {
         super();
         addFrameScript(0,this.frame1,15,this.frame16);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         gotoAndPlay("Flashing");
      }
   }
}

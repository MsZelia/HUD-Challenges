package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1525")]
   public dynamic class CritMeterBar extends MeterBarWidget
   {
       
      
      public function CritMeterBar()
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

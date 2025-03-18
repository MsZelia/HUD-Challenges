package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol930")]
   public dynamic class MeterBarFriendly extends MeterBarWidget
   {
       
      
      public function MeterBarFriendly()
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

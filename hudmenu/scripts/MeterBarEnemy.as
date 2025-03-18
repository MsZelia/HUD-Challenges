package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol926")]
   public dynamic class MeterBarEnemy extends MeterBarWidget
   {
       
      
      public function MeterBarEnemy()
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

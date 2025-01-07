package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol16")]
   public dynamic class MeterBar extends MeterBarWidget
   {
       
      
      public function MeterBar()
      {
         super();
         addFrameScript(0,this.frame1);
      }
      
      internal function frame1() : *
      {
         stop();
      }
   }
}

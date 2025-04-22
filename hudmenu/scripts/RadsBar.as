package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1610")]
   public dynamic class RadsBar extends MeterBarWidget
   {
       
      
      public function RadsBar()
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

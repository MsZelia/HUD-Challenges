package
{
   [Embed(source="/_assets/assets.swf", symbol="symbol1566")]
   public dynamic class EncounterHealthMeter extends EncounterMeter
   {
       
      
      public function EncounterHealthMeter()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4);
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
   }
}

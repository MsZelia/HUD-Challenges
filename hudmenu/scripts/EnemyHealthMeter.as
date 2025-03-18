package
{
   import flash.geom.ColorTransform;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol985")]
   public dynamic class EnemyHealthMeter extends HealthMeter
   {
       
      
      public function EnemyHealthMeter()
      {
         super();
         addFrameScript(0,this.frame1,3,this.frame4,8,this.frame9);
      }
      
      internal function frame1() : *
      {
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.96,0.46,0.46,1,0,0,0,0);
      }
      
      internal function frame4() : *
      {
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(1,1,1,1,0,0,0,0);
      }
      
      internal function frame9() : *
      {
         stop();
         this.LevelText_mc.transform.colorTransform = new ColorTransform(0.97,0.8,0.46,1,0,0,0,0);
      }
   }
}

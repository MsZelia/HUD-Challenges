package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol569")]
   public dynamic class DirectionalHitIndicator extends MovieClip
   {
       
      
      public var Arc_mc:MovieClip;
      
      public function DirectionalHitIndicator()
      {
         super();
         addFrameScript(1,this.frame2,3,this.frame4);
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame4() : *
      {
         stop();
      }
   }
}

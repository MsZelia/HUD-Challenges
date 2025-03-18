package
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol597")]
   public dynamic class ActiveEffectsTextPopup extends MovieClip
   {
       
      
      public var AETPAnimHolder_mc:MovieClip;
      
      public function ActiveEffectsTextPopup()
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

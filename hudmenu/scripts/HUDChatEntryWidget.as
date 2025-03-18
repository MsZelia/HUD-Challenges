package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol917")]
   public dynamic class HUDChatEntryWidget extends BSUIComponent
   {
       
      
      public var ChatEntryText_tf:TextField;
      
      public function HUDChatEntryWidget()
      {
         super();
      }
      
      override public function redrawUIComponent() : void
      {
      }
   }
}

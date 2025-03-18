package
{
   import Shared.AS3.BSUIComponent;
   import flash.text.TextField;
   import flash.utils.setTimeout;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol915")]
   public dynamic class HUDChatWidget extends BSUIComponent
   {
       
      
      public var ChatText_tf:TextField;
      
      public var ChatMessageArray:Array;
      
      private var DefaultOnscreenTime:Number = 10000;
      
      public function HUDChatWidget()
      {
         super();
         this.ChatMessageArray = new Array();
      }
      
      override public function redrawUIComponent() : void
      {
      }
      
      public function updateChat() : *
      {
         this.ChatText_tf.text = "";
         var _loc1_:Number = 0;
         while(_loc1_ < this.ChatMessageArray.length)
         {
            this.ChatText_tf.appendText(this.ChatMessageArray[_loc1_]);
            _loc1_++;
         }
         this.ChatText_tf.setSelection(this.ChatText_tf.length,this.ChatText_tf.length);
      }
      
      public function removeChatMessage() : *
      {
         this.ChatMessageArray.shift();
         this.updateChat();
      }
      
      public function addChatMessage(param1:String, param2:String = "") : *
      {
         var _loc3_:* = new String();
         setTimeout(this.removeChatMessage,this.DefaultOnscreenTime);
         _loc3_ = param2 + ": " + param1 + "\n";
         this.ChatMessageArray.push(_loc3_);
         this.updateChat();
      }
   }
}

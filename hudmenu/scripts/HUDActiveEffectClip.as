package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol443")]
   public class HUDActiveEffectClip extends BSUIComponent
   {
      
      private static const DEFAULT_STACK_WIDTH:Number = 19;
      
      private static const STACK_WITH_PADDING:Number = 12;
      
      private static const STACK_SHADOW_AMOUNT:Number = 1;
       
      
      public var Icon_mc:MovieClip;
      
      public var Stack_mc:MovieClip;
      
      private var m_IconFrame:String;
      
      private const COLOR_GREEN:uint = 0;
      
      private const COLOR_RED:uint = 1;
      
      private var m_IconColor:uint = 0;
      
      private var m_IconID:String = "";
      
      private var m_StackAmount:uint = 0;
      
      public function HUDActiveEffectClip()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
      }
      
      public function set iconID(param1:String) : void
      {
         this.m_IconID = param1;
      }
      
      public function set IconFrame(param1:String) : void
      {
         if(this.m_IconFrame != param1)
         {
            this.m_IconFrame = param1;
            SetIsDirty();
         }
      }
      
      public function set IconColor(param1:uint) : *
      {
         var _loc2_:* = param1 == this.COLOR_GREEN ? this.COLOR_GREEN : this.COLOR_RED;
         if(this.m_IconColor != _loc2_)
         {
            this.m_IconColor = _loc2_;
            SetIsDirty();
         }
      }
      
      public function set StackAmount(param1:uint) : void
      {
         if(this.m_StackAmount != param1)
         {
            this.m_StackAmount = param1;
            SetIsDirty();
         }
      }
      
      public function get StackAmount() : uint
      {
         return this.m_StackAmount;
      }
      
      override public function redrawUIComponent() : void
      {
         if(this.m_IconColor == this.COLOR_RED)
         {
            gotoAndStop("negative");
         }
         else
         {
            gotoAndStop("positive");
         }
         this.Icon_mc.gotoAndStop(this.m_IconFrame);
         this.Stack_mc.visible = false;
         if(this.m_StackAmount != 0)
         {
            this.Stack_mc.StackAmount_tf.text = this.m_StackAmount.toString();
            this.Stack_mc.BG_mc.width = DEFAULT_STACK_WIDTH + (this.Stack_mc.StackAmount_tf.text.length - 1) * STACK_WITH_PADDING;
            this.Stack_mc.StackAmount_tf.width = this.Stack_mc.BG_mc.width - STACK_SHADOW_AMOUNT * 2;
            this.Stack_mc.StackAmount_tf.x = this.Stack_mc.BG_mc.x + STACK_SHADOW_AMOUNT;
            this.Stack_mc.visible = true;
         }
         visible = this.m_IconFrame != null && this.m_IconFrame.length > 0;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

package
{
   import Shared.GlobalFunc;
   import fl.transitions.Tween;
   import fl.transitions.TweenEvent;
   import fl.transitions.easing.*;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol552")]
   public class DoTDamageIcon extends MovieClip
   {
      
      public static const EVENT_DAMAGE_COMPLETE:String = "DoTIcon::DamageComplete";
      
      private static const EVENT_ROLL_ON_COMPLETE:String = "DoTDamageIcon::RollOnComplete";
       
      
      public var IconInternal_mc:MovieClip;
      
      private var BGAnim_mc:MovieClip;
      
      private const TWEEN_END_Y:Number = 0;
      
      private var m_DefaultFillY:Number = -26;
      
      private var m_FillTween:Tween = null;
      
      private var m_RemainingDuration:uint = 0;
      
      private var m_TotalDuration:uint = 0;
      
      private var m_StartingY:Number = 0;
      
      private var m_TweenProgress:Number = 0;
      
      public function DoTDamageIcon()
      {
         super();
         addFrameScript(0,this.frame1,7,this.frame8);
         this.BGAnim_mc = this.IconInternal_mc.BGAnim_mc;
         this.m_DefaultFillY = this.BGAnim_mc.FillInternal_mc.Fill_mc.y;
         addEventListener(EVENT_ROLL_ON_COMPLETE,this.onRollOnComplete);
      }
      
      public function get remainingDuration() : Number
      {
         return this.m_TweenProgress;
      }
      
      public function setType(param1:uint, param2:Boolean, param3:uint, param4:uint) : *
      {
         this.m_RemainingDuration = param3;
         this.m_TotalDuration = param4;
         this.IconInternal_mc.gotoAndStop(GlobalFunc.NUM_DAMAGE_TYPES + param1);
         if(this.m_RemainingDuration != this.m_TotalDuration)
         {
            this.BGAnim_mc.gotoAndStop(param2 ? "positiveOn" : "negativeOn");
            this.m_StartingY = this.m_DefaultFillY + (1 - this.m_RemainingDuration / this.m_TotalDuration) * (this.TWEEN_END_Y - this.m_DefaultFillY);
            this.BGAnim_mc.FillInternal_mc.Fill_mc.y = this.m_StartingY;
            gotoAndPlay("rollOn");
         }
         else
         {
            this.m_StartingY = this.m_DefaultFillY;
            gotoAndPlay("rollOn");
            this.BGAnim_mc.gotoAndPlay(param2 ? "positive" : "negative");
            this.clearTween();
         }
         this.m_TweenProgress = this.m_RemainingDuration;
      }
      
      private function clearTween() : void
      {
         this.m_TweenProgress = 0;
         if(this.m_FillTween != null)
         {
            this.m_FillTween.removeEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish);
            this.m_FillTween.removeEventListener(TweenEvent.MOTION_CHANGE,this.onTweenChange);
            this.m_FillTween.stop();
            this.m_FillTween = null;
            this.BGAnim_mc.FillInternal_mc.Fill_mc.y = this.m_DefaultFillY;
         }
      }
      
      private function onTweenChange(param1:TweenEvent) : void
      {
         this.m_TweenProgress = this.m_RemainingDuration - param1.time * 1000;
      }
      
      private function onTweenFinish() : void
      {
         this.m_TweenProgress = 0;
         dispatchEvent(new Event(EVENT_DAMAGE_COMPLETE,true,true));
      }
      
      private function onRollOnComplete(param1:Event) : void
      {
         this.m_FillTween = new Tween(this.BGAnim_mc.FillInternal_mc.Fill_mc,"y",None.easeIn,this.m_StartingY,this.TWEEN_END_Y,this.m_RemainingDuration / 1000,true);
         this.m_FillTween.addEventListener(TweenEvent.MOTION_FINISH,this.onTweenFinish,false,0,true);
         this.m_FillTween.addEventListener(TweenEvent.MOTION_CHANGE,this.onTweenChange);
         this.m_FillTween.start();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame8() : *
      {
         dispatchEvent(new Event("DoTDamageIcon::RollOnComplete",true,true));
         stop();
      }
   }
}

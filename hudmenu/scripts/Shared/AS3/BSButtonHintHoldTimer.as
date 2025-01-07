package Shared.AS3
{
   public class BSButtonHintHoldTimer
   {
      
      private static const DEFAULT_HOLD_TIME:Number = 250;
       
      
      private var m_StartTime:Number;
      
      private var m_HoldTime:Number;
      
      public function BSButtonHintHoldTimer(param1:Number = 250, param2:Number = -1)
      {
         super();
         if(param2 < 0)
         {
            param2 = Number(new Date().getTime());
         }
         this.startTime = param2;
         this.holdTime = param1;
      }
      
      public function get startTime() : Number
      {
         return this.m_StartTime;
      }
      
      public function set startTime(param1:Number) : void
      {
         this.m_StartTime = param1;
      }
      
      public function get holdTime() : Number
      {
         return this.m_HoldTime;
      }
      
      public function set holdTime(param1:Number) : void
      {
         this.m_HoldTime = param1;
      }
      
      public function get percentComplete() : Number
      {
         var _loc1_:Number = Number(new Date().getTime());
         var _loc2_:* = (_loc1_ - this.startTime) / this.holdTime;
         return _loc2_ > 1 ? 1 : _loc2_;
      }
      
      public function get timeElapsed() : Number
      {
         var _loc1_:Number = Number(new Date().getTime());
         return _loc1_ - this.startTime;
      }
      
      public function resetTimer() : *
      {
         this.startTime = new Date().getTime();
      }
   }
}

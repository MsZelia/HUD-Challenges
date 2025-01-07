package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class QuestEvent extends Event
   {
      
      public static const EVENT_COMPLETE:String = "QuestComplete";
      
      public static const EVENT_AVAILABLE:String = "QuestAvailable";
      
      public static const EVENT_ACCEPTED:String = "QuestAccepted";
       
      
      private var m_Data:Object;
      
      public var pvpFlag:Boolean;
      
      public function QuestEvent(param1:String, param2:Object, param3:Boolean = false, param4:Boolean = false, param5:Boolean = false)
      {
         this.m_Data = param2;
         this.pvpFlag = param5;
         super(param1,param3,param4);
      }
      
      public function get data() : Object
      {
         return this.m_Data;
      }
      
      override public function clone() : Event
      {
         return new QuestEvent(type,this.data,bubbles,cancelable);
      }
   }
}

package
{
   public class HUDMessageItemData
   {
      
      public static const TYPE_EVENT:String = "eventBox";
      
      public static const TYPE_KILL_SINGLE:String = "kill";
      
      public static const TYPE_KILL_TEAM:String = "teamKill";
      
      public static const TYPE_UNDER_ATTACK:String = "underAttack";
      
      public static const TYPE_COMEBACK:String = "comeback";
      
      public static const TYPE_KILL_GROUP:String = "groupKill";
      
      public static const TYPE_DAILY_OPS:String = "dailyOps";
      
      public static const TYPE_MUTATED_EVENT:String = "mutatedEvent";
      
      public static const TYPE_CASINO:String = "casino";
      
      public static const TYPE_RAID:String = "raid";
       
      
      private var m_MessageID:Number;
      
      private var m_Type:String;
      
      private var m_Data:Object;
      
      private var m_Sound:String;
      
      public function HUDMessageItemData(param1:Number, param2:String, param3:Object, param4:String)
      {
         this.m_Data = new Object();
         super();
         this.messageID = param1;
         this.type = param2;
         this.data = param3;
         this.sound = param4;
      }
      
      public function set messageID(param1:Number) : void
      {
         this.m_MessageID = param1;
      }
      
      public function get messageID() : Number
      {
         return this.m_MessageID;
      }
      
      public function set type(param1:String) : void
      {
         this.m_Type = param1;
      }
      
      public function get type() : String
      {
         return this.m_Type;
      }
      
      public function set data(param1:Object) : void
      {
         var _loc2_:String = null;
         for(_loc2_ in param1)
         {
            this.m_Data[_loc2_] = param1[_loc2_];
         }
      }
      
      public function get data() : Object
      {
         return this.m_Data;
      }
      
      public function set sound(param1:String) : void
      {
         this.m_Sound = param1;
      }
      
      public function get sound() : String
      {
         return this.m_Sound;
      }
   }
}

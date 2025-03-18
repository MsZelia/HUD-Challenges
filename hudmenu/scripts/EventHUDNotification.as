package
{
   import flash.display.MovieClip;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol741")]
   public class EventHUDNotification extends MovieClip
   {
      
      public static const EVENT_STW_COMBAT_TAG:String = "[#STW_COMBAT]";
      
      public static const EVENT_STW_TWIST_TAG:String = "[#STW_TWIST]";
      
      public static const EVENT_STW_BOSS_TAG:String = "[#STW_BOSS]";
      
      public static const EVENT_STW_COMPLETE_TAG:String = "[#STW_COMPLETE]";
      
      public static const EVENT_STW_FREEBIE_TAG:String = "[#STW_FREEBIE]";
       
      
      public var EventHUDNotificationAnim_mc:MovieClip;
      
      private var STWEventType_mc:MovieClip;
      
      public function EventHUDNotification()
      {
         super();
         addFrameScript(0,this.frame1,38,this.frame39,69,this.frame70);
         this.STWEventType_mc = this.EventHUDNotificationAnim_mc.STWEventType_mc;
         TextFieldEx.setTextAutoSize(this.STWEventType_mc.ENHeaderText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.STWEventType_mc.ENDynamicText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function isEventNotification(param1:String) : Boolean
      {
         return param1.indexOf(EVENT_STW_COMBAT_TAG) != -1 || param1.indexOf(EVENT_STW_TWIST_TAG) != -1 || param1.indexOf(EVENT_STW_BOSS_TAG) != -1 || param1.indexOf(EVENT_STW_COMPLETE_TAG) != -1 || param1.indexOf(EVENT_STW_FREEBIE_TAG) != -1;
      }
      
      public function setData(param1:Object) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc6_:String = null;
         if(param1.messageText.indexOf(EVENT_STW_COMBAT_TAG) != -1)
         {
            this.STWEventType_mc.gotoAndStop("STW_Combat");
            _loc2_ = param1.messageText.replace(EVENT_STW_COMBAT_TAG,"");
            this.STWEventType_mc.ENDynamicText_tf.text = _loc2_;
         }
         else if(param1.messageText.indexOf(EVENT_STW_TWIST_TAG) != -1)
         {
            this.STWEventType_mc.gotoAndStop("STW_Twist");
            _loc3_ = param1.messageText.replace(EVENT_STW_TWIST_TAG,"");
            this.STWEventType_mc.ENDynamicText_tf.text = _loc3_;
         }
         else if(param1.messageText.indexOf(EVENT_STW_BOSS_TAG) != -1)
         {
            this.STWEventType_mc.gotoAndStop("STW_Boss");
            _loc4_ = param1.messageText.replace(EVENT_STW_BOSS_TAG,"");
            this.STWEventType_mc.ENDynamicText_tf.text = _loc4_;
         }
         else if(param1.messageText.indexOf(EVENT_STW_COMPLETE_TAG) != -1)
         {
            this.STWEventType_mc.gotoAndStop("STW_Complete");
            _loc5_ = param1.messageText.replace(EVENT_STW_COMPLETE_TAG,"");
            this.STWEventType_mc.ENDynamicText_tf.text = _loc5_;
         }
         else if(param1.messageText.indexOf(EVENT_STW_FREEBIE_TAG) != -1)
         {
            this.STWEventType_mc.gotoAndStop("STW_Freebie");
            _loc6_ = param1.messageText.replace(EVENT_STW_FREEBIE_TAG,"");
            this.STWEventType_mc.ENDynamicText_tf.text = _loc6_;
         }
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame39() : *
      {
         stop();
      }
      
      internal function frame70() : *
      {
         stop();
      }
   }
}

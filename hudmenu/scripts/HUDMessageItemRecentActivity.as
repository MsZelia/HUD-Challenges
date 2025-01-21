package
{
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol244")]
   public class HUDMessageItemRecentActivity extends HUDMessageItemBase
   {
      
      public static const EVENT_ON_FADE_OUT_COMPLETE:* = "HUDMessage::RecentActivityOnFadeOutComplete";
      
      public static const EVENT_ON_FADE_IN_COMPLETE:* = "HUDMessage::RecentActivityOnFadeInComplete";
       
      
      public function HUDMessageItemRecentActivity()
      {
         super();
         addFrameScript(4,this.frame5,15,this.frame16,177,this.frame178);
         TextFieldEx.setTextAutoSize(Internal_mc.TitleText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(Internal_mc.BodyText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         Internal_mc.Icon_mc.clipWidth = Internal_mc.Icon_mc.width;
         Internal_mc.Icon_mc.clipHeight = Internal_mc.Icon_mc.height;
         Internal_mc.Icon_mc.clipScale = 1;
         Internal_mc.Icon_mc.clipXOffset = Internal_mc.Icon_mc.clipWidth / 2;
         Internal_mc.Icon_mc.clipYOffset = Internal_mc.Icon_mc.clipHeight / 2;
      }
      
      override public function redrawUIComponent() : void
      {
         var _loc1_:String = null;
         if(Boolean(data) && Boolean(data.data))
         {
            visible = true;
            _loc1_ = "";
            switch(data.type)
            {
               case HUDMessageItemData.TYPE_DAILY_OPS:
                  Internal_mc.Icon_mc.clipWidth = Internal_mc.Icon_mc.width;
                  Internal_mc.Icon_mc.clipHeight = Internal_mc.Icon_mc.height;
                  _loc1_ = "DOMode_Uplink2";
                  break;
               case HUDMessageItemData.TYPE_MUTATED_EVENT:
                  Internal_mc.Icon_mc.clipWidth = Internal_mc.Icon_mc.width * 0.75;
                  Internal_mc.Icon_mc.clipHeight = Internal_mc.Icon_mc.height * 0.75;
                  _loc1_ = "InWorldMutatedPublicEventIcon";
                  break;
               case HUDMessageItemData.TYPE_RAID:
                  Internal_mc.Icon_mc.clipWidth = Internal_mc.Icon_mc.width;
                  Internal_mc.Icon_mc.clipHeight = Internal_mc.Icon_mc.height;
                  _loc1_ = "RaidEventIcon";
            }
            Internal_mc.Icon_mc.setContainerIconClip(_loc1_);
            Internal_mc.TitleText_tf.text = data.data.titleText;
            Internal_mc.TitleText_tf.text = Internal_mc.TitleText_tf.text.toUpperCase();
            Internal_mc.BodyText_tf.text = data.data.messageText;
         }
         else
         {
            visible = false;
         }
      }
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame16() : *
      {
         OnFadeInComplete();
         stop();
      }
      
      internal function frame178() : *
      {
         OnFadeOutComplete();
         stop();
      }
   }
}

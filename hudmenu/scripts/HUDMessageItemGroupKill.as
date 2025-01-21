package
{
   import Shared.GlobalFunc;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol277")]
   public class HUDMessageItemGroupKill extends HUDMessageItemBase
   {
      
      public static const MAX_TEAMS:uint = 2;
       
      
      public function HUDMessageItemGroupKill()
      {
         super();
         addFrameScript(4,this.frame5,27,this.frame28,347,this.frame348);
      }
      
      override public function redrawUIComponent() : void
      {
         var _loc1_:uint = 0;
         if(data != null)
         {
            visible = true;
            GlobalFunc.SetText(Internal_mc.Header_tf,m_Data.data.headerText,true);
            if(m_Data.data.isWarning)
            {
               Internal_mc.gotoAndStop("enemy");
            }
            else
            {
               Internal_mc.gotoAndStop("friendly");
            }
            _loc1_ = 0;
            while(_loc1_ < MAX_TEAMS)
            {
               GlobalFunc.SetText(Internal_mc["Team" + _loc1_ + "Score_tf"],m_Data.data.scores[_loc1_],true);
               _loc1_++;
            }
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
      
      internal function frame28() : *
      {
         OnFadeInComplete();
         stop();
      }
      
      internal function frame348() : *
      {
         OnFadeOutComplete();
         stop();
      }
   }
}

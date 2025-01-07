package
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import scaleform.gfx.TextFieldEx;
   
   public class HUDQuestTrackerObjectiveTitle extends MovieClip
   {
      
      private static const ICON_SPACE:String = "      ";
      
      private static const DEFAULT_ICON_HEIGHT:Number = 33;
       
      
      public var TitleText_tf:TextField;
      
      public var Sizer_mc:MovieClip;
      
      private var m_ObjectiveIconsV:Vector.<HUDObjectiveIcon>;
      
      public function HUDQuestTrackerObjectiveTitle()
      {
         super();
         this.m_ObjectiveIconsV = new Vector.<HUDObjectiveIcon>();
         TextFieldEx.setTextAutoSize(this.TitleText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function setTitleData(param1:String) : void
      {
         var _loc6_:String = null;
         var _loc7_:HUDObjectiveIcon = null;
         var _loc2_:RegExp = /{#[^{#}]+}/g;
         var _loc3_:* = GlobalFunc.LocalizeFormattedString(param1);
         var _loc4_:int = 0;
         var _loc5_:Object = _loc2_.exec(_loc3_);
         while(Boolean(_loc5_) && _loc5_.index != -1)
         {
            _loc6_ = _loc5_[0].replace("{#","").replace("}","").toUpperCase();
            _loc4_++;
            if(_loc4_ > this.m_ObjectiveIconsV.length)
            {
               (_loc7_ = new HUDObjectiveIcon()).setData(_loc6_,_loc5_.index);
               _loc7_.setColor(this.TitleText_tf.textColor);
               this.m_ObjectiveIconsV.push(_loc7_);
               addChild(_loc7_);
            }
            else
            {
               this.m_ObjectiveIconsV[_loc4_ - 1].setData(_loc6_,_loc5_.index);
               this.m_ObjectiveIconsV[_loc4_ - 1].setColor(this.TitleText_tf.textColor);
            }
            _loc3_ = _loc3_.replace(_loc5_[0],ICON_SPACE);
            _loc5_ = _loc2_.exec(_loc3_);
         }
         if(_loc4_ > 0 && _loc3_.charAt(_loc3_.length - 1) == " ")
         {
            _loc3_ += "​";
         }
         while(_loc4_ < this.m_ObjectiveIconsV.length)
         {
            removeChild(this.m_ObjectiveIconsV.pop());
         }
         this.TitleText_tf.text = _loc3_;
         if(this.TitleText_tf.length > 0 && this.m_ObjectiveIconsV.length > 0)
         {
            addEventListener(Event.EXIT_FRAME,this.onExitFrame);
         }
         else
         {
            removeEventListener(Event.EXIT_FRAME,this.onExitFrame);
         }
      }
      
      private function onExitFrame(param1:Event) : void
      {
         var _loc2_:HUDObjectiveIcon = null;
         var _loc3_:Rectangle = null;
         var _loc4_:Number = NaN;
         if(visible && this.TitleText_tf.length > 0 && this.m_ObjectiveIconsV.length > 0)
         {
            for each(_loc2_ in this.m_ObjectiveIconsV)
            {
               _loc3_ = this.TitleText_tf.getCharBoundaries(_loc2_.charIndex);
               _loc2_.x = _loc3_.x + this.TitleText_tf.x;
               _loc2_.y = _loc3_.y;
               _loc4_ = this.TitleText_tf.textHeight / this.TitleText_tf.numLines / DEFAULT_ICON_HEIGHT;
               _loc2_.scaleX = _loc4_;
               _loc2_.scaleY = _loc4_;
            }
         }
         removeEventListener(Event.EXIT_FRAME,this.onExitFrame);
      }
   }
}

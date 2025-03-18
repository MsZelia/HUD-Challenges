package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol984")]
   public class DoTIconsManager extends MovieClip
   {
      
      public static const EVENT_DOT_COMPLETE:String = "DoTIconsManager::DoTComplete";
      
      public static const NEW_ICON_THRESHOLD:uint = 1500;
      
      public static const ICON_WIDTH_WITH_GAP:uint = 38;
      
      public static const ALIGNMENT_CENTER:uint = 0;
      
      public static const ALIGNMENT_LEFT:uint = 1;
      
      public static const ALIGNMENT_RIGHT:uint = 2;
       
      
      private var IconContainer_mc:MovieClip;
      
      public var Sizer_mc:MovieClip;
      
      private var m_Alignment:uint = 0;
      
      private var m_NumIcons:uint = 0;
      
      private var m_IconArray:Array;
      
      private var m_bAffectedByStealth:Boolean = false;
      
      private var ORIG_Y:Number = 23.2;
      
      private var STEALTH_BAR_HEIGHT:Number = 32;
      
      private var STEALTH_BAR_HEIGHT_MARGIN:Number = 4;
      
      public function DoTIconsManager()
      {
         this.m_IconArray = new Array();
         super();
         this.IconContainer_mc = new MovieClip();
         addChild(this.IconContainer_mc);
         addEventListener(DoTDamageIcon.EVENT_DAMAGE_COMPLETE,this.onDamageComplete);
      }
      
      public function set alignment(param1:uint) : *
      {
         this.m_Alignment = param1;
      }
      
      public function reset() : void
      {
         this.m_NumIcons = 0;
         this.m_IconArray = [];
         removeChild(this.IconContainer_mc);
         this.IconContainer_mc = new MovieClip();
         addChild(this.IconContainer_mc);
      }
      
      public function SetStealthMeterAwareness(param1:Boolean) : void
      {
         this.m_bAffectedByStealth = param1;
      }
      
      public function SetStealthMeterStatus(param1:Boolean) : void
      {
         this.y = this.ORIG_Y + (this.m_bAffectedByStealth && param1 ? this.STEALTH_BAR_HEIGHT + this.STEALTH_BAR_HEIGHT_MARGIN : 0);
      }
      
      public function isActive() : Boolean
      {
         return this.m_NumIcons > 0;
      }
      
      public function get numActiveIcons() : uint
      {
         return this.m_NumIcons;
      }
      
      public function populateIcons(param1:Array) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc6_:Boolean = false;
         var _loc7_:* = undefined;
         var _loc8_:* = undefined;
         var _loc9_:* = undefined;
         var _loc10_:DoTDamageIcon = null;
         var _loc2_:* = false;
         if(param1.length == 0)
         {
            this.visible = false;
         }
         else
         {
            _loc3_ = new Array();
            _loc4_ = 0;
            while(_loc4_ < param1.length)
            {
               _loc6_ = false;
               _loc7_ = 0;
               while(_loc7_ < _loc3_.length)
               {
                  if(_loc3_[_loc7_].damageType == param1[_loc4_].damageType)
                  {
                     _loc6_ = true;
                     _loc3_[_loc7_].remainingDuration = Math.max(_loc3_[_loc7_].remainingDuration,param1[_loc4_].remainingDuration);
                     _loc3_[_loc7_].totalDuration = Math.max(_loc3_[_loc7_].totalDuration,param1[_loc4_].remainingDuration);
                     break;
                  }
                  _loc7_++;
               }
               if(!_loc6_)
               {
                  _loc3_.push(param1[_loc4_]);
               }
               _loc4_++;
            }
            if(!(_loc5_ = _loc3_.length != this.m_IconArray.length))
            {
               _loc8_ = 0;
               while(_loc8_ < _loc3_.length)
               {
                  if(_loc3_[_loc8_].remainingDuration - this.m_IconArray[_loc8_].remainingDuration > NEW_ICON_THRESHOLD)
                  {
                     _loc5_ = true;
                     break;
                  }
                  _loc8_++;
               }
            }
            if(_loc5_)
            {
               this.reset();
               this.visible = true;
               _loc9_ = 0;
               _loc4_ = 0;
               while(_loc4_ < _loc3_.length)
               {
                  (_loc10_ = new DoTDamageIcon()).setType(_loc3_[_loc4_].damageType,_loc3_[_loc4_].positive,_loc3_[_loc4_].remainingDuration,_loc3_[_loc4_].totalDuration);
                  this.IconContainer_mc.addChild(_loc10_);
                  _loc10_.x = _loc9_;
                  _loc9_ += ICON_WIDTH_WITH_GAP;
                  this.m_IconArray.push(_loc10_);
                  ++this.m_NumIcons;
                  _loc4_++;
               }
               this.alignIcons();
            }
            _loc2_ = this.m_NumIcons > 0;
         }
         return _loc2_;
      }
      
      private function onDamageComplete(param1:Event) : void
      {
         --this.m_NumIcons;
         this.IconContainer_mc.removeChild(param1.target as DisplayObject);
         this.alignIcons();
         param1.stopPropagation();
         if(this.m_NumIcons == 0)
         {
            dispatchEvent(new Event(EVENT_DOT_COMPLETE,true,true));
         }
      }
      
      private function alignIcons(param1:Boolean = false) : void
      {
         var _loc5_:DisplayObject = null;
         var _loc2_:* = 0;
         var _loc3_:uint = uint(this.IconContainer_mc.numChildren);
         var _loc4_:uint = 0;
         while(_loc4_ < _loc3_)
         {
            if((_loc5_ = this.IconContainer_mc.getChildAt(_loc4_)) is DoTDamageIcon && (_loc5_ as DoTDamageIcon).remainingDuration > 0)
            {
               _loc5_.x = _loc2_;
               _loc2_ += ICON_WIDTH_WITH_GAP;
            }
            _loc4_++;
         }
         switch(this.m_Alignment)
         {
            case ALIGNMENT_CENTER:
               this.IconContainer_mc.x = this.Sizer_mc.width / 2 - this.m_NumIcons * ICON_WIDTH_WITH_GAP / 2;
               break;
            case ALIGNMENT_LEFT:
               this.IconContainer_mc.x = param1 ? this.IconContainer_mc.x - ICON_WIDTH_WITH_GAP : this.Sizer_mc.x;
               break;
            case ALIGNMENT_RIGHT:
               this.IconContainer_mc.x = this.Sizer_mc.width - this.m_NumIcons * ICON_WIDTH_WITH_GAP;
         }
      }
   }
}

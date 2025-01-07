package Shared
{
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.utils.describeType;
   import flash.utils.getQualifiedClassName;
   import scaleform.gfx.Extensions;
   
   public class GlobalFunc
   {
      
      public static const PIPBOY_GREY_OUT_ALPHA:Number = 0.5;
      
      public static const SELECTED_RECT_ALPHA:Number = 1;
      
      public static const DIMMED_ALPHA:Number = 0.65;
      
      public static const NUM_DAMAGE_TYPES:uint = 6;
      
      public static const PLAYER_ICON_TEXTURE_BUFFER:String = "AvatarTextureBuffer";
      
      protected static const CLOSE_ENOUGH_EPSILON:Number = 0.001;
      
      public static const MAX_TRUNCATED_TEXT_LENGTH:* = 42;
      
      public static const PLAY_FOCUS_SOUND:String = "GlobalFunc::playFocusSound";
      
      public static const PLAY_MENU_SOUND:String = "GlobalFunc::playMenuSound";
      
      public static const SHOW_HUD_MESSAGE:String = "GlobalFunc::showHUDMessage";
      
      public static const MENU_SOUND_OK:String = "UIMenuOK";
      
      public static const MENU_SOUND_CANCEL:String = "UIMenuCancel";
      
      public static const MENU_SOUND_PREV_NEXT:String = "UIMenuPrevNext";
      
      public static const MENU_SOUND_POPUP:String = "UIMenuPopupGeneric";
      
      public static const MENU_SOUND_FOCUS_CHANGE:String = "UIMenuFocus";
      
      public static const MENU_SOUND_FRIEND_PROMPT_OPEN:String = "UIMenuPromptFriendRequestBladeOpen";
      
      public static const MENU_SOUND_FRIEND_PROMPT_CLOSE:String = "UIMenuPromptFriendRequestBladeClose";
      
      public static const COLOR_TEXT_BODY:uint = 16777163;
      
      public static const COLOR_TEXT_HEADER:uint = 16108379;
      
      public static const COLOR_TEXT_SELECTED:uint = 1580061;
      
      public static const COLOR_TEXT_FRIEND:uint = COLOR_TEXT_HEADER;
      
      public static const COLOR_TEXT_ENEMY:uint = 16741472;
      
      public static const COLOR_TEXT_UNAVAILABLE:uint = 5661031;
      
      public static const COLOR_BACKGROUND_BOX:uint = 3225915;
      
      public static const COOR_WARNING:uint = 15089200;
      
      public static const COLOR_WARNING_ACCENT:uint = 16151129;
      
      public static const EVENT_USER_CONTEXT_MENU_ACTION:String = "UserContextMenu::MenuOptionSelected";
      
      public static const EVENT_OPEN_USER_CONTEXT_MENU:String = "UserContextMenu::UserSelected";
      
      public static const USER_MENU_CONTEXT_ALL:uint = 0;
      
      public static const USER_MENU_CONTEXT_FRIENDS:uint = 1;
      
      public static const USER_MENU_CONTEXT_TEAM:uint = 2;
      
      public static const USER_MENU_CONTEXT_RECENT:uint = 3;
      
      public static const USER_MENU_CONTEXT_BLOCKED:uint = 4;
      
      public static const USER_MENU_CONTEXT_MAP:uint = 5;
      
      public static const ALIGN_LEFT:uint = 0;
      
      public static const ALIGN_CENTER:uint = 1;
      
      public static const ALIGN_RIGHT:uint = 2;
      
      public static const DURABILITY_MAX:uint = 100;
      
      public static const DIRECTION_NONE:* = 0;
      
      public static const DIRECTION_UP:* = 1;
      
      public static const DIRECTION_RIGHT:* = 2;
      
      public static const DIRECTION_DOWN:* = 3;
      
      public static const DIRECTION_LEFT:* = 4;
      
      public static const IMAGE_FRAME_MAP:Object = {
         "a":1,
         "b":2,
         "c":3,
         "d":4,
         "e":5,
         "f":6,
         "g":7,
         "h":8,
         "i":9,
         "j":10,
         "k":11,
         "l":12,
         "m":13,
         "n":14,
         "o":15,
         "p":16,
         "q":17,
         "r":18,
         "s":19,
         "t":20,
         "u":21,
         "v":22,
         "w":23,
         "x":24,
         "y":25,
         "z":26,
         "0":1,
         "1":2,
         "2":3,
         "3":4,
         "4":5,
         "5":6,
         "6":7,
         "7":8,
         "8":9,
         "9":10
      };
       
      
      public function GlobalFunc()
      {
         super();
      }
      
      public static function ShowHUDMessage(param1:String) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.SHOW_HUD_MESSAGE,{"text":param1}));
      }
      
      public static function Lerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean) : Number
      {
         var _loc7_:Number = param1 + (param5 - param3) / (param4 - param3) * (param2 - param1);
         if(param6)
         {
            if(param1 < param2)
            {
               _loc7_ = Math.min(Math.max(_loc7_,param1),param2);
            }
            else
            {
               _loc7_ = Math.min(Math.max(_loc7_,param2),param1);
            }
         }
         return _loc7_;
      }
      
      public static function PadNumber(param1:Number, param2:uint) : String
      {
         var _loc3_:String = "" + param1;
         while(_loc3_.length < param2)
         {
            _loc3_ = "0" + _loc3_;
         }
         return _loc3_;
      }
      
      public static function SimpleTimeString(param1:Number) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         if(_loc3_ > 1)
         {
            return _loc3_ + " Days";
         }
         if(_loc3_ == 1)
         {
            return _loc3_ + " Day";
         }
         var _loc4_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         if(_loc4_ > 1)
         {
            return _loc4_ + " Hours";
         }
         if(_loc4_ == 1)
         {
            return _loc4_ + " Hour";
         }
         var _loc5_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         if(_loc5_ > 1)
         {
            return _loc5_ + " Minutes";
         }
         if(_loc5_ == 1)
         {
            return _loc5_ + " Minute";
         }
         var _loc6_:Number;
         if((_loc6_ = Math.floor(_loc2_)) > 1)
         {
            return _loc6_ + " Seconds";
         }
         if(_loc6_ == 1)
         {
            return _loc6_ + " Second";
         }
         return "0";
      }
      
      public static function FormatTimeString(param1:Number) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc4_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc5_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc6_:Number = Math.floor(_loc2_);
         var _loc7_:Boolean = false;
         var _loc8_:* = "";
         if(_loc3_ > 0)
         {
            _loc8_ = PadNumber(_loc3_,2);
            _loc7_ = true;
         }
         if(_loc3_ > 0 || _loc4_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ += ":";
            }
            else
            {
               _loc7_ = true;
            }
            _loc8_ += PadNumber(_loc4_,2);
         }
         if(_loc3_ > 0 || _loc4_ > 0 || _loc5_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ += ":";
            }
            else
            {
               _loc7_ = true;
            }
            _loc8_ += PadNumber(_loc5_,2);
         }
         if(_loc3_ > 0 || _loc4_ > 0 || _loc5_ > 0 || _loc6_ > 0)
         {
            if(_loc7_)
            {
               _loc8_ += ":";
            }
            else if(_loc3_ == 0 && _loc4_ == 0 && _loc5_ == 0)
            {
               _loc8_ = "0:";
            }
            _loc8_ += PadNumber(_loc6_,2);
         }
         return _loc8_;
      }
      
      public static function ImageFrameFromCharacter(param1:String) : uint
      {
         var _loc2_:String = null;
         if(param1 != null && param1.length > 0)
         {
            _loc2_ = param1.substring(0,1).toLowerCase();
            if(IMAGE_FRAME_MAP[_loc2_] != null)
            {
               return IMAGE_FRAME_MAP[_loc2_];
            }
         }
         return 1;
      }
      
      public static function GetAccountIconPath(param1:String) : String
      {
         if(param1 == null || param1.length == 0)
         {
            param1 = "Textures/ATX/Storefront/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
         }
         return param1;
      }
      
      public static function RoundDecimal(param1:Number, param2:Number) : Number
      {
         var _loc3_:Number = Math.pow(10,param2);
         return Math.round(_loc3_ * param1) / _loc3_;
      }
      
      public static function CloseToNumber(param1:Number, param2:Number, param3:Number = 0.001) : Boolean
      {
         return Math.abs(param1 - param2) < param3;
      }
      
      public static function Clamp(param1:Number, param2:Number, param3:Number) : Number
      {
         return Math.max(param2,Math.min(param3,param1));
      }
      
      public static function MaintainTextFormat() : *
      {
         TextField.prototype.SetText = function(param1:String, param2:Boolean = false, param3:Boolean = false):*
         {
            var _loc4_:Number = NaN;
            var _loc5_:Boolean = false;
            if(!param1 || param1 == "")
            {
               param1 = "";
            }
            if(param3 && param1.charAt(0) != "$")
            {
               param1 = param1.toUpperCase();
            }
            var _loc6_:TextFormat = this.getTextFormat();
            if(param2)
            {
               _loc4_ = Number(_loc6_.letterSpacing);
               _loc5_ = Boolean(_loc6_.kerning);
               this.htmlText = param1;
               (_loc6_ = this.getTextFormat()).letterSpacing = _loc4_;
               _loc6_.kerning = _loc5_;
               this.setTextFormat(_loc6_);
               this.htmlText = param1;
            }
            else
            {
               this.text = param1;
               this.setTextFormat(_loc6_);
               this.text = param1;
            }
         };
      }
      
      public static function SetText(param1:TextField, param2:String, param3:Boolean = false, param4:Boolean = false, param5:* = false) : *
      {
         var _loc6_:TextFormat = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         if(!param2 || param2 == "")
         {
            param2 = "";
         }
         if(param4 && param2.charAt(0) != "$")
         {
            param2 = param2.toUpperCase();
         }
         if(param3)
         {
            _loc6_ = param1.getTextFormat();
            _loc7_ = Number(_loc6_.letterSpacing);
            _loc8_ = Boolean(_loc6_.kerning);
            param1.htmlText = param2;
            (_loc6_ = param1.getTextFormat()).letterSpacing = _loc7_;
            _loc6_.kerning = _loc8_;
            param1.setTextFormat(_loc6_);
         }
         else
         {
            param1.text = param2;
         }
         if(param5 && param1.text.length > MAX_TRUNCATED_TEXT_LENGTH)
         {
            param1.text = param1.text.slice(0,MAX_TRUNCATED_TEXT_LENGTH - 3) + "...";
         }
      }
      
      public static function LockToSafeRect(param1:DisplayObject, param2:String, param3:Number = 0, param4:Number = 0) : *
      {
         var _loc5_:Rectangle = Extensions.visibleRect;
         var _loc6_:Point = new Point(_loc5_.x + param3,_loc5_.y + param4);
         var _loc7_:Point = new Point(_loc5_.x + _loc5_.width - param3,_loc5_.y + _loc5_.height - param4);
         var _loc8_:Point = param1.parent.globalToLocal(_loc6_);
         var _loc9_:Point = param1.parent.globalToLocal(_loc7_);
         var _loc10_:Point = Point.interpolate(_loc8_,_loc9_,0.5);
         if(param2 == "T" || param2 == "TL" || param2 == "TR" || param2 == "TC")
         {
            param1.y = _loc8_.y;
         }
         if(param2 == "CR" || param2 == "CC" || param2 == "CL")
         {
            param1.y = _loc10_.y;
         }
         if(param2 == "B" || param2 == "BL" || param2 == "BR" || param2 == "BC")
         {
            param1.y = _loc9_.y;
         }
         if(param2 == "L" || param2 == "TL" || param2 == "BL" || param2 == "CL")
         {
            param1.x = _loc8_.x;
         }
         if(param2 == "TC" || param2 == "CC" || param2 == "BC")
         {
            param1.x = _loc10_.x;
         }
         if(param2 == "R" || param2 == "TR" || param2 == "BR" || param2 == "CR")
         {
            param1.x = _loc9_.x;
         }
      }
      
      public static function AddMovieExploreFunctions() : *
      {
         MovieClip.prototype.getMovieClips = function():Array
         {
            var _loc1_:* = undefined;
            var _loc2_:* = new Array();
            for(_loc1_ in this)
            {
               if(this[_loc1_] is MovieClip && this[_loc1_] != this)
               {
                  _loc2_.push(this[_loc1_]);
               }
            }
            return _loc2_;
         };
         MovieClip.prototype.showMovieClips = function():*
         {
            var _loc1_:* = undefined;
            for(_loc1_ in this)
            {
               if(this[_loc1_] is MovieClip && this[_loc1_] != this)
               {
                  trace(this[_loc1_]);
                  this[_loc1_].showMovieClips();
               }
            }
         };
      }
      
      public static function InspectObject(param1:Object, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc4_:String = getQualifiedClassName(param1);
         trace("Inspecting object with type " + _loc4_);
         trace("{");
         InspectObjectHelper(param1,param2,param3);
         trace("}");
      }
      
      private static function InspectObjectHelper(param1:Object, param2:Boolean, param3:Boolean, param4:String = "") : void
      {
         var member:XML = null;
         var constMember:XML = null;
         var id:String = null;
         var prop:XML = null;
         var propName:String = null;
         var propValue:Object = null;
         var memberName:String = null;
         var memberValue:Object = null;
         var constMemberName:String = null;
         var constMemberValue:Object = null;
         var value:Object = null;
         var subid:String = null;
         var subvalue:Object = null;
         var aObject:Object = param1;
         var abRecursive:Boolean = param2;
         var abIncludeProperties:Boolean = param3;
         var astrIndent:String = param4;
         var typeDef:XML = describeType(aObject);
         if(abIncludeProperties)
         {
            for each(prop in typeDef.accessor.(@access == "readwrite" || @access == "readonly"))
            {
               propName = prop.@name;
               propValue = aObject[prop.@name];
               trace(astrIndent + propName + " = " + propValue);
               if(abRecursive)
               {
                  InspectObjectHelper(propValue,abRecursive,abIncludeProperties,astrIndent + "");
               }
            }
         }
         for each(member in typeDef.variable)
         {
            memberName = member.@name;
            memberValue = aObject[memberName];
            trace(astrIndent + memberName + " = " + memberValue);
            if(abRecursive)
            {
               InspectObjectHelper(memberValue,true,abIncludeProperties,astrIndent + "");
            }
         }
         for each(constMember in typeDef.constant)
         {
            constMemberName = constMember.@name;
            constMemberValue = aObject[constMemberName];
            trace(astrIndent + constMemberName + " = " + constMemberValue + " --const");
            if(abRecursive)
            {
               InspectObjectHelper(constMemberValue,true,abIncludeProperties,astrIndent + "");
            }
         }
         for(id in aObject)
         {
            value = aObject[id];
            trace(astrIndent + id + " = " + value);
            if(abRecursive)
            {
               InspectObjectHelper(value,true,abIncludeProperties,astrIndent + "");
            }
            else
            {
               for(subid in value)
               {
                  subvalue = value[subid];
                  trace(astrIndent + "" + subid + " = " + subvalue);
               }
            }
         }
      }
      
      public static function AddReverseFunctions() : *
      {
         MovieClip.prototype.PlayReverseCallback = function(param1:Event):*
         {
            if(param1.currentTarget.currentFrame > 1)
            {
               param1.currentTarget.gotoAndStop(param1.currentTarget.currentFrame - 1);
            }
            else
            {
               param1.currentTarget.removeEventListener(Event.ENTER_FRAME,param1.currentTarget.PlayReverseCallback);
            }
         };
         MovieClip.prototype.PlayReverse = function():*
         {
            if(this.currentFrame > 1)
            {
               this.gotoAndStop(this.currentFrame - 1);
               this.addEventListener(Event.ENTER_FRAME,this.PlayReverseCallback);
            }
            else
            {
               this.gotoAndStop(1);
            }
         };
         MovieClip.prototype.PlayForward = function(param1:String):*
         {
            delete this.onEnterFrame;
            this.gotoAndPlay(param1);
         };
         MovieClip.prototype.PlayForward = function(param1:Number):*
         {
            delete this.onEnterFrame;
            this.gotoAndPlay(param1);
         };
      }
      
      public static function PlayMenuSound(param1:String) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":param1}));
      }
      
      public static function updateConditionMeter(param1:MovieClip, param2:Number, param3:Number, param4:Number) : void
      {
         var _loc5_:MovieClip = null;
         if(param3 > 0)
         {
            param1.visible = true;
            _loc5_ = param1.MeterClip_mc;
            param1.gotoAndStop(GlobalFunc.Lerp(param1.totalFrames,1,0,DURABILITY_MAX,param4,true));
            if(param2 > 0)
            {
               _loc5_.gotoAndStop(GlobalFunc.Lerp(_loc5_.totalFrames,2,0,param3 * 2,param2,true));
            }
            else
            {
               _loc5_.gotoAndStop(1);
            }
         }
         else
         {
            param1.visible = false;
         }
      }
      
      public static function getTextfieldSize(param1:TextField, param2:Boolean = true) : *
      {
         var _loc3_:Number = NaN;
         var _loc4_:uint = 0;
         if(param1.multiline)
         {
            _loc3_ = 0;
            _loc4_ = 0;
            while(_loc4_ < param1.numLines)
            {
               _loc3_ += param2 ? param1.getLineMetrics(_loc4_).height : param1.getLineMetrics(_loc4_).width;
               _loc4_++;
            }
            return _loc3_;
         }
         return param2 ? param1.textHeight : param1.textWidth;
      }
      
      public static function getDisplayObjectSize(param1:DisplayObject, param2:Boolean = false) : *
      {
         if(param1 is BSScrollingList)
         {
            return (param1 as BSScrollingList).shownItemsHeight;
         }
         if(param1 is MovieClip)
         {
            if(param1["Sizer_mc"] != undefined && param1["Sizer_mc"] != null)
            {
               return param2 ? param1["Sizer_mc"].height : param1["Sizer_mc"].width;
            }
            if(param1["textField"] != null)
            {
               return getTextfieldSize(param1["textField"],param2);
            }
            return param2 ? param1.height : param1.width;
         }
         if(param1 is TextField)
         {
            return getTextfieldSize(param1 as TextField,param2);
         }
         throw new Error("GlobalFunc.getDisplayObjectSize: unsupported object type");
      }
      
      public static function arrangeItems(param1:Array, param2:Boolean, param3:uint = 0, param4:Number = 0, param5:Boolean = false, param6:Number = 0) : Number
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:uint = 0;
         var _loc10_:Array = null;
         var _loc11_:uint = 0;
         var _loc12_:uint = param1.length;
         var _loc14_:Number = 0;
         if(_loc12_ > 0)
         {
            _loc7_ = 0;
            _loc8_ = param5 ? Number(-1) : Number(1);
            _loc10_ = [];
            _loc11_ = param1.length;
            _loc9_ = 0;
            while(_loc9_ < _loc11_)
            {
               if(_loc9_ > 0)
               {
                  _loc14_ += param4;
               }
               _loc10_[_loc9_] = getDisplayObjectSize(param1[_loc9_],param2);
               _loc14_ += _loc10_[_loc9_];
               _loc9_++;
            }
            if(param3 == ALIGN_CENTER)
            {
               _loc7_ = _loc14_ * -0.5;
            }
            else if(param3 == ALIGN_RIGHT)
            {
               _loc7_ = -_loc14_ - _loc10_[0];
            }
            if(param5)
            {
               param1.reverse();
               _loc10_.reverse();
            }
            _loc7_ += param6;
            _loc9_ = 0;
            while(_loc9_ < _loc11_)
            {
               if(param2)
               {
                  param1[_loc9_].y = _loc7_;
               }
               else
               {
                  param1[_loc9_].x = _loc7_;
               }
               _loc7_ += _loc10_[_loc9_] + param4;
               _loc9_++;
            }
         }
         return _loc14_;
      }
      
      public static function StringTrim(param1:String) : String
      {
         var _loc2_:String = null;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = param1.length;
         while(param1.charAt(_loc3_) == "" || param1.charAt(_loc3_) == "" || param1.charAt(_loc3_) == "" || param1.charAt(_loc3_) == "")
         {
            _loc3_++;
         }
         _loc2_ = param1.substring(_loc3_);
         _loc4_ = _loc2_.length - 1;
         while(_loc2_.charAt(_loc4_) == "" || _loc2_.charAt(_loc4_) == "" || _loc2_.charAt(_loc4_) == "" || _loc2_.charAt(_loc4_) == "")
         {
            _loc4_--;
         }
         return _loc2_.substring(0,_loc4_ + 1);
      }
      
      public static function BSASSERT(param1:Boolean, param2:String) : void
      {
         var _loc3_:String = null;
         if(!param1)
         {
            _loc3_ = new Error().getStackTrace();
            fscommand("BSASSERT",param2 + "\nCallstack:\n" + _loc3_);
         }
      }
   }
}

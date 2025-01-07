package Shared
{
   import Shared.AS3.BCGridList;
   import Shared.AS3.BSScrollingList;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.SWFLoaderClip;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.system.fscommand;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import flash.text.TextLineMetrics;
   import flash.utils.ByteArray;
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
      
      public static const STORE_IMAGE_TEXTURE_BUFFER:String = "StoreTextureBuffer";
      
      public static const ACCOUNT_UPGRADES_STORE_IMAGE_TEXTURE_BUFFER:String = "AccountUpgradesStoreTextureBuffer";
      
      public static const MAP_TEXTURE_BUFFER:String = "MapMenuTextureBuffer";
      
      public static const CHARACTER_PROFILE_TEXTURE_BUFFER:String = "CharacterProfileTextureBuffer";
      
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
      
      public static const BUTTON_BAR_ALIGN_CENTER:uint = 0;
      
      public static const BUTTON_BAR_ALIGN_LEFT:uint = 1;
      
      public static const BUTTON_BAR_ALIGN_RIGHT:uint = 2;
      
      public static const COLOR_TEXT_BODY:uint = 16777163;
      
      public static const COLOR_TEXT_HEADER:uint = 16108379;
      
      public static const COLOR_TEXT_SELECTED:uint = 1580061;
      
      public static const COLOR_TEXT_FRIEND:uint = COLOR_TEXT_HEADER;
      
      public static const COLOR_TEXT_ENEMY:uint = 16741472;
      
      public static const COLOR_TEXT_UNAVAILABLE:uint = 5661031;
      
      public static const COLOR_BACKGROUND_BOX:uint = 3225915;
      
      public static const COOR_WARNING:uint = 15089200;
      
      public static const COLOR_WARNING_ACCENT:uint = 16151129;
      
      public static const COLOR_RARITY_LEGENDARY:uint = 15046481;
      
      public static const COLOR_RARITY_EPIC:uint = 10763770;
      
      public static const COLOR_RARITY_RARE:uint = 4960214;
      
      public static const COLOR_RARITY_COMMON:uint = 9043803;
      
      public static const FRAME_RARITY_NONE:String = "None";
      
      public static const FRAME_RARITY_COMMON:String = "Common";
      
      public static const FRAME_RARITY_RARE:String = "Rare";
      
      public static const FRAME_RARITY_EPIC:String = "Epic";
      
      public static const FRAME_RARITY_LEGENDARY:String = "Legendary";
      
      public static var TEXT_SIZE_VERYSMALL:Number = 16;
      
      public static var TEXT_SIZE_MIN:Number = 14;
      
      public static var TEXT_LEADING_MIN:Number = -2;
      
      public static const VOICE_STATUS_UNAVAILABLE:uint = 0;
      
      public static const VOICE_STATUS_AVAILABLE:uint = 1;
      
      public static const VOICE_STATUS_SPEAKING:uint = 2;
      
      public static const FIRST_PARTY_PLATFORM_BNET:uint = 0;
      
      public static const FIRST_PARTY_PLATFORM_XBL:uint = 1;
      
      public static const FIRST_PARTY_PLATFORM_PSN:uint = 2;
      
      public static const FIRST_PARTY_PLATFORM_STEAM:uint = 3;
      
      public static const FIRST_PARTY_PLATFORM_MSSTORE:uint = 4;
      
      public static const WORLD_TYPE_INVALID:uint = 0;
      
      public static const WORLD_TYPE_NORMAL:uint = 1;
      
      public static const WORLD_TYPE_SURVIVAL:uint = 2;
      
      public static const WORLD_TYPE_NWTEMP:uint = 3;
      
      public static const WORLD_TYPE_NUCLEARWINTER:uint = 4;
      
      public static const WORLD_TYPE_PRIVATE:uint = 5;
      
      public static const WORLD_TYPE_OPENCUSTOM:uint = 6;
      
      public static const WORLD_TYPE_PUBLICCUSTOM:uint = 7;
      
      public static const QUEST_DISPLAY_TYPE_NONE:uint = 0;
      
      public static const QUEST_DISPLAY_TYPE_MAIN:uint = 1;
      
      public static const QUEST_DISPLAY_TYPE_SIDE:uint = 2;
      
      public static const QUEST_DISPLAY_TYPE_MISC:uint = 3;
      
      public static const QUEST_DISPLAY_TYPE_EVENT:uint = 4;
      
      public static const QUEST_DISPLAY_TYPE_OTHER:uint = 5;
      
      public static const QUEST_DISPLAY_TYPE_FUEL:uint = 6;
      
      public static const STAT_VALUE_TYPE_INTEGER:uint = 0;
      
      public static const STAT_VALUE_TYPE_TIME:uint = 1;
      
      public static const STAT_VALUE_TYPE_CAPS:uint = 2;
      
      public static var STAT_TYPE_INVALID:uint = 20;
      
      public static var STAT_TYPE_SURVIVAL_SCORE:* = 29;
      
      public static const EVENT_USER_CONTEXT_MENU_ACTION:String = "UserContextMenu::MenuOptionSelected";
      
      public static const EVENT_OPEN_USER_CONTEXT_MENU:String = "UserContextMenu::UserSelected";
      
      public static const USER_MENU_CONTEXT_ALL:uint = 0;
      
      public static const USER_MENU_CONTEXT_FRIENDS:uint = 1;
      
      public static const USER_MENU_CONTEXT_TEAM:uint = 2;
      
      public static const USER_MENU_CONTEXT_RECENT:uint = 3;
      
      public static const USER_MENU_CONTEXT_BLOCKED:uint = 4;
      
      public static const USER_MENU_CONTEXT_MAP:uint = 5;
      
      public static const MTX_CURRENCY_ATOMS:uint = 0;
      
      public static const ALIGN_LEFT:uint = 0;
      
      public static const ALIGN_CENTER:uint = 1;
      
      public static const ALIGN_RIGHT:uint = 2;
      
      public static const DURABILITY_MAX:uint = 100;
      
      public static const DIRECTION_NONE:* = 0;
      
      public static const DIRECTION_UP:* = 1;
      
      public static const DIRECTION_RIGHT:* = 2;
      
      public static const DIRECTION_DOWN:* = 3;
      
      public static const DIRECTION_LEFT:* = 4;
      
      public static const REWARD_TYPE_ENUM_ATOMS:* = 0;
      
      public static const REWARD_TYPE_ENUM_PERK_PACKS:* = 1;
      
      public static const REWARD_TYPE_ENUM_PHOTO_FRAMES:* = 2;
      
      public static const REWARD_TYPE_ENUM_EMOTES:* = 3;
      
      public static const REWARD_TYPE_ENUM_ICONS:* = 4;
      
      public static const REWARD_TYPE_ENUM_WEAPON:* = 5;
      
      public static const REWARD_TYPE_ENUM_WEAPON_MOD:* = 6;
      
      public static const REWARD_TYPE_ENUM_ARMOR:* = 7;
      
      public static const REWARD_TYPE_ENUM_ARMOR_MOD:* = 8;
      
      public static const REWARD_TYPE_ENUM_AMMO:* = 9;
      
      public static const REWARD_TYPE_ENUM_PHOTO_POSE:* = 10;
      
      public static const REWARD_TYPE_ENUM_COMPONENTS:* = 11;
      
      public static const REWARD_TYPE_ENUM_EXPERIENCE:* = 12;
      
      public static const REWARD_TYPE_ENUM_BADGES:* = 13;
      
      public static const REWARD_TYPE_ENUM_STIMPAKS:* = 14;
      
      public static const REWARD_TYPE_ENUM_CHEMS:* = 15;
      
      public static const REWARD_TYPE_ENUM_BOOK:* = 16;
      
      public static const REWARD_TYPE_ENUM_CAPS:* = 17;
      
      public static const REWARD_TYPE_ENUM_LEGENDARY_TOKENS:* = 18;
      
      public static const REWARD_TYPE_ENUM_POSSUM_BADGES:* = 19;
      
      public static const REWARD_TYPE_ENUM_TADPOLE_BADGES:* = 20;
      
      public static const REWARD_TYPE_ENUM_CUSTOM_ICON:* = 21;
      
      public static const REWARD_TYPE_ENUM_CAMP:* = 22;
      
      public static const REWARD_TYPE_ENUM_GOLD_BULLION:* = 23;
      
      public static const REWARD_TYPE_ENUM_SCORE:* = 24;
      
      public static const REWARD_TYPE_ENUM_ULTRACITE_BATTERY_FUEL:* = 25;
      
      public static const REWARD_TYPE_ENUM_REPAIR_KIT:* = 26;
      
      public static const REWARD_TYPE_ENUM_LUNCH_BOX:* = 27;
      
      public static const REWARD_TYPE_ENUM_PREMIUM:* = 28;
      
      public static const REWARD_TYPE_ENUM_SCORE_BOOST:* = 29;
      
      public static const REWARD_TYPE_ENUM_STAMPS:* = 30;
      
      public static const REWARD_TYPE_ENUM_SCOUT_BANNER:* = 31;
      
      public static const REWARD_TYPE_ENUM_FOOD_AND_DRINK:* = 32;
      
      public static const REWARD_TYPE_ENUM_RE_ROLLER:* = 33;
      
      public static const REWARD_TYPE_ENUM_PERK_COIN:* = 34;
      
      public static const REWARD_TYPE_ENUM_SCORE_BOOSTER_CONSUMABLE:* = 35;
      
      public static const REWARD_TYPE_ENUM_SCOUT_BACKPACK:* = 36;
      
      public static const REWARD_TYPE_ENUM_FLAIR:* = 37;
      
      public static const REWARD_TYPE_ENUM_TICKETS:* = 38;
      
      public static const REWARD_TYPE_ENUM_PLAYER_TITLE:* = 39;
      
      public static const PLAYER_TITLE_DELIMITER:* = "|";
      
      public static const PLAYER_TITLE_DIVIDER:* = " |";
      
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
         0:1,
         1:2,
         2:3,
         3:4,
         4:5,
         5:6,
         6:7,
         7:8,
         8:9,
         9:10
      };
       
      
      public function GlobalFunc()
      {
         super();
      }
      
      public static function CloneObject(param1:Object) : *
      {
         var _loc2_:ByteArray = new ByteArray();
         _loc2_.writeObject(param1);
         _loc2_.position = 0;
         return _loc2_.readObject();
      }
      
      public static function GeneratePlayerNameAndTitle(param1:String) : String
      {
         var _loc4_:uint = 0;
         var _loc2_:String = "";
         var _loc3_:Array = param1.split(PLAYER_TITLE_DELIMITER);
         _loc2_ = _loc3_[0];
         if(_loc3_.length > 1)
         {
            _loc2_ += PLAYER_TITLE_DIVIDER;
            _loc4_ = 1;
            while(_loc4_ < _loc3_.length)
            {
               _loc2_ += " " + _loc3_[_loc4_];
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public static function GeneratePlayerName(param1:String) : String
      {
         return param1.split(PLAYER_TITLE_DELIMITER)[0];
      }
      
      public static function HasPlayerTitle(param1:String) : Boolean
      {
         return param1.indexOf(PLAYER_TITLE_DELIMITER) > -1;
      }
      
      public static function GeneratePlayerTitle(param1:String) : String
      {
         var _loc4_:uint = 0;
         var _loc2_:String = "";
         var _loc3_:Array = param1.split(PLAYER_TITLE_DELIMITER);
         if(_loc3_.length > 1)
         {
            _loc2_ = _loc3_[1];
            _loc4_ = 2;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_].length > 0)
               {
                  _loc2_ += " " + _loc3_[_loc4_];
               }
               _loc4_++;
            }
         }
         return _loc2_;
      }
      
      public static function GeneratePlayerNameAndTitleArray(param1:String) : Array
      {
         var _loc5_:uint = 0;
         var _loc2_:Array = param1.split(PLAYER_TITLE_DELIMITER);
         var _loc3_:String = "";
         if(_loc2_.length > 1)
         {
            _loc3_ = _loc2_[1];
            _loc5_ = 2;
            while(_loc5_ < _loc2_.length)
            {
               if(_loc2_[_loc5_].length > 0)
               {
                  _loc3_ += " " + _loc2_[_loc5_];
               }
               _loc5_++;
            }
         }
         var _loc4_:Array = new Array(_loc2_[0]);
         if(_loc3_ != "")
         {
            _loc4_.push(_loc3_);
         }
         return _loc4_;
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
      
      public static function setChallengeRewardIcon(param1:SWFLoaderClip, param2:uint, param3:String = "") : MovieClip
      {
         var _loc4_:String = null;
         switch(param2)
         {
            case REWARD_TYPE_ENUM_ATOMS:
               _loc4_ = "IconCR_Atoms";
               break;
            case REWARD_TYPE_ENUM_PERK_PACKS:
               _loc4_ = "IconCR_PerkPack";
               break;
            case REWARD_TYPE_ENUM_PERK_COIN:
               _loc4_ = "IconCR_PerkCoin";
               break;
            case REWARD_TYPE_ENUM_PHOTO_FRAMES:
               _loc4_ = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_EMOTES:
               _loc4_ = "IconCR_Emote";
               break;
            case REWARD_TYPE_ENUM_ICONS:
               _loc4_ = "IconCR_PlayerIcon";
               break;
            case REWARD_TYPE_ENUM_WEAPON:
               _loc4_ = "IconCR_Weapon";
               break;
            case REWARD_TYPE_ENUM_WEAPON_MOD:
               _loc4_ = "IconCR_WeaponMod";
               break;
            case REWARD_TYPE_ENUM_ARMOR:
               _loc4_ = "IconCR_Armor";
               break;
            case REWARD_TYPE_ENUM_ARMOR_MOD:
               _loc4_ = "IconCR_ArmorMod";
               break;
            case REWARD_TYPE_ENUM_AMMO:
               _loc4_ = "IconCR_Ammo";
               break;
            case REWARD_TYPE_ENUM_PHOTO_POSE:
               _loc4_ = "IconCR_PhotoMode";
               break;
            case REWARD_TYPE_ENUM_COMPONENTS:
               _loc4_ = "IconCR_Components";
               break;
            case REWARD_TYPE_ENUM_EXPERIENCE:
               _loc4_ = "IconCR_Experience";
               break;
            case REWARD_TYPE_ENUM_BADGES:
               _loc4_ = "IconCR_Badges";
               break;
            case REWARD_TYPE_ENUM_STIMPAKS:
               _loc4_ = "IconCR_Stimpaks";
               break;
            case REWARD_TYPE_ENUM_CHEMS:
               _loc4_ = "IconCR_Chems";
               break;
            case REWARD_TYPE_ENUM_BOOK:
               _loc4_ = "IconCR_Recipe";
               break;
            case REWARD_TYPE_ENUM_CAPS:
               _loc4_ = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_LEGENDARY_TOKENS:
               _loc4_ = "IconCR_LegendaryToken";
               break;
            case REWARD_TYPE_ENUM_POSSUM_BADGES:
            case REWARD_TYPE_ENUM_TADPOLE_BADGES:
               _loc4_ = "IconCR_Caps";
               break;
            case REWARD_TYPE_ENUM_CUSTOM_ICON:
               if(param3.length > 0)
               {
                  _loc4_ = param3;
                  break;
               }
               throw new Error("GlobalFunc.setChallengeRewardIcon: No custom icon specified.");
               break;
            case REWARD_TYPE_ENUM_CAMP:
               _loc4_ = "IconCR_Camp";
               break;
            case REWARD_TYPE_ENUM_GOLD_BULLION:
               _loc4_ = "IconCR_GoldBullion";
               break;
            case REWARD_TYPE_ENUM_SCORE:
               _loc4_ = "IconCR_Score";
               break;
            case REWARD_TYPE_ENUM_REPAIR_KIT:
               _loc4_ = "IconCR_RepairKit";
               break;
            case REWARD_TYPE_ENUM_LUNCH_BOX:
               _loc4_ = "IconCR_LunchBox";
               break;
            case REWARD_TYPE_ENUM_PREMIUM:
               _loc4_ = "IconCR_Premium";
               break;
            case REWARD_TYPE_ENUM_SCORE_BOOST:
               _loc4_ = "IconCR_ScoreBoost";
               break;
            case REWARD_TYPE_ENUM_STAMPS:
               _loc4_ = "IconCR_Stamps";
               break;
            case REWARD_TYPE_ENUM_SCOUT_BACKPACK:
               _loc4_ = "IconCR_ScoutBackpack";
               break;
            case REWARD_TYPE_ENUM_SCOUT_BANNER:
               _loc4_ = "IconCR_ScoutBanner";
               break;
            case REWARD_TYPE_ENUM_FOOD_AND_DRINK:
               _loc4_ = "IconCR_FoodAndDrink";
               break;
            case REWARD_TYPE_ENUM_RE_ROLLER:
               _loc4_ = "IconCR_ReRoller";
               break;
            case REWARD_TYPE_ENUM_SCORE_BOOSTER_CONSUMABLE:
               _loc4_ = "IconCR_ScoreBoosterConsumable";
               break;
            case REWARD_TYPE_ENUM_FLAIR:
               _loc4_ = "IconCR_Flair";
               break;
            case REWARD_TYPE_ENUM_TICKETS:
               _loc4_ = "IconCR_Ticket";
               break;
            case REWARD_TYPE_ENUM_PLAYER_TITLE:
               _loc4_ = "IconCR_PlayerTitle";
         }
         return param1.setContainerIconClip(_loc4_);
      }
      
      public static function parseStatValue(param1:Number, param2:uint) : String
      {
         switch(param2)
         {
            case GlobalFunc.STAT_VALUE_TYPE_TIME:
               return ShortTimeString(param1);
            default:
               return param1.toString();
         }
      }
      
      public static function ShortTimeStringMinutes(param1:Number) : String
      {
         var _loc2_:TextField = new TextField();
         var _loc3_:Number = 0;
         var _loc4_:Number = Math.floor(param1 / 86400);
         _loc3_ = param1 % 86400;
         var _loc5_:Number = Math.floor(_loc3_ / 3600);
         _loc3_ = param1 % 3600;
         var _loc6_:Number = Math.floor(_loc3_ / 60);
         var _loc7_:* = 0;
         if(_loc4_ >= 1)
         {
            _loc2_.text = "$ShortTimeDays";
            _loc7_ = _loc4_;
         }
         else if(_loc5_ >= 1)
         {
            _loc2_.text = "$ShortTimeHours";
            _loc7_ = _loc5_;
         }
         else
         {
            _loc2_.text = "$ShortTimeMinutes";
            _loc7_ = _loc6_;
         }
         _loc2_.text = _loc2_.text.replace("{time}",_loc7_.toString());
         return _loc2_.text;
      }
      
      public static function ShortTimeString(param1:Number) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:TextField = new TextField();
         var _loc4_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc5_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc6_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc7_:Number = Math.floor(_loc2_);
         var _loc8_:* = 0;
         if(_loc4_ >= 1)
         {
            _loc3_.text = "$ShortTimeDays";
            _loc8_ = _loc4_;
         }
         else if(_loc5_ >= 1)
         {
            _loc3_.text = "$ShortTimeHours";
            _loc8_ = _loc5_;
         }
         else if(_loc6_ >= 1)
         {
            _loc3_.text = "$ShortTimeMinutes";
            _loc8_ = _loc6_;
         }
         else if(_loc7_ >= 1)
         {
            _loc3_.text = "$ShortTimeSeconds";
            _loc8_ = _loc7_;
         }
         else
         {
            _loc3_.text = "$ShortTimeSecond";
            _loc8_ = _loc7_;
         }
         if(_loc8_ != 0)
         {
            _loc3_.text = _loc3_.text.replace("{time}",_loc8_.toString());
            return _loc3_.text;
         }
         return "0";
      }
      
      public static function SimpleTimeString(param1:Number) : String
      {
         var _loc2_:Number = 0;
         var _loc3_:TextField = new TextField();
         var _loc4_:Number = Math.floor(param1 / 86400);
         _loc2_ = param1 % 86400;
         var _loc5_:Number = Math.floor(_loc2_ / 3600);
         _loc2_ = param1 % 3600;
         var _loc6_:Number = Math.floor(_loc2_ / 60);
         _loc2_ = param1 % 60;
         var _loc7_:Number = Math.floor(_loc2_);
         var _loc8_:* = 0;
         if(_loc4_ > 1)
         {
            _loc3_.text = "$SimpleTimeDays";
            _loc8_ = _loc4_;
         }
         else if(_loc4_ == 1)
         {
            _loc3_.text = "$SimpleTimeDay";
            _loc8_ = _loc4_;
         }
         else if(_loc5_ > 1)
         {
            _loc3_.text = "$SimpleTimeHours";
            _loc8_ = _loc5_;
         }
         else if(_loc5_ == 1)
         {
            _loc3_.text = "$SimpleTimeHour";
            _loc8_ = _loc5_;
         }
         else if(_loc6_ > 1)
         {
            _loc3_.text = "$SimpleTimeMinutes";
            _loc8_ = _loc6_;
         }
         else if(_loc6_ == 1)
         {
            _loc3_.text = "$SimpleTimeMinute";
            _loc8_ = _loc6_;
         }
         else if(_loc7_ > 1)
         {
            _loc3_.text = "$SimpleTimeSeconds";
            _loc8_ = _loc7_;
         }
         else if(_loc7_ == 1)
         {
            _loc3_.text = "$SimpleTimeSecond";
            _loc8_ = _loc7_;
         }
         if(_loc8_ != 0)
         {
            _loc3_.text = _loc3_.text.replace("{time}",_loc8_.toString());
            return _loc3_.text;
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
            param1 = "Textures/ATX/Storefront/Player/PlayerIcons/ATX_PlayerIcon_VaultBoy_76.dds";
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
            var _loc5_:Number = NaN;
            var _loc6_:Boolean = false;
            if(!param1 || param1 == "")
            {
               param1 = " ";
            }
            if(param3 && param1.charAt(0) != "$")
            {
               param1 = param1.toUpperCase();
            }
            var _loc4_:TextFormat = this.getTextFormat();
            if(param2)
            {
               _loc5_ = Number(_loc4_.letterSpacing);
               _loc6_ = Boolean(_loc4_.kerning);
               this.htmlText = param1;
               (_loc4_ = this.getTextFormat()).letterSpacing = _loc5_;
               _loc4_.kerning = _loc6_;
               this.setTextFormat(_loc4_);
               this.htmlText = param1;
            }
            else
            {
               this.text = param1;
               this.setTextFormat(_loc4_);
               this.text = param1;
            }
         };
      }
      
      public static function TruncateSingleLineText(param1:TextField) : *
      {
         var _loc2_:int = 0;
         if(param1.text.length > 3)
         {
            _loc2_ = param1.getCharIndexAtPoint(param1.width,0);
            if(_loc2_ > 0)
            {
               param1.replaceText(_loc2_ - 1,param1.length,"…");
            }
         }
      }
      
      public static function SetTruncatedMultilineText(param1:TextField, param2:String, param3:Boolean = false) : *
      {
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc10_:* = undefined;
         var _loc4_:TextLineMetrics = param1.getLineMetrics(0);
         var _loc5_:int = param1.height / _loc4_.height;
         param1.text = "W";
         var _loc6_:int = param1.width / param1.textWidth;
         GlobalFunc.SetText(param1,param2,false,param3);
         var _loc7_:int = Math.min(_loc5_,param1.numLines);
         if(param1.numLines > _loc5_)
         {
            _loc8_ = param2;
            _loc10_ = (_loc9_ = param1.getLineOffset(_loc5_ - 1)) + _loc6_ - 1;
            if(_loc8_.charAt(_loc10_ - 1) == " ")
            {
               _loc10_--;
            }
            _loc8_ = _loc8_.substr(0,_loc10_) + "…";
            GlobalFunc.SetText(param1,_loc8_,false,param3);
         }
      }
      
      public static function SetText(param1:TextField, param2:String, param3:Boolean = false, param4:Boolean = false, param5:* = false) : *
      {
         var _loc6_:TextFormat = null;
         var _loc7_:Number = NaN;
         var _loc8_:Boolean = false;
         if(!param2 || param2 == "")
         {
            param2 = " ";
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
            var _loc2_:* = undefined;
            var _loc1_:* = new Array();
            for(_loc2_ in this)
            {
               if(this[_loc2_] is MovieClip && this[_loc2_] != this)
               {
                  _loc1_.push(this[_loc2_]);
               }
            }
            return _loc1_;
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
      
      private static function InspectObjectHelper(param1:Object, param2:Boolean, param3:Boolean, param4:String = "\t") : void
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
                  InspectObjectHelper(propValue,abRecursive,abIncludeProperties,astrIndent + "\t");
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
               InspectObjectHelper(memberValue,true,abIncludeProperties,astrIndent + "\t");
            }
         }
         for each(constMember in typeDef.constant)
         {
            constMemberName = constMember.@name;
            constMemberValue = aObject[constMemberName];
            trace(astrIndent + constMemberName + " = " + constMemberValue + " --const");
            if(abRecursive)
            {
               InspectObjectHelper(constMemberValue,true,abIncludeProperties,astrIndent + "\t");
            }
         }
         for(id in aObject)
         {
            value = aObject[id];
            trace(astrIndent + id + " = " + value);
            if(abRecursive)
            {
               InspectObjectHelper(value,true,abIncludeProperties,astrIndent + "\t");
            }
            else
            {
               for(subid in value)
               {
                  subvalue = value[subid];
                  trace(astrIndent + "\t" + subid + " = " + subvalue);
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
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":param1,
            "soundFormID":0
         }));
      }
      
      public static function PlayMenuSoundWithFormID(param1:uint) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{
            "soundID":"",
            "soundFormID":param1
         }));
      }
      
      public static function ShowHUDMessage(param1:String) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.SHOW_HUD_MESSAGE,{"text":param1}));
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
      
      public static function updateVoiceIndicator(param1:MovieClip, param2:Boolean, param3:Boolean, param4:Boolean, param5:Boolean = true, param6:Boolean = false) : void
      {
         if(!param2)
         {
            param1.gotoAndStop("muted");
         }
         else if(!param4)
         {
            param1.gotoAndStop("hasMicSpeakingChannel");
         }
         else if(param3)
         {
            param1.gotoAndStop("hasMicSpeaking");
         }
         else
         {
            param1.gotoAndStop("hasMic");
         }
         if(param1.Icon_mc)
         {
            if(param6)
            {
               param1.Icon_mc.gotoAndStop("enemy");
            }
            else if(param5)
            {
               param1.Icon_mc.gotoAndStop("ally");
            }
            else
            {
               param1.Icon_mc.gotoAndStop("neutral");
            }
         }
      }
      
      public static function quickMultiLineShrinkToFit(param1:TextField, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:TextFormat = param1.getTextFormat();
         if(param2 == 0)
         {
            param2 = _loc4_.size as Number;
         }
         _loc4_.size = param2;
         _loc4_.leading = param3;
         param1.setTextFormat(_loc4_);
         var _loc5_:Boolean = false;
         if(getTextfieldSize(param1) > param1.height)
         {
            _loc4_.size = TEXT_SIZE_VERYSMALL;
            _loc4_.leading = TEXT_LEADING_MIN;
            param1.setTextFormat(_loc4_);
            _loc5_ = true;
         }
         if(_loc5_ && getTextfieldSize(param1) > param1.height)
         {
            _loc4_.size = TEXT_SIZE_MIN;
            _loc4_.leading = TEXT_LEADING_MIN;
            param1.setTextFormat(_loc4_);
         }
      }
      
      public static function shrinkMultiLineTextToFit(param1:TextField, param2:Number = 0, param3:Number = 0) : void
      {
         var _loc4_:TextFormat = param1.getTextFormat();
         if(param2 == 0)
         {
            param2 = _loc4_.size as Number;
         }
         var _loc5_:Number = param2;
         _loc4_.size = _loc5_;
         param1.setTextFormat(_loc4_);
         while(getTextfieldSize(param1) > param1.height - param3 && _loc5_ > TEXT_SIZE_MIN)
         {
            _loc5_--;
            _loc4_.size = _loc5_;
            param1.setTextFormat(_loc4_);
         }
      }
      
      public static function shrinkMultilineToFitLines(param1:TextField, param2:String, param3:Boolean = false) : *
      {
         var _loc4_:TextFormat;
         var _loc5_:Number = (_loc4_ = param1.getTextFormat()).size as Number;
         var _loc6_:TextLineMetrics = param1.getLineMetrics(0);
         var _loc7_:int = param1.height / _loc6_.height;
         GlobalFunc.SetText(param1,param2,false,param3);
         while(param1.numLines > _loc7_ && _loc5_ > TEXT_SIZE_MIN)
         {
            _loc5_--;
            _loc4_.size = _loc5_;
            param1.setTextFormat(_loc4_);
            GlobalFunc.SetText(param1,param2,false,param3);
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
         if(param1 is BCGridList)
         {
            return (param1 as BCGridList).displayHeight;
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
            if(param1["displayHeight"] != null)
            {
               return param1["displayHeight"];
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
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:uint = 0;
         var _loc12_:Object = null;
         var _loc13_:Array = null;
         var _loc14_:uint = 0;
         var _loc7_:uint = param1.length;
         var _loc8_:Number = 0;
         if(_loc7_ > 0)
         {
            _loc9_ = 0;
            _loc10_ = param5 ? -1 : 1;
            _loc13_ = [];
            _loc14_ = param1.length;
            _loc11_ = 0;
            while(_loc11_ < _loc14_)
            {
               if(_loc11_ > 0)
               {
                  _loc8_ += param4;
               }
               _loc13_[_loc11_] = getDisplayObjectSize(param1[_loc11_],param2);
               _loc8_ += _loc13_[_loc11_];
               _loc11_++;
            }
            if(param3 == ALIGN_CENTER)
            {
               _loc9_ = _loc8_ * -0.5;
            }
            else if(param3 == ALIGN_RIGHT)
            {
               _loc9_ = -_loc8_ - _loc13_[0];
            }
            if(param5)
            {
               param1.reverse();
               _loc13_.reverse();
            }
            _loc9_ += param6;
            _loc11_ = 0;
            while(_loc11_ < _loc14_)
            {
               if(param2)
               {
                  param1[_loc11_].y = _loc9_;
               }
               else
               {
                  param1[_loc11_].x = _loc9_;
               }
               _loc9_ += _loc13_[_loc11_] + param4;
               _loc11_++;
            }
         }
         return _loc8_;
      }
      
      public static function StringTrim(param1:String) : String
      {
         var _loc5_:String = null;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = param1.length;
         while(param1.charAt(_loc2_) == " " || param1.charAt(_loc2_) == "\n" || param1.charAt(_loc2_) == "\r" || param1.charAt(_loc2_) == "\t")
         {
            _loc2_++;
         }
         _loc3_ = (_loc5_ = param1.substring(_loc2_)).length - 1;
         while(_loc5_.charAt(_loc3_) == " " || _loc5_.charAt(_loc3_) == "\n" || _loc5_.charAt(_loc3_) == "\r" || _loc5_.charAt(_loc3_) == "\t")
         {
            _loc3_--;
         }
         return _loc5_.substring(0,_loc3_ + 1);
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
      
      public static function HasFFEvent(param1:Object, param2:String) : Boolean
      {
         var obj:Object = null;
         var aDataObject:Object = param1;
         var asEventString:String = param2;
         var result:Boolean = false;
         try
         {
            if(aDataObject.eventArray.length > 0)
            {
               for each(obj in aDataObject.eventArray)
               {
                  if(obj.eventName == asEventString)
                  {
                     result = true;
                     break;
                  }
               }
            }
         }
         catch(e:Error)
         {
            trace(e.getStackTrace() + " The following Fire Forget Event object could not be parsed:");
            GlobalFunc.InspectObject(aDataObject,true);
         }
         return result;
      }
      
      public static function LocalizeFormattedString(param1:String, ... rest) : String
      {
         var _loc3_:String = "";
         var _loc4_:TextField;
         (_loc4_ = new TextField()).text = param1;
         _loc3_ = _loc4_.text;
         var _loc5_:uint = 0;
         while(_loc5_ < rest.length)
         {
            _loc4_.text = rest[_loc5_];
            _loc3_ = _loc3_.replace("{" + (_loc5_ + 1) + "}",_loc4_.text);
            _loc5_++;
         }
         return _loc3_;
      }
      
      public static function BuildLegendaryStarsGlyphString(param1:Object) : String
      {
         var _loc5_:* = undefined;
         var _loc6_:TextField = null;
         var _loc2_:Boolean = false;
         var _loc3_:Number = 0;
         var _loc4_:String = "";
         if(param1 != null && Boolean(param1.hasOwnProperty("isLegendary")))
         {
            _loc2_ = Boolean(param1.isLegendary);
            if(_loc2_ && Boolean(param1.hasOwnProperty("numLegendaryStars")))
            {
               _loc3_ = Number(param1.numLegendaryStars);
               _loc5_ = 0;
               while(_loc5_ < _loc3_)
               {
                  (_loc6_ = new TextField()).text = "$LegendaryModGlyph";
                  _loc4_ += _loc6_.text;
                  _loc5_++;
               }
               _loc4_ = " " + _loc4_;
            }
         }
         return _loc4_;
      }
      
      public static function TrimZeros(param1:String) : String
      {
         var _loc3_:* = undefined;
         var _loc2_:* = param1.indexOf(".");
         if(_loc2_ > -1)
         {
            _loc3_ = param1.length - 1;
            while(_loc3_ > _loc2_)
            {
               if(param1.charAt(_loc3_) != "0")
               {
                  break;
               }
               _loc3_--;
            }
            param1 = _loc3_ == _loc2_ ? param1.substring(0,_loc2_) : param1.substring(0,_loc3_ + 1);
         }
         return param1;
      }
   }
}

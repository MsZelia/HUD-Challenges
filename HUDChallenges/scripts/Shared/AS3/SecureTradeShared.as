package Shared.AS3
{
   import flash.display.MovieClip;
   
   public class SecureTradeShared
   {
      
      public static const MODE_CONTAINER:uint = 0;
      
      public static const MODE_PLAYERVENDING:uint = 1;
      
      public static const MODE_NPCVENDING:uint = 2;
      
      public static const MODE_VENDING_MACHINE:int = 3;
      
      public static const MODE_DISPLAY_CASE:int = 4;
      
      public static const MODE_CAMP_DISPENSER:int = 5;
      
      public static const MODE_FERMENTER:int = 6;
      
      public static const MODE_REFRIGERATOR:int = 7;
      
      public static const MODE_ALLY:int = 8;
      
      public static const MODE_RECHARGER:int = 9;
      
      public static const MODE_FREEZER:int = 10;
      
      public static const MODE_PET:int = 11;
      
      public static const MODE_INVALID:uint = uint.MAX_VALUE;
      
      public static const SUB_MODE_STANDARD:uint = 0;
      
      public static const SUB_MODE_LEGENDARY_VENDOR:uint = 1;
      
      public static const SUB_MODE_LEGENDARY_VENDING_MACHINE:uint = 2;
      
      public static const SUB_MODE_POSSUM_VENDING_MACHINE:uint = 3;
      
      public static const SUB_MODE_TADPOLE_VENDING_MACHINE:uint = 4;
      
      public static const SUB_MODE_DISPENSER_AID_ONLY:uint = 5;
      
      public static const SUB_MODE_DISPENSER_AMMO_ONLY:uint = 6;
      
      public static const SUB_MODE_DISPENSER_JUNK_ONLY:uint = 7;
      
      public static const SUB_MODE_ARMOR_RACK:uint = 8;
      
      public static const SUB_MODE_GOLD_BULLION_VENDOR:uint = 9;
      
      public static const SUB_MODE_GOLD_BULLION_VENDING_MACHINE:uint = 10;
      
      public static const SUB_MODE_ALLY:uint = 11;
      
      public static const SUB_MODE_EXPEDITION_STAMPS_VENDOR:uint = 12;
      
      public static const SUB_MODE_WEAPON_DISPLAY:uint = 13;
      
      public static const SUB_MODE_POWER_ARMOR_DISPLAY:uint = 14;
      
      public static const SUB_MODE_APPAREL_DISPLAY:uint = 15;
      
      public static const SUB_MODE_FOODWATER_DISPLAY:uint = 16;
      
      public static const SUB_MODE_AID_DISPLAY:uint = 17;
      
      public static const SUB_MODE_BOOK_DISPLAY:uint = 18;
      
      public static const SUB_MODE_MISC_DISPLAY:uint = 19;
      
      public static const SUB_MODE_JUNK_DISPLAY:uint = 20;
      
      public static const SUB_MODE_HOLO_DISPLAY:uint = 21;
      
      public static const SUB_MODE_MODS_DISPLAY:uint = 22;
      
      public static const SUB_MODE_AMMO_DISPLAY:uint = 23;
      
      public static const CURRENCY_CAPS:uint = 0;
      
      public static const CURRENCY_LEGENDARY_TOKENS:uint = 1;
      
      public static const CURRENCY_POSSUM_BADGES:uint = 2;
      
      public static const CURRENCY_TADPOLE_BADGES:uint = 3;
      
      public static const CURRENCY_GOLD_BULLION:uint = 4;
      
      public static const CURRENCY_PERK_COINS:uint = 5;
      
      public static const CURRENCY_LEGENDARY_CORES_TIER_1:uint = 6;
      
      public static const CURRENCY_LEGENDARY_CORES_TIER_2:uint = 7;
      
      public static const CURRENCY_LEGENDARY_CORES_TIER_3:uint = 8;
      
      public static const CURRENCY_LEGENDARY_CORES_TIER_4:uint = 9;
      
      public static const CURRENCY_EXPEDITION_ULTRACITE_BATTERY:uint = 10;
      
      public static const CURRENCY_EXPEDITION_STAMPS:uint = 11;
      
      public static const CURRENCY_SUPPLIES:uint = 12;
      
      public static const CURRENCY_INVALID:uint = uint.MAX_VALUE;
      
      public static const MACHINE_TYPE_INVALID:* = 0;
      
      public static const MACHINE_TYPE_VENDING:* = 1;
      
      public static const MACHINE_TYPE_DISPLAY:* = 2;
      
      public static const MACHINE_TYPE_DISPENSER:* = 3;
      
      public static const MACHINE_TYPE_FERMENTER:* = 4;
      
      public static const MACHINE_TYPE_REFRIGERATOR:* = 5;
      
      public static const MACHINE_TYPE_ALLY:* = 6;
      
      public static const MACHINE_TYPE_RECHARGER:* = 7;
      
      public static const MACHINE_TYPE_FREEZER:* = 8;
      
      public static const MACHINE_TYPE_PET:* = 9;
      
      public static const LOOT:* = 0;
      
      public static const POWER_ARMOR:* = 3;
      
      public static const LIMITED_TYPE_STORAGE_SCRAP:* = 7;
      
      public static const LIMITED_TYPE_STORAGE_AMMO:* = 8;
      
      public static const LIMITED_TYPE_STORAGE_AID:* = 9;
      
      public function SecureTradeShared()
      {
         super();
      }
      
      public static function IsCampVendingMenuType(param1:uint) : Boolean
      {
         return param1 == SecureTradeShared.MODE_VENDING_MACHINE || param1 == SecureTradeShared.MODE_DISPLAY_CASE || param1 == SecureTradeShared.MODE_ALLY || param1 == SecureTradeShared.MODE_CAMP_DISPENSER || param1 == SecureTradeShared.MODE_FERMENTER || param1 == SecureTradeShared.MODE_REFRIGERATOR || param1 == SecureTradeShared.MODE_RECHARGER || param1 == SecureTradeShared.MODE_FREEZER || param1 == SecureTradeShared.MODE_PET;
      }
      
      public static function DoesMachineTypeMatchMode(param1:uint, param2:uint) : Boolean
      {
         return param1 == MACHINE_TYPE_VENDING ? param2 == MODE_VENDING_MACHINE : (param1 == MACHINE_TYPE_DISPLAY ? param2 == MODE_DISPLAY_CASE : (param1 == MACHINE_TYPE_DISPENSER ? param2 == MODE_CAMP_DISPENSER : (param1 == MACHINE_TYPE_FERMENTER ? param2 == MODE_FERMENTER : (param1 == MACHINE_TYPE_REFRIGERATOR ? param2 == MODE_REFRIGERATOR : (param1 == MACHINE_TYPE_ALLY ? param2 == MODE_ALLY : (param1 == MACHINE_TYPE_RECHARGER ? param2 == MODE_RECHARGER : (param1 == MACHINE_TYPE_FREEZER ? param2 == MODE_FREEZER : (param1 == MACHINE_TYPE_PET ? param2 == MODE_PET : false))))))));
      }
      
      public static function setCurrencyIcon(param1:SWFLoaderClip, param2:uint, param3:Boolean = false) : MovieClip
      {
         var _loc4_:String = null;
         switch(param2)
         {
            case CURRENCY_CAPS:
               if(param3)
               {
                  _loc4_ = "IconCu_CapsHUD";
               }
               else
               {
                  _loc4_ = "IconCu_Caps";
               }
               break;
            case CURRENCY_LEGENDARY_TOKENS:
               if(param3)
               {
                  _loc4_ = "IconCu_LegendaryTokenHUD";
               }
               else
               {
                  _loc4_ = "IconCu_LegendaryToken";
               }
               break;
            case CURRENCY_POSSUM_BADGES:
               _loc4_ = "IconCu_Possum";
               break;
            case CURRENCY_TADPOLE_BADGES:
               _loc4_ = "IconCu_Tadpole";
               break;
            case CURRENCY_GOLD_BULLION:
               if(param3)
               {
                  _loc4_ = "IconCu_GBHUD";
               }
               else
               {
                  _loc4_ = "IconCu_GB";
               }
               break;
            case CURRENCY_PERK_COINS:
               if(param3)
               {
                  _loc4_ = "IconCu_LGNPerkCoinHUD";
               }
               else
               {
                  _loc4_ = "IconCu_LGNPerkCoin";
               }
               break;
            case CURRENCY_EXPEDITION_ULTRACITE_BATTERY:
               if(param3)
               {
                  _loc4_ = "IconCu_BatteryHUD";
               }
               break;
            case CURRENCY_EXPEDITION_STAMPS:
               if(param3)
               {
                  _loc4_ = "IconCu_StampsHUD";
               }
               else
               {
                  _loc4_ = "IconCu_Stamps";
               }
               break;
            case CURRENCY_SUPPLIES:
               _loc4_ = "IconCu_SuppliesHUD";
         }
         return param1.setContainerIconClip(_loc4_);
      }
   }
}


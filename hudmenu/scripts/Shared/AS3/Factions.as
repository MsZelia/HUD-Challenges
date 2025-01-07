package Shared.AS3
{
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   
   public class Factions
   {
      
      public static const THRESHOLD_TIER_HOSTILE:uint = 0;
      
      public static const THRESHOLD_TIER_CAUTIOUS:uint = 1;
      
      public static const THRESHOLD_TIER_NEUTRAL:uint = 2;
      
      public static const THRESHOLD_TIER_COOPERATIVE:uint = 3;
      
      public static const THRESHOLD_TIER_FRIENDLY:uint = 4;
      
      public static const THRESHOLD_TIER_NEIGHBORLY:uint = 5;
      
      public static const THRESHOLD_TIER_ALLY:uint = 6;
       
      
      public function Factions()
      {
         super();
      }
      
      public static function updateFaceIcon(param1:MovieClip, param2:Object) : void
      {
         param1.gotoAndStop(param2.code);
         param1.Face_mc.gotoAndStop(getReputationFaceFromFromTier(param2.tier));
         param1.Backer_mc.gotoAndStop(getReputationBackerFrameFromTier(param2.tier));
      }
      
      public static function getFactionByID(param1:uint, param2:Array) : Object
      {
         var _loc3_:uint = 0;
         while(_loc3_ < param2.length)
         {
            if(param2[_loc3_].factionID == param1)
            {
               return param2[_loc3_];
            }
            _loc3_++;
         }
         return null;
      }
      
      public static function buildFactionInfo(param1:Object) : Array
      {
         var _loc4_:Object = null;
         var _loc5_:String = null;
         var _loc6_:int = 0;
         var _loc7_:uint = 0;
         var _loc2_:Array = new Array();
         var _loc3_:Array = ["Crater","Foundation"];
         var _loc8_:uint = 0;
         while(_loc8_ < _loc3_.length)
         {
            _loc5_ = _loc3_[_loc8_];
            _loc4_ = param1["factionData" + _loc5_];
            _loc6_ = int(param1["playerRep" + _loc5_]);
            _loc7_ = getReputationTier(_loc6_,_loc4_.reputationTiers);
            _loc2_[_loc8_] = {
               "name":_loc4_.szFactionName,
               "code":_loc3_[_loc8_].toLowerCase(),
               "tier":_loc7_,
               "factionID":_loc4_.uFactionID,
               "tierPercent":getNextReputationTierPercent(_loc6_,_loc7_,_loc4_.reputationTiers)
            };
            _loc8_++;
         }
         return _loc2_;
      }
      
      public static function getNextReputationTierPercent(param1:int, param2:uint, param3:Array) : Number
      {
         if(param2 + 1 >= param3.length)
         {
            return 1;
         }
         var _loc4_:Object = param3[param2];
         var _loc5_:Object = param3[param2 + 1];
         var _loc6_:Number = (param1 - _loc4_.fValue) / (_loc5_.fValue - _loc4_.fValue);
         return GlobalFunc.Clamp(_loc6_,0,1);
      }
      
      public static function getReputationTier(param1:int, param2:Array) : uint
      {
         var _loc3_:uint = param2.length - 1;
         while(_loc3_ > 0)
         {
            if(param1 >= param2[_loc3_].fValue)
            {
               break;
            }
            _loc3_--;
         }
         return _loc3_;
      }
      
      public static function getReputationBackerFrameFromTier(param1:uint) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case THRESHOLD_TIER_HOSTILE:
               _loc2_ = "hostile";
               break;
            case THRESHOLD_TIER_ALLY:
               _loc2_ = "ally";
               break;
            default:
               _loc2_ = "neutral";
         }
         return _loc2_;
      }
      
      public static function getReputationFaceFromFromTier(param1:uint) : String
      {
         var _loc2_:String = "";
         switch(param1)
         {
            case THRESHOLD_TIER_HOSTILE:
               _loc2_ = "hostile";
               break;
            case THRESHOLD_TIER_CAUTIOUS:
               _loc2_ = "cautious";
               break;
            case THRESHOLD_TIER_NEUTRAL:
               _loc2_ = "neutral";
               break;
            case THRESHOLD_TIER_COOPERATIVE:
               _loc2_ = "cooperative";
               break;
            case THRESHOLD_TIER_FRIENDLY:
               _loc2_ = "friendly";
               break;
            case THRESHOLD_TIER_NEIGHBORLY:
               _loc2_ = "neighborly";
               break;
            case THRESHOLD_TIER_ALLY:
               _loc2_ = "ally";
         }
         return _loc2_;
      }
   }
}

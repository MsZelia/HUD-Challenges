package
{
   public class CasinoShared
   {
      
      public static const CASINO_GAME_TYPE_ROULETTE:uint = 0;
      
      public static const CASINO_GAME_TYPE_DERBY_RACE:uint = 1;
      
      public static const CASINO_GAME_TYPE_LUCKY_DICE:uint = 2;
      
      public static const CASINO_GAME_TYPE_SLOTS_1:uint = 3;
      
      public static const CASINO_GAME_TYPE_SLOTS_2:uint = 4;
      
      public static const CASINO_GAME_TYPE_SLOTS_BIG:uint = 5;
      
      public static const ROULETTE_COLOR_RED:uint = 0;
      
      public static const ROULETTE_COLOR_BLACK:uint = 1;
      
      public static const ROULETTE_COLOR_GREEN:uint = 2;
      
      public static const ROULETTE_OPTION_JACKPOT:uint = 0;
      
      public static const ROULETTE_OPTION_FIRST_THIRD:uint = 1;
      
      public static const ROULETTE_OPTION_SECOND_THIRD:uint = 2;
      
      public static const ROULETTE_OPTION_LAST_THIRD:uint = 3;
      
      public static const ROULETTE_OPTION_RED_EVEN:uint = 4;
      
      public static const ROULETTE_OPTION_BLACK_ODD:uint = 5;
      
      public static const ROULETTE_INDEX_FIRST_THIRD:uint = 37;
      
      public static const ROULETTE_INDEX_SECOND_THIRD:uint = 38;
      
      public static const ROULETTE_INDEX_LAST_THIRD:uint = 39;
      
      public static const ROULETTE_INDEX_EVEN:uint = 40;
      
      public static const ROULETTE_INDEX_RED:uint = 40;
      
      public static const ROULETTE_INDEX_BLACK:uint = 41;
      
      public static const ROULETTE_INDEX_ODD:uint = 41;
      
      public static const EVENT_CASINO_CLOSE_MENU:String = "Casino::CloseMenu";
      
      public static const EVENT_CASINO_GET_POSSIBLY_PAYOUT:String = "Casino::GetPossiblePayout";
      
      public static const EVENT_CASINO_CLEAR_POSSIBLE_PAYOUT:String = "Casino::ClearPossiblePayout";
      
      public static const EVENT_CASINO_SUBMIT_BET:String = "Casino::SubmitBet";
      
      public static const EVENT_CASINO_DATA:String = "CasinoData";
      
      public static const PAYOUT_CAPS_ICON_SPACING:Number = 3;
       
      
      public function CasinoShared()
      {
         super();
      }
   }
}

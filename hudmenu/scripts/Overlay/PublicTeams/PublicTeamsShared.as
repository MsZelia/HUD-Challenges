package Overlay.PublicTeams
{
   public final class PublicTeamsShared
   {
      
      public static const EVENT_PUBLIC_TEAMS_DATA:String = "PublicTeamsData";
      
      public static const EVENT_JOIN_PUBLIC_TEAM:String = "SocialData::JoinPublicTeam";
      
      public static const EVENT_CREATE_PUBLIC_TEAM:String = "SocialData::CreatePublicTeam";
      
      public static const EVENT_CHANGE_PUBLIC_TEAM_TYPE:String = "SocialData::ChangePublicTeamType";
      
      public static const EVENT_CONVERT_TEAM_TO_PUBLIC:String = "SocialData::ConvertTeamToPublic";
      
      public static const LINKAGE_PUBLIC_TEAMS_ENTRY:String = "Overlay.PublicTeams.PublicTeamsEntry";
      
      public static const LINKAGE_PUBLIC_TEAMS_MODAL_ENTRY:String = "Overlay.PublicTeams.PublicTeamsModalEntry";
      
      public static const LINKAGE_PUBLIC_TEAMS_BOND_ENTRY:String = "Overlay.PublicTeams.PublicTeamsBondEntry";
      
      public static const TEAM_TYPE_NEW:uint = 99;
      
      public static const TEAM_TYPE_UNAVAILABLE:uint = 999;
      
      public static const TEAM_TYPE_PRIVATE:uint = 0;
      
      public static const TEAM_TYPE_HUNTERS:uint = 1;
      
      public static const TEAM_TYPE_ROLEPLAY:uint = 2;
      
      public static const TEAM_TYPE_EVENT:uint = 3;
      
      public static const TEAM_TYPE_EXPLORATION:uint = 4;
      
      public static const TEAM_TYPE_WORKSHOP:uint = 5;
      
      public static const TEAM_TYPE_CASUAL:uint = 6;
      
      public static const TEAM_TYPE_SPECIAL_EVENT:uint = 7;
      
      public static const TEAM_TYPE_EXTRATEAM:uint = 8;
      
      public static const TEAM_TYPE_TRADING:uint = 9;
      
      public static const TEAM_TYPE_WORKSHOP_RAID:uint = 10;
      
      public static const TEAM_TYPE_INVALID:uint = 11;
      
      public static const TEAM_TYPE_DAILY_OPS:uint = 12;
      
      public static const TEAM_TYPE_EXPEDITIONS:uint = 13;
      
      public static const TEAM_TYPE_RAIDS:uint = 14;
      
      public static const TEAM_STATUS_JOIN:uint = 0;
      
      public static const TEAM_STATUS_LEADER:uint = 1;
      
      public static const TEAM_STATUS_MEMBER:uint = 2;
      
      public static const TEAM_STATUS_FULL:uint = 3;
      
      public static const HIDE_BOND_METER:int = -1;
       
      
      public function PublicTeamsShared()
      {
         super();
      }
      
      public static function DecideTeamTypeString(param1:uint) : String
      {
         switch(param1)
         {
            case TEAM_TYPE_NEW:
               return "CreateNew";
            case TEAM_TYPE_UNAVAILABLE:
               return "Unavailable";
            case TEAM_TYPE_EVENT:
               return "Event";
            case TEAM_TYPE_EXTRATEAM:
               return "ExtraTeam";
            case TEAM_TYPE_WORKSHOP:
               return "Workshop";
            case TEAM_TYPE_SPECIAL_EVENT:
               return "SpecialEvent";
            case TEAM_TYPE_ROLEPLAY:
               return "Roleplay";
            case TEAM_TYPE_TRADING:
               return "Trading";
            case TEAM_TYPE_CASUAL:
               return "Casual";
            case TEAM_TYPE_HUNTERS:
               return "Hunters";
            case TEAM_TYPE_EXPLORATION:
               return "Exploration";
            case TEAM_TYPE_WORKSHOP_RAID:
               return "WorkshopRaid";
            case TEAM_TYPE_DAILY_OPS:
               return "DailyOps";
            case TEAM_TYPE_EXPEDITIONS:
               return "Expeditions";
            case TEAM_TYPE_RAIDS:
               return "Raids";
            default:
               return "";
         }
      }
      
      public static function IsValidPublicTeamType(param1:uint) : Boolean
      {
         var _loc2_:Boolean = false;
         if(param1 && param1 != TEAM_TYPE_PRIVATE && param1 != TEAM_TYPE_INVALID && param1 != TEAM_TYPE_UNAVAILABLE && param1 != TEAM_TYPE_NEW && DecideTeamTypeString(param1) != "")
         {
            _loc2_ = true;
         }
         return _loc2_;
      }
   }
}

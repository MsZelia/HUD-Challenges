package
{
   import utils.Parser;
   
   public class HUDChallengesConfig
   {
      
      private static var _config:Object;
      
      public static const STATE_HIDDEN:String = "hidden";
      
      public static const STATE_SHOWN:String = "shown";
      
      public static const DEFAULT_CHALLENGE_FORMAT:* = "{text} {currentValue}/{thresholdValue}";
      
      public static const DEFAULT_EVENT_FORMAT:* = "{text} {time}";
      
      public static const DEFAULT_MUTATED_EVENT_FORMAT:* = "{text} [{mutation}] {time}";
      
      public static const DEFAULT_SCORE_FORMAT:* = "SCORE [{currentRank}] {currentValue}/{thresholdValue} ({progress}%) +{currentBoost}% boost";
      
      public static const DEFAULT_XP_FORMAT:* = "{text} [{currentLevel}] {currentValue}/{thresholdValue} ({lastChangeValue})";
      
      public static const DEFAULT_RAID_XP_FORMAT:* = "Raid XP: {xp}";
      
      public static const DEFAULT_MINERVA_AVAILABLE_FORMAT:* = "Minerva is at {location} for {time}";
      
      public static const DEFAULT_MINERVA_NOT_AVAILABLE_FORMAT:* = "Minerva will be at {location} in {time}";
      
      public static const DEFAULT_MINERVA_LOCATIONS:* = ["Foundation","Crater","Fort Atlas","Whitesprings"];
      
      public static const DEFAULT_NUCLEAR_CODES_TEXT_FORMAT:* = "A:{codeAlpha}  B:{codeBravo}  C:{codeCharlie} ({time})";
      
      public static const DEFAULT_EVENT_TIMER_TEXT_FORMAT:* = "Next public event in: {time}";
      
      public static const DEFAULT_SEASON_END_FORMAT:* = "Season end: {time}";
      
      public static const DEFAULT_MINISEASON_ACTIVE_FORMAT:* = "MiniSeason end: {time} [{currentValue}/{thresholdValue}]";
      
      public static const DEFAULT_MINISEASON_INACTIVE_FORMAT:* = "MiniSeason start: {time}";
      
      public static const DEFAULT_VERDANT_SEASON_ACTIVE_FORMAT:* = "Verdant season active in {region} ({time} ago)";
      
      public static const DEFAULT_VERDANT_SEASON_ENDED_FORMAT:* = "Verdant season ended in {region} ({time} ago)";
      
      public static const DEFAULT_TIME_FORMAT_LONG:* = "{d}:{h}:{m}:{s}";
      
      public static const DEFAULT_TIME_FORMAT_MID:* = "{h}:{m}:{s}";
      
      public static const DEFAULT_TIME_FORMAT_SHORT:* = "{m}:{s}";
      
      public static const DEFAULT_FISHING_SEASON_TEXT1_FORMAT:* = "{month} fishing season ends in {time}";
      
      public static const DEFAULT_FISHING_SEASON_TEXT2_FORMAT:* = "{caught} {fish} - {region1} / {region2}";
      
      public static const DEFAULT_FISHING_SEASON_CAUGHT:* = ["Ø","¬"];
      
      public function HUDChallengesConfig()
      {
         super();
      }
      
      public static function get() : Object
      {
         return _config;
      }
      
      public static function init(jsonObject:*) : Object
      {
         var config:* = jsonObject;
         config.x = Parser.parseNumber(config.x,0);
         config.y = Parser.parseNumber(config.y,0);
         config.anchor = Boolean(config.anchor) ? config.anchor.toLowerCase() : "top";
         config.ySpacing = Parser.parseNumber(config.ySpacing,0);
         config.width = Parser.parseNumber(config.width,250);
         config.textSize = Parser.parseNumber(config.textSize,18);
         config.textFont = Boolean(config.textFont) ? config.textFont : "$MAIN_Font";
         config.textAlign = Boolean(config.textAlign) ? config.textAlign.toLowerCase() : "left";
         config.textColor = Parser.parseNumber(config.textColor,16777215);
         config.textShadow = Parser.parseBoolean(config.textShadow,true);
         config.background = Parser.parseBoolean(config.background,false);
         config.backgroundColor = Parser.parseNumber(config.backgroundColor,2236962);
         config.alpha = Parser.parseNumber(config.alpha,1);
         config.backgroundAlpha = Parser.parseNumber(config.backgroundAlpha,0.5);
         config.blendMode = Boolean(config.blendMode) ? config.blendMode.toLowerCase() : "normal";
         config.textBlendMode = Boolean(config.textBlendMode) ? config.textBlendMode.toLowerCase() : "normal";
         config.refresh = Parser.parseNumber(config.refresh,1000);
         config.offsetUTC = Parser.parseNumber(config.offsetUTC,0);
         config.toggleVisibilityHotkey = Parser.parsePositiveNumber(config.toggleVisibilityHotkey,0);
         config.forceHideHotkey = Parser.parsePositiveNumber(config.forceHideHotkey,0);
         if(!config.formats)
         {
            config.formats = {};
            config.formats.daily = DEFAULT_CHALLENGE_FORMAT;
            config.formats.weekly = DEFAULT_CHALLENGE_FORMAT;
            config.formats.monthly = DEFAULT_CHALLENGE_FORMAT;
            config.formats.events = DEFAULT_CHALLENGE_FORMAT;
            config.formats.seasonal = DEFAULT_CHALLENGE_FORMAT;
            config.formats.character = DEFAULT_CHALLENGE_FORMAT;
            config.formats.survival = DEFAULT_CHALLENGE_FORMAT;
            config.formats.combat = DEFAULT_CHALLENGE_FORMAT;
            config.formats.social = DEFAULT_CHALLENGE_FORMAT;
            config.formats.world = DEFAULT_CHALLENGE_FORMAT;
            config.formats.fishing = DEFAULT_CHALLENGE_FORMAT;
            config.formats.burning_springs = DEFAULT_CHALLENGE_FORMAT;
            config.formats.mutatedEvent = DEFAULT_MUTATED_EVENT_FORMAT;
            config.formats.publicEvent = DEFAULT_EVENT_FORMAT;
            config.formats.worldEvent = DEFAULT_EVENT_FORMAT;
            config.formats.caravan = DEFAULT_EVENT_FORMAT;
            config.formats.showSeasonEndTime = DEFAULT_SEASON_END_FORMAT;
            config.formats.showRaidXP = DEFAULT_RAID_XP_FORMAT;
            config.formats.timeLong = DEFAULT_TIME_FORMAT_LONG;
            config.formats.timeMid = DEFAULT_TIME_FORMAT_MID;
            config.formats.timeShort = DEFAULT_TIME_FORMAT_SHORT;
         }
         else
         {
            if(!config.formats.daily)
            {
               config.formats.daily = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.weekly)
            {
               config.formats.weekly = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.monthly)
            {
               config.formats.monthly = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.events)
            {
               config.formats.events = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.seasonal)
            {
               config.formats.seasonal = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.character)
            {
               config.formats.character = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.survival)
            {
               config.formats.survival = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.combat)
            {
               config.formats.combat = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.social)
            {
               config.formats.social = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.world)
            {
               config.formats.world = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.fishing)
            {
               config.formats.fishing = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.burning_springs)
            {
               config.formats.burning_springs = DEFAULT_CHALLENGE_FORMAT;
            }
            if(!config.formats.mutatedEvent)
            {
               config.formats.mutatedEvent = DEFAULT_MUTATED_EVENT_FORMAT;
            }
            if(!config.formats.publicEvent)
            {
               config.formats.publicEvent = DEFAULT_EVENT_FORMAT;
            }
            if(!config.formats.worldEvent)
            {
               config.formats.worldEvent = DEFAULT_EVENT_FORMAT;
            }
            if(!config.formats.caravan)
            {
               config.formats.caravan = DEFAULT_EVENT_FORMAT;
            }
            if(!config.formats.showSeasonEndTime)
            {
               config.formats.showSeasonEndTime = DEFAULT_SEASON_END_FORMAT;
            }
            if(!config.formats.showRaidXP)
            {
               config.formats.showRaidXP = DEFAULT_RAID_XP_FORMAT;
            }
            if(!config.formats.timeLong)
            {
               config.formats.timeLong = DEFAULT_TIME_FORMAT_LONG;
            }
            if(!config.formats.timeMid)
            {
               config.formats.timeMid = DEFAULT_TIME_FORMAT_MID;
            }
            if(!config.formats.timeShort)
            {
               config.formats.timeShort = DEFAULT_TIME_FORMAT_SHORT;
            }
         }
         if(!config.xpBar)
         {
            config.xpBar = {};
            config.xpBar.enabled = true;
            config.xpBar.text = DEFAULT_XP_FORMAT;
            config.xpBar.alignVertical = "bottom";
            config.xpBar.alignHorizontal = "left";
            config.xpBar.height = 4;
         }
         else
         {
            config.xpBar.enabled = Parser.parseBoolean(config.xpBar.enabled,true);
            config.xpBar.text = Boolean(config.xpBar.text) ? config.xpBar.text : DEFAULT_XP_FORMAT;
            config.xpBar.alignVertical = Boolean(config.xpBar.alignVertical) ? config.xpBar.alignVertical.toLowerCase() : "bottom";
            config.xpBar.alignHorizontal = Boolean(config.xpBar.alignHorizontal) ? config.xpBar.alignHorizontal.toLowerCase() : "left";
            config.xpBar.height = Parser.parseNumber(config.xpBar.height,4);
         }
         if(!config.scoreBar)
         {
            config.scoreBar = {};
            config.scoreBar.enabled = true;
            config.scoreBar.text = DEFAULT_SCORE_FORMAT;
            config.scoreBar.alignVertical = "bottom";
            config.scoreBar.alignHorizontal = "left";
            config.scoreBar.height = 4;
         }
         else
         {
            config.scoreBar.enabled = Parser.parseBoolean(config.scoreBar.enabled,true);
            config.scoreBar.text = Boolean(config.scoreBar.text) ? config.scoreBar.text : DEFAULT_SCORE_FORMAT;
            config.scoreBar.alignVertical = Boolean(config.scoreBar.alignVertical) ? config.scoreBar.alignVertical.toLowerCase() : "bottom";
            config.scoreBar.alignHorizontal = Boolean(config.scoreBar.alignHorizontal) ? config.scoreBar.alignHorizontal.toLowerCase() : "left";
            config.scoreBar.height = Parser.parseNumber(config.scoreBar.height,4);
         }
         if(!config.minerva)
         {
            config.minerva = {};
            config.minerva.availableText = DEFAULT_MINERVA_AVAILABLE_FORMAT;
            config.minerva.notAvailableText = DEFAULT_MINERVA_NOT_AVAILABLE_FORMAT;
            config.minerva.offsetHours = 0;
            config.minerva.locations = DEFAULT_MINERVA_LOCATIONS;
            config.minerva.hideIfNotAvailable = false;
         }
         else
         {
            config.minerva.availableText = Boolean(config.minerva.availableText) ? config.minerva.availableText : DEFAULT_MINERVA_AVAILABLE_FORMAT;
            config.minerva.notAvailableText = Boolean(config.minerva.notAvailableText) ? config.minerva.notAvailableText : DEFAULT_MINERVA_NOT_AVAILABLE_FORMAT;
            config.minerva.offsetHours = Parser.parseNumber(config.minerva.offsetHours,0);
            config.minerva.locations = Boolean(config.minerva.locations) && config.minerva.locations.length == 4 ? config.minerva.locations : DEFAULT_MINERVA_LOCATIONS;
            config.minerva.hideIfNotAvailable = Boolean(config.minerva.hideIfNotAvailable);
         }
         if(!config.nuclearCodes)
         {
            config.nuclearCodes = {};
            config.nuclearCodes.offsetHours = Parser.parseNumber(config.nuclearCodes.offsetHours,0);
            config.nuclearCodes.text = DEFAULT_NUCLEAR_CODES_TEXT_FORMAT;
         }
         else
         {
            config.nuclearCodes.offsetHours = Parser.parseNumber(config.nuclearCodes.offsetHours,0);
            config.nuclearCodes.text = Boolean(config.nuclearCodes.text) ? config.nuclearCodes.text : DEFAULT_NUCLEAR_CODES_TEXT_FORMAT;
         }
         if(!config.eventTimer)
         {
            config.eventTimer = {};
            config.eventTimer.showWithDurationBelowMinutes = Parser.parseNumber(config.eventTimer.showWithDurationBelowMinutes,5);
            config.eventTimer.eventTimestamps = [20,40,60];
            config.eventTimer.text = DEFAULT_EVENT_TIMER_TEXT_FORMAT;
         }
         else
         {
            config.eventTimer.showWithDurationBelowMinutes = Parser.parseNumber(config.eventTimer.showWithDurationBelowMinutes,5);
            config.eventTimer.eventTimestamps = Boolean(config.eventTimer.eventTimestamps) ? config.eventTimer.eventTimestamps : [20,40,60];
            config.eventTimer.text = Boolean(config.eventTimer.text) ? config.eventTimer.text : DEFAULT_EVENT_TIMER_TEXT_FORMAT;
         }
         if(!config.miniSeason)
         {
            config.miniSeason = {};
            config.miniSeason.hideIfInactive = false;
            config.miniSeason.hideIfRewardsClaimed = false;
            config.miniSeason.activeText = DEFAULT_MINISEASON_ACTIVE_FORMAT;
            config.miniSeason.inactiveText = DEFAULT_MINISEASON_INACTIVE_FORMAT;
         }
         else
         {
            config.miniSeason.hideIfInactive = Boolean(config.miniSeason.hideIfInactive);
            config.miniSeason.hideIfRewardsClaimed = Boolean(config.miniSeason.hideIfRewardsClaimed);
            config.miniSeason.activeText = Boolean(config.miniSeason.activeText) ? config.miniSeason.activeText : DEFAULT_MINISEASON_ACTIVE_FORMAT;
            config.miniSeason.inactiveText = Boolean(config.miniSeason.inactiveText) ? config.miniSeason.inactiveText : DEFAULT_MINISEASON_INACTIVE_FORMAT;
         }
         if(!config.verdantSeason)
         {
            config.verdantSeason = {};
            config.verdantSeason.hideEndedSeasonAfter = 30;
            config.verdantSeason.activeText = DEFAULT_VERDANT_SEASON_ACTIVE_FORMAT;
            config.verdantSeason.endedText = DEFAULT_VERDANT_SEASON_ENDED_FORMAT;
         }
         else
         {
            config.verdantSeason.hideEndedSeasonAfter = Parser.parseNumber(config.verdantSeason.hideEndedSeasonAfter,30);
            config.verdantSeason.activeText = Boolean(config.verdantSeason.activeText) ? config.verdantSeason.activeText : DEFAULT_VERDANT_SEASON_ACTIVE_FORMAT;
            config.verdantSeason.endedText = Boolean(config.verdantSeason.endedText) ? config.verdantSeason.endedText : DEFAULT_VERDANT_SEASON_ENDED_FORMAT;
         }
         if(!config.fishingSeason)
         {
            config.fishingSeason = {};
            config.fishingSeason.text1 = DEFAULT_FISHING_SEASON_TEXT1_FORMAT;
            config.fishingSeason.text2 = DEFAULT_FISHING_SEASON_TEXT2_FORMAT;
            config.fishingSeason.offsetHours = 0;
            config.fishingSeason.caught = DEFAULT_FISHING_SEASON_CAUGHT;
            config.fishingSeason.hideIfCaught = false;
         }
         else
         {
            config.fishingSeason.text1 = Boolean(config.fishingSeason.text1) ? config.fishingSeason.text1 : DEFAULT_FISHING_SEASON_TEXT1_FORMAT;
            config.fishingSeason.text2 = Boolean(config.fishingSeason.text1) ? config.fishingSeason.text2 : DEFAULT_FISHING_SEASON_TEXT2_FORMAT;
            config.fishingSeason.offsetHours = Parser.parseNumber(config.fishingSeason.offsetHours,0);
            config.fishingSeason.caught = Boolean(config.fishingSeason.caught) && config.fishingSeason.caught.length == 2 ? config.fishingSeason.caught : DEFAULT_FISHING_SEASON_CAUGHT;
            config.fishingSeason.hideIfCaught = Boolean(config.fishingSeason.hideIfCaught);
         }
         if(!config.showOnlyTrackedChallenges)
         {
            config.showOnlyTrackedChallenges = {};
         }
         if(!config.showSubChallenges)
         {
            config.showSubChallenges = {};
         }
         if(!config.countdownTimerForEvents)
         {
            config.countdownTimerForEvents = {};
            config.countdownTimerForEvents.enabled = false;
         }
         else
         {
            config.countdownTimerForEvents.enabled = Boolean(config.countdownTimerForEvents.enabled);
            if(!config.countdownTimerForEvents.events)
            {
               config.countdownTimerForEvents.events = {};
            }
         }
         if(!config.displayData)
         {
            config.displayData = [];
            config.displayData.push("showVersion");
         }
         if(!config.customColors)
         {
            config.customColors = {};
         }
         else
         {
            for(color in config.customColors)
            {
               config.customColors[color] = Parser.parseNumber(config.customColors[color],config.textColor);
            }
         }
         if(!config.customEventChallengeColors)
         {
            config.customEventChallengeColors = {};
            config.customEventChallengeColors.keys = [];
         }
         else
         {
            var keys:Array = [];
            for(color in config.customEventChallengeColors)
            {
               config.customEventChallengeColors[color] = Parser.parseNumber(config.customEventChallengeColors[color],config.textColor);
               keys.push(color);
            }
            config.customEventChallengeColors.keys = keys;
         }
         config.hideEventsState = getState(config.hideEventsState);
         if(!config.hideEvents)
         {
            config.hideEvents = [];
         }
         else
         {
            for(i in config.hideEvents)
            {
               config.hideEvents[i] = config.hideEvents[i].toLowerCase();
            }
         }
         config.hideChallengesState = getState(config.hideChallengesState);
         if(!config.hideChallenges)
         {
            config.hideChallenges = [];
         }
         else
         {
            for(i in config.hideChallenges)
            {
               config.hideChallenges[i] = config.hideChallenges[i].toLowerCase();
            }
         }
         config.HUDModesState = getState(config.HUDModesState);
         if(!config.HUDModes)
         {
            config.HUDModes = [];
         }
         _config = config;
         return _config;
      }
      
      private static function getState(data:Object) : String
      {
         if(!data)
         {
            return STATE_HIDDEN;
         }
         if(data.toLowerCase() == STATE_SHOWN)
         {
            return STATE_SHOWN;
         }
         return STATE_HIDDEN;
      }
   }
}


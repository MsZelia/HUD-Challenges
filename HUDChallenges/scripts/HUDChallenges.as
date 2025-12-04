package
{
   import Shared.*;
   import Shared.AS3.*;
   import Shared.AS3.Data.*;
   import Shared.AS3.Events.*;
   import com.adobe.serialization.json.*;
   import fl.motion.*;
   import flash.display.*;
   import flash.events.*;
   import flash.filters.*;
   import flash.geom.*;
   import flash.net.*;
   import flash.system.*;
   import flash.text.*;
   import flash.ui.*;
   import flash.utils.*;
   import scaleform.gfx.*;
   import utils.*;
   
   public class HUDChallenges extends MovieClip
   {
      
      public static const MOD_NAME:String = "HUDChallenges";
      
      public static const MOD_VERSION:String = "1.2.7";
      
      public static const FULL_MOD_NAME:String = MOD_NAME + " " + MOD_VERSION;
      
      public static const CONFIG_FILE:String = "../HUDChallenges.json";
      
      public static const CONFIG_RELOAD_TIME:uint = 10100;
      
      private static const DATA_SEPARATOR:String = "separator";
      
      private static const DATA_EMPTY_SPACE:String = "emptyspace";
      
      private static const DATA_TEXT:String = "text";
      
      private static const DATA_CHALLENGES:String = "challenges";
      
      private static const DATA_EVENTS:String = "events";
      
      private static const DATA_POSITION_X:String = "positionX";
      
      private static const DATA_POSITION_Y:String = "positionY";
      
      private static const DATA_Y_SPACING:String = "ySpacing";
      
      private static const DATA_ALIGN:String = "textAlign";
      
      private static const DATA_SIZE:String = "textSize";
      
      private static const STRING_TEXT:String = "{text}";
      
      private static const STRING_TIME:String = "{time}";
      
      private static const STRING_LOCATION:String = "{location}";
      
      private static const STRING_LIST:String = "{list}";
      
      private static const STRING_MUTATION:String = "{mutation}";
      
      private static const STRING_PARTICIPANTS:String = "{participants}";
      
      private static const STRING_TIME_IN_SECONDS:String = "{timeInSeconds}";
      
      private static const STRING_TIME_IN_MINUTES:String = "{timeInMinutes}";
      
      private static const STRING_CURRENT_VALUE:String = "{currentValue}";
      
      private static const STRING_THRESHOLD_VALUE:String = "{thresholdValue}";
      
      private static const STRING_PROGRESS:String = "{progress}";
      
      private static const STRING_LAST_CHANGE_VALUE:String = "{lastChangeValue}";
      
      private static const STRING_CURRENT_LEVEL:String = "{currentLevel}";
      
      private static const STRING_CURRENT_RANK:String = "{currentRank}";
      
      private static const STRING_CURRENT_BOOST:String = "{currentBoost}";
      
      private static const STRING_DAILY_EXPIRE:String = "{dailyExpireTime}";
      
      private static const STRING_WEEKLY_EXPIRE:String = "{weeklyExpireTime}";
      
      private static const STRING_DAILY_PROGRESS:String = "{dailyProgress}";
      
      private static const STRING_WEEKLY_PROGRESS:String = "{weeklyProgress}";
      
      private static const STRING_MONTHLY_EXPIRE:String = "{monthlyExpireTime}";
      
      private static const STRING_MONTHLY_PROGRESS:String = "{monthlyProgress}";
      
      private static const STRING_EVENTS_EXPIRE:String = "{eventsExpireTime}";
      
      private static const STRING_EVENTS_PROGRESS:String = "{eventsProgress}";
      
      private static const STRING_SEASONAL_EXPIRE:String = "{seasonalExpireTime}";
      
      private static const STRING_SEASONAL_PROGRESS:String = "{seasonalProgress}";
      
      private static const STRING_TIME_ZERO:String = "00:00";
      
      private static const STRING_CODE_ALPHA:String = "{codeAlpha}";
      
      private static const STRING_CODE_BRAVO:String = "{codeBravo}";
      
      private static const STRING_CODE_CHARLIE:String = "{codeCharlie}";
      
      private static const STRING_REGION:String = "{region}";
      
      private static const STRING_XP:String = "{xp}";
      
      private static const STRING_DAYS:String = "{d}";
      
      private static const STRING_HOURS:String = "{h}";
      
      private static const STRING_MINUTES:String = "{m}";
      
      private static const STRING_SECONDS:String = "{s}";
      
      private static const STRING_MONTH:String = "{month}";
      
      private static const STRING_FISH:String = "{fish}";
      
      private static const STRING_REGION1:String = "{region1}";
      
      private static const STRING_REGION2:String = "{region2}";
      
      private static const STRING_CAUGHT:String = "{caught}";
      
      private static const STRING_END_TIME:String = "{endTime}";
      
      private static const TITLE_HUDMENU:String = "HUDMenu";
      
      private static const MAIN_MENU:String = "MainMenu";
      
      private static const CHALLENGE_TYPE_DAILY:uint = 0;
      
      private static const CHALLENGE_TYPE_WEEKLY:uint = 1;
      
      private static const CHALLENGE_TYPE_MONTHLY:uint = 3;
      
      private static const CHALLENGE_TYPE_EVENTS:uint = 4;
      
      private static const CHALLENGE_TYPE_SEASONAL:uint = 5;
      
      private static const ACTIVITY_TYPE_PUBLIC_EVENT:uint = 1;
      
      private static const ACTIVITY_TYPE_MUTATED_EVENT:uint = 5;
      
      private static const ACTIVITY_LABEL_MUTATED_EVENT:String = "$DailyOps_Header_Mutation";
      
      private static const ACTIVITY_LABEL_EVENT_STATS:String = "$STATS";
      
      private static const ACTIVITY_LABEL_EVENT_PARTICIPANTS:String = "$Participants";
      
      private static const FILTER_RECENT_ACTIVITY_TYPES:Array = [1,2,5,6];
      
      private static const FILTER_EVENTS:Object = {
         "publicEvent":1,
         "worldEvent":2,
         "mutatedEvent":5,
         "caravan":6
      };
      
      private static const FILTER_CHALLENGE:Object = [{
         "name":"daily",
         "type":0,
         "category":8
      },{
         "name":"weekly",
         "type":1,
         "category":8
      },{
         "name":"monthly",
         "type":3,
         "category":8
      },{
         "name":"events",
         "type":4,
         "category":8
      },{
         "name":"seasonal",
         "type":5,
         "category":8
      },{
         "name":"character",
         "type":2,
         "category":0
      },{
         "name":"survival",
         "type":2,
         "category":1
      },{
         "name":"combat",
         "type":2,
         "category":4
      },{
         "name":"social",
         "type":2,
         "category":5
      },{
         "name":"world",
         "type":2,
         "category":6
      },{
         "name":"fishing",
         "type":2,
         "category":9
      },{
         "name":"burning_springs",
         "type":2,
         "category":10
      }];
      
      private static const HUDTOOLS_MENU_TOGGLE_VISIBILITY:String = MOD_NAME + "_TOGGLE_VISIBILITY";
      
      private static const HUDTOOLS_MENU_HIDE:String = MOD_NAME + "_HIDE";
      
      private static const HUDTOOLS_MENU_RELOAD_CONFIG:String = MOD_NAME + "_RELOAD_CONFIG";
      
      private static const MONTHS_NAMES:Array = ["January","February","March","April","May","June","July","August","September","October","November","December"];
      
      private static const REGION_INITIALS:Array = ["AH","BS","CB","TF","TM","SD","SV","TV"];
      
      private static const REGION_NAMES:Array = ["The Ash Heap","Burning Springs","Cranberry Bog","The Forest","The Mire","Savage Divide","Skyline Valley","Toxic Valley"];
      
      private static const FISH_NAMES:Array = ["Banded Axolotl","Charcoal Axolotl","Clay Axolotl","Dotted Axolotl","Pink Axolotl","Purple Axolotl","Scaled Axolotl","Shadow Axolotl","Speckled Axolotl","Spotted Axolotl","Stone Axolotl","Striped Axolotl"];
      
      private const MINERVA_TIMESTAMP:Number = 1725897600;
      
      private const MINERVA_TIMESTAMP_LIST:Number = 12;
      
      private const SECONDS_IN_DAY:Number = 86400;
      
      private const SECONDS_IN_WEEK:Number = 604800;
      
      private const SECONDS_IN_16_HOURS:Number = 57600;
      
      private const NUCLEAR_CODES_TIMESTAMP:Number = 1756944000;
      
      private const NUCLEAR_CODE:String = "541637043868811082732426759596495180575192177003190806867939409095473432331647559379360282810778955094715401111443821877916779364691188767941208455967179302025258814269177276827044468110327695103227736576310606400062697672011770547250771475542781784820187394508710628512203928480953520316121881244759217576230732515712821527170860849743383566941210521004030650247271357653739560950161553533035599790677901611816224935501489675767275314376925939786868368012821523123380706842763574955196113891651635036316223724782766254835288444104281553097772821648870563775422057503886394594102506014586374243351039404134580027461199236061903031218888719855527099941619644470636930406084300073370389262887831524870850600071317464224746158610523237625148760102369691000588753006715856385632986324143220526823172149341694997969441377674392568367817123764754380474534236837041387550556910676818592042632824753645717497075391179264053382463838145910561398408079133733215794908016006424983771496054605999511198577971550861719616682197346244081513184600679211054558936209425207196942090930903400898406659852492920791672676850102212076908994429639159931812270360855722162113257066671209529160686528387147275610606607843847076129070436818626587989650402606629849601530614";
      
      private const NUCLEAR_CODE_COMBINATIONS:int = 99999999;
      
      private const VERDANT_SEASON_BEGIN:* = /It's a verdant season in .*! Enjoy the abundance!/;
      
      private const VERDANT_SEASON_END:* = /The verdant season in .* has ended./;
      
      private const VERDANT_SEASON_BEGIN_LOCALIZED:* = {
         "en":/It's a verdant season in .*! Enjoy the abundance!/,
         "es":/¡Es temporada verde en .*! ¡Disfruta de la abundancia!/,
         "esmx":/¡Es temporada verde en .*! ¡Disfruta de la abundancia!/,
         "fr":/Une saison verdoyante a commencé dans .* ! Profitez de l'abondance !/,
         "de":/In .* hat die fruchtbare Saison begonnen! Genieße den Überfluss!/,
         "it":/Stagione della fioritura iniziata in questa regione: .*! Goditi l'abbondanza!/,
         "pl":/.* świętuje sezon urodzaju! Korzystaj z bogactwa zbiorów!/,
         "ptbr":/Chegou a estação verdejante em .*! Desfrute da abundância!/,
         "ru":/Зеленый сезон в регионе .*! Наслаждайтесь изобилием!/,
         "ja":/.*が緑の季節に入りました！ 豊かな緑をお楽しみください！/,
         "ko":/.*에 푸른 계절이 찾아왔습니다! 풍요를 만끽하세요!/,
         "zhhans":/现在的.*正处于繁茂季节！享受丰收吧！/,
         "zhhant":/.*已經到了繁茂季節！好好享受這片富饒吧！/
      };
      
      private const VERDANT_SEASON_END_LOCALIZED:* = {
         "en":/The verdant season in .* has ended./,
         "es":/Ha terminado la temporada verde en .*./,
         "esmx":/Terminó la temporada verde en .*./,
         "fr":/La saison verdoyante dans .* est terminée./,
         "de":/Die fruchtbare Saison in .* ist vorüber./,
         "it":/Stagione della fioritura terminata in questa regione: .*./,
         "pl":/.* wita koniec sezonu urodzaju./,
         "ptbr":/A estação verdejante em .* acabou./,
         "ru":/Зеленый сезон в регионе .* закончился./,
         "ja":/.*の緑の季節が終わりました/,
         "ko":/.*의 푸른 계절이 끝났습니다./,
         "zhhans":/.*的繁茂季节结束了。/,
         "zhhant":/.*的繁茂季節結束了。/
      };
      
      private const LANGUAGES:Array = ["en","es","esmx","fr","de","it","pl","ptbr","ru","ja","ko","zhhans","zhhant"];
      
      private var FISHING_SEASONS:Array = [{
         "month":0,
         "fish":1,
         "region1":5,
         "region2":6
      },{
         "month":1,
         "fish":4,
         "region1":2,
         "region2":3
      },{
         "month":2,
         "fish":2,
         "region1":6,
         "region2":7
      },{
         "month":3,
         "fish":3,
         "region1":0,
         "region2":4
      },{
         "month":4,
         "fish":5,
         "region1":2,
         "region2":6
      },{
         "month":5,
         "fish":0,
         "region1":4,
         "region2":7
      },{
         "month":6,
         "fish":6,
         "region1":3,
         "region2":0
      },{
         "month":7,
         "fish":11,
         "region1":4,
         "region2":6
      },{
         "month":8,
         "fish":7,
         "region1":0,
         "region2":7
      },{
         "month":9,
         "fish":9,
         "region1":5,
         "region2":7
      },{
         "month":10,
         "fish":8,
         "region1":2,
         "region2":3
      },{
         "month":11,
         "fish":10,
         "region1":0,
         "region2":7
      }];
      
      private var MONTHS_LOCALIZED:Array = new Array(12);
      
      private var REGION_LOCALIZED:Array = new Array(8);
      
      private var FISH_LOCALIZED:Array = new Array(12);
      
      private var FISH_CAUGHT:Array = new Array(12);
      
      private var _lastRecentActivitiesUpdateTime:Number = 0;
      
      private var _lastChallengeUpdateTime:Number = 0;
      
      private var _lastConfigUpdateTime:Number = 0;
      
      private var _lastRenderTime:Number = 0;
      
      private var topLevel:* = null;
      
      private var dummy_tf:TextField;
      
      private var textFormat:TextFormat;
      
      private var textFormatAlignment:TextFormat;
      
      private var timer:Timer;
      
      private var configTimer:Timer;
      
      private var displayTimer:Timer;
      
      private var lastConfig:String;
      
      private var HUDModeData:*;
      
      private var AccountInfoData:*;
      
      private var CharacterInfoData:*;
      
      private var ChallengeData:*;
      
      private var RecentActivitiesData:*;
      
      private var SeasonWidgetData:*;
      
      private var SeasonData:*;
      
      private var HUDMessageProvider:*;
      
      private var UniversalRewardData:*;
      
      private var RegionNamesData:*;
      
      private var _challenges:Object;
      
      private var _events:Array;
      
      private var _eventTimes:* = {};
      
      private var challenges_tf:Array = [];
      
      private var challenges_index:int = 0;
      
      private var yOffset:Number = 0;
      
      private var separators:Array = [];
      
      private var daily_secsTilRefresh:Number = 0;
      
      private var weekly_secsTilRefresh:Number = 0;
      
      private var monthly_secsTilRefresh:Number = 0;
      
      private var event_secsTilRefresh:Number = 0;
      
      private var seasonal_secsTilRefresh:Number = 0;
      
      private var daily_TilRefresh:String = "00:00";
      
      private var weekly_TilRefresh:String = "00:00";
      
      private var monthly_TilRefresh:String = "00:00";
      
      private var event_TilRefresh:String = "00:00";
      
      private var seasonal_TilRefresh:String = "00:00";
      
      private var daily_progress:String = "0/0";
      
      private var weekly_progress:String = "0/0";
      
      private var monthly_progress:String = "0/0";
      
      private var event_progress:String = "0/0";
      
      private var seasonal_progress:String = "0/0";
      
      private var scoreBar:Object;
      
      private var xpBar:Object;
      
      private var XPMeter:* = null;
      
      private var isHudMenu:Boolean = true;
      
      private var isInMainMenu:Boolean = true;
      
      private var toggleVisibility:Boolean = false;
      
      private var forceHide:Boolean = false;
      
      private var nextY:Number = 0;
      
      private var nextX:Number = 0;
      
      private var nextYSpacing:Number = 0;
      
      private var nextTextSize:Number = 0;
      
      private var nextFormat:TextFormat = null;
      
      private var nextTextAlign:String = "";
      
      private var verdantSeasons:Array = [];
      
      private var language:String = "";
      
      private var hudTools:SharedHUDTools;
      
      private var miniSeasonRewards:int = 0;
      
      private var miniSeasonRewardsClaimed:int = 0;
      
      private var isKeyDownDetected:Object = {};
      
      private var regionsLocalized:Boolean = false;
      
      public function HUDChallenges()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler,false,0,true);
         this.HUDModeData = BSUIDataManager.GetDataFromClient("HUDModeData");
         this.AccountInfoData = BSUIDataManager.GetDataFromClient("AccountInfoData");
         this.CharacterInfoData = BSUIDataManager.GetDataFromClient("CharacterInfoData");
         this.ChallengeData = BSUIDataManager.GetDataFromClient("ChallengeData");
         this.RecentActivitiesData = BSUIDataManager.GetDataFromClient("RecentActivitiesData");
         this.SeasonWidgetData = BSUIDataManager.GetDataFromClient("SeasonWidgetData");
         this.SeasonData = BSUIDataManager.GetDataFromClient("SeasonData");
         this.HUDMessageProvider = BSUIDataManager.GetDataFromClient("HUDMessageProvider");
         this.UniversalRewardData = BSUIDataManager.GetDataFromClient("UniversalRewardData");
         this.RegionNamesData = BSUIDataManager.GetDataFromClient("RegionNamesData");
         BSUIDataManager.Subscribe("MessageEvents",this.onMessageEvent);
      }
      
      public static function toString(param1:Object) : String
      {
         return new JSONEncoder(param1).getString();
      }
      
      public static function ShowHUDMessage(param1:String) : void
      {
         GlobalFunc.ShowHUDMessage("[" + FULL_MOD_NAME + "] " + param1);
      }
      
      public function FormatCountdownTimeString(param1:Number) : String
      {
         var timeString:* = "";
         if(param1 < 0)
         {
            timeString = "T+";
            param1 = Math.abs(param1);
         }
         else
         {
            timeString = "T-";
         }
         return timeString + FormatTimeStringCustom(param1);
      }
      
      public function FormatTimeStringCustom(param1:Number) : String
      {
         if(isNaN(param1))
         {
            return STRING_TIME_ZERO;
         }
         var remainingTime:Number = 0;
         var nDays:Number = Math.floor(param1 / 86400);
         remainingTime = param1 % 86400;
         var nHours:Number = Math.floor(remainingTime / 3600);
         remainingTime = param1 % 3600;
         var nMinutes:Number = Math.floor(remainingTime / 60);
         remainingTime = param1 % 60;
         var nSeconds:Number = Math.floor(remainingTime);
         var timeString:* = "";
         if(nDays > 0)
         {
            timeString = config.formats.timeLong.replace(STRING_DAYS,nDays).replace(STRING_HOURS,GlobalFunc.PadNumber(nHours,2));
         }
         else if(nHours > 0)
         {
            timeString = config.formats.timeMid.replace(STRING_DAYS,"").replace(STRING_HOURS,GlobalFunc.PadNumber(nHours,2));
         }
         else
         {
            timeString = config.formats.timeShort.replace(STRING_DAYS,"").replace(STRING_HOURS,"");
         }
         return timeString.replace(STRING_MINUTES,GlobalFunc.PadNumber(nMinutes,2)).replace(STRING_SECONDS,GlobalFunc.PadNumber(nSeconds,2));
      }
      
      public function addedToStageHandler(param1:Event) : *
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
         addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler,false,0,true);
         this.topLevel = stage.getChildAt(0);
         if(Boolean(this.topLevel))
         {
            if(getQualifiedClassName(this.topLevel) == TITLE_HUDMENU)
            {
               this.isInMainMenu = false;
               if(this.topLevel.HUDNotificationsGroup_mc != null && this.topLevel.HUDNotificationsGroup_mc.XPMeter_mc != null)
               {
                  this.XPMeter = this.topLevel.HUDNotificationsGroup_mc.XPMeter_mc;
               }
               this.hudTools = new SharedHUDTools(MOD_NAME);
               this.hudTools.RegisterMenu(this.onBuildMenu,this.onSelectMenu);
            }
            else
            {
               this.isHudMenu = false;
               BSUIDataManager.Subscribe("MenuStackData",this.updateIsMainMenu);
               stage.addEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler,false,0,true);
               stage.addEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler,false,0,true);
            }
            this.initConfigTimer();
            this.loadConfig();
            trace(MOD_NAME + " added to stage: " + getQualifiedClassName(this.topLevel));
         }
         else
         {
            trace(MOD_NAME + " not added to stage: " + getQualifiedClassName(this.topLevel));
            ShowHUDMessage("Not added to stage: " + getQualifiedClassName(this.topLevel));
         }
      }
      
      public function removedFromStageHandler(param1:Event) : *
      {
         BSUIDataManager.Unsubscribe("MenuStackData",this.updateIsMainMenu);
         BSUIDataManager.Unsubscribe("MessageEvents",this.onMessageEvent);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStageHandler);
         if(stage)
         {
            stage.removeEventListener(KeyboardEvent.KEY_DOWN,this.keyDownHandler);
            stage.removeEventListener(KeyboardEvent.KEY_UP,this.keyUpHandler);
         }
         if(this.configTimer)
         {
            this.configTimer.removeEventListener(TimerEvent.TIMER,this.loadConfig);
         }
         if(this.displayTimer)
         {
            this.displayTimer.removeEventListener(TimerEvent.TIMER,this.displayChallengesLoop);
         }
         if(this.hudtools)
         {
            this.hudtools.Shutdown();
         }
      }
      
      public function initConfigTimer() : void
      {
         this.configTimer = new Timer(CONFIG_RELOAD_TIME);
         this.configTimer.addEventListener(TimerEvent.TIMER,this.loadConfig,false,0,true);
         this.configTimer.start();
      }
      
      public function onBuildMenu(parentItem:String = null) : *
      {
         try
         {
            if(parentItem == MOD_NAME)
            {
               if(config && config.disableRealTimeEdit)
               {
                  this.hudTools.AddMenuItem(HUDTOOLS_MENU_RELOAD_CONFIG,"Reload Config",true,false,250);
               }
               this.hudTools.AddMenuItem(HUDTOOLS_MENU_TOGGLE_VISIBILITY,"Toggle Visible",true,false,250);
               this.hudTools.AddMenuItem(HUDTOOLS_MENU_HIDE,"Force Hide",true,false,250);
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function onSelectMenu(selectItem:String) : *
      {
         try
         {
            if(selectItem == HUDTOOLS_MENU_TOGGLE_VISIBILITY)
            {
               this.toggleVisibility = !this.toggleVisibility;
            }
            else if(selectItem == HUDTOOLS_MENU_HIDE)
            {
               this.forceHide = !this.forceHide;
            }
            else if(selectItem == HUDTOOLS_MENU_RELOAD_CONFIG)
            {
               config.disableRealTimeEdit = false;
               this.loadConfig();
            }
         }
         catch(e:Error)
         {
         }
      }
      
      public function keyDownHandler(event:Event) : void
      {
         try
         {
            this.isKeyDownDetected[event.keyCode] = true;
            if(!config || !challenges_tf)
            {
               return;
            }
            if(config.debugKeys)
            {
               displayMessage("keyDown: " + event.keyCode + " - " + Buttons.getButtonKey(event.keyCode));
            }
            this.handleKey(event);
         }
         catch(e:Error)
         {
            displayMessage("Error keyDownHandler: " + e);
         }
      }
      
      public function keyUpHandler(event:Event) : void
      {
         try
         {
            if(!config || !challenges_tf)
            {
               return;
            }
            if(config.debugKeys)
            {
               displayMessage("keyUp (kd:" + Boolean(this.isKeyDownDetected[event.keyCode]) + "): " + event.keyCode + " - " + Buttons.getButtonKey(event.keyCode));
            }
            if(!this.isKeyDownDetected[event.keyCode])
            {
               this.handleKey(event);
            }
         }
         catch(e:Error)
         {
            displayMessage("Error keyUpHandler: " + e);
         }
      }
      
      private function handleKey(event:Event) : void
      {
         if(event.keyCode == config.toggleVisibilityHotkey)
         {
            this.toggleVisibility = !this.toggleVisibility;
         }
         if(event.keyCode == config.forceHideHotkey)
         {
            this.forceHide = !this.forceHide;
         }
      }
      
      private function updateIsMainMenu(event:FromClientDataEvent) : void
      {
         try
         {
            this.isInMainMenu = Boolean(event) && Boolean(event.data) && Boolean(event.data.menuStackA) && Boolean(event.data.menuStackA.some(function(x:*):*
            {
               return x.menuName == MAIN_MENU;
            }));
         }
         catch(e:Error)
         {
         }
      }
      
      private function onMessageEvent(event:FromClientDataEvent) : void
      {
         var messageData:*;
         var messageText:String;
         var startId:int;
         var endId:int;
         var regionName:String;
         var parts:Array;
         var i:int;
         var isBegin:Boolean;
         var lang:String;
         var l:int;
         var vsRegex:*;
         var isVerdantSeasonMessage:Boolean;
         var messageIndex:int = 0;
         var errorCode:String = "init";
         try
         {
            if(this.HUDMessageProvider.data.messages == null)
            {
               return;
            }
            while(messageIndex < this.HUDMessageProvider.data.messages.length)
            {
               errorCode = "messageData";
               messageData = this.HUDMessageProvider.data.messages[messageIndex];
               errorCode = "messageText";
               if(messageData != null && messageData.messageText != null)
               {
                  messageText = messageData.messageText;
                  errorCode = "LANGUAGE";
                  isBegin = false;
                  isVerdantSeasonMessage = false;
                  if(language != "")
                  {
                     if(VERDANT_SEASON_BEGIN_LOCALIZED[language] && VERDANT_SEASON_BEGIN_LOCALIZED[language].test(messageText))
                     {
                        lang = language;
                        isBegin = true;
                        isVerdantSeasonMessage = true;
                     }
                     else if(VERDANT_SEASON_END_LOCALIZED[language] && VERDANT_SEASON_END_LOCALIZED[language].test(messageText))
                     {
                        lang = language;
                        isVerdantSeasonMessage = true;
                     }
                  }
                  else
                  {
                     l = 0;
                     while(l < LANGUAGES.length)
                     {
                        lang = LANGUAGES[l];
                        if(VERDANT_SEASON_BEGIN_LOCALIZED[lang] && VERDANT_SEASON_BEGIN_LOCALIZED[lang].test(messageText))
                        {
                           isVerdantSeasonMessage = true;
                           isBegin = true;
                           if(lang != "es" && lang != "esmx")
                           {
                              language = lang;
                           }
                           break;
                        }
                        if(VERDANT_SEASON_END_LOCALIZED[lang] && VERDANT_SEASON_END_LOCALIZED[lang].test(messageText))
                        {
                           isVerdantSeasonMessage = true;
                           language = lang;
                           break;
                        }
                        l++;
                     }
                  }
                  if(isVerdantSeasonMessage)
                  {
                     errorCode = "VERDANT_SEASON";
                     vsRegex = isBegin ? VERDANT_SEASON_BEGIN_LOCALIZED[lang] : VERDANT_SEASON_END_LOCALIZED[lang];
                     errorCode = "VERDANT_SEASON_MATCH";
                     parts = String(vsRegex).split(".*");
                     errorCode = "VSM ids";
                     startId = Math.max(0,parts[0].length - 1);
                     endId = parts[1].length - 1;
                     errorCode = "VSM regionName";
                     regionName = messageText.substring(startId,messageText.length - endId);
                     errorCode = "VSM splice";
                     i = verdantSeasons.length - 1;
                     while(i >= 0)
                     {
                        if(verdantSeasons[i].region == regionName)
                        {
                           verdantSeasons.splice(i,1);
                        }
                        i--;
                     }
                     errorCode = "VSB push";
                     verdantSeasons.push({
                        "region":regionName,
                        "active":isBegin,
                        "time":new Date().getTime() / 1000
                     });
                  }
               }
               messageIndex++;
            }
         }
         catch(e:*)
         {
         }
      }
      
      public function loadConfig() : void
      {
         var loaderComplete:Function;
         var ioErrorHandler:Function;
         var url:URLRequest = null;
         var loader:URLLoader = null;
         try
         {
            if(config && Boolean(config.disableRealTimeEdit))
            {
               return;
            }
            loaderComplete = function(param1:Event):void
            {
               var jsonData:Object;
               try
               {
                  if(lastConfig != loader.data)
                  {
                     jsonData = new JSONDecoder(loader.data,true).getValue();
                     HUDChallengesConfig.init(jsonData);
                     initTextField();
                     initTimers();
                     _lastConfigUpdateTime = getTimer();
                     lastConfig = loader.data;
                  }
               }
               catch(e:Error)
               {
                  ShowHUDMessage("Error parsing config: " + e);
               }
            };
            ioErrorHandler = function(param1:*):void
            {
               ShowHUDMessage("Error loading config: " + param1.text);
            };
            url = new URLRequest(CONFIG_FILE);
            loader = new URLLoader();
            loader.load(url);
            loader.addEventListener(Event.COMPLETE,loaderComplete,false,0,true);
            loader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler,false,0,true);
         }
         catch(e:Error)
         {
            ShowHUDMessage("Error loading config: " + e);
         }
      }
      
      private function initTextField() : void
      {
         this.dummy_tf = new TextField();
         this.formatMessage();
      }
      
      private function initTimers() : void
      {
         if(this.displayTimer)
         {
            this.displayTimer.removeEventListener(TimerEvent.TIMER,this.displayChallengesLoop);
         }
         this.displayTimer = new Timer(config.refresh);
         this.displayTimer.addEventListener(TimerEvent.TIMER,this.displayChallengesLoop,false,0,true);
         this.displayTimer.start();
      }
      
      public function get isReloadable() : Boolean
      {
         return true;
      }
      
      public function get config() : Object
      {
         return HUDChallengesConfig.get();
      }
      
      public function get elapsedTime() : Number
      {
         return getTimer() / 1000;
      }
      
      public function get timeSinceLastConfigUpdate() : Number
      {
         return (getTimer() - this._lastConfigUpdateTime) / 1000;
      }
      
      public function get requiredLevelUpXP() : int
      {
         return Math.min(this.CharacterInfoData.data.level,999) * 160 + 40;
      }
      
      private function onChallengeDataUpdate(param1:*) : void
      {
         var challenges:Object;
         var fo1st_disabledChallenges:int;
         var challengeType:String;
         var t1:Number;
         var hasSeasonPass:Boolean;
         var category:Object;
         var filter:Object;
         var challenge:Object;
         var now:Number;
         try
         {
            if(!config)
            {
               return;
            }
            now = new Date().getTime() / 1000;
            t1 = Number(getTimer());
            this.daily_secsTilRefresh = param1.data.daily_secsTilRefresh;
            this.weekly_secsTilRefresh = param1.data.weekly_secsTilRefresh;
            this.monthly_secsTilRefresh = param1.data.monthly_secsTilRefresh;
            this.event_secsTilRefresh = param1.data.event_secsTilRefresh;
            this.seasonal_secsTilRefresh = param1.data.seasonal_secsTilRefresh;
            challenges = {};
            hasSeasonPass = this.AccountInfoData && this.AccountInfoData.data && (this.AccountInfoData.data.hasZeus || this.AccountInfoData.data.hasFO1Preview);
            for each(category in param1.data.categories)
            {
               if(config && config.debugCats)
               {
                  displayMessage(category.text + ": " + category.type + " " + category.category);
               }
               challengeType = "";
               fo1st_disabledChallenges = 0;
               for each(filter in FILTER_CHALLENGE)
               {
                  if(filter.type == category.type && filter.category == category.category)
                  {
                     challengeType = filter.name;
                     break;
                  }
               }
               if(challengeType != "")
               {
                  challenges[challengeType] = [];
                  for each(challenge in category.challenges)
                  {
                     if(challenge.currentValue < challenge.thresholdValue)
                     {
                        if(hasSeasonPass || !challenge.isFO1st)
                        {
                           challenges[challengeType].push({
                              "text":challenge.text,
                              "currentValue":challenge.currentValue,
                              "thresholdValue":challenge.thresholdValue,
                              "endTime":(challenge.endTime && challenge.endTime.lo > 0 ? challenge.endTime.lo - now : 0),
                              "isTracked":challenge.isTracked,
                              "subChallenges":(Boolean(config.showSubChallenges[challengeType]) ? challenge.subChallenges.filter(function(sub:Object):Boolean
                              {
                                 return sub.currentValue < sub.thresholdValue;
                              }) : [])
                           });
                        }
                        else
                        {
                           fo1st_disabledChallenges++;
                        }
                     }
                  }
                  if(category.type == CHALLENGE_TYPE_DAILY)
                  {
                     this.daily_progress = category.challenges.length - challenges[challengeType].length - fo1st_disabledChallenges + "/" + category.challenges.length;
                  }
                  else if(category.type == CHALLENGE_TYPE_WEEKLY)
                  {
                     this.weekly_progress = category.challenges.length - challenges[challengeType].length - fo1st_disabledChallenges + "/" + category.challenges.length;
                  }
                  else if(category.type == CHALLENGE_TYPE_MONTHLY)
                  {
                     this.monthly_progress = category.challenges.length - challenges[challengeType].length - fo1st_disabledChallenges + "/" + category.challenges.length;
                  }
                  else if(category.type == CHALLENGE_TYPE_EVENTS)
                  {
                     this.event_progress = category.challenges.length - challenges[challengeType].length - fo1st_disabledChallenges + "/" + category.challenges.length;
                  }
                  else if(category.type == CHALLENGE_TYPE_SEASONAL)
                  {
                     this.seasonal_progress = category.challenges.length - challenges[challengeType].length - fo1st_disabledChallenges + "/" + category.challenges.length;
                  }
               }
            }
            _challenges = challenges;
            _lastChallengeUpdateTime = getTimer() - t1;
         }
         catch(e:*)
         {
            displayMessage("Error onChallengeDataUpdate:" + e);
         }
      }
      
      private function onRecentActivitiesDataUpdate(param1:*) : void
      {
         var events:Array;
         var t1:Number;
         try
         {
            if(!config)
            {
               return;
            }
            t1 = Number(getTimer());
            events = [];
            for each(activity in param1.data.recentActivities)
            {
               if(FILTER_RECENT_ACTIVITY_TYPES.indexOf(activity.type) != -1 && isValidEventName(activity.name))
               {
                  events.push({
                     "id":activity.id,
                     "name":activity.name,
                     "type":activity.type
                  });
                  if(_eventTimes[activity.id] == null || _eventTimes[activity.id].time != activity.time)
                  {
                     _eventTimes[activity.id] = {
                        "time":activity.time,
                        "timestamp":getTimer()
                     };
                     if(config.eventSoundNotify.enabled && config.eventSoundNotify.events[activity.name])
                     {
                        GlobalFunc.PlayMenuSound(config.eventSoundNotify.events[activity.name]);
                     }
                  }
                  if(activity.type == ACTIVITY_TYPE_MUTATED_EVENT)
                  {
                     events[events.length - 1].mutation = "";
                     events[events.length - 1].participants = -1;
                     for each(detail in activity.details)
                     {
                        if(detail.groupLabel == ACTIVITY_LABEL_MUTATED_EVENT && detail.pairList.length > 0)
                        {
                           for(mutation in detail.pairList)
                           {
                              if(mutation == 0)
                              {
                                 events[events.length - 1].mutation = detail.pairList[mutation].label;
                              }
                              else
                              {
                                 events[events.length - 1].mutation += "|" + detail.pairList[mutation].label;
                              }
                           }
                        }
                        else if(detail.groupLabel == ACTIVITY_LABEL_EVENT_STATS && detail.pairList.length > 0)
                        {
                           for(pair in detail.pairList)
                           {
                              if(detail.pairList[pair].label == ACTIVITY_LABEL_EVENT_PARTICIPANTS)
                              {
                                 events[events.length - 1].participants = Number(detail.pairList[pair].description);
                              }
                           }
                        }
                     }
                  }
                  else if(activity.type == ACTIVITY_TYPE_PUBLIC_EVENT)
                  {
                     events[events.length - 1].participants = -1;
                     for each(detail in activity.details)
                     {
                        if(detail.groupLabel == ACTIVITY_LABEL_EVENT_STATS && detail.pairList.length > 0)
                        {
                           for(pair in detail.pairList)
                           {
                              if(detail.pairList[pair].label == ACTIVITY_LABEL_EVENT_PARTICIPANTS)
                              {
                                 events[events.length - 1].participants = Number(detail.pairList[pair].description);
                              }
                           }
                        }
                     }
                  }
               }
            }
            _events = events;
            _lastRecentActivitiesUpdateTime = getTimer() - t1;
         }
         catch(e:*)
         {
            displayMessage("Error onRecentActivitiesDataUpdate:" + e);
         }
      }
      
      public function formatMessage() : void
      {
         this.dummy_tf.htmlText = MOD_VERSION;
         this.dummy_tf.x = config.x;
         this.dummy_tf.y = config.y;
         this.dummy_tf.width = config.width;
         this.dummy_tf.background = false;
         TextFieldEx.setTextAutoSize(this.dummy_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.dummy_tf.autoSize = TextFieldAutoSize.LEFT;
         this.dummy_tf.wordWrap = false;
         this.dummy_tf.multiline = true;
         this.dummy_tf.visible = true;
         this.textFormat = new TextFormat(config.textFont,config.textSize,config.textColor);
         this.textFormat.align = config.textAlign;
         this.textFormatAlignment = new TextFormat();
         this.textFormatAlignment.align = config.textAlign;
         this.dummy_tf.defaultTextFormat = this.textFormat;
         this.dummy_tf.setTextFormat(this.textFormat);
         this.dummy_tf.filters = [new DropShadowFilter(2,45,0,1,1,1,1,BitmapFilterQuality.HIGH)];
         this.alpha = config.alpha;
         this.blendMode = config.blendMode;
         resetMessages(true);
      }
      
      public function resetMessages(setFormat:Boolean = false) : void
      {
         this.nextY = config.y;
         this.nextX = config.x;
         this.nextYSpacing = config.ySpacing;
         this.nextTextSize = config.textSize;
         this.nextTextAlign = "";
         this.nextFormat = null;
         this.separators = [];
         this.graphics.clear();
         this.challenges_index = 0;
         this.yOffset = 0;
         for each(challenge_tf in challenges_tf)
         {
            if(challenge_tf != null)
            {
               challenge_tf.visible = false;
               if(setFormat)
               {
                  challenge_tf.defaultTextFormat = this.textFormat;
                  challenge_tf.setTextFormat(this.textFormat);
                  challenge_tf.filters = Boolean(config.textShadow) ? this.dummy_tf.filters : [];
                  challenge_tf.blendMode = config.textBlendMode;
               }
               else
               {
                  challenge_tf.textColor = config.textColor;
                  challenge_tf.defaultTextFormat = this.textFormatAlignment;
                  challenge_tf.setTextFormat(this.textFormatAlignment);
               }
            }
         }
      }
      
      public function createTextfield() : TextField
      {
         tf = new TextField();
         tf.multiline = false;
         tf.wordWrap = false;
         tf.defaultTextFormat = this.textFormat;
         TextFieldEx.setTextAutoSize(tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         tf.setTextFormat(this.textFormat);
         if(config)
         {
            tf.filters = Boolean(config.textShadow) ? this.dummy_tf.filters : [];
            tf.blendMode = config.textBlendMode;
         }
         addChild(tf);
         return tf;
      }
      
      public function applyConfig(tf:TextField) : void
      {
         tf.x = nextX;
         tf.background = false;
         tf.width = config.width;
         tf.height = this.dummy_tf.height;
         if(challenges_index == 0)
         {
            tf.y = nextY;
         }
         else
         {
            if(config.anchor == "bottom")
            {
               tf.y = nextY - LastDisplayTextfield.height - this.nextYSpacing - yOffset;
            }
            else
            {
               tf.y = nextY + LastDisplayTextfield.height + this.nextYSpacing + yOffset;
            }
            nextY = tf.y;
            yOffset = 0;
         }
         if(this.nextFormat == null && (this.nextTextSize != config.textSize || this.nextTextAlign != ""))
         {
            this.nextFormat = new TextFormat();
            if(this.nextTextSize != config.textSize)
            {
               this.nextFormat.size = this.nextTextSize;
            }
            if(this.nextTextAlign != "")
            {
               this.nextFormat.align = this.nextTextAlign;
            }
         }
         tf.visible = true;
      }
      
      public function displayMessage(text:String) : void
      {
         if(challenges_tf.length < challenges_index || challenges_tf[challenges_index] == null)
         {
            challenges_tf[challenges_index] = createTextfield();
         }
         applyConfig(challenges_tf[challenges_index]);
         challenges_tf[challenges_index].text = text;
         if(this.nextFormat != null)
         {
            challenges_tf[challenges_index].setTextFormat(this.nextFormat);
         }
         ++challenges_index;
      }
      
      public function drawBackground() : void
      {
         if(config.background)
         {
            this.graphics.beginFill(config.backgroundColor,config.backgroundAlpha);
            if(config.anchor == "bottom")
            {
               this.graphics.drawRect(config.x,config.y + LastDisplayTextfield.height,config.width,LastDisplayTextfield.y - LastDisplayTextfield.height - config.y);
            }
            else
            {
               this.graphics.drawRect(config.x,config.y,config.width,LastDisplayTextfield.y + LastDisplayTextfield.height - config.y);
            }
            this.graphics.endFill();
         }
         if(config.legacyAnchor)
         {
            if(config.anchor == "bottom")
            {
               this.y = -(LastDisplayTextfield.y + LastDisplayTextfield.height - config.y);
            }
            else if(this.y != 0)
            {
               this.y = 0;
            }
         }
      }
      
      public function get LastDisplayTextfield() : TextField
      {
         if(challenges_index == 0)
         {
            return challenges_tf[challenges_index];
         }
         return challenges_tf[challenges_index - 1];
      }
      
      public function getCustomColor(name:String) : Number
      {
         if(config.customColors[name] != null)
         {
            return config.customColors[name];
         }
         return config.textColor;
      }
      
      public function applyColor(name:String) : Boolean
      {
         if(config.customColors[name] != null)
         {
            LastDisplayTextfield.textColor = config.customColors[name];
            return true;
         }
         return false;
      }
      
      public function applyEventChallengeColor(name:String) : Boolean
      {
         var index:int = int(ArrayUtils.indexOfCaseInsensitiveString(config.customEventChallengeColors.keys,name));
         if(index != -1)
         {
            LastDisplayTextfield.textColor = config.customEventChallengeColors[config.customEventChallengeColors.keys[index]];
            return true;
         }
         return false;
      }
      
      public function addSeparator(data:String) : void
      {
         if(data == null || data.length == 0)
         {
            return;
         }
         data = data.replace(" ","");
         var parts:Array = data.split(":");
         var color:Number = Number(config.textColor);
         if(parts.length > 1)
         {
            var height:Number = Parser.parseNumber(parts[1],0);
            if(parts.length > 2)
            {
               color = Parser.parseNumber(parts[2],getCustomColor(parts[2]));
            }
            if(challenges_index == 0)
            {
               var y:Number = Number(config.y);
            }
            else
            {
               y = LastDisplayTextfield.y + LastDisplayTextfield.height + this.nextYSpacing / 2 + yOffset;
            }
            yOffset += height;
            separators.push({
               "y":y,
               "height":height,
               "color":color
            });
         }
      }
      
      public function addEmptySpace(data:String) : void
      {
         if(data == null || data.length == 0)
         {
            return;
         }
         var parts:Array = data.split(":");
         var space:Number = Parser.parseNumber(parts[1],0);
         yOffset += space;
      }
      
      public function addCustomText(data:String) : void
      {
         if(data == null || data.length == 0)
         {
            return;
         }
         data = data.replace("/:","/COLON/");
         var parts:Array = data.split(":");
         if(parts.length == 3)
         {
            var color:Number = Parser.parseNumber(parts[1],getCustomColor(parts[1]));
            var text:String = parts[2];
            text = text.replace("/COLON/",":");
            var now:Number = new Date().getTime() / 1000;
            if(text.indexOf(STRING_DAILY_EXPIRE) != -1)
            {
               this.daily_TilRefresh = FormatTimeStringCustom(Math.max(this.daily_secsTilRefresh - now,0));
               text = text.replace(STRING_DAILY_EXPIRE,this.daily_TilRefresh);
            }
            if(text.indexOf(STRING_WEEKLY_EXPIRE) != -1)
            {
               this.weekly_TilRefresh = FormatTimeStringCustom(Math.max(this.weekly_secsTilRefresh - now,0));
               text = text.replace(STRING_WEEKLY_EXPIRE,this.weekly_TilRefresh);
            }
            if(text.indexOf(STRING_MONTHLY_EXPIRE) != -1)
            {
               this.monthly_TilRefresh = FormatTimeStringCustom(Math.max(this.monthly_secsTilRefresh - now,0));
               text = text.replace(STRING_MONTHLY_EXPIRE,this.monthly_TilRefresh);
            }
            if(text.indexOf(STRING_EVENTS_EXPIRE) != -1)
            {
               this.event_TilRefresh = FormatTimeStringCustom(Math.max(this.event_secsTilRefresh - now,0));
               text = text.replace(STRING_EVENTS_EXPIRE,this.event_TilRefresh);
            }
            if(text.indexOf(STRING_SEASONAL_EXPIRE) != -1)
            {
               this.seasonal_TilRefresh = FormatTimeStringCustom(Math.max(this.seasonal_secsTilRefresh - now,0));
               text = text.replace(STRING_SEASONAL_EXPIRE,this.seasonal_TilRefresh);
            }
            text = text.replace(STRING_DAILY_PROGRESS,daily_progress).replace(STRING_WEEKLY_PROGRESS,weekly_progress).replace(STRING_MONTHLY_PROGRESS,monthly_progress).replace(STRING_EVENTS_PROGRESS,event_progress).replace(STRING_SEASONAL_PROGRESS,seasonal_progress);
            displayMessage(text);
            LastDisplayTextfield.textColor = color;
         }
      }
      
      public function displayChallenges(groupName:String) : void
      {
         groupName = groupName.toLowerCase();
         if(_challenges != null && _challenges[groupName] != null && _challenges[groupName].length > 0)
         {
            for each(challenge in _challenges[groupName])
            {
               if(isValidChallengeName(challenge.text) && (!config.showOnlyTrackedChallenges[groupName] || challenge.isTracked))
               {
                  displayMessage(formatChallenge(groupName,challenge));
                  if(!applyEventChallengeColor(challenge.text))
                  {
                     applyColor(groupName);
                  }
                  if(Boolean(config.showSubChallenges[groupName]) && challenge.subChallenges.length > 0)
                  {
                     var challengeColor:uint = LastDisplayTextfield.textColor;
                     for each(sub in challenge.subChallenges)
                     {
                        displayMessage(formatChallenge(groupName,sub));
                        LastDisplayTextfield.textColor = challengeColor;
                     }
                  }
               }
            }
         }
      }
      
      public function displayEvents(eventType:String) : void
      {
         if(eventType != null && eventType != "" && FILTER_EVENTS[eventType] != null)
         {
            for each(event in _events)
            {
               if(FILTER_EVENTS[eventType] == event.type)
               {
                  displayMessage(formatEvent(eventType,event));
                  if(!applyEventChallengeColor(event.name))
                  {
                     applyColor(eventType);
                  }
               }
            }
         }
      }
      
      public function drawSeparators() : void
      {
         for each(separator in separators)
         {
            this.graphics.beginFill(separator.color);
            this.graphics.drawRect(config.x,separator.y,config.width,separator.height);
            this.graphics.endFill();
         }
      }
      
      public function showHUDChildren() : void
      {
         if(!this.topLevel)
         {
            return;
         }
         var i:int = 0;
         while(i < this.topLevel.numChildren)
         {
            if(this.topLevel.getChildAt(i) is Loader)
            {
               displayMessage(i + ":" + getQualifiedClassName(this.topLevel.getChildAt(i).content));
            }
            else
            {
               displayMessage(i + ":" + getQualifiedClassName(this.topLevel.getChildAt(i)));
            }
            i++;
         }
      }
      
      public function trim(str:String) : String
      {
         return str.replace(/^\s+|\s+$/g,"");
      }
      
      public function setFishLocalized(param1:Object) : void
      {
         var filter:Object = {};
         filter.type = 2;
         filter.category = 9;
         var challengeID:int = 8390365;
         if(param1 && param1.data && param1.data.categories && param1.data.categories.length)
         {
            for each(var category in param1.data.categories)
            {
               if(filter.type == category.type && filter.category == category.category)
               {
                  for each(var challenge in category.challenges)
                  {
                     if(challenge.ID == challengeID)
                     {
                        var i:int = 0;
                        var subChallenges:Object = challenge.subChallenges;
                        while(i < subChallenges.length)
                        {
                           var text:String = subChallenges[i].text;
                           var firstIndexOfBracket:int = -1;
                           if(text.indexOf("(") != -1)
                           {
                              text = text.substring(text.indexOf("(") + 1);
                              firstIndexOfBracket = int(text.indexOf(")"));
                           }
                           else
                           {
                              text = text.substring(text.indexOf("（") + 1);
                              firstIndexOfBracket = int(text.indexOf("）"));
                           }
                           MONTHS_LOCALIZED[i] = trim(text.substring(0,firstIndexOfBracket));
                           FISH_LOCALIZED[i] = trim(text.substring(firstIndexOfBracket + 1));
                           FISHING_SEASONS[i].fish = i;
                           FISH_CAUGHT[i] = Boolean(subChallenges[i].currentValue == subChallenges[i].thresholdValue);
                           i++;
                        }
                     }
                  }
               }
            }
            if(!MONTHS_LOCALIZED[0])
            {
               MONTHS_LOCALIZED = MONTHS_NAMES;
            }
         }
      }
      
      public function setRegionsLocalized(param1:Object) : void
      {
         if(!this.regionsLocalized && param1 && param1.data && param1.data.MarkerData && param1.data.MarkerData.length)
         {
            for each(var markerData in this.RegionNamesData.data.MarkerData)
            {
               var text:String = markerData.text;
               if(text.indexOf(">") != -1 && text.indexOf("<") != -1)
               {
                  var regionLocale:String = text.split(">")[1].split("<")[0];
                  if(regionLocale)
                  {
                     var rsplit:Array = regionLocale.split("_");
                     if(rsplit.length > 1)
                     {
                        var initials:String = rsplit[1].charAt(0) + rsplit[2].charAt(0);
                        var match:int = int(REGION_INITIALS.indexOf(initials));
                        REGION_LOCALIZED[REGION_INITIALS.indexOf(initials)] = GlobalFunc.LocalizeFormattedString(regionLocale);
                     }
                  }
               }
            }
            this.regionsLocalized = true;
         }
         else if(!REGION_LOCALIZED[0])
         {
            REGION_LOCALIZED = REGION_NAMES;
         }
      }
      
      public function GetFirstDayOfMonth(dayOfTheWeek:int, month:int, year:int) : Date
      {
         var tzOffset:Number = new Date().getTimezoneOffset() / 60;
         var offset:Number = Number(config.fishingSeason.offsetHours);
         if(config.fishingSeason.debug)
         {
            displayMessage("tzOffset: " + tzOffset);
         }
         var comment:String = "Fishing season reset / First Tuesday of each month at 12PM EST";
         var comment2:String = "(tzOffset -4) UTC 0 / 4PM - EST 4 / 12PM - PST 7 / 9AM";
         var date:Date = new Date(year,month,1,12 - (offset + tzOffset - 4),0);
         date.date += (7 + dayOfTheWeek - date.day) % 7;
         return date;
      }
      
      public function GetFirstNextFirstDayOfTheWeek(currentDate:Date, weekDay:int, n:int = 0) : Date
      {
         var returnValue:Date = GetFirstDayOfMonth(weekDay,currentDate.month,currentDate.fullYear);
         if((returnValue.date < currentDate.date || returnValue <= currentDate) && n < 12)
         {
            return GetFirstNextFirstDayOfTheWeek(new Date(currentDate.fullYear,currentDate.month + 1,1),weekDay,n + 1);
         }
         return returnValue;
      }
      
      public function GetFirstWeekDay(weekDay:int, month:int, year:int) : Date
      {
         return GetFirstDayOfMonth(weekDay,month,year);
      }
      
      public function GetFirstNextFirstWeekDay(weekDay:int, date:Date = null) : Date
      {
         if(date == null)
         {
            date = new Date();
         }
         return GetFirstNextFirstDayOfTheWeek(date,weekDay);
      }
      
      public function splitDisplayLine(text:String, color:String) : void
      {
         var split:Array = text.split("\n");
         for(line in split)
         {
            displayMessage(split[line]);
            applyColor(color);
         }
      }
      
      public function displayData(ddata:Array) : void
      {
         var data:Array = ddata.concat();
         if(config.anchor == "bottom")
         {
            data.reverse();
         }
         if(data && data.length > 0)
         {
            var date:Date = new Date();
            var utcSeconds:Number = date.getTime() / 1000;
            var utc:Number = (utcSeconds + config.offsetUTC * 3600) % 86400;
            var eventsTimestampHour:* = utcSeconds - utcSeconds % 3600;
            for each(dataField in data)
            {
               switch(dataField)
               {
                  case "showVersion":
                     displayMessage(FULL_MOD_NAME + (this.isHudMenu ? "" : " (non-HUD)"));
                     applyColor(dataField);
                     break;
                  case "showLastConfigUpdate":
                     displayMessage("ConfigUpdate: " + FormatTimeStringCustom(this.timeSinceLastConfigUpdate) + " ago");
                     applyColor(dataField);
                     break;
                  case "showLastEventsUpdate":
                     displayMessage("EventsTime: " + this._lastRecentActivitiesUpdateTime + "ms");
                     applyColor(dataField);
                     break;
                  case "showLastChallengesUpdate":
                     displayMessage("ChallengesTime: " + this._lastChallengeUpdateTime + "ms");
                     applyColor(dataField);
                     break;
                  case "showElapsedTime":
                     displayMessage("ElapsedTime: " + FormatTimeStringCustom(this.elapsedTime));
                     applyColor(dataField);
                     break;
                  case "showHUDMode":
                     displayMessage("HUDMode: " + (!this.isInMainMenu ? this.HUDModeData.data.hudMode : MAIN_MENU));
                     applyColor(dataField);
                     break;
                  case "showRenderTime":
                     displayMessage("RenderTime: " + this._lastRenderTime + "ms");
                     applyColor(dataField);
                     break;
                  case "showTime12":
                     displayMessage("Time: " + (date.hours == 0 ? 12 : date.hours % 12) + ":" + (date.minutes < 10 ? "0" + date.minutes : date.minutes) + (date.hours > 12 ? " PM" : " AM"));
                     applyColor(dataField);
                     break;
                  case "showTime24":
                     displayMessage("Time: " + date.hours + ":" + (date.minutes < 10 ? "0" + date.minutes : date.minutes));
                     applyColor(dataField);
                     break;
                  case "showUTCTime":
                     displayMessage("UTC: " + FormatTimeStringCustom(utc));
                     applyColor(dataField);
                     break;
                  case "showSeasonEndTime":
                     if(this.SeasonData && this.SeasonData.data && this.SeasonData.data.allSeasonData)
                     {
                        displayMessage(config.formats.showSeasonEndTime.replace(STRING_TIME,this.SeasonData.data.allSeasonData.uEndTimeSec != 0 ? FormatTimeStringCustom(Number(this.SeasonData.data.allSeasonData.uEndTimeSec - date.getTime() / 1000)) : "00:00"));
                        applyColor(dataField);
                     }
                     break;
                  case "showMiniSeasonTime":
                     if(this.SeasonData && this.SeasonData.data && this.SeasonData.data.allSeasonData)
                     {
                        var seasonData:Object = this.SeasonData.data.allSeasonData;
                        if(seasonData.szBeginTime != "")
                        {
                           if(seasonData.iSeasonType == 1)
                           {
                              this.miniSeasonRewards = 0;
                              this.miniSeasonRewardsClaimed = 0;
                              if(seasonData.seasonPageDataA && seasonData.seasonPageDataA.length > 0)
                              {
                                 var page:int = 0;
                                 while(page < seasonData.seasonPageDataA.length)
                                 {
                                    var pageData:Object = seasonData.seasonPageDataA[page].pageTileDataA;
                                    if(pageData)
                                    {
                                       this.miniSeasonRewards += int(pageData.length);
                                       var i:int = 0;
                                       while(i < pageData.length)
                                       {
                                          if(pageData[i] && pageData[i].bHasBeenClaimed)
                                          {
                                             ++this.miniSeasonRewardsClaimed;
                                          }
                                          i++;
                                       }
                                    }
                                    page++;
                                 }
                              }
                           }
                           if(!config.miniSeason.hideIfRewardsClaimed || this.miniSeasonRewards == 0 || this.miniSeasonRewards != this.miniSeasonRewardsClaimed)
                           {
                              splitDisplayLine(config.miniSeason.activeText.replace(STRING_TIME,seasonData.szEndTime).replace(STRING_CURRENT_VALUE,this.miniSeasonRewardsClaimed).replace(STRING_THRESHOLD_VALUE,this.miniSeasonRewards),"miniSeasonActive");
                           }
                        }
                        else if(!config.miniSeason.hideIfInactive)
                        {
                           splitDisplayLine(config.miniSeason.inactiveText.replace(STRING_TIME,seasonData.szBeginTime),"miniSeasonInactive");
                        }
                     }
                     break;
                  case "showVerdantSeasons":
                     if(this.verdantSeasons)
                     {
                        if(config.verdantSeason.debug)
                        {
                           displayMessage("vs lang: " + language);
                        }
                        i = this.verdantSeasons.length - 1;
                        while(i >= 0)
                        {
                           var vSeason:Object = this.verdantSeasons[i];
                           var timeDelta:int = utcSeconds - vSeason.time;
                           if(vSeason.active)
                           {
                              splitDisplayLine(config.verdantSeason.activeText.replace(STRING_REGION,vSeason.region).replace(STRING_TIME,FormatTimeStringCustom(timeDelta)),"verdantSeasonActive");
                           }
                           else if(timeDelta < config.verdantSeason.hideEndedSeasonAfter)
                           {
                              splitDisplayLine(config.verdantSeason.endedText.replace(STRING_REGION,vSeason.region).replace(STRING_TIME,FormatTimeStringCustom(timeDelta)),"verdantSeasonEnded");
                           }
                           else
                           {
                              this.verdantSeasons.splice(i,1);
                           }
                           i--;
                        }
                     }
                     break;
                  case "showFishingSeason":
                     if(config.fishingSeason)
                     {
                        setRegionsLocalized(this.RegionNamesData);
                        setFishLocalized(this.ChallengeData);
                        var fishingNextDate:Date = GetFirstNextFirstWeekDay(2,date);
                        var fishingStartDate:Date = GetFirstWeekDay(2,fishingNextDate.month - 1,date.fullYear);
                        var fishingEndDate:Date = new Date(fishingNextDate.time - 60000);
                        var dateFormat:String = config.fishingSeason.dateFormat;
                        var fishingTime:String = FormatTimeStringCustom(Math.max(fishingNextDate.time / 1000 - date.time / 1000,0));
                        var month:int = fishingStartDate.month;
                        var fishingMonth:String = MONTHS_LOCALIZED[FISHING_SEASONS[month].month];
                        var fishingFish:String = FISH_LOCALIZED[FISHING_SEASONS[month].fish];
                        var fishingRegion1:String = REGION_LOCALIZED[FISHING_SEASONS[month].region1];
                        var fishingRegion2:String = REGION_LOCALIZED[FISHING_SEASONS[month].region2];
                        var fishCaught:String = "";
                        fishCaught = Boolean(config.fishingSeason.caught) && Boolean(FISH_CAUGHT[month]) ? config.fishingSeason.caught[1] : config.fishingSeason.caught[0];
                        if(config.fishingSeason.debug)
                        {
                           displayMessage("fishingNextDate: " + fishingNextDate);
                           displayMessage("fishingStartDate: " + fishingStartDate);
                           displayMessage("fishingEndDate: " + fishingEndDate);
                           displayMessage("dateFormat: " + dateFormat);
                           displayMessage("fishingTime: " + fishingTime);
                           displayMessage("month: " + month);
                           displayMessage("fishingMonth: " + fishingMonth);
                           displayMessage("fishingFish: " + fishingFish);
                           displayMessage("fishingRegion1: " + fishingRegion1);
                           displayMessage("fishingRegion2: " + fishingRegion2);
                           displayMessage("fishCaught: " + fishCaught);
                        }
                        if(!config.fishingSeason.hideIfCaught || !Boolean(FISH_CAUGHT[month]))
                        {
                           splitDisplayLine(config.fishingSeason.text.replace(STRING_MONTH,fishingMonth).replace(STRING_FISH,fishingFish).replace(STRING_REGION1,fishingRegion1).replace(STRING_REGION2,fishingRegion2).replace(STRING_TIME,fishingTime).replace(STRING_CAUGHT,fishCaught),dataField);
                        }
                     }
                     break;
                  case "showRaidXP":
                     if(this.UniversalRewardData.data && this.UniversalRewardData.data.xp)
                     {
                        displayMessage(config.formats.showRaidXP.replace(STRING_XP,this.UniversalRewardData.data.xp));
                        applyColor(dataField);
                     }
                     break;
                  case "showXPBar":
                     if(this.XPMeter)
                     {
                        displayMessage(formatXPBarText());
                        applyColor(dataField);
                        if(config.xpBar.enabled)
                        {
                           this.xpBar = {
                              "id":challenges_index - 1,
                              "progress":this.XPMeter.LevelUPBar.Percent
                           };
                        }
                     }
                     break;
                  case "showScoreBar":
                     if(this.SeasonWidgetData.data && this.SeasonWidgetData.data.currentRank)
                     {
                        displayMessage(formatScoreBarText());
                        applyColor(dataField);
                        if(config.scoreBar.enabled)
                        {
                           this.scoreBar = {
                              "id":challenges_index - 1,
                              "progress":this.SeasonWidgetData.data.currentRank.nValuePosition / this.SeasonWidgetData.data.currentRank.nValueThreshold
                           };
                        }
                     }
                     break;
                  case "showMinerva":
                     if(config.minerva)
                     {
                        var utcWithOffset:Number = utcSeconds + config.minerva.offsetHours * 3600;
                        var timeSinceMinervaTimestamp:Number = utcWithOffset - MINERVA_TIMESTAMP;
                        var timeThisWeek:Number = timeSinceMinervaTimestamp % SECONDS_IN_WEEK;
                        var thisWeekMondayTimestamp:Number = utcWithOffset - timeThisWeek;
                        var thisWeekWednesdayTimestamp:Number = thisWeekMondayTimestamp + 2 * SECONDS_IN_DAY;
                        var thisWeekThursdayTimestamp:Number = thisWeekMondayTimestamp + 3 * SECONDS_IN_DAY;
                        var daysFromTimestamp:Number = Math.floor(timeSinceMinervaTimestamp / SECONDS_IN_DAY);
                        var weeksFromTimestamp:Number = Math.floor(timeSinceMinervaTimestamp / SECONDS_IN_WEEK);
                        var nthWeek:int = weeksFromTimestamp % 5;
                        var location:int = nthWeek > 2 ? 3 : nthWeek;
                        var list:int = (Math.floor(weeksFromTimestamp / 5) * 4 + location + MINERVA_TIMESTAMP_LIST) % 24 + 1;
                        var isAvailable:Boolean = false;
                        var arriveLeaveTime:Number = 0;
                        switch(nthWeek)
                        {
                           case 4:
                              isAvailable = false;
                              arriveLeaveTime = thisWeekMondayTimestamp + SECONDS_IN_WEEK - utcWithOffset;
                              break;
                           case 3:
                              isAvailable = utcWithOffset > thisWeekThursdayTimestamp;
                              if(isAvailable)
                              {
                                 arriveLeaveTime = thisWeekMondayTimestamp + SECONDS_IN_WEEK - utcWithOffset;
                              }
                              else
                              {
                                 arriveLeaveTime = thisWeekThursdayTimestamp - utcWithOffset;
                              }
                              break;
                           case 2:
                              isAvailable = utcWithOffset < thisWeekWednesdayTimestamp;
                              if(isAvailable)
                              {
                                 arriveLeaveTime = thisWeekWednesdayTimestamp - utcWithOffset;
                              }
                              else
                              {
                                 arriveLeaveTime = thisWeekThursdayTimestamp + SECONDS_IN_WEEK - utcWithOffset;
                              }
                              break;
                           case 1:
                           case 0:
                              isAvailable = utcWithOffset < thisWeekWednesdayTimestamp;
                              if(isAvailable)
                              {
                                 arriveLeaveTime = thisWeekWednesdayTimestamp - utcWithOffset;
                              }
                              else
                              {
                                 arriveLeaveTime = thisWeekMondayTimestamp + SECONDS_IN_WEEK - utcWithOffset;
                              }
                        }
                        if(nthWeek != 3 && !isAvailable)
                        {
                           list++;
                        }
                        if(config.minerva.showLists.indexOf(list) != -1)
                        {
                           if(isAvailable)
                           {
                              splitDisplayLine(config.minerva.availableText.replace(STRING_LIST,list).replace(STRING_LOCATION,config.minerva.locations[location]).replace(STRING_TIME,FormatTimeStringCustom(arriveLeaveTime)),"minervaAvailable");
                           }
                           else if(!config.minerva.hideIfNotAvailable)
                           {
                              splitDisplayLine(config.minerva.notAvailableText.replace(STRING_LIST,list).replace(STRING_LOCATION,config.minerva.locations[nthWeek != 3 ? (location + 1) % 4 : location]).replace(STRING_TIME,FormatTimeStringCustom(arriveLeaveTime)),"minervaNotAvailable");
                           }
                        }
                     }
                     break;
                  case "showNuclearCodes":
                     if(config.nuclearCodes)
                     {
                        utcWithOffset = utcSeconds + config.nuclearCodes.offsetHours * 3600;
                        var timeSinceCodesTimestamp:Number = utcWithOffset - NUCLEAR_CODES_TIMESTAMP;
                        timeThisWeek = timeSinceCodesTimestamp % SECONDS_IN_WEEK;
                        var iWeeksFromTimeStamp:int = (Math.floor(timeSinceCodesTimestamp / SECONDS_IN_WEEK) - 1) % 52;
                        var expireTime:Number = SECONDS_IN_WEEK - timeThisWeek;
                        var codeAlpha:String = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(iWeeksFromTimeStamp * 24,8)),8);
                        var codeBravo:String = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(iWeeksFromTimeStamp * 24 + 8,8)),8);
                        var codeCharlie:String = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(iWeeksFromTimeStamp * 24 + 16,8)),8);
                        splitDisplayLine(config.nuclearCodes.text.replace(STRING_CODE_ALPHA,codeAlpha).replace(STRING_CODE_BRAVO,codeBravo).replace(STRING_CODE_CHARLIE,codeCharlie).replace(STRING_TIME,FormatTimeStringCustom(expireTime)),dataField);
                        if(iWeeksFromTimeStamp == 0)
                        {
                           if(config.anchor == "top")
                           {
                              displayMessage("WARNING: Rollover week, last week\'s codes:");
                              applyColor(dataField);
                           }
                           codeAlpha = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(NUCLEAR_CODE.length - 24,8)),8);
                           codeBravo = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(NUCLEAR_CODE.length - 16,8)),8);
                           codeCharlie = GlobalFunc.PadNumber(NUCLEAR_CODE_COMBINATIONS - int(NUCLEAR_CODE.substr(NUCLEAR_CODE.length - 8,8)),8);
                           splitDisplayLine(config.nuclearCodes.text.replace(STRING_CODE_ALPHA,codeAlpha).replace(STRING_CODE_BRAVO,codeBravo).replace(STRING_CODE_CHARLIE,codeCharlie).replace(STRING_TIME,"00:00"),dataField);
                           if(config.anchor == "bottom")
                           {
                              displayMessage("WARNING: Rollover week, last week\'s codes:");
                              applyColor(dataField);
                           }
                        }
                     }
                     break;
                  case "showEventTimer":
                     if(config.eventTimer)
                     {
                        var timeThisHour:Number = (utcSeconds - eventsTimestampHour) % 3600;
                        i = 0;
                        while(i < config.eventTimer.eventTimestamps.length)
                        {
                           var timeUntilEvent:Number = config.eventTimer.eventTimestamps[i] * 60 - timeThisHour;
                           if(timeThisHour < config.eventTimer.eventTimestamps[i] * 60 && timeUntilEvent < config.eventTimer.showWithDurationBelowMinutes * 60)
                           {
                              displayMessage(config.eventTimer.text.replace(STRING_TIME,FormatTimeStringCustom(timeUntilEvent)));
                              applyColor(dataField);
                           }
                           i++;
                        }
                     }
                     break;
                  case "showHUDChildren":
                     showHUDChildren();
                     break;
                  default:
                     var parts:Array = dataField.split(":");
                     if(parts.length > 0)
                     {
                        switch(parts[0])
                        {
                           case DATA_SEPARATOR:
                              addSeparator(dataField);
                              break;
                           case DATA_EMPTY_SPACE:
                              addEmptySpace(dataField);
                              break;
                           case DATA_TEXT:
                              addCustomText(dataField);
                              break;
                           case DATA_CHALLENGES:
                              if(parts.length > 1)
                              {
                                 displayChallenges(parts[1]);
                              }
                              break;
                           case DATA_EVENTS:
                              if(parts.length > 1)
                              {
                                 displayEvents(parts[1]);
                              }
                              break;
                           case DATA_POSITION_Y:
                              if(parts.length > 1 && !isNaN(parts[1]))
                              {
                                 nextY = parts[1];
                              }
                              break;
                           case DATA_POSITION_X:
                              if(parts.length > 1 && !isNaN(parts[1]))
                              {
                                 nextX = parts[1];
                              }
                              break;
                           case DATA_Y_SPACING:
                              if(parts.length > 1 && !isNaN(parts[1]))
                              {
                                 nextYSpacing = parts[1];
                              }
                              break;
                           case DATA_SIZE:
                              if(parts.length > 1 && !isNaN(parts[1]))
                              {
                                 nextTextSize = parts[1];
                              }
                              break;
                           case DATA_ALIGN:
                              if(parts.length > 1 && ["left","center","right"].indexOf(parts[1].toLowerCase()) != -1)
                              {
                                 nextTextAlign = parts[1].toLowerCase();
                              }
                              break;
                           case "showHUDChildrenOf":
                              showHUDChildrenOf(parts[1]);
                        }
                     }
                     break;
               }
            }
         }
      }
      
      public function showHUDChildrenOf(item:String) : void
      {
         if(item == null || item == "")
         {
            displayMessage("children not found of: \"\"");
            return;
         }
         var itemProp:* = this.topLevel;
         var parts:Array = item.split(/\./);
         var i:int = 0;
         var len:int = parts.length - 1;
         while(i < parts.length)
         {
            if(itemProp[parts[i]] == null)
            {
               displayMessage(parts[i] + " child not found");
               break;
            }
            itemProp = itemProp[parts[i]];
            i++;
         }
         displayMessage("children: " + itemProp.numChildren);
         getChildrenOf(itemProp);
      }
      
      private function getChildrenOf(item:Object, pref:String = "") : void
      {
         var i:int = 0;
         displayMessage(pref + getQualifiedClassName(item));
         while(i < item.numChildren)
         {
            getChildrenOf(item.getChildAt(i),pref + "\t");
            i++;
         }
      }
      
      public function formatScoreBarText() : String
      {
         return config.scoreBar.text.replace(STRING_CURRENT_VALUE,this.SeasonWidgetData.data.currentRank.nValuePosition).replace(STRING_THRESHOLD_VALUE,this.SeasonWidgetData.data.currentRank.nValueThreshold).replace(STRING_PROGRESS,(100 * (this.SeasonWidgetData.data.currentRank.nValuePosition / this.SeasonWidgetData.data.currentRank.nValueThreshold)).toFixed(1)).replace(STRING_CURRENT_RANK,this.SeasonWidgetData.data.currentRank.nRankNumber).replace(STRING_CURRENT_BOOST,this.SeasonWidgetData.data.uBoostAmount);
      }
      
      public function formatXPBarText() : String
      {
         return config.xpBar.text.replace(STRING_TEXT,this.XPMeter.xptext.text).replace(STRING_CURRENT_LEVEL,this.CharacterInfoData.data.level).replace(STRING_CURRENT_VALUE,int(this.requiredLevelUpXP * this.XPMeter.LevelUPBar.Percent)).replace(STRING_THRESHOLD_VALUE,this.requiredLevelUpXP).replace(STRING_PROGRESS,(100 * this.XPMeter.LevelUPBar.Percent).toFixed(1)).replace(STRING_LAST_CHANGE_VALUE,this.XPMeter.PlusSign.text + this.XPMeter.NumberText.text);
      }
      
      public function formatChallenge(groupName:String, challenge:Object) : String
      {
         if(!challenge)
         {
            return null;
         }
         if(!config.formats[groupName])
         {
            config.formats[groupName] = HUDChallengesConfig.DEFAULT_CHALLENGE_FORMAT;
         }
         return config.formats[groupName].replace(STRING_TEXT,challenge.text).replace(STRING_THRESHOLD_VALUE,challenge.thresholdValue).replace(STRING_CURRENT_VALUE,challenge.currentValue).replace(STRING_END_TIME,FormatTimeStringCustom(challenge.endTime));
      }
      
      public function formatEvent(eventType:String, event:Object) : String
      {
         if(!event)
         {
            return null;
         }
         if(!config.formats[eventType])
         {
            config.formats[eventType] = HUDChallengesConfig.DEFAULT_EVENT_FORMAT;
         }
         var isCountdown:Boolean = false;
         var timeSeconds:Number = _eventTimes[event.id].time + (getTimer() - _eventTimes[event.id].timestamp) / 1000;
         if(config.countdownTimerForEvents.enabled && config.countdownTimerForEvents.events[event.name] != null && config.countdownTimerForEvents.events[event.name] > 0)
         {
            timeSeconds = config.countdownTimerForEvents.events[event.name] - timeSeconds;
            isCountdown = true;
         }
         return config.formats[eventType].replace(STRING_TEXT,event.name).replace(STRING_TIME,isCountdown ? FormatCountdownTimeString(timeSeconds) : FormatTimeStringCustom(timeSeconds)).replace(STRING_TIME_IN_SECONDS,Math.floor(timeSeconds)).replace(STRING_TIME_IN_MINUTES,Math.floor(timeSeconds / 60)).replace(STRING_MUTATION,event.mutation).replace(STRING_PARTICIPANTS,event.participants);
      }
      
      public function drawBar(bar:Object, barConfig:Object, barColorName:String) : void
      {
         if(bar != null && barConfig.enabled)
         {
            var lastCha:Object = challenges_tf[bar.id];
            var barWidth:Number = bar.progress * config.width;
            switch(barConfig.alignVertical)
            {
               case "top":
                  var barY:Number = Number(lastCha.y);
                  break;
               case "center":
                  barY = lastCha.y + lastCha.height / 2 - barConfig.height / 2;
                  break;
               case "bottom":
               default:
                  barY = lastCha.y + lastCha.height - barConfig.height;
            }
            switch(barConfig.alignHorizontal)
            {
               case "right":
                  var barX:Number = lastCha.x + config.width - barWidth;
                  break;
               case "center":
                  barX = lastCha.x + config.width / 2 - barWidth / 2;
                  break;
               case "left":
               default:
                  barX = Number(lastCha.x);
            }
            var barColor:Number = getCustomColor(barColorName);
            this.graphics.beginFill(barColor);
            this.graphics.drawRect(barX,barY,barWidth,barConfig.height);
            this.graphics.endFill();
         }
      }
      
      public function displayChallengesLoop() : void
      {
         var t1:Number;
         try
         {
            t1 = Number(getTimer());
            this.visible = !this.forceHide && Boolean(this.isValidHUDMode() ^ this.toggleVisibility);
            this.scoreBar = null;
            this.xpBar = null;
            if(!this.visible)
            {
               return;
            }
            this.resetMessages();
            this.onRecentActivitiesDataUpdate(this.RecentActivitiesData);
            this.onChallengeDataUpdate(this.ChallengeData);
            this.displayData(config.displayData);
            drawBackground();
            drawSeparators();
            drawBar(this.scoreBar,config.scoreBar,"scoreBar");
            drawBar(this.xpBar,config.xpBar,"xpBar");
            this._lastRenderTime = getTimer() - t1;
         }
         catch(error:*)
         {
            displayMessage("Error displaying: " + error);
            drawBackground();
         }
      }
      
      public function isValidChallengeName(text:String) : Boolean
      {
         var isStateHidden:Boolean = config.hideChallengesState == HUDChallengesConfig.STATE_HIDDEN;
         if(config.hideChallenges.length > 0)
         {
            var index:int = int(ArrayUtils.indexOfCaseInsensitiveString(config.hideChallenges,text));
            if(isStateHidden)
            {
               return index == -1;
            }
            return index != -1;
         }
         return isStateHidden;
      }
      
      public function isValidEventName(text:String) : Boolean
      {
         var isStateHidden:Boolean = config.hideEventsState == HUDChallengesConfig.STATE_HIDDEN;
         if(config.hideEvents.length > 0)
         {
            var index:int = int(ArrayUtils.indexOfCaseInsensitiveString(config.hideEvents,text));
            if(isStateHidden)
            {
               return index == -1;
            }
            return index != -1;
         }
         return isStateHidden;
      }
      
      public function isValidHUDMode() : Boolean
      {
         if(config)
         {
            if(config.HUDModesState == HUDChallengesConfig.STATE_HIDDEN)
            {
               return this.isInMainMenu ? config.HUDModes.indexOf(MAIN_MENU) == -1 : config.HUDModes.indexOf(this.HUDModeData.data.hudMode) == -1;
            }
            return this.isInMainMenu ? config.HUDModes.indexOf(MAIN_MENU) != -1 : config.HUDModes.indexOf(this.HUDModeData.data.hudMode) != -1;
         }
         return true;
      }
   }
}


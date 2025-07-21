package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.GlobalFunc;
   import Shared.HUDModes;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   public class SharedHUDTools
   {
      
      private static const VERSION:String = "v1.1";
      
      public static const PREFIX:String = String.fromCharCode(8192,8192);
      
      public static const READY:String = "HDTREADY";
      
      public static const REGISTER:String = "REG";
      
      public static const UNLOAD:String = "UNLD";
      
      public static const MESSAGE:String = "MSG";
      
      public static const TEXTEDIT:String = "TXT";
      
      public static const STOPTEXTEDIT:String = "XTXT";
      
      public static const FORMATTEXTEDIT:String = "FMTTXT";
      
      public static const FORMATONSCREENKEYBOARD:String = "FMTOSK";
      
      public static const LANGUAGEONSCREENKEYBOARD:String = "LNGOSK";
      
      public static const ERROR:String = "ERROR";
      
      public static const ERRORMESSAGE:String = "ERRMSG";
      
      public static const HUDTOOLS:String = "HDT";
      
      public static const BROADCAST:String = "BROADCASTALLMODS";
      
      public static const MENU:String = "MENU";
      
      public static const STOPMENU:String = "XMENU";
      
      public static const FORMATMENU:String = "FMTMENU";
      
      public static const BUILDMENU:String = "BUILDMENU";
       
      
      private var modName:String = "";
      
      private var hudMode:String = "";
      
      private var msgPayload:UIDataFromClient = null;
      
      private var messageFunction:Function = null;
      
      private var textFunction:Function = null;
      
      private var buildMenuFunction:Function = null;
      
      private var selectMenuFunction:Function = null;
      
      private var menuId:String = "";
      
      private var menuItems:String = "";
      
      private var iteration:uint = 0;
      
      private var queueTimer:Timer;
      
      private var queueArray:Array;
      
      private var queueFlag:Boolean = true;
      
      private var registerQueueFlag:Boolean = false;
      
      private var _active:Boolean = false;
      
      public function SharedHUDTools(modname:String, hudmode:String = "")
      {
         this.queueArray = new Array();
         var date:Date = new Date();
         if(hudmode == "")
         {
            hudmode = HUDModes.ALL;
         }
         iteration = uint(date.getTime());
         super();
         this.modName = modname;
         this.hudMode = hudmode;
         this.msgPayload = BSUIDataManager.GetDataFromClient("HUDMessageProvider");
         if(this.modName != HUDTOOLS)
         {
            this.SubscribeListener("MessageEvents",this.onMessageEvent);
         }
         this.queueFlag = true;
         this.queueTimer = new Timer(100,1);
         this.queueTimer.addEventListener(TimerEvent.TIMER_COMPLETE,queueComplete);
         this.queueTimer.start();
      }
      
      private function queueComplete(e:TimerEvent) : void
      {
         var text:String = "";
         this.queueFlag = false;
         this.registerQueueFlag = false;
         for each(text in this.queueArray)
         {
            this.dispatchMessage(text);
         }
         this.queueArray = new Array();
      }
      
      public function startQueue() : *
      {
         this.queueFlag = true;
         this.queueTimer.reset();
         this.queueTimer.start();
      }
      
      public function dispatchMessage(text:String) : void
      {
         if(queueFlag)
         {
            this.queueArray.push(text);
         }
         else
         {
            GlobalFunc.ShowHUDMessage(text);
         }
      }
      
      public function formatMsg(rec:String, msgType:String, msgOptions:Array) : String
      {
         var msg:String = PREFIX + this.modName + "|" + (this.iteration++).toString(16) + "|" + rec + "|" + msgType;
         if(msgOptions.length > 0)
         {
            msg += "|" + msgOptions.join("|");
         }
         return msg;
      }
      
      public function Register(func:Function) : Boolean
      {
         var newMsgString:String;
         try
         {
            if(this.modName.length >= 3 && this.hudMode.length >= 3)
            {
               this.messageFunction = func;
               newMsgString = formatMsg(HUDTOOLS,REGISTER,[this.hudMode,VERSION]);
               this.dispatchMessage(newMsgString);
               if(this.queueFlag)
               {
                  this.registerQueueFlag = true;
               }
               return true;
            }
         }
         catch(e:Error)
         {
            return false;
         }
         return false;
      }
      
      public function Shutdown() : void
      {
         try
         {
            BSUIDataManager.Unsubscribe("MessageEvents",this.onMessageEvent);
         }
         catch(e:Error)
         {
         }
      }
      
      public function TextEdit(func:Function, startText:String = "") : Boolean
      {
         var newMsgString:String;
         try
         {
            isActive = true;
            textFunction = func;
            newMsgString = formatMsg(HUDTOOLS,TEXTEDIT,[startText]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            isActive = false;
            textFunction = null;
            return false;
         }
         return true;
      }
      
      public function EndTextEdit() : Boolean
      {
         var newMsgString:String;
         try
         {
            newMsgString = formatMsg(HUDTOOLS,STOPTEXTEDIT,[]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function FormatTextEdit(x:Number, y:Number, width:Number, height:Number, font:String = "", size:Number = -1, hexColor:String = "", bgHexColor:String = "", bgAlpha:Number = -1) : Boolean
      {
         var newMsgString:String;
         var textFormat:String;
         try
         {
            textFormat = String(x) + "," + String(y) + "," + String(width) + "," + String(height);
            if(font.length > 0)
            {
               textFormat += "," + font;
               if(size >= 0)
               {
                  textFormat += "," + String(size);
                  if(hexColor.length > 0)
                  {
                     textFormat += "," + hexColor;
                     if(bgHexColor.length > 0)
                     {
                        textFormat += "," + bgHexColor;
                        if(bgAlpha > 0)
                        {
                           textFormat += "," + String(bgAlpha);
                        }
                     }
                  }
               }
            }
            newMsgString = formatMsg(HUDTOOLS,FORMATTEXTEDIT,[textFormat]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function FormatOnScreenKeyboard(x:Number, y:Number, hexColor:String = "", bgHexColor:String = "", bgAlpha:Number = -1, selectHexColor:String = "", selectBGHexColor:String = "") : Boolean
      {
         var newMsgString:String;
         var oskFormat:String;
         try
         {
            oskFormat = String(x) + "," + String(y);
            if(hexColor.length > 0)
            {
               oskFormat += "," + hexColor;
               if(bgHexColor.length > 0)
               {
                  oskFormat += "," + bgHexColor;
                  if(bgAlpha >= 0)
                  {
                     oskFormat += "," + String(bgAlpha);
                     if(selectHexColor.length > 0)
                     {
                        oskFormat += "," + selectHexColor;
                        if(selectBGHexColor.length > 0)
                        {
                           oskFormat += "," + selectBGHexColor;
                        }
                     }
                  }
               }
            }
            newMsgString = formatMsg(HUDTOOLS,FORMATONSCREENKEYBOARD,[oskFormat]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function ShowMenu() : Boolean
      {
         var newMsgString:String;
         try
         {
            isActive = true;
            newMsgString = formatMsg(HUDTOOLS,MENU,[]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            isActive = false;
            return false;
         }
         return true;
      }
      
      public function CloseMenu() : Boolean
      {
         var newMsgString:String;
         try
         {
            newMsgString = formatMsg(HUDTOOLS,STOPMENU,[]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function RegisterMenu(build:Function, select:Function) : *
      {
         buildMenuFunction = build;
         selectMenuFunction = select;
      }
      
      public function AddMenuItem(id:String, text:String, isEnabled:Boolean = true, isMenu:Boolean = false, timeout:Number = -1) : *
      {
         if(this.menuItems.length > 0)
         {
            this.menuItems += ";";
         }
         if(timeout < 0)
         {
            timeout = 0;
         }
         this.menuItems += id + "," + text + "," + (isEnabled ? "Y" : "N") + "," + (isMenu ? "Y" : "N") + "," + String(timeout);
      }
      
      public function FormatMenu(x:Number, y:Number, direction:String = "") : *
      {
         var newMsgString:String;
         var menuFormat:String;
         try
         {
            menuFormat = String(x) + "," + String(y);
            if(direction.length > 0)
            {
               menuFormat += "," + direction;
            }
            newMsgString = formatMsg(HUDTOOLS,FORMATMENU,[menuFormat]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function SetLanguageOnScreenKeyboard(lang:String) : Boolean
      {
         var newMsgString:String;
         try
         {
            newMsgString = formatMsg(HUDTOOLS,LANGUAGEONSCREENKEYBOARD,[lang]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function SendMessage(rec:String, msg:String, queue:Boolean = true) : Boolean
      {
         var newMsgString:String;
         var queueString:String;
         try
         {
            queueString = queue ? "true" : "false";
            newMsgString = formatMsg(rec,MESSAGE,[msg,queueString]);
            this.dispatchMessage(newMsgString);
         }
         catch(e:Error)
         {
            return false;
         }
         return true;
      }
      
      public function onMessageEvent(msgEvent:FromClientDataEvent) : void
      {
         var msgIndex:int;
         var msgData:*;
         var msgArray:Array;
         var eventData:*;
         var newMsgString:String;
         var broadcast:Boolean;
         var eventIndex:int = 0;
         var result:String = "";
         while(eventIndex < msgEvent.data.events.length)
         {
            try
            {
               eventData = msgEvent.data.events[eventIndex];
               switch(eventData.eventType)
               {
                  case "new":
                     msgIndex = int(eventData.eventIndex);
                     msgData = this.msgPayload.data.messages[msgIndex];
                     if(msgData == null)
                     {
                        break;
                     }
                     if(msgData.messageText.substring(0,2) == PREFIX)
                     {
                        msgArray = msgData.messageText.substring(2).split("|");
                        if(msgArray.length >= 4)
                        {
                           broadcast = msgArray[2] == BROADCAST;
                           if(msgArray[2] == this.modName || broadcast)
                           {
                              this.queueFlag = true;
                              this.queueTimer.reset();
                              this.queueTimer.start();
                              if(msgArray[3] == MESSAGE && msgArray.length >= 5)
                              {
                                 if(messageFunction != null)
                                 {
                                    messageFunction(msgArray[0],msgArray[4]);
                                 }
                              }
                              else if(msgArray[3] == READY)
                              {
                                 if(messageFunction != null && !this.registerQueueFlag)
                                 {
                                    newMsgString = formatMsg(HUDTOOLS,REGISTER,[this.hudMode,VERSION]);
                                    this.dispatchMessage(newMsgString);
                                 }
                              }
                              else if(msgArray[3] == TEXTEDIT)
                              {
                                 if(textFunction != null)
                                 {
                                    if(msgArray.length >= 5)
                                    {
                                       textFunction(msgArray[4]);
                                    }
                                    else
                                    {
                                       textFunction(null);
                                    }
                                    textFunction = null;
                                 }
                                 isActive = false;
                              }
                              else if(msgArray[3] == MENU)
                              {
                                 if(msgArray.length >= 5 && selectMenuFunction != null)
                                 {
                                    selectMenuFunction(msgArray[4]);
                                 }
                                 else
                                 {
                                    isActive = false;
                                 }
                              }
                              else if(msgArray[3] == BUILDMENU)
                              {
                                 if(buildMenuFunction != null)
                                 {
                                    this.menuId = this.modName;
                                    if(msgArray.length >= 5)
                                    {
                                       this.menuId = msgArray[4];
                                    }
                                    this.menuItems = "";
                                    buildMenuFunction(this.menuId);
                                    newMsgString = formatMsg(HUDTOOLS,BUILDMENU,[this.menuId,this.menuItems]);
                                    this.dispatchMessage(newMsgString);
                                 }
                              }
                              else if(msgArray[3] == ERROR && msgArray.length >= 5)
                              {
                                 if(msgArray[4] == TEXTEDIT && textFunction != null)
                                 {
                                    textFunction(null);
                                    textFunction = null;
                                    isActive = false;
                                 }
                                 else if(msgArray[4] == MENU)
                                 {
                                    isActive = false;
                                 }
                              }
                           }
                        }
                        break;
                     }
               }
            }
            catch(e:Error)
            {
               this.displayError("SharedHUDTools.onMessageEvent error: " + e.message);
            }
            eventIndex++;
         }
      }
      
      private function SubscribeListener(eventName:String, eventFunction:Function) : Function
      {
         var uiData:UIDataFromClient;
         try
         {
            uiData = BSUIDataManager.GetDataFromClient(eventName,true,false);
            if(uiData != null)
            {
               uiData.addEventListener(Event.CHANGE,eventFunction,false,2);
               return eventFunction;
            }
            this.displayError("SharedHUDTools.SubscribeListener error: couldn\'t subscribe to data provider: " + eventName);
            return null;
         }
         catch(e:Error)
         {
            this.displayError("SharedHUDTools error: " + e.message);
         }
         return null;
      }
      
      private function displayError(errorString:String) : void
      {
         var newMsgString:String = formatMsg(HUDTOOLS,ERRORMESSAGE,[errorString]);
         this.dispatchMessage(newMsgString);
      }
      
      public function get isActive() : Boolean
      {
         return _active;
      }
      
      public function set isActive(value:Boolean) : void
      {
         _active = value;
      }
   }
}

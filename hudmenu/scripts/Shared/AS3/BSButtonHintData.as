package Shared.AS3
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.PlatformChangeEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   
   public dynamic class BSButtonHintData extends EventDispatcher
   {
      
      public static const BUTTON_HINT_DATA_CHANGE:String = "ButtonHintDataChange";
      
      public static const EVENT_CONTROL_MAP_DATA:String = "ControlMapData";
       
      
      private var _strButtonText:String;
      
      private var _strPCKey:String;
      
      private var _strPSNButton:String;
      
      private var _strXenonButton:String;
      
      private var _uiJustification:uint;
      
      private var _callbackFunction:Function;
      
      private var _bButtonDisabled:Boolean;
      
      private var _bSecondaryButtonDisabled:Boolean;
      
      private var _bButtonVisible:Boolean;
      
      private var _bButtonFlashing:Boolean;
      
      private var m_DispatchEvent:String;
      
      private var m_UserEvent:String;
      
      private var _hasSecondaryButton:Boolean;
      
      private var _strSecondaryPCKey:String;
      
      private var _strSecondaryXenonButton:String;
      
      private var _strSecondaryPSNButton:String;
      
      private var _secondaryButtonCallback:Function;
      
      private var m_CanHold:Boolean = false;
      
      private var m_HoldPercent:Number = 0;
      
      private var m_bIgnorePCKeyMapping:Boolean = false;
      
      private var m_UserEventMapping:String = "";
      
      private var m_bForceUppercase:Boolean = true;
      
      private var _isWarning:Boolean;
      
      private var _strDynamicMovieClipName:String;
      
      public var onAnnounceDataChange:Function;
      
      public var onTextClick:Function;
      
      public var onSecondaryButtonClick:Function;
      
      public function BSButtonHintData(param1:String, param2:String, param3:String, param4:String, param5:uint, param6:Function, param7:String = "", param8:String = "")
      {
         this.onAnnounceDataChange = this.onAnnounceDataChange_Impl;
         this.onTextClick = this.onTextClick_Impl;
         this.onSecondaryButtonClick = this.onSecondaryButtonClick_Impl;
         super();
         this._strPCKey = param2;
         this._strButtonText = param1;
         this._strXenonButton = param4;
         this._strPSNButton = param3;
         this._uiJustification = param5;
         this._callbackFunction = param6;
         this._bButtonDisabled = false;
         this._bButtonVisible = true;
         this._bButtonFlashing = false;
         this.m_DispatchEvent = param7;
         this.m_UserEvent = param8;
         this._hasSecondaryButton = false;
         this._strSecondaryPCKey = "";
         this._strSecondaryPSNButton = "";
         this._strSecondaryXenonButton = "";
         this._secondaryButtonCallback = null;
         this._strDynamicMovieClipName = "";
         this._isWarning = false;
      }
      
      public function get PCKey() : String
      {
         return this._strPCKey;
      }
      
      public function get PSNButton() : String
      {
         return this._strPSNButton;
      }
      
      public function get XenonButton() : String
      {
         return this._strXenonButton;
      }
      
      public function get Justification() : uint
      {
         return this._uiJustification;
      }
      
      public function get DispatchEvent() : String
      {
         return this.m_DispatchEvent;
      }
      
      public function get UserEvent() : String
      {
         return this.m_UserEvent;
      }
      
      public function get SecondaryPCKey() : String
      {
         return this._strSecondaryPCKey;
      }
      
      public function get SecondaryPSNButton() : String
      {
         return this._strSecondaryPSNButton;
      }
      
      public function get SecondaryXenonButton() : String
      {
         return this._strSecondaryXenonButton;
      }
      
      public function get DynamicMovieClipName() : String
      {
         return this._strDynamicMovieClipName;
      }
      
      public function set DynamicMovieClipName(param1:String) : void
      {
         if(this._strDynamicMovieClipName != param1)
         {
            this._strDynamicMovieClipName = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get canHold() : Boolean
      {
         return this.m_CanHold;
      }
      
      public function set canHold(param1:Boolean) : void
      {
         if(this.m_CanHold != param1)
         {
            this.m_CanHold = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get holdPercent() : Number
      {
         return this.m_HoldPercent;
      }
      
      public function set holdPercent(param1:Number) : void
      {
         if(this.m_HoldPercent != param1)
         {
            this.m_HoldPercent = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ignorePCKeyMapping() : Boolean
      {
         return this.m_bIgnorePCKeyMapping;
      }
      
      public function set ignorePCKeyMapping(param1:Boolean) : void
      {
         if(this.m_bIgnorePCKeyMapping != param1)
         {
            this.m_bIgnorePCKeyMapping = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get forceUppercase() : Boolean
      {
         return this.m_bForceUppercase;
      }
      
      public function set forceUppercase(param1:Boolean) : void
      {
         if(this.m_bForceUppercase != param1)
         {
            this.m_bForceUppercase = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get userEventMapping() : String
      {
         return this.m_UserEventMapping;
      }
      
      public function set userEventMapping(param1:String) : void
      {
         var _loc2_:UIDataFromClient = null;
         if(this.m_UserEventMapping != param1)
         {
            this.m_UserEventMapping = param1;
            if(this.m_UserEventMapping == "")
            {
               BSUIDataManager.Unsubscribe(EVENT_CONTROL_MAP_DATA,this.onControlMapData);
            }
            else
            {
               BSUIDataManager.Subscribe(EVENT_CONTROL_MAP_DATA,this.onControlMapData);
               _loc2_ = BSUIDataManager.GetDataFromClient(EVENT_CONTROL_MAP_DATA);
               if(_loc2_ && _loc2_.data && Boolean(_loc2_.data.buttonMappings) && _loc2_.data.uiController != null)
               {
                  this.updateButtonsFromMapping(_loc2_.data.uiController,_loc2_.data.buttonMappings);
               }
            }
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonDisabled() : Boolean
      {
         return this._bButtonDisabled;
      }
      
      public function set ButtonDisabled(param1:Boolean) : *
      {
         if(this._bButtonDisabled != param1)
         {
            this._bButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonEnabled() : Boolean
      {
         return !this.ButtonDisabled;
      }
      
      public function set ButtonEnabled(param1:Boolean) : void
      {
         this.ButtonDisabled = !param1;
      }
      
      public function get SecondaryButtonDisabled() : Boolean
      {
         return this._bSecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonDisabled(param1:Boolean) : *
      {
         if(this._bSecondaryButtonDisabled != param1)
         {
            this._bSecondaryButtonDisabled = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get SecondaryButtonEnabled() : Boolean
      {
         return !this.SecondaryButtonDisabled;
      }
      
      public function set SecondaryButtonEnabled(param1:Boolean) : void
      {
         this.SecondaryButtonDisabled = !param1;
      }
      
      public function get ButtonText() : String
      {
         return this._strButtonText;
      }
      
      public function set ButtonText(param1:String) : void
      {
         if(this._strButtonText != param1)
         {
            this._strButtonText = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonVisible() : Boolean
      {
         return this._bButtonVisible;
      }
      
      public function set ButtonVisible(param1:Boolean) : void
      {
         if(this._bButtonVisible != param1)
         {
            this._bButtonVisible = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get ButtonFlashing() : Boolean
      {
         return this._bButtonFlashing;
      }
      
      public function set ButtonFlashing(param1:Boolean) : void
      {
         if(this._bButtonFlashing != param1)
         {
            this._bButtonFlashing = param1;
            this.AnnounceDataChange();
         }
      }
      
      public function get hasSecondaryButton() : Boolean
      {
         return this._hasSecondaryButton;
      }
      
      public function get IsWarning() : Boolean
      {
         return this._isWarning;
      }
      
      public function set IsWarning(param1:Boolean) : void
      {
         if(this._isWarning != param1)
         {
            this._isWarning = param1;
            this.AnnounceDataChange();
         }
      }
      
      private function AnnounceDataChange() : void
      {
         dispatchEvent(new Event(BUTTON_HINT_DATA_CHANGE));
         if(this.onAnnounceDataChange is Function)
         {
            this.onAnnounceDataChange();
         }
      }
      
      private function onAnnounceDataChange_Impl() : void
      {
      }
      
      public function SetButtons(param1:String, param2:String, param3:String) : *
      {
         var _loc4_:Boolean = false;
         if(this._strPCKey != param1)
         {
            this._strPCKey = param1;
            _loc4_ = true;
         }
         if(this._strPSNButton != param2)
         {
            this._strPSNButton = param2;
            _loc4_ = true;
         }
         if(this._strXenonButton != param3)
         {
            this._strXenonButton = param3;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function SetSecondaryButtons(param1:String, param2:String, param3:String) : *
      {
         this._hasSecondaryButton = true;
         var _loc4_:Boolean = false;
         if(this._strSecondaryPCKey != param1)
         {
            this._strSecondaryPCKey = param1;
            _loc4_ = true;
         }
         if(this._strSecondaryPSNButton != param2)
         {
            this._strSecondaryPSNButton = param2;
            _loc4_ = true;
         }
         if(this._strSecondaryXenonButton != param3)
         {
            this._strSecondaryXenonButton = param3;
            _loc4_ = true;
         }
         if(_loc4_)
         {
            this.AnnounceDataChange();
         }
      }
      
      public function set secondaryButtonCallback(param1:Function) : *
      {
         this._secondaryButtonCallback = param1;
      }
      
      private function onTextClick_Impl() : void
      {
         if(this._callbackFunction is Function)
         {
            if(this.m_DispatchEvent != "")
            {
               this._callbackFunction.call(null,this.m_DispatchEvent);
            }
            else
            {
               this._callbackFunction.call();
            }
         }
      }
      
      private function onSecondaryButtonClick_Impl() : void
      {
         if(this._secondaryButtonCallback is Function)
         {
            this._secondaryButtonCallback.call();
         }
      }
      
      private function onControlMapData(param1:FromClientDataEvent) : void
      {
         if(this.userEventMapping != "" && param1 && param1.data && Boolean(param1.data.buttonMappings) && param1.data.uiController != null)
         {
            this.updateButtonsFromMapping(param1.data.uiController,param1.data.buttonMappings);
         }
      }
      
      private function updateButtonsFromMapping(param1:uint, param2:Array) : void
      {
         var _loc3_:String = null;
         var _loc4_:uint = 0;
         if(param1 != PlatformChangeEvent.PLATFORM_INVALID && this.userEventMapping != "" && (!this.ignorePCKeyMapping || param1 != PlatformChangeEvent.PLATFORM_PC_KB_MOUSE))
         {
            _loc3_ = "";
            _loc4_ = 0;
            while(_loc4_ < param2.length)
            {
               if(param2[_loc4_].userEventName == this.userEventMapping)
               {
                  _loc3_ = param2[_loc4_].buttonName;
                  break;
               }
               _loc4_++;
            }
            if(_loc3_ != "")
            {
               switch(param1)
               {
                  case PlatformChangeEvent.PLATFORM_PC_KB_MOUSE:
                     this.SetButtons(_loc3_,this.PSNButton,this.XenonButton);
                     break;
                  case PlatformChangeEvent.PLATFORM_PS4:
                     this.SetButtons(this.PCKey,_loc3_,this.XenonButton);
                     break;
                  case PlatformChangeEvent.PLATFORM_PC_GAMEPAD:
                  case PlatformChangeEvent.PLATFORM_XB1:
                     this.SetButtons(this.PCKey,this.PSNButton,_loc3_);
               }
            }
         }
      }
   }
}

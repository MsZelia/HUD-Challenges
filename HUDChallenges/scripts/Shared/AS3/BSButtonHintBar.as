package Shared.AS3
{
   import Shared.AS3.COMPANIONAPP.CompanionAppMode;
   import Shared.AS3.COMPANIONAPP.MobileButtonHint;
   import flash.display.Graphics;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Rectangle;
   
   public dynamic class BSButtonHintBar extends BSUIComponent
   {
      
      public static var BACKGROUND_COLOR:uint = 0;
      
      public static var BACKGROUND_ALPHA:Number = 0.4;
      
      public static var BACKGROUND_PAD:Number = 8;
      
      public static var BUTTON_SPACING:Number = 20;
      
      public static var BAR_Y_OFFSET:Number = 5;
      
      private static var ALIGN_CENTER:* = 0;
      
      private static var ALIGN_LEFT:* = 1;
      
      private static var ALIGN_RIGHT:* = 2;
      
      public var Sizer_mc:MovieClip;
      
      private var Alignment:int = 0;
      
      private var StartingXPos:int = 0;
      
      private var m_UseBackground:Boolean = true;
      
      private var m_PaddingRect:Rectangle;
      
      private var ButtonHintBarInternal_mc:MovieClip;
      
      private var _buttonHintDataV:Vector.<BSButtonHintData>;
      
      private var ButtonPoolV:Vector.<BSButtonHint>;
      
      private var m_UseVaultTecColor:Boolean = true;
      
      private var _holdButtonsV:Vector.<BSButtonHintData>;
      
      private var _bRedirectToButtonBarMenu:Boolean = true;
      
      public var SetButtonHintData:Function;
      
      public function BSButtonHintBar()
      {
         this.SetButtonHintData = this.SetButtonHintData_Impl;
         super();
         visible = false;
         this.ButtonHintBarInternal_mc = new MovieClip();
         this.ButtonHintBarInternal_mc.y = BAR_Y_OFFSET;
         addChild(this.ButtonHintBarInternal_mc);
         this._buttonHintDataV = new Vector.<BSButtonHintData>();
         this.ButtonPoolV = new Vector.<BSButtonHint>();
         this._holdButtonsV = new Vector.<BSButtonHintData>();
         this.m_PaddingRect = new Rectangle();
         this.StartingXPos = this.x;
      }
      
      public function set paddingRect(param1:Rectangle) : void
      {
         this.m_PaddingRect = param1;
         SetIsDirty();
      }
      
      public function get paddingRect() : Rectangle
      {
         return this.m_PaddingRect;
      }
      
      public function set useBackground(param1:Boolean) : void
      {
         this.m_UseBackground = param1;
         SetIsDirty();
      }
      
      public function get useBackground() : Boolean
      {
         return this.m_UseBackground;
      }
      
      public function get bRedirectToButtonBarMenu_Inspectable() : Boolean
      {
         return this._bRedirectToButtonBarMenu;
      }
      
      public function set bRedirectToButtonBarMenu_Inspectable(param1:Boolean) : *
      {
         if(this._bRedirectToButtonBarMenu != param1)
         {
            this._bRedirectToButtonBarMenu = param1;
            SetIsDirty();
         }
      }
      
      public function get useVaultTecColor() : Boolean
      {
         return this.m_UseVaultTecColor;
      }
      
      public function set useVaultTecColor(param1:Boolean) : void
      {
         if(this.m_UseVaultTecColor != param1)
         {
            this.m_UseVaultTecColor = param1;
            SetIsDirty();
         }
      }
      
      public function set align(param1:uint) : *
      {
         this.Alignment = param1;
         SetIsDirty();
      }
      
      private function CanBeVisible() : Boolean
      {
         return !this.bRedirectToButtonBarMenu_Inspectable || !bAcquiredByNativeCode;
      }
      
      override public function onAcquiredByNativeCode() : *
      {
         var _loc1_:Vector.<BSButtonHintData> = null;
         super.onAcquiredByNativeCode();
         if(this.bRedirectToButtonBarMenu_Inspectable)
         {
            this.SetButtonHintData(this._buttonHintDataV);
            _loc1_ = new Vector.<BSButtonHintData>();
            this.SetButtonHintData_Impl(_loc1_);
            SetIsDirty();
         }
      }
      
      private function SetButtonHintData_Impl(param1:Vector.<BSButtonHintData>) : void
      {
         var abuttonHintDataV:Vector.<BSButtonHintData> = param1;
         this._buttonHintDataV.forEach(function(param1:BSButtonHintData, param2:int, param3:Vector.<BSButtonHintData>):*
         {
            if(param1)
            {
               param1.removeEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
            }
         },this);
         this._holdButtonsV.length = 0;
         this._buttonHintDataV = abuttonHintDataV;
         this._buttonHintDataV.forEach(function(param1:BSButtonHintData, param2:int, param3:Vector.<BSButtonHintData>):*
         {
            if(param1)
            {
               param1.addEventListener(BSButtonHintData.BUTTON_HINT_DATA_CHANGE,this.onButtonHintDataDirtyEvent);
               if(param1.canHold)
               {
                  _holdButtonsV.push(param1);
               }
            }
         },this);
         this.CreateButtonHints();
      }
      
      public function FindDispatchEventForUserEvent(param1:String) : String
      {
         var _loc2_:String = "";
         var _loc3_:* = 0;
         while(_loc3_ < this._buttonHintDataV.length)
         {
            if(this._buttonHintDataV[_loc3_].UserEvent == param1)
            {
               _loc2_ = this._buttonHintDataV[_loc3_].DispatchEvent;
               break;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function FindButtonHintDataForUserEvent(param1:String, param2:Boolean) : BSButtonHintData
      {
         var _loc4_:* = undefined;
         var _loc5_:* = undefined;
         var _loc3_:BSButtonHintData = null;
         if(!param2)
         {
            _loc4_ = 0;
            while(_loc4_ < this._holdButtonsV.length)
            {
               if(this._holdButtonsV[_loc4_].UserEvent == param1)
               {
                  _loc3_ = this._holdButtonsV[_loc4_];
                  break;
               }
               _loc4_++;
            }
         }
         if(_loc3_ == null)
         {
            _loc5_ = 0;
            while(_loc5_ < this._buttonHintDataV.length)
            {
               if(this._buttonHintDataV[_loc5_].UserEvent == param1 && !this._buttonHintDataV[_loc5_].canHold)
               {
                  _loc3_ = this._buttonHintDataV[_loc5_];
                  break;
               }
               _loc5_++;
            }
         }
         return _loc3_;
      }
      
      public function onButtonHintDataDirtyEvent(param1:Event) : void
      {
         SetIsDirty();
      }
      
      public function HideAllButtons() : void
      {
         var _loc1_:BSButtonHintData = null;
         for each(_loc1_ in this._buttonHintDataV)
         {
            _loc1_.ButtonVisible = false;
         }
      }
      
      public function HideAllButtonsExcept(... rest) : void
      {
         var _loc2_:BSButtonHintData = null;
         var _loc3_:* = false;
         var _loc4_:int = 0;
         for each(_loc2_ in this._buttonHintDataV)
         {
            _loc3_ = true;
            _loc4_ = 0;
            while(_loc4_ < rest.length)
            {
               _loc3_ = _loc2_ != rest[_loc4_];
               if(!_loc3_)
               {
                  break;
               }
               _loc4_++;
            }
            if(_loc3_)
            {
               _loc2_.ButtonVisible = false;
            }
         }
      }
      
      private function CreateButtonHints() : *
      {
         visible = false;
         while(this.ButtonPoolV.length < this._buttonHintDataV.length)
         {
            if(CompanionAppMode.isOn)
            {
               this.ButtonPoolV.push(new MobileButtonHint());
            }
            else
            {
               this.ButtonPoolV.push(new BSButtonHint());
            }
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.ButtonPoolV.length)
         {
            this.ButtonPoolV[_loc1_].ButtonHintData = _loc1_ < this._buttonHintDataV.length ? this._buttonHintDataV[_loc1_] : null;
            _loc1_++;
         }
         SetIsDirty();
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
      }
      
      override public function redrawUIComponent() : void
      {
         var _loc4_:BSButtonHint = null;
         super.redrawUIComponent();
         var _loc1_:* = false;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         if(CompanionAppMode.isOn)
         {
            _loc3_ = stage.stageWidth - 75;
         }
         var _loc5_:int = -1;
         var _loc6_:Number = 0;
         while(_loc6_ < this.ButtonPoolV.length)
         {
            _loc4_ = this.ButtonPoolV[_loc6_];
            if(_loc4_.ButtonVisible && this.CanBeVisible())
            {
               _loc1_ = true;
               _loc4_.useVaultTecColor = this.useVaultTecColor;
               _loc5_ = _loc6_;
               if(!this.ButtonHintBarInternal_mc.contains(_loc4_))
               {
                  this.ButtonHintBarInternal_mc.addChild(_loc4_);
               }
               if(_loc4_.bIsDirty)
               {
                  _loc4_.redrawUIComponent();
               }
               if(CompanionAppMode.isOn && _loc4_.Justification == BSButtonHint.JUSTIFY_RIGHT)
               {
                  _loc3_ -= _loc4_.Sizer_mc.width;
                  _loc4_.x = _loc3_;
               }
               else
               {
                  _loc4_.x = _loc2_;
                  _loc2_ += _loc4_.Sizer_mc.width + BUTTON_SPACING;
               }
            }
            else if(this.ButtonHintBarInternal_mc.contains(_loc4_))
            {
               this.ButtonHintBarInternal_mc.removeChild(_loc4_);
            }
            _loc6_++;
         }
         if(this.ButtonPoolV.length > this._buttonHintDataV.length)
         {
            this.ButtonPoolV.splice(this._buttonHintDataV.length,this.ButtonPoolV.length - this._buttonHintDataV.length);
         }
         var _loc7_:Rectangle = new Rectangle(0,0,0,0);
         if(_loc5_ >= 0)
         {
            _loc7_.width = this.ButtonPoolV[_loc5_].x + this.ButtonPoolV[_loc5_].Sizer_mc.width;
            _loc7_.height = this.ButtonPoolV[_loc5_].y + this.ButtonPoolV[_loc5_].Sizer_mc.height;
         }
         if(Boolean(this.Sizer_mc) && this.ButtonHintBarInternal_mc.contains(this.Sizer_mc))
         {
            this.ButtonHintBarInternal_mc.removeChild(this.Sizer_mc);
         }
         this.Sizer_mc = new MovieClip();
         var _loc8_:Graphics = this.Sizer_mc.graphics;
         this.ButtonHintBarInternal_mc.addChildAt(this.Sizer_mc,0);
         _loc8_.clear();
         _loc8_.beginFill(BACKGROUND_COLOR,this.m_UseBackground ? BACKGROUND_ALPHA : 0);
         _loc8_.drawRect(0 + this.m_PaddingRect.x,0 + this.m_PaddingRect.y,_loc7_.width + this.m_PaddingRect.width + BACKGROUND_PAD,_loc7_.height + this.m_PaddingRect.height);
         _loc8_.endFill();
         this.Sizer_mc.x = BACKGROUND_PAD * -0.5;
         if(!CompanionAppMode.isOn)
         {
            this.ButtonHintBarInternal_mc.x = -_loc7_.width / 2;
         }
         visible = _loc1_;
         if(this.Alignment == ALIGN_LEFT)
         {
            this.x = this.StartingXPos + _loc7_.width / 2;
         }
         else if(this.Alignment != ALIGN_CENTER)
         {
            if(this.Alignment == ALIGN_RIGHT)
            {
               this.x = this.StartingXPos - _loc7_.width / 2;
            }
         }
      }
   }
}


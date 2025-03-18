package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Data.UIDataFromClient;
   import Shared.AS3.Events.CustomEvent;
   import Shared.GlobalFunc;
   import flash.events.Event;
   import flash.utils.getTimer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol689")]
   public dynamic class Messages extends BSUIComponent
   {
      
      private static var MAX_SHOWN:uint = 4;
      
      private static var THROTTLE_DURATION:uint = 5 * 1000;
       
      
      public var MessageArray:Vector.<HUDMessageItemData>;
      
      public var ShownMessageArray:Vector.<HUDMessageItemBase>;
      
      private var MessageSpacing:int = -2;
      
      private var bAnimating:Boolean;
      
      private var ySpacing:Number;
      
      private var bqueuedMessage:Boolean = false;
      
      private var fadingOutMessage:Boolean = false;
      
      private var lastTime:Number = 0;
      
      private var bPauseUpdates:Boolean = false;
      
      private var _maxClipHeight:Number = 160;
      
      private var MessagePayload:UIDataFromClient = null;
      
      private var NotificationPayload:UIDataFromClient = null;
      
      private var ThrottledMessages:Vector.<Object>;
      
      public function Messages()
      {
         var processEvent:Function;
         super();
         processEvent = function(param1:Object, param2:Function):*
         {
            var _loc6_:* = undefined;
            var _loc3_:* = param1.events;
            var _loc4_:* = _loc3_.length;
            var _loc5_:* = 0;
            while(_loc5_ < _loc4_)
            {
               _loc6_ = _loc3_[_loc5_];
               param2(_loc6_);
               _loc5_++;
            }
         };
         this.MessageArray = new Vector.<HUDMessageItemData>();
         this.ShownMessageArray = new Vector.<HUDMessageItemBase>();
         this.ThrottledMessages = new Vector.<Object>();
         this.bAnimating = false;
         this.alpha = 1;
         this.MessagePayload = BSUIDataManager.GetDataFromClient("HUDMessageProvider");
         BSUIDataManager.Subscribe("MessageEvents",function(param1:FromClientDataEvent):*
         {
            var arEvent:FromClientDataEvent = param1;
            var messages:* = MessagePayload.data.messages;
            processEvent(arEvent.data,function(param1:Object):*
            {
               var _loc3_:* = undefined;
               var _loc4_:* = undefined;
               var _loc5_:Boolean = false;
               var _loc6_:* = undefined;
               var _loc7_:* = undefined;
               var _loc2_:* = param1.eventIndex;
               switch(param1.eventType)
               {
                  case "new":
                     _loc3_ = MessagePayload.data.messages[_loc2_];
                     _loc4_ = false;
                     if(_loc3_.canBeThrottled)
                     {
                        _loc7_ = 0;
                        while(_loc7_ < ThrottledMessages.length)
                        {
                           if(ThrottledMessages[_loc7_].msg == _loc3_.messageText && ThrottledMessages[_loc7_].title == _loc3_.titleText && ThrottledMessages[_loc7_].header == _loc3_.headerText)
                           {
                              _loc4_ = true;
                              break;
                           }
                           _loc7_++;
                        }
                        if(!_loc4_)
                        {
                           ThrottledMessages.push({
                              "msg":_loc3_.messageText,
                              "title":_loc3_.titleText,
                              "header":_loc3_.headerText,
                              "throttledTime":THROTTLE_DURATION
                           });
                        }
                     }
                     _loc5_ = false;
                     _loc6_ = 0;
                     while(_loc6_ < MessageArray.length)
                     {
                        if(MessageArray[_loc6_].messageID == _loc3_.messageId && MessageArray[_loc6_].type == _loc3_.type && MessageArray[_loc6_].data == _loc3_)
                        {
                           _loc5_ = true;
                           break;
                        }
                        _loc6_++;
                     }
                     if(!_loc4_ && !_loc5_)
                     {
                        MessageArray.push(new HUDMessageItemData(_loc3_.messageId,_loc3_.type,_loc3_,_loc3_.sound));
                     }
                     else
                     {
                        DiscardMessage(_loc3_.messageId);
                     }
                     break;
                  case "remove":
                     _loc3_ = MessagePayload.data.messages[_loc2_];
                     DiscardMessage(_loc3_.messageId);
                     break;
                  case "clear":
                     RemoveMessages(false);
               }
            });
         });
         this.lastTime = getTimer();
         addEventListener(Event.ENTER_FRAME,this.Update);
      }
      
      public function get maxClipHeight_Inspectable() : Number
      {
         return this._maxClipHeight;
      }
      
      public function set maxClipHeight_Inspectable(param1:Number) : void
      {
         this._maxClipHeight = param1;
      }
      
      private function get pauseUpdates() : Boolean
      {
         return this.bPauseUpdates;
      }
      
      private function set pauseUpdates(param1:Boolean) : void
      {
         var _loc2_:uint = 0;
         if(this.bPauseUpdates != param1)
         {
            this.bPauseUpdates = param1;
            while(_loc2_ < this.ShownMessageArray.length)
            {
               if(this.bPauseUpdates)
               {
                  this.ShownMessageArray[_loc2_].OnPause();
               }
               else
               {
                  this.ShownMessageArray[_loc2_].OnResume();
               }
               _loc2_++;
            }
         }
      }
      
      public function set TutorialShowing(param1:Boolean) : *
      {
         if(this.pauseUpdates && !param1)
         {
            this.lastTime = getTimer();
         }
         this.pauseUpdates = param1;
         this.visible = !param1;
      }
      
      public function get ShownCount() : int
      {
         return this.ShownMessageArray.length;
      }
      
      public function UpdatePositions() : *
      {
         var _loc2_:HUDFadingListItem = null;
         var _loc3_:* = undefined;
         var _loc4_:HUDMessageItemBase = null;
         var _loc5_:HUDMessageItemBase = null;
         var _loc6_:uint = 0;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Boolean = false;
         var _loc11_:* = undefined;
         var _loc12_:Number = NaN;
         var _loc13_:Boolean = false;
         var _loc1_:int = this.ShownCount;
         if(_loc1_ == 1)
         {
            _loc2_ = this.ShownMessageArray[0];
            if(!_loc2_.fadeInStarted)
            {
               if(_loc2_.CanFadeIn())
               {
                  this.bAnimating = true;
                  _loc2_.FadeIn();
               }
               this.fadingOutMessage = false;
            }
            else if(this.MessageArray.length == 0 && !this.fadingOutMessage && _loc2_.CanFadeOut())
            {
               _loc2_.FadeOut();
               this.bAnimating = false;
               this.fadingOutMessage = true;
            }
            else
            {
               this.bAnimating = false;
               this.fadingOutMessage = false;
            }
         }
         else if(_loc1_ > 1)
         {
            _loc3_ = _loc1_ - 1;
            _loc4_ = this.ShownMessageArray[_loc3_];
            _loc5_ = this.ShownMessageArray[_loc3_ - 1];
            _loc6_ = _loc4_.height;
            _loc7_ = _loc5_.y;
            _loc9_ = (_loc8_ = _loc6_ + this.MessageSpacing) - _loc7_;
            this.bAnimating = _loc9_ > 0 || _loc4_.bIsDirty;
            if(!_loc4_.bIsDirty)
            {
               if(_loc10_ = _loc4_.CanFadeIn() && _loc1_ <= MAX_SHOWN)
               {
                  _loc4_.FadeIn();
               }
               if(this.bAnimating && _loc4_.fadeInStarted)
               {
                  _loc11_ = 1;
                  _loc12_ = 0;
                  while(_loc12_ < _loc3_)
                  {
                     this.ShownMessageArray[_loc12_].y += _loc11_;
                     _loc12_++;
                  }
               }
               else if(!this.fadingOutMessage)
               {
                  _loc13_ = !_loc10_ && _loc4_.CanFadeIn();
                  if(!this.bqueuedMessage || _loc1_ == MAX_SHOWN || _loc13_ && this.ShownMessageArray[0].CanFadeOut())
                  {
                     this.fadingOutMessage = true;
                     this.ShownMessageArray[0].FadeOut();
                  }
               }
            }
         }
      }
      
      public function RemoveMessages(param1:Boolean) : *
      {
         var _loc3_:Vector.<HUDMessageItemBase> = null;
         var _loc2_:int = int(this.ShownMessageArray.length - 1);
         while(_loc2_ >= 0)
         {
            if(!param1 || this.ShownMessageArray[_loc2_].currentFrame >= this.ShownMessageArray[_loc2_].endAnimFrame || this.ShownMessageArray[_loc2_].fullyFadedOut)
            {
               _loc3_ = this.ShownMessageArray.splice(_loc2_,1);
               this.removeChild(_loc3_[0]);
               this.fadingOutMessage = false;
               this.DiscardMessage(_loc3_[0].data.messageID);
            }
            _loc2_--;
         }
      }
      
      private function DiscardMessage(param1:Number) : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent("HUDMessages::DiscardMessage",{"id":param1}));
      }
      
      public function get CanAddMessage() : Boolean
      {
         return !this.bAnimating && !this.fadingOutMessage && this.ShownCount < MAX_SHOWN;
      }
      
      public function Update(param1:Event) : *
      {
         var _loc2_:* = undefined;
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         var _loc5_:* = false;
         var _loc6_:* = false;
         var _loc7_:* = undefined;
         var _loc8_:HUDMessageItemData = null;
         var _loc9_:HUDMessageItemBase = null;
         if(!this.pauseUpdates)
         {
            _loc2_ = getTimer();
            _loc3_ = _loc2_ - this.lastTime;
            if((_loc4_ = this.ThrottledMessages.length) > 0)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc4_)
               {
                  this.ThrottledMessages[_loc7_].throttledTime -= _loc3_;
                  _loc7_++;
               }
               while(_loc4_ > 0 && this.ThrottledMessages[0].throttledTime <= 0)
               {
                  this.ThrottledMessages.shift();
                  _loc4_--;
               }
            }
            this.bqueuedMessage = this.MessageArray.length > 0;
            _loc5_ = this.ShownCount > 0;
            this.RemoveMessages(true);
            if(this.bqueuedMessage && this.CanAddMessage)
            {
               _loc8_ = this.MessageArray.shift();
               switch(_loc8_.type)
               {
                  case HUDMessageItemData.TYPE_EVENT:
                     _loc9_ = new HUDMessageItemBox();
                     break;
                  case HUDMessageItemData.TYPE_KILL_SINGLE:
                     _loc9_ = new HUDMessageItemKill();
                     break;
                  case HUDMessageItemData.TYPE_KILL_TEAM:
                     _loc9_ = new HUDMessageItemTeamKill();
                     break;
                  case HUDMessageItemData.TYPE_UNDER_ATTACK:
                     _loc9_ = new HUDMessageItemUnderAttack();
                     break;
                  case HUDMessageItemData.TYPE_COMEBACK:
                     _loc9_ = new HUDMessageItemRevenge();
                     break;
                  case HUDMessageItemData.TYPE_KILL_GROUP:
                     _loc9_ = new HUDMessageItemGroupKill();
                     break;
                  case HUDMessageItemData.TYPE_MUTATED_EVENT:
                  case HUDMessageItemData.TYPE_DAILY_OPS:
                     _loc9_ = new HUDMessageItemRecentActivity();
                     break;
                  case HUDMessageItemData.TYPE_CASINO:
                     _loc9_ = new HUDMessageItemCasino();
                     break;
                  default:
                     _loc9_ = new HUDMessageItem();
               }
               _loc9_.data = _loc8_;
               this.addChild(_loc9_);
               this.ShownMessageArray.push(_loc9_ as HUDMessageItemBase);
               BSUIDataManager.dispatchEvent(new CustomEvent(GlobalFunc.PLAY_MENU_SOUND,{"soundID":_loc9_.data.sound}));
            }
            this.UpdatePositions();
            _loc6_ = this.ShownCount > 0;
            if(_loc5_ || _loc6_)
            {
               SetIsDirty();
            }
            this.lastTime = _loc2_;
         }
      }
   }
}

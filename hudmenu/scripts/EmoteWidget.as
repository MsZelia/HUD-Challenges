package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   public class EmoteWidget extends MovieClip
   {
      
      public static const ALIGN_LEFT:uint = 0;
      
      public static const ALIGN_RIGHT:uint = 1;
      
      public static const ALIGN_CENTER:uint = 2;
      
      public static const EVENT_CLEARED:String = "EmoteWidget::Cleared";
      
      public static const EVENT_ACTIVE:String = "EmoteWidget::Active";
      
      public static const EMOTE_SPACING:Number = 30;
      
      public static const FADE_OLDER:Boolean = false;
       
      
      private var m_EntityID:uint = 0;
      
      private var m_Align:uint = 0;
      
      private var m_DisplayMax:uint = 1;
      
      private var m_Scale:Number = 1;
      
      private var m_MaxEmoteWidth:Number = 0;
      
      private var m_MaxEmoteHeight:Number = 0;
      
      private var m_ProviderCallback:Function;
      
      private var m_HasPrompt:* = false;
      
      public function EmoteWidget()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemovedFromStage);
      }
      
      public function get maxEmoteWidth() : Number
      {
         return this.m_MaxEmoteWidth;
      }
      
      public function get maxEmoteHeight() : Number
      {
         return this.m_MaxEmoteHeight;
      }
      
      public function set displayMax(param1:uint) : void
      {
         this.m_DisplayMax = param1;
         this.clear();
      }
      
      public function set scale(param1:Number) : void
      {
         this.m_Scale = param1;
         var _loc2_:int = 0;
         while(_loc2_ < this.numChildren)
         {
            this.getChildElement(_loc2_).scaleX = this.m_Scale;
            this.getChildElement(_loc2_).scaleY = this.m_Scale;
            _loc2_++;
         }
      }
      
      public function set align(param1:uint) : void
      {
         if(param1 != this.m_Align)
         {
            this.m_Align = param1;
            if(this.numChildren > 0)
            {
               this.updatePositions();
            }
         }
      }
      
      public function set entityID(param1:uint) : void
      {
         this.m_EntityID = param1;
      }
      
      public function get entityID() : uint
      {
         return this.m_EntityID;
      }
      
      private function getChildElement(param1:int) : EmoteContainer
      {
         return this.getChildAt(param1) as EmoteContainer;
      }
      
      private function updatePositions() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:EmoteContainer = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Boolean = false;
         var _loc8_:int = 0;
         var _loc9_:uint = 0;
         var _loc1_:Number = 0;
         var _loc2_:int = 0;
         while(_loc2_ < this.numChildren)
         {
            if(!this.getChildElement(_loc2_).removed)
            {
               _loc1_++;
            }
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            _loc3_ = 0;
            _loc4_ = this.getChildElement(0);
            _loc5_ = EMOTE_SPACING * this.m_Scale;
            _loc6_ = 0;
            _loc7_ = false;
            this.m_MaxEmoteWidth = 0;
            this.m_MaxEmoteHeight = 0;
            _loc2_ = 0;
            while(_loc2_ < this.numChildren)
            {
               _loc4_ = this.getChildElement(_loc2_);
               this.m_MaxEmoteWidth = Math.max(this.maxEmoteWidth,_loc4_.realWidth * this.m_Scale);
               this.m_MaxEmoteHeight = Math.max(this.maxEmoteHeight,_loc4_.realHeight * this.m_Scale);
               if(!_loc4_.removed)
               {
                  if(_loc7_)
                  {
                     _loc3_ += _loc5_;
                     _loc3_ += _loc4_.realWidth * this.m_Scale;
                  }
                  _loc7_ = true;
               }
               _loc2_++;
            }
            if(this.m_Align != ALIGN_LEFT)
            {
               _loc6_ -= _loc3_;
               if(this.m_Align == ALIGN_CENTER)
               {
                  _loc6_ /= 2;
               }
            }
            _loc8_ = this.numChildren;
            _loc9_ = 0;
            _loc2_ = 0;
            while(_loc2_ < _loc8_)
            {
               if(!(_loc4_ = this.getChildElement(_loc2_)).removed)
               {
                  if(_loc2_ != _loc8_ - 1)
                  {
                     _loc4_.showMod = false;
                  }
                  if(_loc9_ >= 1)
                  {
                     _loc6_ += _loc5_;
                  }
                  if(FADE_OLDER)
                  {
                     _loc4_.visAlpha = 1 - (_loc1_ - 1 - _loc9_) * (1 / this.m_DisplayMax);
                  }
                  else
                  {
                     _loc4_.visAlpha = 1;
                  }
                  this.getChildElement(_loc2_).slideX(_loc6_);
                  _loc6_ += _loc4_.realWidth * this.m_Scale;
                  _loc9_++;
               }
               _loc2_++;
            }
         }
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this.numChildren)
         {
            this.getChildElement(_loc1_).hide(false);
            _loc1_++;
         }
         this.m_HasPrompt = false;
      }
      
      public function removeEntry(param1:EmoteContainer, param2:Boolean = true) : void
      {
         this.removeChild(param1);
         if(this.numChildren == 0)
         {
            dispatchEvent(new Event(EVENT_CLEARED,true));
         }
         this.updatePositions();
      }
      
      private function onEmoteUpdate(param1:FromClientDataEvent) : *
      {
         var _loc2_:String = null;
         var _loc3_:EmoteContainer = null;
         var _loc4_:EmoteContainer = null;
         if(param1.data.entityID == this.m_EntityID)
         {
            _loc2_ = param1.data.emoteName;
            if(_loc2_ == null || _loc2_.length == 0)
            {
               this.clear();
            }
            else
            {
               if(param1.data.emoteMod == EmoteContainer.MOD_PROMPT)
               {
                  this.clear();
               }
               if(this.numChildren > 0 && this.numChildren == this.m_DisplayMax)
               {
                  if((_loc4_ = this.getChildElement(0)).mod == EmoteContainer.MOD_PROMPT)
                  {
                     this.m_HasPrompt = false;
                  }
                  _loc4_.hide(false);
               }
               _loc3_ = new EmoteContainer();
               _loc3_.scaleX = this.m_Scale;
               _loc3_.scaleY = this.m_Scale;
               _loc3_.image = _loc2_;
               _loc3_.mod = param1.data.emoteMod;
               if(param1.data.emoteMod == EmoteContainer.MOD_PROMPT)
               {
                  this.m_HasPrompt = true;
               }
               if(param1.data.ignoreDuration == false)
               {
                  _loc3_.timeout = param1.data.duration;
               }
               _loc3_.parentWidget = this;
               addChild(_loc3_);
               if(this.numChildren == 1)
               {
                  dispatchEvent(new Event(EVENT_ACTIVE,true));
               }
               this.updatePositions();
            }
         }
      }
      
      public function onAddedToStage(param1:Event) : void
      {
         this.m_ProviderCallback = BSUIDataManager.Subscribe("ActiveEmoteData",this.onEmoteUpdate);
      }
      
      public function onRemovedFromStage(param1:Event) : void
      {
         if(this.m_ProviderCallback != null)
         {
            BSUIDataManager.Unsubscribe("ActiveEmoteData",this.onEmoteUpdate);
         }
      }
   }
}

package Shared.AS3
{
   import Shared.AS3.COMPANIONAPP.PipboyLoader;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   import flash.utils.setTimeout;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1008")]
   public dynamic class ConditionBoy extends BSUIComponent
   {
      
      private static const CONDITION_DISPLAY_TIME:uint = 5000;
      
      private static const CLIP_BODY_TEMPLATE_PATH:String = "Components/ConditionClips/Condition_Body_";
      
      private static const CLIP_BODY_HUNGER_ID:int = 16;
      
      private static const CLIP_BODY_DISEASE_ID:int = 17;
      
      private static const CLIP_BODY_THIRST_ID:int = 18;
      
      private static const CLIP_BODY_MUTATION_ID:int = 19;
      
      private static const CLIP_BODY_FERAL_ID:int = 20;
      
      private static const NUM_BODY_CLIPS:int = 21;
      
      private static const HEAD_HUNGER_FRAME:String = "Drugged";
      
      private static const HEAD_THIRST_FRAME:String = "Drugged";
      
      private static const HEAD_FERAL_FRAME:String = "Feral";
       
      
      private var BodyClip:MovieClip = null;
      
      private var HeadClip:MovieClip = null;
      
      private var HeadLoader:PipboyLoader;
      
      private var BodyLoader:PipboyLoader;
      
      private var ColorFileText:String;
      
      private var PrimaryCondition:Object;
      
      private var SecondaryConditions:Vector.<Object>;
      
      private var CurrentlyShownCondition:Object;
      
      private var PreloadedBodyClips:Vector.<PipboyLoader>;
      
      private var ShouldUpdate:Boolean = false;
      
      private var PrimaryConditionChanged:Boolean = false;
      
      private var IsReadyForNextCondition:Boolean = true;
      
      private var IsMutated:Boolean = false;
      
      private var IsDiseased:Boolean = false;
      
      private var IsThirstStateNegative:Boolean = false;
      
      private var IsHungerStateNegative:Boolean = false;
      
      private var IsFeralStateNegative:Boolean = false;
      
      private var m_IsGhoul:Boolean = false;
      
      private var IsMenuInstance:Boolean = false;
      
      public function ConditionBoy()
      {
         this.ColorFileText = new String();
         this.PrimaryCondition = {};
         this.SecondaryConditions = new Vector.<Object>();
         this.CurrentlyShownCondition = {};
         super();
         this.LoadHead();
      }
      
      public function set isMenuInstance(param1:Boolean) : *
      {
         this.IsMenuInstance = param1;
      }
      
      public function PreloadConditions() : *
      {
         var _loc1_:* = undefined;
         var _loc2_:PipboyLoader = null;
         var _loc3_:URLRequest = null;
         if(!this.PreloadedBodyClips)
         {
            this.PreloadedBodyClips = new Vector.<PipboyLoader>(NUM_BODY_CLIPS,true);
            for(_loc1_ in this.PreloadedBodyClips)
            {
               _loc2_ = new PipboyLoader();
               this.PreloadedBodyClips[_loc1_] = _loc2_;
               _loc3_ = new URLRequest(this.GetPathForCondition(_loc1_));
               _loc2_.load(_loc3_);
            }
         }
      }
      
      private function GetPathForCondition(param1:int) : *
      {
         return CLIP_BODY_TEMPLATE_PATH + this.ColorFileText + param1 + ".swf";
      }
      
      public function SetData(param1:Object) : *
      {
         this.m_IsGhoul = param1.isGhoul;
         this.UpdatePrimaryCondition(param1);
         if(!this.IsMenuInstance)
         {
            this.UpdateSecondaryConditions(param1);
         }
         if(this.IsReadyForNextCondition)
         {
            this.ShowNextCondition();
         }
      }
      
      private function UpdatePrimaryCondition(param1:Object) : *
      {
         var _loc2_:Boolean = Boolean(param1.isHeadDamaged);
         var _loc3_:String = "Normal";
         if(this.m_IsGhoul)
         {
            _loc3_ = _loc2_ ? "GhoulDamaged" : "Ghoul";
         }
         else if(param1.isIrradiated)
         {
            _loc3_ = _loc2_ ? "IrradiatedDamaged" : "Irradiated";
         }
         else if(param1.isDrugged)
         {
            _loc3_ = _loc2_ ? "DruggedDamaged" : "Drugged";
         }
         else if(param1.isAddicted || _loc2_ || param1.bodyFlags != 0)
         {
            _loc3_ = _loc2_ ? "NegativeDamaged" : "Negative";
         }
         this.PrimaryCondition.isPersistent = _loc2_ || param1.bodyFlags != 0;
         if(this.PrimaryCondition.headFrame != _loc3_ || this.PrimaryCondition.bodyId != param1.bodyFlags)
         {
            this.PrimaryCondition.headFrame = _loc3_;
            this.PrimaryCondition.bodyId = param1.bodyFlags;
            this.PrimaryConditionChanged = true;
         }
      }
      
      private function UpdateSecondaryConditions(param1:Object) : *
      {
         var _loc2_:Boolean = Boolean(param1.isHeadDamaged);
         if(!this.IsMutated && Boolean(param1.isMutated))
         {
            this.SecondaryConditions.push({
               "headFrame":(this.m_IsGhoul ? "Ghoul" : (!!("" + _loc2_) ? "MutatedDamaged" : "Mutated")),
               "bodyId":CLIP_BODY_MUTATION_ID
            });
         }
         this.IsMutated = param1.isMutated;
         if(!this.IsDiseased && Boolean(param1.isDiseased))
         {
            this.SecondaryConditions.push({
               "headFrame":(_loc2_ ? "DiseasedDamaged" : "Diseased"),
               "bodyId":CLIP_BODY_DISEASE_ID
            });
         }
         this.IsDiseased = param1.isDiseased;
         if(Boolean(param1.isThirstStateNegative) && !this.IsThirstStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_THIRST_FRAME,
               "bodyId":CLIP_BODY_THIRST_ID
            });
         }
         this.IsThirstStateNegative = param1.isThirstStateNegative;
         if(Boolean(param1.isHungerStateNegative) && !this.IsHungerStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_HUNGER_FRAME,
               "bodyId":CLIP_BODY_HUNGER_ID
            });
         }
         this.IsHungerStateNegative = param1.isHungerStateNegative;
         if(Boolean(param1.isFeralStateNegative) && !this.IsFeralStateNegative)
         {
            this.SecondaryConditions.push({
               "headFrame":HEAD_FERAL_FRAME,
               "bodyId":CLIP_BODY_FERAL_ID
            });
         }
         this.IsFeralStateNegative = param1.isFeralStateNegative;
      }
      
      private function ShowNextCondition() : *
      {
         var _loc2_:Boolean = false;
         var _loc3_:URLRequest = null;
         var _loc1_:Object = null;
         if(this.SecondaryConditions.length > 0)
         {
            _loc1_ = this.SecondaryConditions.pop();
         }
         else if(this.PrimaryConditionChanged || Boolean(this.PrimaryCondition.isPersistent))
         {
            _loc1_ = this.PrimaryCondition;
            this.PrimaryConditionChanged = false;
         }
         if(_loc1_)
         {
            _loc2_ = this.IsShowingCondition(_loc1_) && Boolean(_loc1_.isPersistent);
            if(!_loc2_)
            {
               this.UnloadBody();
               this.LoadHead();
               this.CurrentlyShownCondition.headFrame = _loc1_.headFrame;
               this.CurrentlyShownCondition.bodyId = _loc1_.bodyId;
               if(this.PreloadedBodyClips != null)
               {
                  this.onConditionBodyLoadComplete(null);
               }
               else
               {
                  this.BodyLoader = new PipboyLoader();
                  this.BodyLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
                  this.BodyLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
                  _loc3_ = new URLRequest(this.GetPathForCondition(_loc1_.bodyId));
                  this.BodyLoader.load(_loc3_);
               }
            }
         }
         else if(!this.IsMenuInstance)
         {
            visible = false;
            this.UnloadBody();
         }
      }
      
      private function IsShowingCondition(param1:Object) : *
      {
         return param1 && this.CurrentlyShownCondition && param1.headFrame == this.CurrentlyShownCondition.headFrame && param1.bodyId == this.CurrentlyShownCondition.bodyId;
      }
      
      private function LoadHead() : *
      {
         if(this.HeadLoader)
         {
            this.HeadLoader.unloadAndStop();
         }
         this.HeadLoader = new PipboyLoader();
         var _loc1_:URLRequest = new URLRequest("Components/ConditionClips/Condition_Head.swf");
         this.HeadLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
         this.HeadLoader.load(_loc1_);
      }
      
      private function UnloadBody() : *
      {
         if(this.BodyLoader)
         {
            try
            {
               this.BodyLoader.close();
            }
            catch(e:Error)
            {
            }
         }
         if(this.BodyClip)
         {
            removeChild(this.BodyClip);
            this.BodyClip.stop();
            this.BodyClip = null;
         }
         if(this.BodyLoader)
         {
            this.BodyLoader.unload();
            this.BodyLoader = null;
         }
         this.CurrentlyShownCondition = {};
      }
      
      override public function redrawUIComponent() : void
      {
         super.redrawUIComponent();
         if(Boolean(this.BodyClip) && Boolean(this.HeadClip) && this.ShouldUpdate)
         {
            visible = true;
            this.ShouldUpdate = false;
            this.BodyClip.Head_mc.addChild(this.HeadClip);
            this.BodyClip.scaleX = 1.2;
            this.BodyClip.scaleY = this.BodyClip.scaleX;
            addChild(this.BodyClip);
            this.BodyClip.gotoAndPlay(this.m_IsGhoul ? "Ghoul" : "Human");
            this.HeadClip.gotoAndStop(this.CurrentlyShownCondition.headFrame);
            if(!this.IsMenuInstance)
            {
               this.IsReadyForNextCondition = false;
               setTimeout(function():void
               {
                  IsReadyForNextCondition = true;
                  ShowNextCondition();
               },CONDITION_DISPLAY_TIME);
            }
         }
      }
      
      private function onConditionBodyLoadComplete(param1:Event) : *
      {
         if(this.BodyLoader)
         {
            param1.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
            param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
            this.BodyClip = this.BodyLoader.contentLoaderInfo.content as MovieClip;
         }
         else
         {
            if(!this.PreloadedBodyClips)
            {
               throw new Error("onConditionBodyLoadComplete called but there is no loader nor preloaded clip to get info from");
            }
            this.BodyClip = this.PreloadedBodyClips[this.CurrentlyShownCondition.bodyId].contentLoaderInfo.content as MovieClip;
         }
         this.ShouldUpdate = true;
         SetIsDirty();
      }
      
      private function onConditionBodyLoadFailed(param1:IOErrorEvent) : *
      {
         param1.target.removeEventListener(Event.COMPLETE,this.onConditionBodyLoadComplete);
         param1.target.removeEventListener(IOErrorEvent.IO_ERROR,this.onConditionBodyLoadFailed);
         trace("failed to load body: " + this.GetPathForCondition(this.CurrentlyShownCondition.bodyId));
         this.UnloadBody();
      }
      
      private function onConditionHeadLoadComplete(param1:Event) : *
      {
         if(this.HeadLoader)
         {
            param1.target.removeEventListener(Event.COMPLETE,this.onConditionHeadLoadComplete);
            this.HeadClip = this.HeadLoader.contentLoaderInfo.content as MovieClip;
            this.HeadLoader = null;
         }
      }
   }
}

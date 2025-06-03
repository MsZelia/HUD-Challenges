package
{
   import Shared.AS3.BSUIComponent;
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1653")]
   public dynamic class HUDActiveEffectsWidget extends BSUIComponent
   {
      
      private static const MAX_NUM_CLIPS:uint = 8;
      
      private static const CLIP_WIDTH:Number = 35;
      
      private static const CLIP_SPACER:Number = 4;
      
      private static const STACK_OVERLAP:Number = 2;
       
      
      public var ActiveEffectStatusLabel_mc:MovieClip;
      
      private var ClipHolderInternal_mc:MovieClip;
      
      private var m_EffectClipsA:Array;
      
      private var _bInPowerArmorMode:Boolean = false;
      
      public function HUDActiveEffectsWidget()
      {
         this.m_EffectClipsA = new Array();
         super();
         this.instantiateClips();
      }
      
      public function get bInPowerArmorMode() : Boolean
      {
         return this._bInPowerArmorMode;
      }
      
      public function set bInPowerArmorMode(param1:Boolean) : void
      {
         if(this._bInPowerArmorMode != param1)
         {
            this._bInPowerArmorMode = param1;
            SetIsDirty();
         }
      }
      
      private function instantiateClips() : void
      {
         var _loc1_:Number = NaN;
         var _loc3_:HUDActiveEffectClip = null;
         this.ClipHolderInternal_mc = new MovieClip();
         addChild(this.ClipHolderInternal_mc);
         _loc1_ = 0;
         var _loc2_:* = 0;
         while(_loc2_ < MAX_NUM_CLIPS)
         {
            _loc1_ -= CLIP_WIDTH;
            _loc3_ = new HUDActiveEffectClip();
            _loc3_.x = _loc1_;
            _loc3_.visible = false;
            this.ClipHolderInternal_mc.addChild(_loc3_);
            this.m_EffectClipsA.push(_loc3_);
            _loc1_ -= CLIP_SPACER;
            _loc2_++;
         }
      }
      
      public function onDataUpdate(param1:Array) : void
      {
         var _loc4_:HUDActiveEffectClip = null;
         var _loc2_:uint = param1.length - 1;
         var _loc3_:* = 0;
         while(_loc3_ < this.m_EffectClipsA.length)
         {
            _loc4_ = this.m_EffectClipsA[_loc3_];
            if(_loc3_ < param1.length)
            {
               _loc4_.IconFrame = param1[_loc2_].iconID;
               _loc4_.IconColor = param1[_loc2_].iconColor;
               _loc4_.StackAmount = param1[_loc2_].stackAmount;
            }
            else
            {
               _loc4_.IconFrame = "";
            }
            _loc3_++;
            _loc2_--;
         }
         SetIsDirty();
      }
      
      override public function redrawUIComponent() : void
      {
         if(this.bInPowerArmorMode)
         {
            this.ClipHolderInternal_mc.x = 50;
            this.ClipHolderInternal_mc.y = 15;
         }
         else
         {
            this.ClipHolderInternal_mc.x = 0;
            this.ClipHolderInternal_mc.y = 0;
         }
         var _loc1_:Number = this.m_EffectClipsA[0].x - CLIP_SPACER;
         var _loc2_:* = 1;
         while(_loc2_ < this.m_EffectClipsA.length)
         {
            if(this.m_EffectClipsA[_loc2_].visible)
            {
               _loc1_ -= this.m_EffectClipsA[_loc2_].StackAmount > 0 ? CLIP_WIDTH + this.m_EffectClipsA[_loc2_].Stack_mc.width - STACK_OVERLAP : CLIP_WIDTH;
               this.m_EffectClipsA[_loc2_].x = _loc1_;
               _loc1_ -= CLIP_SPACER;
            }
            _loc2_++;
         }
      }
   }
}

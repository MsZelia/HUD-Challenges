package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.FrameLabel;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1546")]
   public dynamic class QuickContainerWidget extends BSUIComponent
   {
      
      private static var cuiNumClips:Number = 5;
       
      
      public var ListHeaderAndBracket_mc:MovieClip;
      
      public var Spinner_mc:MovieClip;
      
      public var ListItems_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var WeightIcon_mc:MovieClip;
      
      public var WeightText_mc:MovieClip;
      
      public var ItemDataA:Vector.<QuickContainerItemData>;
      
      private var _selectedIndex:int;
      
      private var _bracketsVisible:Boolean;
      
      private var _ConditionMeterEnabled:Boolean;
      
      public var AButton:BSButtonHintData;
      
      public var XButton:BSButtonHintData;
      
      public var YButton:BSButtonHintData;
      
      private var ItemClipsA:Vector.<QuickContainerItem>;
      
      private var m_HeaderTextFormat:TextFormat;
      
      private var PositionForListSize:Vector.<int>;
      
      private var m_PostInventoryFrame:int = 31;
      
      public function QuickContainerWidget()
      {
         var _loc4_:FrameLabel = null;
         var _loc5_:QuickContainerItem = null;
         this.AButton = new BSButtonHintData("$TAKE","E","PSN_A","Xenon_A",1,null);
         this.XButton = new BSButtonHintData("$QuickContainerTransfer","R","PSN_X","Xenon_X",1,null);
         this.YButton = new BSButtonHintData("Special Action","$SPACEBAR","PSN_Y","Xenon_Y",1,null);
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,11,this.frame12,12,this.frame13,21,this.frame22,22,this.frame23,28,this.frame29);
         Extensions.enabled = true;
         this._ConditionMeterEnabled = true;
         this._selectedIndex = -1;
         this.PopulateButtonBar();
         this.ItemDataA = new Vector.<QuickContainerItemData>();
         this.ItemClipsA = new Vector.<QuickContainerItem>(cuiNumClips,true);
         this.PositionForListSize = new Vector.<int>(cuiNumClips + 1,true);
         var _loc1_:TextField = this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf as TextField;
         this.m_HeaderTextFormat = _loc1_.getTextFormat();
         _loc1_.multiline = false;
         _loc1_.wordWrap = false;
         var _loc2_:Number = 0;
         while(_loc2_ < cuiNumClips)
         {
            _loc5_ = this.ListItems_mc.getChildByName("ItemText" + _loc2_) as QuickContainerItem;
            this.ItemClipsA[_loc2_] = _loc5_;
            this.PositionForListSize[cuiNumClips - _loc2_] = _loc5_.y;
            _loc2_++;
         }
         this.PositionForListSize[0] = this.PositionForListSize[1];
         visible = false;
         alpha = 0;
         var _loc3_:Array = this.currentLabels;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if((_loc4_ = _loc3_[_loc2_]).name == "rollOff")
            {
               this.m_PostInventoryFrame = _loc4_.frame;
               break;
            }
            _loc2_++;
         }
         this.ButtonHintBar_mc.useVaultTecColor = true;
         this.ButtonHintBar_mc.useBackground = false;
         BSUIDataManager.Subscribe("CharacterInfoData",this.onCharacterInfoUpdate);
         TextFieldEx.setTextAutoSize(this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         TextFieldEx.setTextAutoSize(this.WeightText_mc.WeightText_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
      }
      
      public function get numClips() : uint
      {
         return cuiNumClips;
      }
      
      private function onCharacterInfoUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:Number = Math.floor(param1.data.currWeight);
         var _loc3_:Number = Math.floor(param1.data.maxWeight);
         var _loc4_:Number = Math.floor(param1.data.absoluteWeightLimit);
         if(_loc2_ >= _loc4_)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = "$AbsoluteWeightLimitDisplay";
            this.WeightText_mc.WeightText_tf.text = this.WeightText_mc.WeightText_tf.text.replace("{weight}",_loc2_.toString());
         }
         else if(_loc2_ > _loc3_)
         {
            this.WeightIcon_mc.gotoAndStop("warning");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COOR_WARNING;
            this.WeightText_mc.WeightText_tf.text = _loc2_ + "/" + _loc3_;
         }
         else
         {
            this.WeightIcon_mc.gotoAndStop("normal");
            this.WeightText_mc.WeightText_tf.textColor = GlobalFunc.COLOR_TEXT_BODY;
            this.WeightText_mc.WeightText_tf.text = _loc2_ + "/" + _loc3_;
         }
      }
      
      public function onQuickContainerOpen() : void
      {
         alpha = 1;
         if(this._bracketsVisible)
         {
            if(this.currentFrame == 1 || this.currentFrame >= this.m_PostInventoryFrame)
            {
               this.m_HeaderTextFormat.align = "left";
               this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf.setTextFormat(this.m_HeaderTextFormat);
               this.gotoAndPlay("rollOn");
            }
         }
         else
         {
            this.m_HeaderTextFormat.align = "center";
            this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf.setTextFormat(this.m_HeaderTextFormat);
            this.gotoAndStop("onWorkshop");
         }
      }
      
      public function onQuickContainerClose() : void
      {
         if(this._bracketsVisible)
         {
            this.gotoAndPlay("rollOff");
         }
         else
         {
            this.gotoAndStop("off");
         }
         this.Spinner_mc.visible = false;
         var _loc1_:uint = 0;
         while(_loc1_ < cuiNumClips)
         {
            this.ItemClipsA[_loc1_].data = null;
            _loc1_++;
         }
      }
      
      public function onQuickContainerForceHide() : void
      {
         this.gotoAndStop("off");
      }
      
      protected function PopulateButtonBar() : void
      {
         var _loc1_:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         _loc1_.push(this.AButton);
         _loc1_.push(this.XButton);
         _loc1_.push(this.YButton);
         this.XButton.ButtonVisible = false;
         this.AButton.ButtonVisible = false;
         this.YButton.ButtonVisible = false;
         this.ButtonHintBar_mc.SetButtonHintData(_loc1_);
      }
      
      public function UpdateList(param1:int, param2:Boolean) : void
      {
         var _loc4_:QuickContainerItem = null;
         this._selectedIndex = param1;
         var _loc3_:uint = 0;
         while(_loc3_ < cuiNumClips)
         {
            _loc4_ = this.ItemClipsA[_loc3_];
            if(_loc3_ < this.ItemDataA.length)
            {
               _loc4_.data = this.ItemDataA[_loc3_];
               _loc4_.selected = this._selectedIndex == _loc3_;
               _loc4_.ConditionMeterEnabled = this._ConditionMeterEnabled;
            }
            else
            {
               _loc4_.data = null;
            }
            _loc3_++;
         }
         if(param2 && this._bracketsVisible && this.ItemClipsA[0].data == null)
         {
            this.Spinner_mc.gotoAndPlay(1);
            this.Spinner_mc.visible = true;
         }
      }
      
      public function onInventorySynced() : *
      {
         this.Spinner_mc.visible = false;
      }
      
      public function set containerName(param1:String) : *
      {
         GlobalFunc.SetText(this.ListHeaderAndBracket_mc.ContainerName_mc.textField_tf,param1,false,true);
      }
      
      public function set bracketsVisible(param1:Boolean) : void
      {
         this._bracketsVisible = param1;
      }
      
      public function DisableConditionMeter() : *
      {
         this._ConditionMeterEnabled = false;
      }
      
      internal function frame1() : *
      {
         stop();
         this.visible = false;
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         this.visible = true;
      }
      
      internal function frame12() : *
      {
         stop();
      }
      
      internal function frame13() : *
      {
         this.visible = false;
      }
      
      internal function frame22() : *
      {
         stop();
      }
      
      internal function frame23() : *
      {
         this.visible = true;
      }
      
      internal function frame29() : *
      {
         stop();
      }
   }
}

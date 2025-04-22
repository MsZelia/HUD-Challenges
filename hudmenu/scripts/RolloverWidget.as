package
{
   import Shared.AS3.BSButtonHintBar;
   import Shared.AS3.BSButtonHintData;
   import Shared.AS3.BSUIComponent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.text.TextField;
   import scaleform.gfx.Extensions;
   import scaleform.gfx.TextFieldEx;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1316")]
   public dynamic class RolloverWidget extends BSUIComponent
   {
       
      
      public var RolloverName_tf:TextField;
      
      public var RolloverName_mc:MovieClip;
      
      public var RolloverTitle_tf:TextField;
      
      public var RolloverTitle_mc:MovieClip;
      
      public var ButtonHintBar_mc:BSButtonHintBar;
      
      public var LegendaryIcon_mc:MovieClip;
      
      public var TaggedForSearchIcon_mc:MovieClip;
      
      public var AButtonData:BSButtonHintData;
      
      public var XButtonData:BSButtonHintData;
      
      public var YButtonData:BSButtonHintData;
      
      public var BButtonData:BSButtonHintData;
      
      private var m_IconSpacing:uint = 10;
      
      public function RolloverWidget()
      {
         this.AButtonData = new BSButtonHintData("","E","PSN_A","Xenon_A",1,null);
         this.XButtonData = new BSButtonHintData("","R","PSN_X","Xenon_X",1,null);
         this.YButtonData = new BSButtonHintData("","Space","PSN_Y","Xenon_Y",1,null);
         this.BButtonData = new BSButtonHintData("","Tab","PSN_B","Xenon_B",1,null);
         super();
         addFrameScript(0,this.frame1,1,this.frame2);
         this.RolloverName_tf = this.RolloverName_mc.RolloverName_tf;
         this.TaggedForSearchIcon_mc = this.RolloverName_mc.TaggedForSearchIcon_mc;
         this.LegendaryIcon_mc = this.RolloverName_mc.LegendaryIcon_mc;
         this.ButtonHintBar_mc.useBackground = false;
         this.PopulateButtonBar();
         Extensions.enabled = true;
         TextFieldEx.setTextAutoSize(this.RolloverName_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
         this.RolloverName_tf.text = " ";
         TextFieldEx.setVerticalAlign(this.RolloverName_tf,TextFieldEx.VALIGN_BOTTOM);
         if(this.RolloverTitle_mc)
         {
            this.RolloverTitle_tf = this.RolloverTitle_mc.RolloverTitle_tf;
            TextFieldEx.setTextAutoSize(this.RolloverTitle_tf,TextFieldEx.TEXTAUTOSZ_SHRINK);
            this.RolloverTitle_tf.text = " ";
            TextFieldEx.setVerticalAlign(this.RolloverTitle_tf,TextFieldEx.VALIGN_BOTTOM);
         }
         this.AdjustRolloverPositions();
         this.ButtonHintBar_mc.useVaultTecColor = true;
      }
      
      private function PopulateButtonBar() : void
      {
         var _loc1_:Vector.<BSButtonHintData> = new Vector.<BSButtonHintData>();
         _loc1_.push(this.AButtonData);
         _loc1_.push(this.XButtonData);
         _loc1_.push(this.YButtonData);
         _loc1_.push(this.BButtonData);
         this.AButtonData.ButtonVisible = false;
         this.XButtonData.ButtonVisible = false;
         this.YButtonData.ButtonVisible = false;
         this.BButtonData.ButtonVisible = false;
         this.ButtonHintBar_mc.SetButtonHintData(_loc1_);
      }
      
      public function AdjustRolloverPositions() : *
      {
         if(this.RolloverName_tf.length > 0)
         {
            this.LegendaryIcon_mc.x = this.RolloverName_tf.getCharBoundaries(0).x - this.LegendaryIcon_mc.width - this.m_IconSpacing;
            this.TaggedForSearchIcon_mc.x = this.RolloverName_tf.getCharBoundaries(0).x - this.TaggedForSearchIcon_mc.width - this.m_IconSpacing;
         }
      }
      
      public function UpdateText(param1:String, param2:Boolean) : void
      {
         var _loc3_:Array = GlobalFunc.GeneratePlayerNameAndTitleArray(param1);
         if(_loc3_.length > 1 && _loc3_[1] != " ")
         {
            gotoAndStop("Title");
            if(this.RolloverTitle_tf)
            {
               this.RolloverTitle_tf.text = _loc3_[1];
               GlobalFunc.TruncateSingleLineText(this.RolloverTitle_tf);
            }
         }
         else
         {
            gotoAndStop("Basic");
            if(this.RolloverTitle_tf)
            {
               this.RolloverTitle_tf.text = "";
            }
         }
         this.RolloverName_tf.text = _loc3_[0].toUpperCase();
         this.visible = param2;
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
   }
}

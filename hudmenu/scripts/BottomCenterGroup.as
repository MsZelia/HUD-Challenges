package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1603")]
   public class BottomCenterGroup extends MovieClip
   {
       
      
      public var SubtitleText_mc:Subtitles;
      
      public var EncounterHealthMeterContainer_mc:EncounterHealthMeterContainer;
      
      public var PerkVaultBoy_mc:MovieClip;
      
      public var CritMeter_mc:MovieClip;
      
      public var CompassWidget_mc:MovieClip;
      
      private const DEFAULT_SPEAKER_NAME_Y:Number = -57.75;
      
      private const DEFAULT_SUBTITLE_TEXT_Y:Number = -25.75;
      
      public function BottomCenterGroup()
      {
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
         addEventListener(Event.ENTER_FRAME,this.adjustSubtitlePosition);
         this.__setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0();
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         if(this.SubtitleText_mc != null && this.EncounterHealthMeterContainer_mc != null)
         {
            this.adjustSubtitlePosition();
         }
      }
      
      private function adjustSubtitlePosition(param1:Event = null) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         if(this.SubtitleText_mc != null && this.EncounterHealthMeterContainer_mc != null)
         {
            _loc2_ = 0;
            _loc3_ = [this.EncounterHealthMeterContainer_mc.EncounterHealthMeter1_mc,this.EncounterHealthMeterContainer_mc.EncounterHealthMeter2_mc,this.EncounterHealthMeterContainer_mc.EncounterHealthMeter3_mc];
            _loc4_ = 0;
            while(_loc4_ < _loc3_.length)
            {
               if(_loc3_[_loc4_] != null && Boolean(_loc3_[_loc4_].visible))
               {
                  _loc2_ = 100;
                  break;
               }
               _loc4_++;
            }
            this.SubtitleText_mc.SpeakerName_tf.y = this.DEFAULT_SPEAKER_NAME_Y - _loc2_;
            this.SubtitleText_mc.SubtitleText_tf.y = this.DEFAULT_SUBTITLE_TEXT_Y - _loc2_;
         }
      }
      
      internal function __setProp_PerkVaultBoy_mc_BottomCenterGroup_PerkVaultBoy_mc_0() : *
      {
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = true;
         }
         catch(e:Error)
         {
         }
         this.PerkVaultBoy_mc.bPlayClipOnce = true;
         this.PerkVaultBoy_mc.bracketCornerLength = 6;
         this.PerkVaultBoy_mc.bracketLineWidth = 1.5;
         this.PerkVaultBoy_mc.bracketPaddingX = 0;
         this.PerkVaultBoy_mc.bracketPaddingY = 0;
         this.PerkVaultBoy_mc.BracketStyle = "horizontal";
         this.PerkVaultBoy_mc.bShowBrackets = false;
         this.PerkVaultBoy_mc.bUseFixedQuestStageSize = false;
         this.PerkVaultBoy_mc.bUseShadedBackground = false;
         this.PerkVaultBoy_mc.ClipAlignment = "Center";
         this.PerkVaultBoy_mc.DefaultBoySwfName = "Components/Quest Vault Boys/Miscellaneous Quests/DefaultBoy.swf";
         this.PerkVaultBoy_mc.maxClipHeight = 128;
         this.PerkVaultBoy_mc.questAnimStageHeight = 400;
         this.PerkVaultBoy_mc.questAnimStageWidth = 550;
         this.PerkVaultBoy_mc.ShadedBackgroundMethod = "Shader";
         this.PerkVaultBoy_mc.ShadedBackgroundType = "normal";
         try
         {
            this.PerkVaultBoy_mc["componentInspectorSetting"] = false;
         }
         catch(e:Error)
         {
         }
      }
   }
}

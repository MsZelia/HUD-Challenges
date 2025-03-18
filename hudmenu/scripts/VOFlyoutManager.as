package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1334")]
   public class VOFlyoutManager extends MovieClip
   {
      
      private static const HIDE_BUFFER_TIME:uint = 800;
      
      private static const FRAME_LABEL_MAPPING:Object = {
         "BS01_NPCM_DailyOps_Dodge":"dailyOps",
         "BS02_NPCM_Pappas":"dailyOps",
         "XPD_NPCF_Hex":"expeditions",
         "E07B_Invaders_NPCM_Homer":"appalachia",
         "XPD_NPCM_Danilo":"expeditions",
         "XPD_AC_NPCM_Buttercup":"expeditions",
         "XPD_AC_NPCM_Sal":"expeditions",
         "XPD_AC_NPCM_BillyBeltbuckles":"expeditions",
         "XPD_AC_NPCM_Veracio":"expeditions",
         "XPD_AC_NPCM_Juchi":"expeditions",
         "XPD_AC_NPCF_MotherCharlotte":"expeditions",
         "XPD_AC_NPCF_Jullian":"expeditions",
         "XPD_AC_NPCM_MayorTim":"expeditions"
      };
       
      
      public var AppalachiaVOFlyoutGraphic_mc:MovieClip;
      
      public var XPDVOFlyoutGraphic_mc:MovieClip;
      
      public var DOVOFlyoutGraphic_mc:MovieClip;
      
      public var DOVOWaveForm_mc:MovieClip;
      
      private var m_ActiveFlyoutClip:MovieClip;
      
      private var m_HideTimer:Timer;
      
      private var m_SpeakerName:String = "";
      
      private var m_SpeakerEditorID:String = "";
      
      public function VOFlyoutManager()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3);
         BSUIDataManager.Subscribe("HUDVOFlyoutData",this.onHUDVOFlyoutData);
         this.m_HideTimer = new Timer(HIDE_BUFFER_TIME,1);
         this.m_HideTimer.addEventListener(TimerEvent.TIMER_COMPLETE,this.onHideTimerEvent);
         this.m_ActiveFlyoutClip = this.DOVOFlyoutGraphic_mc;
      }
      
      public function set speakerName(param1:String) : void
      {
         if(!param1)
         {
            param1 = "";
         }
         if(param1 != this.m_SpeakerName)
         {
            this.m_SpeakerName = param1;
            if(this.m_SpeakerName == "")
            {
               this.HideVOFlyout();
            }
            else
            {
               this.ShowVOFlyout();
            }
         }
      }
      
      private function ShowVOFlyout() : void
      {
         var frameLabel:String = FRAME_LABEL_MAPPING[this.m_SpeakerEditorID];
         if(!frameLabel || frameLabel.length == 0)
         {
            frameLabel = "dailyOps";
         }
         if(currentLabel != frameLabel || !this.m_ActiveFlyoutClip)
         {
            if(Boolean(this.m_ActiveFlyoutClip) && this.m_ActiveFlyoutClip.currentLabel != "off")
            {
               this.m_ActiveFlyoutClip.gotoAndStop("off");
            }
            gotoAndStop(frameLabel);
            switch(frameLabel)
            {
               case "expeditions":
                  this.m_ActiveFlyoutClip = this.XPDVOFlyoutGraphic_mc;
                  break;
               case "appalachia":
                  this.m_ActiveFlyoutClip = this.AppalachiaVOFlyoutGraphic_mc;
                  break;
               case "dailyOps":
               default:
                  this.m_ActiveFlyoutClip = this.DOVOFlyoutGraphic_mc;
            }
         }
         if(this.m_ActiveFlyoutClip)
         {
            try
            {
               this.m_ActiveFlyoutClip.VOCharacter_mc.VOCharacterAnim_mc.gotoAndStop(this.m_SpeakerEditorID);
            }
            catch(aArgumentError:ArgumentError)
            {
               m_ActiveFlyoutClip.VOCharacter_mc.VOCharacterAnim_mc.gotoAndStop(1);
            }
            this.m_ActiveFlyoutClip.VOCharName_mc.textField_tf.text = this.m_SpeakerName;
            if(this.m_ActiveFlyoutClip.currentLabel == "off" || this.m_ActiveFlyoutClip.currentLabel == "rollOff")
            {
               this.m_ActiveFlyoutClip.gotoAndPlay("rollOn");
            }
         }
      }
      
      private function HideVOFlyout() : void
      {
         this.m_HideTimer.reset();
         this.m_HideTimer.start();
      }
      
      private function onHUDVOFlyoutData(param1:FromClientDataEvent) : void
      {
         if(Boolean(param1) && Boolean(param1.data))
         {
            this.m_SpeakerEditorID = param1.data.speakerEditorID;
            this.speakerName = param1.data.speakerName;
         }
      }
      
      private function onHideTimerEvent(param1:Event) : void
      {
         if(this.m_SpeakerName == "" && Boolean(this.m_ActiveFlyoutClip))
         {
            this.m_ActiveFlyoutClip.gotoAndPlay("rollOff");
         }
         this.m_HideTimer.reset();
      }
      
      internal function frame1() : *
      {
         stop();
      }
      
      internal function frame2() : *
      {
         stop();
      }
      
      internal function frame3() : *
      {
         stop();
      }
   }
}

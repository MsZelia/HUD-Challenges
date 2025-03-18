package
{
   import flash.display.MovieClip;
   import scaleform.gfx.Extensions;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol679")]
   public class PingMarker extends MovieClip
   {
      
      public static const CONTEXT_TYPE_DEFAULT:uint = 0;
      
      public static const CONTEXT_TYPE_HOSTILE:uint = 1;
      
      public static const CONTEXT_TYPE_ALLY:uint = 2;
      
      public static const CONTEXT_TYPE_ACTIVATOR:uint = 3;
      
      public static const CONTEXT_TYPE_CONTAINER:uint = 4;
       
      
      public var PingArrow_mc:MovieClip;
      
      public var InsideBox_mc:MovieClip;
      
      public var PingAnimated_mc:MovieClip;
      
      private var m_IsOnScreen:Boolean = true;
      
      private var m_ContextType:uint = 0;
      
      private var m_OffScreenAngle:Number = 0;
      
      private var m_AvatarID:String = "";
      
      private var m_baseArrowX:Number = 0;
      
      private var m_baseArrowY:Number = 0;
      
      public function PingMarker()
      {
         super();
         addFrameScript(0,this.frame1,1,this.frame2,2,this.frame3,3,this.frame4,4,this.frame5,5,this.frame6);
         Extensions.enabled = true;
         this.m_baseArrowX = this.PingArrow_mc.x;
         this.m_baseArrowY = this.PingArrow_mc.y;
      }
      
      public function SetData(param1:Object) : *
      {
         if(param1 == null)
         {
            return;
         }
         this.m_AvatarID = param1.playerIconResource;
         this.m_ContextType = param1.contextType;
         this.m_IsOnScreen = param1.isOnScreen;
         this.m_OffScreenAngle = param1.offScreenAngle;
      }
      
      public function ClearData() : *
      {
         this.m_AvatarID = "";
         this.m_ContextType = 0;
         this.m_IsOnScreen = true;
         this.m_OffScreenAngle = 0;
         stop();
      }
      
      private function RotateAroundPoint(param1:Number, param2:Number, param3:Number, param4:MovieClip) : void
      {
         var _loc5_:Number = Math.sin(param3 * Math.PI / 180);
         var _loc6_:Number = Math.cos(param3 * Math.PI / 180);
         param4.x -= param1;
         param4.y -= param2;
         var _loc7_:Number = param4.x * _loc6_ - param4.y * _loc5_;
         var _loc8_:Number = param4.x * _loc5_ + param4.y * _loc6_;
         param4.x = _loc7_ + param1;
         param4.y = _loc8_ + param2;
      }
      
      public function Redraw() : void
      {
         var _loc1_:String = this.getContextString();
         if(currentFrameLabel != _loc1_)
         {
            gotoAndStop(_loc1_);
         }
         this.PingArrow_mc.visible = !this.m_IsOnScreen;
         if(this.PingArrow_mc.visible)
         {
            this.PingArrow_mc.x = this.m_baseArrowX;
            this.PingArrow_mc.y = this.m_baseArrowY;
            this.PingArrow_mc.rotation = 0;
            this.RotateAroundPoint(this.InsideBox_mc.x,this.InsideBox_mc.y,this.m_OffScreenAngle,this.PingArrow_mc);
            this.PingArrow_mc.rotation = this.m_OffScreenAngle;
            this.PingArrow_mc.gotoAndStop(this.getContextString());
         }
      }
      
      public function GoToAnimationFrame(param1:int) : void
      {
         this.PingAnimated_mc.gotoAndStop(param1);
      }
      
      private function getContextString() : String
      {
         switch(this.m_ContextType)
         {
            case CONTEXT_TYPE_DEFAULT:
               return "DefaultTarget";
            case CONTEXT_TYPE_HOSTILE:
               return "HostileTarget";
            case CONTEXT_TYPE_ALLY:
               return "AllyTarget";
            case CONTEXT_TYPE_ACTIVATOR:
               return "ActivatorTarget";
            case CONTEXT_TYPE_CONTAINER:
               return "ContainerTarget";
            default:
               return "DefaultTarget";
         }
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
      
      internal function frame4() : *
      {
         stop();
      }
      
      internal function frame5() : *
      {
         stop();
      }
      
      internal function frame6() : *
      {
         stop();
      }
   }
}

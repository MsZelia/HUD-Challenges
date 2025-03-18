package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.GlobalFunc;
   import flash.display.MovieClip;
   import flash.events.Event;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol680")]
   public class PingMarkersContainer extends MovieClip
   {
      
      private static const MAX_PINGS:Number = 20;
      
      private static const PING_TIMER:Number = 3000;
      
      private static const PING_ANIM_FRAMES:Number = 95;
       
      
      public var PingContainer_mc:MovieClip;
      
      private var Pings:Vector.<PingMarker>;
      
      private var m_IsPingArrayEmpty:Boolean = true;
      
      private var m_FourthWidth:Number = 0;
      
      private var m_HalfHeight:Number = 0;
      
      public function PingMarkersContainer()
      {
         this.Pings = new Vector.<PingMarker>(MAX_PINGS);
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.onAddedToStage);
      }
      
      private function onAddedToStage(param1:Event) : void
      {
         var _loc2_:int = 0;
         BSUIDataManager.Subscribe("pingArray",this.onPingUpdate);
         this.visible = false;
         _loc2_ = 0;
         while(_loc2_ < this.Pings.length)
         {
            this.Pings[_loc2_] = new PingMarker();
            this.Pings[_loc2_].visible = false;
            addChild(this.Pings[_loc2_]);
            _loc2_++;
         }
         this.m_FourthWidth = this.Pings[0].width / 4;
         this.m_HalfHeight = this.Pings[0].height / 2;
      }
      
      private function onPingUpdate(param1:FromClientDataEvent) : void
      {
         var _loc5_:Boolean = false;
         var _loc6_:* = undefined;
         var _loc7_:Object = null;
         var _loc2_:int = int(param1.data.pingArray.length);
         if(this.m_IsPingArrayEmpty && _loc2_ == 0)
         {
            this.visible = false;
            return;
         }
         this.visible = true;
         var _loc3_:Boolean = true;
         var _loc4_:int = 0;
         while(_loc4_ < MAX_PINGS)
         {
            _loc5_ = false;
            if(_loc4_ < _loc2_)
            {
               _loc6_ = _loc2_ - _loc4_ - 1;
               if((_loc7_ = param1.data.pingArray[_loc4_]).age < PING_TIMER)
               {
                  this.Pings[_loc6_].SetData(_loc7_);
                  this.Pings[_loc6_].x = _loc7_.positionX - this.m_FourthWidth;
                  this.Pings[_loc6_].y = _loc7_.positionY - this.m_HalfHeight;
                  this.Pings[_loc6_].Redraw();
                  if(!this.Pings[_loc6_].visible)
                  {
                     this.Pings[_loc6_].visible = true;
                  }
                  this.Pings[_loc6_].GoToAnimationFrame(this.Map(_loc7_.age,0,PING_TIMER,0,PING_ANIM_FRAMES));
                  _loc3_ = false;
                  if(_loc7_.isPingStart)
                  {
                     GlobalFunc.PlayMenuSound("UIPingActivate");
                  }
                  _loc5_ = true;
               }
            }
            if(!_loc5_)
            {
               this.Pings[_loc4_].x = 0;
               this.Pings[_loc4_].y = 0;
               this.Pings[_loc4_].ClearData();
               this.Pings[_loc4_].Redraw();
               this.Pings[_loc4_].visible = false;
            }
            _loc4_++;
         }
         this.m_IsPingArrayEmpty = _loc3_;
      }
      
      private function Map(param1:int, param2:int, param3:int, param4:int, param5:*) : int
      {
         return int(param4 + (param5 - param4) / (param3 - param2) * (param1 - param2));
      }
   }
}

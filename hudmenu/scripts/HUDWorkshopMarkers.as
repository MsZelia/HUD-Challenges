package
{
   import Shared.AS3.BSUIComponent;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import scaleform.gfx.Extensions;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol685")]
   public class HUDWorkshopMarkers extends BSUIComponent
   {
      
      private static const DATA_PROVIDER_KEY:String = "WorkshopMarkers";
       
      
      private var MarkerMCs:Vector.<WorkshopMarker>;
      
      private var MarkersData:Array;
      
      public function HUDWorkshopMarkers()
      {
         super();
         Extensions.enabled = true;
         this.MarkerMCs = new Vector.<WorkshopMarker>();
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         BSUIDataManager.Subscribe(DATA_PROVIDER_KEY,this.onMarkersUpdated);
      }
      
      public function onMarkersUpdated(param1:FromClientDataEvent) : void
      {
         this.MarkersData = param1.data.markersA;
         SetIsDirty();
      }
      
      override public function redrawUIComponent() : void
      {
         var _loc3_:WorkshopMarker = null;
         var _loc4_:Object = null;
         if(this.MarkersData == null)
         {
            return;
         }
         var _loc1_:int = 0;
         while(_loc1_ < this.MarkersData.length)
         {
            if(_loc1_ < this.MarkerMCs.length)
            {
               _loc3_ = this.MarkerMCs[_loc1_];
            }
            else
            {
               _loc3_ = new WorkshopMarker();
               addChild(_loc3_);
               this.MarkerMCs.push(_loc3_);
            }
            _loc4_ = this.MarkersData[_loc1_];
            _loc3_.x = _loc4_.fScreenX;
            _loc3_.y = _loc4_.fScreenY;
            _loc3_.Update(_loc4_.strDisplayName,_loc4_.strStateName,_loc4_.fCapturePct,_loc4_.bIsOffScreen,_loc4_.bPlayerInContestRadius);
            _loc1_++;
         }
         var _loc2_:int = _loc1_;
         while(_loc2_ < this.MarkerMCs.length)
         {
            removeChild(this.MarkerMCs[_loc2_]);
            _loc2_++;
         }
         this.MarkerMCs.length = _loc1_;
      }
   }
}

package
{
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   import Shared.AS3.Events.CustomEvent;
   import Shared.AS3.SWFLoaderClip;
   import Shared.GlobalFunc;
   import flash.display.Bitmap;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.IOErrorEvent;
   import flash.net.URLRequest;
   
   public class ImageFixture extends SWFLoaderClip
   {
      
      private static const DEMAND_IMAGE:String = "ImageFixtureManager::DemandImage";
      
      private static const REGISTER_IMAGE:String = "ImageFixtureManager::RegisterImage";
      
      private static const UNREGISTER_IMAGE:String = "ImageFixtureManager::UnregisterImage";
      
      private static const DOWNLOAD_ASSOC_MEDIA:String = "ImageFixtureManager::DownloadAssociatedMedia";
      
      public static const NONE_LOADED:int = 0;
      
      public static const SWF_LOADED:int = 1;
      
      public static const IN_LOADED:int = 2;
      
      public static const EX_LOADED:int = 3;
      
      public static const ASSOC_MEDIA_PENDING:int = 4;
      
      public static const ASSOC_MEDIA_LOADED:int = 5;
      
      public static const FT_INVALID:int = -1;
      
      public static const FT_INTERNAL:int = 0;
      
      public static const FT_EXTERNAL:int = 1;
      
      public static const FT_SYMBOL:int = 2;
      
      public static const FT_ASSOC_MEDIA:int = 3;
       
      
      private var m_FixtureState:int = 0;
      
      private var m_ClipInstance:MovieClip = null;
      
      private var m_BitmapInstance:Bitmap = null;
      
      private var m_ImgLoader:Loader;
      
      private var m_Image:String = "";
      
      private var m_BufferName:String = "";
      
      public var LoadingSpinner_mc:MovieClip;
      
      private var m_ScaleLoadingSpinnerWithImage:Boolean = true;
      
      private var m_LoadingSpinnerEnabled:Boolean = true;
      
      private var m_FixtureType:int = -1;
      
      private var m_OnLoadAttemptComplete:Function;
      
      public function ImageFixture()
      {
         this.m_ImgLoader = new Loader();
         super();
         if(this.LoadingSpinner_mc != null)
         {
            this.LoadingSpinner_mc.visible = false;
         }
         this.m_ImgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         addEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
      }
      
      public function set onLoadAttemptComplete(param1:Function) : void
      {
         this.m_OnLoadAttemptComplete = param1;
      }
      
      public function set fixtureType(param1:int) : void
      {
         this.m_FixtureType = param1;
      }
      
      public function set scaleLoadingSpinnerWithImage(param1:Boolean) : void
      {
         this.m_ScaleLoadingSpinnerWithImage = param1;
      }
      
      public function set loadingSpinnerEnabled(param1:Boolean) : void
      {
         if(param1 != this.m_LoadingSpinnerEnabled)
         {
            this.m_LoadingSpinnerEnabled = param1;
            this.RefreshLoadingSpinner();
         }
      }
      
      public function get loadingSpinnerEnabled() : Boolean
      {
         return this.m_LoadingSpinnerEnabled;
      }
      
      public function get scaleLoadingSpinnerWithImage() : Boolean
      {
         return this.m_ScaleLoadingSpinnerWithImage;
      }
      
      public function get fixtureType() : int
      {
         return this.m_FixtureType;
      }
      
      public function get fixtureState() : int
      {
         return this.m_FixtureState;
      }
      
      public function get clipInstance() : MovieClip
      {
         return this.m_ClipInstance;
      }
      
      public function get bitmapInstance() : Bitmap
      {
         return this.m_BitmapInstance;
      }
      
      public function get isExternalFixtureType() : Boolean
      {
         return this.fixtureType == FT_EXTERNAL || this.fixtureType == FT_ASSOC_MEDIA;
      }
      
      public function get imagePath() : String
      {
         return this.m_Image;
      }
      
      public function LoadImageFixtureFromUIData(param1:Object, param2:String) : void
      {
         this.fixtureType = param1.fixtureType;
         switch(param1.fixtureType)
         {
            case FT_INTERNAL:
               this.LoadInternal(param1.directory + param1.imageName,param2);
               break;
            case FT_EXTERNAL:
               this.LoadExternal(param1.directory + param1.imageName,param2);
               break;
            case FT_SYMBOL:
               this.LoadSymbol(param1.imageName);
               break;
            case FT_ASSOC_MEDIA:
               this.LoadAssocMedia(param1.directory + param1.imageName,param1.assocMediaPayload);
               break;
            default:
               trace("ImageFixture::LoadImageFixtureFromUIData: Fixture type is invalid, cannot load.");
         }
         this.RefreshLoadingSpinner();
      }
      
      public function LoadSymbol(param1:String) : void
      {
         if(this.m_Image != param1 || this.m_FixtureState != SWF_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_FixtureState = SWF_LOADED;
            this.SymbolHelper(param1);
         }
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadInternal(param1:String, param2:String) : void
      {
         if(this.m_Image != param1 || this.m_FixtureState != IN_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_FixtureState = IN_LOADED;
            this.m_BufferName = param2;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadExternal(param1:String, param2:String) : void
      {
         if(this.m_Image != param1 || this.m_FixtureState != EX_LOADED)
         {
            this.destroyCurrent();
            this.m_Image = param1;
            this.m_FixtureState = EX_LOADED;
            this.m_BufferName = param2;
            this.LoadBitmap();
         }
         else if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      public function LoadAssocMedia(param1:String, param2:Object) : void
      {
         if(param2)
         {
            if(this.m_Image != param1 || this.m_FixtureState != ASSOC_MEDIA_LOADED && this.m_FixtureState != ASSOC_MEDIA_PENDING)
            {
               this.destroyCurrent();
               this.m_Image = param1;
               this.m_FixtureState = ASSOC_MEDIA_PENDING;
               this.m_BufferName = param2.bufferName;
               BSUIDataManager.dispatchEvent(new CustomEvent(DOWNLOAD_ASSOC_MEDIA,param2));
            }
            else if(this.m_OnLoadAttemptComplete != null)
            {
               this.m_OnLoadAttemptComplete();
            }
         }
      }
      
      public function Unload() : *
      {
         this.destroyCurrent();
      }
      
      private function removeLoadedImage() : void
      {
         if(this.m_ClipInstance != null)
         {
            this.removeChild(this.m_ClipInstance);
            this.m_ClipInstance = null;
         }
         this.UnloadBitmap();
      }
      
      private function destroyCurrent() : void
      {
         this.removeLoadedImage();
         this.m_Image = "";
         this.m_FixtureState = NONE_LOADED;
         this.m_BufferName = "";
      }
      
      private function SymbolHelper(param1:String) : void
      {
         this.m_ClipInstance = this.setContainerIconClip(param1);
         if(!this.m_ClipInstance)
         {
            trace("ImageFixture: Load Symbol Failure [" + param1 + "]");
            this.destroyCurrent();
         }
      }
      
      private function LoadBitmap() : *
      {
         BSUIDataManager.dispatchEvent(new CustomEvent(DEMAND_IMAGE,{
            "imageName":this.m_Image,
            "isExternal":this.isExternalFixtureType,
            "bufferName":this.m_BufferName
         }));
         var _loc1_:* = "img://" + this.m_Image;
         this.m_ImgLoader.load(new URLRequest(_loc1_));
      }
      
      private function UnloadBitmap() : *
      {
         if(this.m_BitmapInstance != null)
         {
            this.removeChild(this.m_BitmapInstance);
            this.m_BitmapInstance = null;
         }
         if(Boolean(this.m_Image) && Boolean(this.m_BufferName))
         {
            BSUIDataManager.dispatchEvent(new CustomEvent(UNREGISTER_IMAGE,{
               "imageName":this.m_Image,
               "isExternal":this.isExternalFixtureType,
               "bufferName":this.m_BufferName
            }));
         }
      }
      
      private function RefreshLoadingSpinner() : *
      {
         if(this.LoadingSpinner_mc != null)
         {
            if(this.m_ScaleLoadingSpinnerWithImage)
            {
               this.LoadingSpinner_mc.scaleX = ClipScale;
               this.LoadingSpinner_mc.scaleY = ClipScale;
            }
            this.LoadingSpinner_mc.visible = this.fixtureType == FT_ASSOC_MEDIA && this.fixtureState == ASSOC_MEDIA_PENDING;
         }
      }
      
      private function onBitmapLoadFailed(param1:Event) : void
      {
         trace("WARNING: ImageFixture:onBitmapLoadFailed | " + this.m_Image);
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      private function onBitmapLoaded(param1:Event) : void
      {
         var _loc2_:* = param1.target as LoaderInfo;
         var _loc3_:* = "img://" + this.m_Image;
         if(_loc2_.url != _loc3_)
         {
            trace("INFO: ImageFixture::onBitmapLoaded | Discarding stale bitmap...");
            return;
         }
         if(this.m_BitmapInstance != null)
         {
            this.removeLoadedImage();
         }
         BSUIDataManager.dispatchEvent(new CustomEvent(REGISTER_IMAGE,{
            "imageName":this.m_Image,
            "isExternal":this.isExternalFixtureType,
            "bufferName":this.m_BufferName
         }));
         GlobalFunc.BSASSERT(_loc2_.content as Bitmap,"ERROR: ImageFixture::onBitmapLoaded | Expected a valid bitmap object!");
         this.m_BitmapInstance = _loc2_.content as Bitmap;
         this.m_BitmapInstance.smoothing = true;
         this.addChild(this.m_BitmapInstance);
         this.m_BitmapInstance.scaleX = ClipScale;
         this.m_BitmapInstance.scaleY = ClipScale;
         if(ClipWidth != 0)
         {
            this.m_BitmapInstance.width = ClipWidth;
         }
         if(ClipHeight != 0)
         {
            this.m_BitmapInstance.height = ClipHeight;
         }
         if(CenterClip)
         {
            this.m_BitmapInstance.x -= ClipWidth / 2;
            this.m_BitmapInstance.y -= ClipHeight / 2;
         }
         this.m_BitmapInstance.x += ClipXOffset;
         this.m_BitmapInstance.y += ClipYOffset;
         this.RefreshLoadingSpinner();
         if(this.m_OnLoadAttemptComplete != null)
         {
            this.m_OnLoadAttemptComplete();
         }
      }
      
      private function onRemoveFromStageEvent(param1:Event) : void
      {
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(Event.COMPLETE,this.onBitmapLoaded);
         this.m_ImgLoader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR,this.onBitmapLoadFailed);
         removeEventListener(Event.REMOVED_FROM_STAGE,this.onRemoveFromStageEvent);
         this.destroyCurrent();
      }
      
      public function onImageFixtureManagerData(param1:FromClientDataEvent) : void
      {
         var _loc2_:int = 0;
         if(param1 && param1.data && param1.data.completedDownloads && this.fixtureType == FT_ASSOC_MEDIA && this.m_FixtureState == ASSOC_MEDIA_PENDING)
         {
            _loc2_ = 0;
            while(_loc2_ < param1.data.completedDownloads.length)
            {
               if(param1.data.completedDownloads[_loc2_] == this.m_Image)
               {
                  this.LoadBitmap();
                  this.m_FixtureState = ASSOC_MEDIA_LOADED;
                  break;
               }
               _loc2_++;
            }
         }
      }
   }
}

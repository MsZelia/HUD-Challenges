package
{
   import flash.display.MovieClip;
   import flash.events.*;
   import flash.net.*;
   import flash.utils.getQualifiedClassName;
   
   public class hudmodloader extends MovieClip
   {
       
      
      private var topLevel:* = null;
      
      private var iniLoader:URLLoader;
      
      private var loaders:Array;
      
      public function hudmodloader()
      {
         this.loaders = new Array();
         super();
         addEventListener(Event.ADDED_TO_STAGE,this.addedToStageHandler);
      }
      
      private function addedToStageHandler(param1:Event) : *
      {
         this.topLevel = stage.getChildAt(0);
         if(this.topLevel != null && getQualifiedClassName(this.topLevel) == "HUDMenu")
         {
            this.iniLoader = new URLLoader();
            this.iniLoader.addEventListener(Event.COMPLETE,this.onConfigLoaded);
            this.iniLoader.load(new URLRequest("../hudmodloader.ini"));
         }
         else
         {
            trace("ERROR: hudmodloader not injected into HUDMenu.");
         }
      }
      
      private function onConfigLoaded(configEvent:Event) : void
      {
         var modName:String;
         var helper:LoaderHelper;
         var line:* = undefined;
         var lineArray:Array = configEvent.target.data.split("\r\n");
         for each(line in lineArray)
         {
            if(line != null && line.length > 0 && line.substr(0,1) != ";")
            {
               try
               {
                  modName = line;
                  if(modName.indexOf(".swf") < 0)
                  {
                     modName += ".swf";
                  }
                  helper = new LoaderHelper(this.topLevel,modName);
                  helper.load();
                  loaders.push(helper);
               }
               catch(e:Error)
               {
                  this.topLevel.displayError(modName + " load error: " + e.toString());
               }
            }
         }
      }
   }
}

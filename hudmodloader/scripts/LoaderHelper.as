package
{
   import flash.display.Loader;
   import flash.events.UncaughtErrorEvent;
   import flash.net.*;
   import flash.system.ApplicationDomain;
   import flash.system.LoaderContext;
   
   public class LoaderHelper
   {
       
      
      private var modName:String;
      
      private var topLevel:Object;
      
      public function LoaderHelper(top:Object, name:String)
      {
         super();
         this.modName = name;
         this.topLevel = top;
      }
      
      public function load() : *
      {
         var loader:Loader;
         try
         {
            loader = new Loader();
            this.topLevel.addChild(loader);
            loader.load(new URLRequest(this.modName),new LoaderContext(false,ApplicationDomain.currentDomain));
            loader.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR,this.uncaughtErrorHandler);
         }
         catch(e:Error)
         {
            this.topLevel.displayError(this.modName + " helper error: " + e.toString());
         }
      }
      
      public function uncaughtErrorHandler(param1:UncaughtErrorEvent) : *
      {
         this.topLevel.displayError(this.modName + ": " + param1.toString());
      }
   }
}

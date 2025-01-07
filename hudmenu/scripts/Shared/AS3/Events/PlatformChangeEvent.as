package Shared.AS3.Events
{
   import flash.events.Event;
   
   public class PlatformChangeEvent extends Event
   {
      
      public static const PLATFORM_PC_KB_MOUSE:uint = 0;
      
      public static const PLATFORM_PC_GAMEPAD:uint = 1;
      
      public static const PLATFORM_XB1:uint = 2;
      
      public static const PLATFORM_PS4:uint = 3;
      
      public static const PLATFORM_MOBILE:uint = 4;
      
      public static const PLATFORM_INVALID:uint = uint.MAX_VALUE;
      
      public static const PLATFORM_PC_KB_ENG:uint = 0;
      
      public static const PLATFORM_PC_KB_FR:uint = 1;
      
      public static const PLATFORM_PC_KB_BE:uint = 2;
      
      public static const PLATFORM_CHANGE:String = "SetPlatform";
       
      
      internal var _uiPlatform:uint = 4294967295;
      
      internal var _bPS3Switch:Boolean = false;
      
      internal var _uiController:uint = 4294967295;
      
      internal var _uiKeyboard:uint = 4294967295;
      
      public function PlatformChangeEvent(param1:uint, param2:Boolean, param3:uint, param4:uint)
      {
         super(PLATFORM_CHANGE,true,true);
         this.uiPlatform = param1;
         this.bPS3Switch = param2;
         this.uiController = param3;
         this.uiKeyboard = param4;
      }
      
      public function get uiPlatform() : *
      {
         return this._uiPlatform;
      }
      
      public function set uiPlatform(param1:uint) : *
      {
         this._uiPlatform = param1;
      }
      
      public function get bPS3Switch() : *
      {
         return this._bPS3Switch;
      }
      
      public function set bPS3Switch(param1:Boolean) : *
      {
         this._bPS3Switch = param1;
      }
      
      public function get uiController() : *
      {
         return this._uiController;
      }
      
      public function set uiController(param1:uint) : *
      {
         this._uiController = param1;
      }
      
      public function get uiKeyboard() : *
      {
         return this._uiKeyboard;
      }
      
      public function set uiKeyboard(param1:uint) : *
      {
         this._uiKeyboard = param1;
      }
      
      override public function clone() : Event
      {
         return new PlatformChangeEvent(this.uiPlatform,this.bPS3Switch,this.uiController,this.uiKeyboard);
      }
   }
}

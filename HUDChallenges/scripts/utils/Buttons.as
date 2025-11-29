package utils
{
   public class Buttons
   {
      
      private static var Version:* = "1.2";
      
      public static var HideUnknownGamepadButtonIcons:Boolean = false;
      
      private static const KEYBINDS:Object = {
         "bksp":8,
         "tab":9,
         "enter":13,
         "shift":16,
         "ctrl":17,
         "alt":18,
         "pause":19,
         "caps":20,
         "esc":27,
         "pgup":33,
         "pgdn":34,
         "end":35,
         "home":36,
         "left":37,
         "up":38,
         "right":39,
         "down":40,
         "ins":45,
         "del":46,
         "0":48,
         "1":49,
         "2":50,
         "3":51,
         "4":52,
         "5":53,
         "6":54,
         "7":55,
         "8":56,
         "9":57,
         "a":65,
         "b":66,
         "c":67,
         "d":68,
         "e":69,
         "f":70,
         "g":71,
         "h":72,
         "i":73,
         "j":74,
         "k":75,
         "l":76,
         "m":77,
         "n":78,
         "o":79,
         "p":80,
         "q":81,
         "r":82,
         "s":83,
         "t":84,
         "u":85,
         "v":86,
         "w":87,
         "x":88,
         "y":89,
         "z":90,
         "sel":93,
         "n0":96,
         "n1":97,
         "n2":98,
         "n3":99,
         "n4":100,
         "n5":101,
         "n6":102,
         "n7":103,
         "n8":104,
         "n9":105,
         "n*":106,
         "n+":107,
         "n-":109,
         "n.":110,
         "n/":111,
         "f1":112,
         "f2":113,
         "f3":114,
         "f4":115,
         "f5":116,
         "f6":117,
         "f7":118,
         "f8":119,
         "f9":120,
         "f10":121,
         "f11":122,
         "f12":123,
         "numlk":144,
         "scrlk":145,
         ";":186,
         "=":187,
         ",":188,
         "-":189,
         ".":190,
         "/":191,
         "`":192,
         "\\":220,
         "\'":222
      };
      
      public function Buttons()
      {
         super();
      }
      
      public static function getButtonKey(keyCode:uint) : String
      {
         switch(keyCode)
         {
            case 8:
               return "BkSp";
            case 9:
               return "Tab";
            case 13:
               return "Enter";
            case 16:
               return "Shift";
            case 17:
               return "Ctrl";
            case 18:
               return "Alt";
            case 19:
               return "Pause";
            case 20:
               return "Caps";
            case 27:
               return "Esc";
            case 33:
               return "PgUp";
            case 34:
               return "PgDn";
            case 35:
               return "End";
            case 36:
               return "Home";
            case 37:
               return "Left";
            case 38:
               return "Up";
            case 39:
               return "Right";
            case 40:
               return "Down";
            case 45:
               return "Ins";
            case 46:
               return "Del";
            case 93:
               return "Sel";
            case 96:
               return "N0";
            case 97:
               return "N1";
            case 98:
               return "N2";
            case 99:
               return "N3";
            case 100:
               return "N4";
            case 101:
               return "N5";
            case 102:
               return "N6";
            case 103:
               return "N7";
            case 104:
               return "N8";
            case 105:
               return "N9";
            case 106:
               return "N*";
            case 107:
               return "N+";
            case 109:
               return "N-";
            case 110:
               return "N.";
            case 111:
               return "N/";
            case 112:
               return "F1";
            case 113:
               return "F2";
            case 114:
               return "F3";
            case 115:
               return "F4";
            case 116:
               return "F5";
            case 117:
               return "F6";
            case 118:
               return "F7";
            case 119:
               return "F8";
            case 120:
               return "F9";
            case 121:
               return "F10";
            case 122:
               return "F11";
            case 123:
               return "F12";
            case 144:
               return "NumLk";
            case 145:
               return "ScrLk";
            case 186:
               return ";";
            case 187:
               return "=";
            case 188:
               return ",";
            case 189:
               return "-";
            case 190:
               return ".";
            case 191:
               return "/";
            case 192:
               return "`";
            case 220:
               return "\\";
            case 222:
               return "\'";
            case 0:
               return "";
            default:
               return String.fromCharCode(keyCode);
         }
      }
      
      public static function getButtonGamepad(keyCode:uint) : String
      {
         switch(keyCode)
         {
            case 37:
               return "_DPad_Left";
            case 38:
               return "_DPad_Up";
            case 39:
               return "_DPad_Right";
            case 40:
               return "_DPad_Down";
            default:
               return HideUnknownGamepadButtonIcons ? "" : "_Question";
         }
      }
      
      public static function getButtonValue(keyChar:String) : uint
      {
         keyChar = keyChar.toLowerCase();
         if(KEYBINDS[keyChar] != null)
         {
            return KEYBINDS[keyChar];
         }
         return 0;
      }
      
      public static function parseValue(value:*) : uint
      {
         if(value == null)
         {
            return 0;
         }
         if(value is String)
         {
            return getButtonValue(value);
         }
         if(!isNaN(value) && value > 0)
         {
            return value;
         }
         return 0;
      }
   }
}


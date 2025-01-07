package
{
   import flash.display.MovieClip;
   import flash.geom.ColorTransform;
   
   public class HUDObjectiveIcon extends MovieClip
   {
      
      public static const DEFAULT_ICON_COLOR:uint = 16777163;
       
      
      public var Icon_mc:MovieClip;
      
      private var m_CharIndex:int = 0;
      
      private var m_ColorTransform:ColorTransform;
      
      public function HUDObjectiveIcon()
      {
         super();
         this.m_ColorTransform = new ColorTransform();
         this.m_ColorTransform.color = DEFAULT_ICON_COLOR;
         this.Icon_mc.transform.colorTransform = this.m_ColorTransform;
      }
      
      public function get charIndex() : int
      {
         return this.m_CharIndex;
      }
      
      public function setData(param1:String, param2:int) : void
      {
         this.Icon_mc.gotoAndStop(param1);
         this.m_CharIndex = param2;
      }
      
      public function setColor(param1:uint) : void
      {
         if(this.m_ColorTransform.color != param1)
         {
            this.m_ColorTransform.color = param1;
            this.Icon_mc.transform.colorTransform = this.m_ColorTransform;
         }
      }
   }
}

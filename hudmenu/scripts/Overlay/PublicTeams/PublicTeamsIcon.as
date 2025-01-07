package Overlay.PublicTeams
{
   import Shared.AS3.SWFLoaderClip;
   import flash.display.DisplayObject;
   
   public class PublicTeamsIcon extends SWFLoaderClip
   {
       
      
      private var m_originalWidth:Number;
      
      private var m_originalHeight:Number;
      
      private var m_TeamType:uint = 0;
      
      public function PublicTeamsIcon()
      {
         super();
         this.m_originalWidth = this.width;
         this.m_originalHeight = this.height;
      }
      
      public function setIconType(param1:uint) : void
      {
         var typeString:String = null;
         var iconClip:DisplayObject = null;
         var aTeamType:uint = param1;
         if(aTeamType != this.m_TeamType && PublicTeamsShared.IsValidPublicTeamType(aTeamType))
         {
            this.m_TeamType = aTeamType;
            typeString = PublicTeamsShared.DecideTeamTypeString(this.m_TeamType);
            this.removeChildren();
            this.setContainerIconClip("IconPT_" + typeString);
         }
         try
         {
            iconClip = this.getChildAt(0);
            if(iconClip)
            {
               iconClip.width = this.m_originalWidth / this.scaleX;
               iconClip.height = this.m_originalHeight / this.scaleY;
            }
         }
         catch(error:RangeError)
         {
            trace("ERROR - Unable to get icon clip and scale it");
         }
      }
   }
}

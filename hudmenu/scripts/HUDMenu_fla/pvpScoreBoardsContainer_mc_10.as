package HUDMenu_fla
{
   import flash.display.MovieClip;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1782")]
   public dynamic class pvpScoreBoardsContainer_mc_10 extends MovieClip
   {
       
      
      public var pvpPlayerScoreBoard_mc:HUDPvPScoreboardPlayer;
      
      public var pvpTeamScoreBoard_mc:HUDPvPScoreboardTeam;
      
      public function pvpScoreBoardsContainer_mc_10()
      {
         super();
         addFrameScript(8,this.frame9,18,this.frame19);
      }
      
      internal function frame9() : *
      {
         stop();
      }
      
      internal function frame19() : *
      {
         stop();
      }
   }
}

package
{
   import Shared.AS3.BSDisplayObject;
   import Shared.AS3.Data.BSUIDataManager;
   import Shared.AS3.Data.FromClientDataEvent;
   
   [Embed(source="/_assets/assets.swf", symbol="symbol1788")]
   public class TeammateMarkersManager extends BSDisplayObject
   {
       
      
      public var TeamNameplates:Vector.<TeammateNameplate>;
      
      public var UnusedTeamNameplates:Vector.<TeammateNameplate>;
      
      private var m_HideMarkers:Boolean = false;
      
      public function TeammateMarkersManager()
      {
         this.TeamNameplates = new Vector.<TeammateNameplate>();
         this.UnusedTeamNameplates = new Vector.<TeammateNameplate>();
         super();
      }
      
      public function set hideMarkers(param1:Boolean) : void
      {
         this.m_HideMarkers = param1;
      }
      
      override public function onAddedToStage() : void
      {
         super.onAddedToStage();
         BSUIDataManager.Subscribe("TeamMarkers",this.onTeamMarkersUpdate);
      }
      
      private function UpdateTeammate(param1:TeammateNameplate, param2:Object) : void
      {
         param1.isLeader = param2.isLeader;
         param1.displayName = param2.displayName;
         param1.playerState = param2.playerState;
         param1.wantedState = param2.wantedState;
         param1.entityID = param2.entityID;
         param1.isLocalPlayer = param2.isLocalPlayer;
         param1.rads = param2.rads;
         param1.HPPct = param2.HPPct;
         param1.isFriend = param2.isFriend;
         param1.isFriendInvitePending = param2.isFriendInvitePending;
         param1.deadState = param2.deadState;
         param1.isTeammate = param2.isTeammate;
         param1.isEventGroup = param2.isEventGroup;
         param1.isHostile = param2.isHostile;
         param1.isPvPFlagged = param2.isPvPFlagged;
         param1.isNuclearWinterMode = param2.isNuclearWinterMode;
         param1.isInConversation = param2.isInConversation;
         param1.teamType = param2.teamType;
         param1.isPublicTeamLeader = param2.isPublicTeamLeader;
         if(param2.voiceChatStatus !== null)
         {
            param1.voiceChatStatus = param2.voiceChatStatus;
         }
         if(param2.isSpeakingInSameChannel !== null)
         {
            param1.isSpeakingInSameChannel = param2.isSpeakingInSameChannel;
         }
         param1.bounty = param2.bounty;
         if(param2.level != null)
         {
            param1.level = param2.level;
         }
         if(param2.isOnScreen != null)
         {
            param1.isOnScreen = param2.isOnScreen;
         }
         if(param2.isBeyondRailLimits != null)
         {
            param1.isBeyondRailLimits = param2.isBeyondRailLimits;
         }
         param1.inLOS = param2.inLOS;
         param1.revengeTarget = param2.revengeTarget;
      }
      
      private function onTeamMarkersUpdate(param1:FromClientDataEvent) : void
      {
         var _loc2_:Array = null;
         var _loc6_:Object = null;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:TeammateNameplate = null;
         var _loc10_:TeammateNameplate = null;
         var _loc11_:TeammateNameplate = null;
         var _loc12_:Boolean = false;
         var _loc13_:int = 0;
         _loc2_ = param1.data.Markers;
         var _loc3_:int = int(_loc2_.length);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc6_ = _loc2_[_loc4_];
            _loc7_ = int(this.TeamNameplates.length);
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               if((_loc9_ = this.TeamNameplates[_loc8_]).entityID == _loc6_.entityID)
               {
                  if(_loc6_.isMarkerDirty)
                  {
                     this.UpdateTeammate(_loc9_,_loc6_);
                  }
                  break;
               }
               _loc8_++;
            }
            if(_loc8_ == _loc7_)
            {
               if(this.UnusedTeamNameplates.length == 0)
               {
                  _loc10_ = new TeammateNameplate();
                  addChild(_loc10_);
               }
               else
               {
                  _loc10_ = this.UnusedTeamNameplates.shift();
               }
               _loc10_.visible = !this.m_HideMarkers;
               this.UpdateTeammate(_loc10_,_loc6_);
               this.TeamNameplates.push(_loc10_);
            }
            _loc4_++;
         }
         var _loc5_:int;
         _loc8_ = (_loc5_ = int(this.TeamNameplates.length)) - 1;
         while(_loc8_ >= 0)
         {
            _loc11_ = this.TeamNameplates[_loc8_];
            _loc12_ = false;
            _loc13_ = 0;
            while(!_loc12_ && _loc13_ < _loc3_)
            {
               if(_loc2_[_loc13_].entityID == _loc11_.entityID)
               {
                  _loc12_ = true;
                  _loc11_.visible = !this.m_HideMarkers;
               }
               _loc13_++;
            }
            if(!_loc12_)
            {
               this.UnusedTeamNameplates.push(this.TeamNameplates.splice(_loc8_,1)[0]);
               this.UnusedTeamNameplates[this.UnusedTeamNameplates.length - 1].visible = false;
            }
            _loc8_--;
         }
      }
   }
}

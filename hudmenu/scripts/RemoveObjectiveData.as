package
{
   public class RemoveObjectiveData
   {
       
      
      private var m_OwningQuest:HUDQuestTrackerEntry;
      
      private var m_ObjectiveToRemove:HUDQuestTrackerObjective;
      
      public function RemoveObjectiveData(param1:HUDQuestTrackerObjective, param2:HUDQuestTrackerEntry)
      {
         super();
         this.m_OwningQuest = param2;
         this.m_ObjectiveToRemove = param1;
      }
      
      public function get owningQuest() : HUDQuestTrackerEntry
      {
         return this.m_OwningQuest;
      }
      
      public function get objectiveToRemove() : HUDQuestTrackerObjective
      {
         return this.m_ObjectiveToRemove;
      }
   }
}

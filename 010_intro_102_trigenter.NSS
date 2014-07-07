#include "acr_quest_i"

void main()
{
	object oPC = GetEnteringObject();
	int nQuest = ACR_RetrieveQuestState("010_intro", oPC);
	if((nQuest == 102 || nQuest == 202 || nQuest == 302 || nQuest == 402 || nQuest == 502) &&
		!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "010_intro_102_A")))
	{
		object oWaypointA = GetWaypointByTag("010_intro_102_A");
		object oWaypointB = GetWaypointByTag("010_intro_102_B");
		object oWaypointC = GetWaypointByTag("010_intro_102_C");
		object oWaypointD = GetWaypointByTag("010_intro_102_D");
		
		object oTransporterA = CreateObject(OBJECT_TYPE_CREATURE, "010_npc_intro_102", GetLocation(oWaypointA));
		object oTransporterB = CreateObject(OBJECT_TYPE_CREATURE, "010_npc_intro_102", GetLocation(oWaypointB));
		object oTransporterC = CreateObject(OBJECT_TYPE_CREATURE, "010_npc_intro_102", GetLocation(oWaypointC));
		object oTransporterD = CreateObject(OBJECT_TYPE_CREATURE, "010_npc_intro_102b", GetLocation(oWaypointD));
		
		SetLocalObject(OBJECT_SELF, "010_intro_102_A", oTransporterA);
		SetLocalObject(OBJECT_SELF, "010_intro_102_B", oTransporterB);
		SetLocalObject(OBJECT_SELF, "010_intro_102_C", oTransporterC);
		SetLocalObject(OBJECT_SELF, "010_intro_102_D", oTransporterD);
	}
}
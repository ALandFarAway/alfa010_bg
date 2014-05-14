#include "acr_quest_i"

void main()
{
	object oPC = GetEnteringObject();
	SendMessageToPC(oPC, "OnEnter fired");
	int nQuest = ACR_RetrieveQuestState("010_intro", oPC);
	SendMessageToPC(oPC, "Quest state: " + IntToString(nQuest));
	if((nQuest == 102 || nQuest == 302) &&
		!GetIsObjectValid(GetLocalObject(OBJECT_SELF, "010_intro_102_A")))
	{
		object oWaypointA = GetWaypointByTag("010_intro_102_A");
		object oWaypointB = GetWaypointByTag("010_intro_102_B");
		object oWaypointC = GetWaypointByTag("010_intro_102_C");
		object oWaypointD = GetWaypointByTag("010_intro_102_D");
		
		SendMessageToPC(oPC, IntToString(ObjectToInt(oWaypointA)));
		SendMessageToPC(oPC, IntToString(ObjectToInt(oWaypointB)));
		SendMessageToPC(oPC, IntToString(ObjectToInt(oWaypointC)));
		SendMessageToPC(oPC, IntToString(ObjectToInt(oWaypointD)));
		
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
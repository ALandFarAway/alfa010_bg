#include "acr_quest_i"
#include "acr_db_persist_i"

void main()
{
	object oPC = GetItemActivator();
	object oWidget = GetItemActivated();
	int dungeonSize = GetLocalInt(oWidget, "DUNGEON_SIZE");
	AssignCommand(oPC, CreateRandomDungeon("DM"+IntToString(ACR_GetPlayerID(oPC)), "sunken", dungeonSize));
	object oEntrance = CreateObject(OBJECT_TYPE_PLACEABLE, "rnddungentr_01", GetLocation(oPC));
	SetLocalString(oEntrance, "DUNGEON_NAME", "DM"+IntToString(ACR_GetPlayerID(oPC)));
}
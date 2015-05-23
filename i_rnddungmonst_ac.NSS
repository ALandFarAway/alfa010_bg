#include "acr_quest_i"
#include "acr_db_persist_i"

void main()
{
	object oPC = GetItemActivator();
	object oWidget = GetItemActivated();
	string dungeonMonst = GetLocalString(oWidget, "DUNGEON_MONSTER");
	AssignSpawnTableToDungeon("DM"+IntToString(ACR_GetPlayerID(oPC)), dungeonMonst);
}
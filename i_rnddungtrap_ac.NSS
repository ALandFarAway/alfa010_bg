#include "acr_quest_i"
#include "acr_db_persist_i"

void main()
{
	object oPC = GetItemActivator();
	object oWidget = GetItemActivated();
	string dungeonMonster = GetLocalString(oWidget, "DUNGEON_TRAP");
	AssignSpawnTableToDungeon("DM"+IntToString(ACR_GetPlayerID(oPC)), dungeonMonster);
}
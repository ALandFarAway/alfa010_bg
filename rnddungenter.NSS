#include "acr_quest_i"

void main()
{
	object oPC = GetLastUsedBy();
	string dung = GetLocalString(OBJECT_SELF, "DUNGEON_NAME");
	if(dung == "")
	{
		SendMessageToPC(oPC, "Could not find an associated dungeon. This transition is thus broken.");
		return;
	}
	else
	{
		SendCreatureToDungeon(oPC, dung);
	}
}
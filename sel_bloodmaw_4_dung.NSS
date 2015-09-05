#include "acr_quest_i"

void main()
{
	if(!GetLocalInt(GetArea(OBJECT_SELF), "BLOODMAW_4_DUNG"))
	{
		CreateRandomDungeon("BLOODMAW_4_DUNG", "sunken", 5);
		AssignSpawnTableToDungeon("BLOODMAW_4_DUNG", "undead");
		AssignQuestToDungeon("BLOODMAW_4_DUNG", "BLOODMAW_4_DUNG");
		SetLocalInt(GetArea(OBJECT_SELF), "BLOODMAW_4_DUNG", 1);
	}
	SendCreatureToDungeon(GetClickingObject(), "BLOODMAW_4_DUNG");
}
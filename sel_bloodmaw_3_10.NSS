#include "acr_quest_i"
#include "010_ship_i"

void main()
{
	object oPC = GetLastUsedBy();
	if(!GetIsPC(oPC)) return;
	
	int nState = ACR_RetrieveQuestState("sel_bloodmaw_3", oPC);
	if(nState == 10)
	{
		SendMessageToPC(oPC, "You must fight off the pirates before you can continue your journey");
		return;
	}
	else if(nState == 11)
	{
		SendMessageToPC(oPC, "You will need to press the fight further, so the ships are safe enough to disengage.");
		return;
	}
	else if(nState == 12)
	{
		SendMessageToPC(oPC, "It takes a heartless person to do nothing for the trapped family-- but none of the sailors know of your neglect, and only the gods may frown on your callused behavior.");
		AdjustAlignment(oPC, ALIGNMENT_EVIL, 2);
		ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_3", 14, oPC, FALSE, FALSE, FALSE, 0, 0.0f);
	}
	else if(nState == 13)
	{
		SendMessageToPC(oPC, "You help those who the pirates had kidnapped onto the passenger vessel and make certain that they are well before disengaging the ships.");
		AdjustAlignment(oPC, ALIGNMENT_GOOD, 1);
		ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_3", 14, oPC, FALSE, FALSE, FALSE, 0, 0.0f);
	}
	
	SendMessageToPC(oPC, "Though the ship is seaworthy still, it is damaged from the attack and crawls northward, unable to stop for the looming presence of hte Cloakwood to the east.");
	AssignCommand(GetModule(), ManageShip("bg_ck_ship_pirates_ext_1", "WP_CKBG_BG", oPC, 15.0f));
}
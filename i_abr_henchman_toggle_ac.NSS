#include "acr_henchmen_i"

void main() {
	object oDM =  GetItemActivator();
	object oTarget = GetItemActivatedTarget();
	object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);
	string errors = "";
	if(!GetIsDM(oDM)) {
		errors += "\nYou must be a DM to use this wand!";
		DestroyObject(GetItemActivated());
	}
	if(ACR_GetIsHenchman(oTarget)) {
		ACR_RemoveHenchman(oDM, oTarget);
		return;
	}
	if(oTarget == OBJECT_INVALID || GetIsPC(oTarget) || GetMaster(oTarget) != OBJECT_INVALID)
		errors += "\nYou must target a NPC to become a henchman, or an existing henchman to be turned into a normal NPC.";
	if(oPC == OBJECT_INVALID)
		errors += "\nThe nearest PC is made master of this henchman, so there must be a PC in the area for this to work.";
	
	if(errors == "")
		ACR_AddHenchman(OBJECT_SELF, oPC, oTarget);
	else SendMessageToPC(oDM, "Error(s) were encountered during henchman conversion:" + errors);
}
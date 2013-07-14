#include "acr_henchmen_i"

void main() {
	object oTarget = GetSpellTargetObject();
	object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);
	string errors = "";
	if(oTarget == OBJECT_INVALID || GetIsPC(oTarget))
		errors += "\nYou must target a NPC to become a henchman.";
	if(oPC == OBJECT_INVALID)
		errors += "\nThe nearest PC is made master of this henchman. There must be a PC in the area for this to work.";
	
	if(errors == "")
		ACR_AddHenchman(GetLastSpellCaster(), oPC, oTarget);
		else SendMessageToPC(GetLastSpellCaster(), "Error(s) were encountered during henchman conversion:" + errors);
}
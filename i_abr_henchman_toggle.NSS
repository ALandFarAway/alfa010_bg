#include "ginc_param_const"
#include "ginc_henchman"

const string _IS_HENCHMAN = "ACR_HENCH";

void main() {
	object oTarget = GetSpellTargetObject();
	if(oTarget != OBJECT_INVALID) {
		if(!GetLocalInt(oTarget, _IS_HENCHMAN)) {
			object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget);
			if(oTarget != OBJECT_INVALID) {
				HenchmanAdd(oPC, oTarget, TRUE, TRUE);
				SetLocalInt(oTarget, _IS_HENCHMAN, 1);
				SendMessageToPC(GetLastSpellCaster(), GetName(oTarget) + " is now a henchman of " + GetName(oPC) + ".");
			}
		} else {
			HenchmanRemove(GetMaster(oTarget), oTarget);
			DeleteLocalInt(oTarget, _IS_HENCHMAN);
			SendMessageToPC(GetLastSpellCaster(), GetName(oTarget) + " is no longer a henchman.");
		}
	}
}
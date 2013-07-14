#include "acr_henchmen_i"

void main() {
	object oTarget = GetSpellTargetObject();
	ACR_AddHenchman(GetLastSpellCaster(), GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC, oTarget), oTarget);
}
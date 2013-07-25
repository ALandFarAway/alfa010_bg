#include "acr_tools_i"

void main() {
	object oTarget = GetItemActivatedTarget();
	int nRace = GetSubRace(oTarget);
	if(nRace == 67 && GetHasSpellEffect(3006, oTarget)) {
		SpeakString("<i>*stakes the vampire through the heart*</i>");
		SetHitPoints(oTarget, 1, DAMAGE_TYPE_PIERCING);
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE, TRUE, TRUE), oTarget);
	}
}
#include "acr_tools_i"

int IsVurnerable(object oTarget) {
	effect eff = GetFirstEffect(oTarget);
	int isNearDeath = (IntToFloat(GetCurrentHitPoints(oTarget)) / IntToFloat(GetMaxHitPoints(oTarget))) <= 0.24;
	while(GetIsEffectValid(eff)) {
		int eType = GetEffectType(eff);
		if(GetEffectSpellId(eff) == 3006) {
			return TRUE;
		}
		if(isNearDeath && (eType == EFFECT_TYPE_ENTANGLE || eType == EFFECT_TYPE_PARALYZE || eType == EFFECT_TYPE_STUNNED || eType == EFFECT_TYPE_TURNED)) {
			return TRUE;
		}
		eff = GetNextEffect(oTarget);
	}
	return FALSE;
}

void main() {
	object oTarget = GetSpellTargetObject();
	int nRace = GetSubRace(oTarget);
	if(nRace == 67 && IsVurnerable(oTarget)) {
		ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(TRUE, TRUE, TRUE), oTarget);
	}
}
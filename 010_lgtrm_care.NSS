#include "acr_resting_i"
#include "acr_skills_i"

void main()
{
	object oPC = GetPCSpeaker();
	
	if(ACR_SkillCheck(SKILL_HEAL, OBJECT_SELF, 15, TRUE, TRUE, 0))
	{
		ACR_SetLongTermCare(oPC, TRUE);
	}
	
	effect eff = GetFirstEffect(oPC);
	while(GetIsEffectValid(eff))
	{
		if(GetEffectType(eff) == EFFECT_TYPE_POISON)
		{
			string sPoisonDC = Get2DAString("poison", "Save_DC", GetEffectSubType(eff));
			int nPoisonDC = StringToInt(sPoisonDC);
			if(ACR_SkillCheck(SKILL_HEAL, OBJECT_SELF, nPoisonDC, TRUE, TRUE, 0))
			{
				RemoveEffect(oPC, eff);
			}
		}
		else if(GetEffectType(eff) == EFFECT_TYPE_DISEASE)
		{
			string sDiseaseDC = Get2DAString("disease", "Subs_Save", GetEffectSubType(eff));
			int nDiseaseDC = StringToInt(sDiseaseDC);
			if(ACR_SkillCheck(SKILL_HEAL, OBJECT_SELF, nDiseaseDC, TRUE, TRUE, 0))
			{
				RemoveEffect(oPC, eff);
			}
		}
		eff = GetNextEffect(oPC);
	}
}
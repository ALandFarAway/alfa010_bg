//::///////////////////////////////////////////////
//	Halt Undead
//	Created by Riotnrrd for ALFA
//	02 / 2009	

#include "nwn2_inc_spells"

#include "X0_I0_SPELLS"
#include "x2_inc_spellhook"
#include "acr_spells_i"

void main()
{

/*
  Spellcast Hook Code
  Added 2003-06-20 by Georg
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more

*/

    if (!ACR_PrecastEvent())
    {
    // If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }

// End of Spell Cast Hook


    //Declare major variables
    object oTarget = GetSpellTargetObject();
    int nCasterLvl = GetCasterLevel(OBJECT_SELF);
    float fDuration = RoundsToSeconds(nCasterLvl);
    //Get the spell target location as opposed to the spell target.
    location lTarget = GetSpellTargetLocation();
	int nSaveDC = GetSpellSaveDC();
	int nTargets = 3;
	int nSpellId = GetSpellId();
	
	effect eLink = EffectLinkEffects(EffectPetrify(), EffectVisualEffect(VFX_DUR_SPELL_HOLD_MONSTER));

    //Do metamagic checks
    fDuration = ApplyMetamagicDurationMods(fDuration);
    int nDurType = ApplyMetamagicDurationTypeMods(DURATION_TYPE_TEMPORARY);
	
	int i = 1;
	object oUndead = GetNearestCreatureToLocation(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, lTarget, 1);
	while(oUndead != OBJECT_INVALID && i <= nTargets) {
		SignalEvent(oUndead, EventSpellCastAt(OBJECT_SELF, nSpellId));
		if(!MyResistSpell(OBJECT_SELF, oUndead) && (
				GetAbilityScore(oUndead, ABILITY_INTELLIGENCE, TRUE) < 5 || // This should be < 1, but most of ALFA's non-intelligent undead have INT scores.
				!MySavingThrow(SAVING_THROW_WILL, oUndead, nSaveDC)
		)) {
			ApplyEffectToObject(nDurType, eLink, oUndead, fDuration);
		}
		i++;
		oUndead = GetNearestCreatureToLocation(CREATURE_TYPE_RACIAL_TYPE, RACIAL_TYPE_UNDEAD, lTarget, i);
	}
}
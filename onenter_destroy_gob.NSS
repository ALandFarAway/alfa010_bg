// *onenter_destroy_gob* this destroys the goblins as part of the
    // quest so PCs find a bloody mess in the goblin cave area 
 
//Put this script OnEnter of trigger


#include "acr_quest_i"

void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYfai_stolen_people");

if (nInt > 0)
   return;

object oTarget;
oTarget = GetObjectByTag("abr_cr_hu_goblin_melee");

DestroyObject(oTarget, 0.0);

effect eEffect;
eEffect = EffectDeath();

eEffect = SupernaturalEffect(eEffect);

ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);

}

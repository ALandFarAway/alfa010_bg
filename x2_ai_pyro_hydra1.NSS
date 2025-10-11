//::///////////////////////////////////////////////
//:: Custom AI Demo Template
//:: x2_ai_demo
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This is a template for those who want to
    override the standard combat AI NWN uses.

    The code in this file effectivly replaces
    the DetermineCombatRound() function in
    nw_i0_generic.nss, which is the core of the
    NWN combat AI.

    To override the default AI with this or any
    other AI script you created, you can either
    call the SetCreatureOverrideAIScript from
    x2_inc_switches

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-21
//:://////////////////////////////////////////////

#include "nw_i0_generic"
#include "x2_inc_switches"
#include "NW_I0_SPELLS"
#include "x0_i0_spells"


void main()
{
    // The following two lines should not be touched
    object oIntruder = GetCreatureOverrideAIScriptTarget();
    ClearCreatureOverrideAIScriptTarget();


    // ********************* Start of custom AI script ****************************



//void main()
{
    //Declare major variables
    int nHD = GetHitDice(OBJECT_SELF);
    int nDamage;
    int nLoop = nHD / 3;
    int nDC = 10 + (nHD/2);
    float fDelay;
	float fMaxDelay = 1.5;
    if(nLoop == 0)
    {
        nLoop = 1;
    }
    //Calculate the damage
    for (nLoop; nLoop > 0; nLoop--)
    {
        nDamage = nDamage + d6(2);
    }
    location lTargetLocation = GetSpellTargetLocation();
    object oTarget;
	effect eDmg;
    effect eCone = EffectVisualEffect(VFX_DUR_CONE_FIRE);
    effect eVis = EffectVisualEffect(VFX_IMP_FLAME_S);
	//Hydra effect override
    if(GetLocalString(OBJECT_SELF, "Breath") == "fire") 
	{
	eCone = EffectNWN2SpecialEffectFile("sp_hydra_cone_fire.sef");
	PlayCustomAnimation(OBJECT_SELF, "Una_breathattack01", 0, 0.7f);
	}
	
    oTarget = GetFirstObjectInShape(SHAPE_SPELLCONE, 10.0, lTargetLocation, TRUE);
    //Get first target in spell area
    while(GetIsObjectValid(oTarget))
    {
        if(GetIsEnemy(oTarget) && oTarget != OBJECT_SELF)
        {
            //Calculate the damage
            nDamage = d6(2*nLoop);
            //Fire cast spell at event for the specified target
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, SPELLABILITY_CONE_FIRE));
            //Determine effect delay
            fDelay = GetDistanceBetween(OBJECT_SELF, oTarget)/20;
            //Adjust the damage based on the Reflex Save, Evasion and Improved Evasion.
            nDamage = GetReflexAdjustedDamage(nDamage, oTarget, nDC, SAVING_THROW_TYPE_FIRE);
            //Set damage effect
            eDmg = EffectDamage(nDamage, DAMAGE_TYPE_FIRE);
            DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, oTarget));
            if(nDamage > 0)
            {
                //Apply the VFX impact and effects
                DelayCommand(fDelay, ApplyEffectToObject(DURATION_TYPE_INSTANT, eDmg, oTarget));
            }
        }
        //Get next target in spell area
        oTarget = GetNextObjectInShape(SHAPE_SPELLCONE, 11.0, lTargetLocation, TRUE);
    }
	fMaxDelay += 0.5;
	ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCone, OBJECT_SELF, fMaxDelay);
}

    // Here you can write your own AI to run in place of DetermineCombatRound.
    // The minimalistic approach would be something like
    //
    // TalentFlee(oTarget); // flee on any combat activity


    // ********************* End of custom AI script ****************************

    // This line *** has to be called here *** or the default AI will take over from
    // this point and really bad things are going to happen
    SetCreatureOverrideAIScriptFinished();
}
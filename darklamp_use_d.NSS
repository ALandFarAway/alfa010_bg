//::///////////////////////////////////////////////
//:: FileName: darklamp_use_d
//:: version : 1.1
//:://////////////////////////////////////////////
//:: Changes in this version:
//:: 1)DARKLAMP CREATION INSTRUCTIONS HAVE CHANGED
//:: 2)Eliminated need for heartbeat event, improves computational efficiency greatly
//:: 3)Eliminated visual artifacts such as bleeding that were result of use of HB event
//:: 4)Summoned defenders now scale to level of whoever damages the DarkLight.
//::   (default settings: 1-5: Skeleton, 6-10: Skeleton Warrior
//::    11-15: Skeleton Chieftian, 16:20: Bone Golem)
//:: 5)Defenders summoned by the DarkLamp now have optional "black light" glow
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: Created By: Trulain
//:: Created On: July 13, 2002
//:://////////////////////////////////////////////
/*
*/
//:://////////////////////////////////////////////
//:: DarkLamps create darkness fields around them.  Undead set these up before
//:: performing rituals outside in the daytime - though they have many other
//:: uses.  To remove the darkness, PC's simply have to destroy the candelabra.
//:: However, DarkLights come with optional OnDamaged script which will summon
//:: creatures to defend them when attacked.
//::
//:: DARKLAMP CREATION INSTRUCTIONS
//:: 1) Make a USEABLE Candelabra and change its name and TAG to DarkLamp
//:: 1a)If you make the candelabra's TAG something other than DarkLamp, edit the darklamp_init script accordingly
//:: 2) Create sound object called DarkLampSound & place on/near the Candelabra
//:: 3) Set up DarkLampSound to play "al_mg_ballmagic1" set to seemless looping
//:: 4) Attach script darklamp_init to the MODULE'S OnModuleLoad event slot
//:: 5) Attach script darklamp_use_d to the Candelabra's OnUserDefined event slot
//:: 6) Attach script darklamp_dmg to the Candelabra's OnDamaged event slot
//:: 7) Attach script darklamp_death to the Candelabra's OnDeath event slot
//:: 8)   Don't forget to add the DarkLamp to the Custom Pallette once it's set up!
//::
//:: OPTIONAL STEPS
//:: 1) In the _dmg script, substitute TAGs for desired critters if you don't want the default skeleton ones
//:: 2) In the _dmg script, comment the identified line to remove "darkglow" effect on summoned critters
//:: 3) In the _use_d script, replace VFX_DUR_DARKNESS with VFX_DUR_ANTI_LIGHT_10 for less darkness - not recommended =)

void main()
{
    int nUser = GetUserDefinedEventNumber();
    if(nUser == 666)
    {
        effect eDarkness = EffectVisualEffect(VFX_DUR_DARKNESS);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eDarkness, OBJECT_SELF);
        effect eGlow = EffectVisualEffect(VFX_DUR_GHOSTLY_VISAGE);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGlow, OBJECT_SELF);
        effect eEnergyField = EffectVisualEffect(VFX_DUR_GLOBE_MINOR);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEnergyField, OBJECT_SELF);
        effect eGroundReflect = EffectVisualEffect(VFX_DUR_SPELLTURNING);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGroundReflect, OBJECT_SELF);
    }
}
///000_reflection_spawn
///Written by Valefort from NWN2 Creator Channel 11/2020
/// this will go on a converstation node 
/// Create a WP  "pc_reflection" where the clone will appear

#include "acr_spawn_i"


void main()
{
    object oPC = GetLastSpeaker();
	
    if(!GetIsObjectValid(oPC));
    //{
      //  return;
    //}
    object oClone = GetObjectByTag("reflection");
    effect eSummon = EffectSummonCopy(oPC);
    
    location lSpawn = GetLocation(GetWaypointByTag("wp_pc_reflection"));
    
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, lSpawn);
    
    //object oClone = GetObjectByTag("reflection");
    ForceRest(oClone); // for spells if you want, buff after
    SetLootable(oClone, FALSE);
    ChangeToStandardFaction(oClone, STANDARD_FACTION_HOSTILE);
	ActionAttack(oPC);
    DetermineCombatRound(oPC);
}


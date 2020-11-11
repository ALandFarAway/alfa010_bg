///000_reflection_spawn
///Written by Valefort from NWN2 Creator Channel 11/2020
/// this will go on a converstation node 
/// Create a WP  "pc_reflection" where the clone will appear



void main()
{
    object oPC = GetLastSpeaker();
    if(!GetIsObjectValid(oPC))
    {
        return;
    }

    effect eSummon = EffectSummonCopy(oPC);
    
    location lSpawn = GetLocation(GetWaypointByTag("pc_reflection"));
    
    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eSummon, lSpawn);
    
    object oClone = GetObjectByTag("hostile_reflection_");
    ForceRest(oClone); // for spells if you want, buff after
    
    ChangeToStandardFaction(oClone, STANDARD_FACTION_HOSTILE);
}


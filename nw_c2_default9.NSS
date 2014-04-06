// BG: TSCC SpawnIn script. JayNi 11th of august 2009.

#include "x0_i0_anims"
//#include "x2_inc_switches"

void main()
{
    // ***** Spawn-In Conditions ***** //
    // See x2_inc_switches for more information about these
    
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }
}
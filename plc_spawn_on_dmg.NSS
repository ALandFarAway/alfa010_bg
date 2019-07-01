/* plc_spawn_on_damage
    Place on a placeable "On Damaged Script", or could also go on the "On Melee Attacked Script" if desired,
    which despite the name will fire on any attack not just melee attacks.
    The placeable will also need variables set to dictate the spawn behavior.
*/

const string HP_TRACKING_VAR = "HP_TRACKING_VAR"; // Name of local integer on object to track health.
const string DAMAGE_THRESHOLD = "DAMAGE_THRESHOLD"; // Local integer for how much damage causes a spawn check, will default to zero which will cause a spawn every time the script fires
const string SPAWN_RESREF = "SPAWN_RESREF"; // Name of local string that tells the object what to spawn when attacked/damaged
const string SPAWN_MIN = "SPAWN_MIN"; // Minimum number of spawns to spawn, will default to one
const string SPAWN_MAX = "SPAWN_MAX"; // Maximum number of spawns to spawn, will default to SPAWN_MIN
void main()
{
//    Determine how much health the object has lost. OBJECT_SELF will be the object being attacked or damaged.
    int nHP = GetCurrentHitPoints();
    int nLastHP = GetLocalInt(OBJECT_SELF,HP_TRACKING_VAR);
    if (nHP>nLastHP) // It must not have been hit yet, need to initialize health tracking.
    {
        nLastHP = GetMaxHitPoints(); 
        SetLocalInt(OBJECT_SELF,HP_TRACKING_VAR,nLastHP);
    }
// Determine if the damage was enough to trigger a spawn.
    int nDamageThreshold = GetLocalInt(OBJECT_SELF,DAMAGE_THRESHOLD);
    // If the damage threshold has been met, spawn some creatures and update the tracking.
    if (nLastHP-nHP>=nDamageThreshold) 
    {
        // Determine how many to spawn.
        int nSpawn = GetLocalInt(OBJECT_SELF,SPAWN_MIN); // Start with SPAWN_MIN.
        if (nSpawn<1) nSpawn = 1; // If SPAWN_MIN wasn't set, default to spawning one creature.
        int nSpawnMax = GetLocalInt(OBJECT_SELF,SPAWN_MAX);
        if (nSpawnMax>nSpawn) // If a range of creatures is specified, adjust by random amount up to SPAWN_MAX
            nSpawn += Random(nSpawnMax-nSpawn+1); 

        // Location to create creatures is the calling object, 
        // the engine will move them a bit so they aren't on top of each other automatically.
        location lSpawn = GetLocation(OBJECT_SELF);
        // Get the template name of the creature to spawn
        string sTemplate = GetLocalString(OBJECT_SELF,SPAWN_RESREF);

        // The attacker is who the creatures will be mad at when they spawn.
        object oAttacker = GetLastAttacker();

        // Spawn the creatures
        for (; nSpawn>0; --nSpawn)
        {
            object oSpawn = CreateObject(OBJECT_TYPE_CREATURE,sTemplate,lSpawn); // Spawn the creature.
            // Set the new creature to attack the cause of the script firing.
            AssignCommand(oSpawn,ActionAttack(oAttacker)); 
        }
/*    Decrese the tracked hitpoints by the damage threshold. 

There are many ways to do this. 

We could update the tracked hitpoints to be the current hit points, 
but then heavy hits wouldn't spawn as many creatures.

We could do a while loop, so multiple spawn cycles would go off even in one script call.
This would require a check to avoid an infinite loop if DAMAGE_THRESHOLD is zero.

Simply checking if damage done is at or above threshold allows a zero damage threshold and eventually spawns 
an appropriate number of creatures on heavy hits without added complication.

*/

        nLastHP -= nDamageThreshold;
        SetLocalInt(OBJECT_SELF,HP_TRACKING_VAR,nLastHP);
    }

}
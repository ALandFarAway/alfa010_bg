/* plc_spawn_on_damage
	Place on a placeable "On Damaged Script", or could also go on the "On Melee Attacked Script" if desired,
	which despite the name will fire on any attack not just melee attacks.
	The placeable will also need variables set to dictate the spawn behavior.
*/

#include "ginc_math"
#include "acr_placeable_i"

// Local variables on placeable to dictate behavior
const string DAMAGE_THRESHOLD = "DAMAGE_THRESHOLD"; // Local integer for how much damage causes a spawn check, will default to zero which will cause a spawn every time the script fires
const string SPAWN_RESREF = "SPAWN_RESREF"; // Local string that tells the object what to spawn when attacked/damaged
const string SPAWN_MIN = "SPAWN_MIN"; // Local integer, minimum number of spawns to spawn, will default to one
const string SPAWN_MAX = "SPAWN_MAX"; // Local integer, maximum number of spawns to spawn, will default to SPAWN_MIN
const string SPAWN_LOCATION_TAG = "SPAWN_LOCATION_TAG"; // Local string, tag of object to spawn at, will default to OBJECT_SELF
const string SPAWN_HEADING_MIN = "SPAWN_HEADING_MIN"; // Local float, minimum heading from source, will default to zero
const string SPAWN_HEADING_MAX = "SPAWN_HEADING_MAX"; // Local float, maximum heading from source, will default to SPAWN_HEADING_MIN
const string SPAWN_DISTANCE_MIN = "SPAWN_DISTANCE_MIN"; // Local float, minimum distance from source, will default to zero
const string SPAWN_DISTANCE_MAX = "SPAWN_DISTANCE_MAX"; // Local float, maximum distance from source, will default to SPAWN_DISTANCE_MIN
const string SPAWN_POSITION_RANDOM = "SPAWN_POSITION_RANDOM"; // Local integer, set to non-zero for random distance 
	// Setting to 0, or not setting at all, will spread the creatures evenly along distance and heading

// Local variable on placeable that script will set itself, doesn't need to be set
const string HP_TRACKING_VAR = "HP_TRACKING_VAR"; // Name of local integer on object to track health.

void main()
{

 ACR_PlaceableOnDamaged();
//	Determine how much health the object has lost. OBJECT_SELF will be the object being attacked or damaged.
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
		
		// Determine location to spawn creatures at
		string sSpawnTag = GetLocalString(OBJECT_SELF,SPAWN_LOCATION_TAG); // Check for a tag variable
		object oSpawnLocation = (sSpawnTag == "Cspawn")?OBJECT_SELF:GetObjectByTag(sSpawnTag); // If found, find the object by tag, otherwie use OBJECT_SELF
		location lSpawn = GetLocation(GetIsObjectValid(oSpawnLocation)?oSpawnLocation:OBJECT_SELF); // If the object is valid, find it's location
		if (!GetIsLocationValid(lSpawn)) lSpawn = GetLocation(OBJECT_SELF); // Final check and default to locaiton of OBJECT_SELF in case of issue
		
		// Break apart the base location into parts to determine spawn location
		object oArea = GetAreaFromLocation(lSpawn);
		vector vSpawn = GetPositionFromLocation(lSpawn);
		// Get values for heading calculation
		float fHeadingMin = GetLocalFloat(OBJECT_SELF,SPAWN_HEADING_MIN); // Minimum heading
		float fHeadingAdd = GetLocalFloat(OBJECT_SELF,SPAWN_HEADING_MAX); // Get maximum value, but will become value to add
		if (fHeadingAdd<fHeadingMin) fHeadingAdd = 0.0; // If it wasn't set, use zero
		else fHeadingAdd-=fHeadingMin; // Is now value to add to fHeadingMin
		// Same for distance calculation
		float fDistanceMin = GetLocalFloat(OBJECT_SELF,SPAWN_DISTANCE_MIN);
		float fDistanceAdd = GetLocalFloat(OBJECT_SELF,SPAWN_DISTANCE_MAX);
		if (fDistanceAdd<fDistanceMin) fDistanceAdd = 0.0;
		else fDistanceAdd-=fDistanceMin;
		
		// Get the template name of the creature to spawn
		string sTemplate = GetLocalString(OBJECT_SELF,SPAWN_RESREF);

		// The attacker is who the creatures will be mad at when they spawn.
		object oAttacker = GetLastAttacker();
		
		// Spawn the creatures
		int bRandomPosition = GetLocalInt(OBJECT_SELF,SPAWN_POSITION_RANDOM);
		int ctSpawn;
		for (ctSpawn = 0; ctSpawn<nSpawn; ++ctSpawn)
		{
			// Find a random location based of the source location
			float fHeading = fHeadingMin;
			float fDistance = fDistanceMin;
			if (bRandomPosition)
			{
				fHeading += RandomFloat(fHeadingAdd);
				fDistance += RandomFloat(fDistanceAdd);
			}
			else
			{
				fHeading += ctSpawn*fHeadingAdd/nSpawn;			
				fDistance += ctSpawn*fDistanceAdd/nSpawn;			
			}
			vector vNewSpawn = vSpawn;
			vNewSpawn.x += fDistance * cos(fHeading);
			vNewSpawn.y += fDistance * sin(fHeading);
			location lNewSpawn = Location(oArea,vNewSpawn,fHeading);
			object oSpawn = CreateObject(OBJECT_TYPE_CREATURE,sTemplate,lNewSpawn); // Spawn the creature.
			// Set the new creature to attack the cause of the script firing.
			AssignCommand(oSpawn,ActionAttack(oAttacker)); 
		}	
		
/*	Decrese the tracked hitpoints by the damage threshold. 

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
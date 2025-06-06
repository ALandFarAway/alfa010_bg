////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.0
//         Date : 2006-9-17
//       Author : Ronan
//
//  Description
//  This is a simple example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_example", the spawn
//  point which uses this script would simply have "example" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. For a
//  more complex example of spawn groups, see the script "as_group_complex".
//
//  Revision History
// Rick, made several types of rats.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This line is required on all spawn group scripts.
#include "acr_1sc_spawn_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This is the main function, which is what the spawn system runs when this
// spawn group is spawned.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main()
{
	object oWP, o;

	oWP = OBJECT_SELF;

	int nRand;


	switch(Random(5)) {
		// 60% 0 Phat Lewt
		case 0:
		case 1:
		case 2:
			if (Random(3)) {
				o = ACR_SpawnLootDetector();
				if (Random(2))
					SetLocalString(o, "PL_RESREF", "phat_lewt_chest_small");
				else
					SetLocalString(o, "PL_RESREF", "phat_lewt_crate");
			} else {
				switch (Random(3)) {
					case 0:
		        		ACR_SpawnObject("phat_lewt_rubble", OBJECT_TYPE_PLACEABLE);
						break;
					case 1:
		        		ACR_SpawnObject("phat_lewt_chest_small_lock", OBJECT_TYPE_PLACEABLE);
						break;
					case 2:
		        		ACR_SpawnObject("phat_lewt_bag", OBJECT_TYPE_PLACEABLE);
						break;
				}
			}
			break;
		case 3:
		case 4: 
			nRand = Random(100);
			// 10% - Corpse
			if (nRand < 25) {
		        ACR_SpawnObject("010_herb_corpse", OBJECT_TYPE_PLACEABLE);
			}
			// 10% - Phosphorescent Moss
			else if (nRand < 50) {
				ACR_SpawnObject("010_herb_spell1", OBJECT_TYPE_PLACEABLE);
			}
			// 10% - Gloomshroom
			else if (nRand < 75) {
				ACR_SpawnObject("010_herb_shroom2", OBJECT_TYPE_PLACEABLE);
			}
			// 10% - Garnishcap
			else {
				ACR_SpawnObject("010_herb_shroom1", OBJECT_TYPE_PLACEABLE);
			}
			break;
	}
 
	// 20% - Destroy spawn.
	if (!Random(5)) ACR_DestroySpawnPoint(oWP);

}
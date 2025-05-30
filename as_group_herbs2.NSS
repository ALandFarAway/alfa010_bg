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
#include "acr_spawn_i"

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

void main() {
	int spawned = 1;

	switch (Random(13)) {
		// 7.7% - Skullcap
		case 0:
			ACR_SpawnObject("010_herb_herb5", OBJECT_TYPE_PLACEABLE);
			break;
		// 15.4% - Fire Fern
		case 1:
		case 2:
			ACR_SpawnObject("010_herb_herb0", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Cassil
		case 3:
			ACR_SpawnObject("010_herb_herb1", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Garclive
		case 4:
			ACR_SpawnObject("010_herb_herb2", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Magpie Mushroom
		case 5:
			ACR_SpawnObject("010_herb_shroom0", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Garnishcap
		case 6:
			ACR_SpawnObject("010_herb_shroom1", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Gloomshroom
		case 7:
			ACR_SpawnObject("010_herb_shroom2", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Bat Guano
		case 8:
			ACR_SpawnObject("010_herb_spell0", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Flashwort
		case 9:
			ACR_SpawnObject("010_herb_spell3", OBJECT_TYPE_PLACEABLE);
			break;
		// 7.7% - Henbane
		case 10:
			ACR_SpawnObject("010_herb_herb4", OBJECT_TYPE_PLACEABLE);
			break;
		default:
			// 5.1% - Corpse
			if (Random(10) < 4)
				ACR_SpawnObject("010_herb_corpse", OBJECT_TYPE_PLACEABLE);
			else
				spawned = 0;
			break;
	}

	// 17.9% chance to destroy self.
	if (spawned && (!Random(5)))
		ACR_DestroySpawnPoint(OBJECT_SELF);

}
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
// Rick, made several types of beetles, for this one, I need to make tougher beetles for later.
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

 if(Random(5) > 3)
 	{ACR_SpawnObject("abr_cr_vm_spider_gargantuanhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_hugehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_largehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_tinyhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_smallhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_tinyhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_smallhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_tinyhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_smallhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_tinyhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_smallhunt", OBJECT_TYPE_CREATURE);
		}
 else if(Random(5) > 2)
 	{ACR_SpawnObject("abr_cr_vm_spider_hugehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_largehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_hugehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_tinyhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_smallhunt", OBJECT_TYPE_CREATURE);
	}
 else if(Random(5) > 1)
 	{ACR_SpawnObject("abr_cr_vm_spider_hugehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_largehunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_hugehunt", OBJECT_TYPE_CREATURE);
	}
 else if(Random(5) > 0)
 	{ACR_SpawnObject("abr_cr_vm_spider_mediumhunt", OBJECT_TYPE_CREATURE);
	ACR_SpawnObject("abr_cr_vm_spider_mediumhunt", OBJECT_TYPE_CREATURE);
	}

  
}
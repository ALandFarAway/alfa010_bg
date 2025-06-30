////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.0
//         Date : 2025-25-6
//       Author : Arri
//
//  Description
//  This is a simple example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_example", the spawn
//  point which uses this script would simply have "example" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. For a
//  more complex example of spawn groups, see the script "as_group_complex".
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This line is required on all spawn group scripts.
#include "acr_spawn_i"
#include "010_spawn_ex"

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
	switch(Random(20)) {
        case 0:
            spawn_group("vsnakes");
            break;
        case 1:
            ACR_SpawnObject("abr_cr_an_w_croc2", OBJECT_TYPE_CREATURE);
            break;
        case 2:
            spawn_group("animal_deer");
            break;
        case 3:
			ACR_SpawnObject("abr_cr_mb_swamplight_lynx", OBJECT_TYPE_CREATURE);
            break;			
	    case 4:
            ACR_SpawnObject("010_v_leech_g_03", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_v_leech_g_03", OBJECT_TYPE_CREATURE);
            break;
        case 5:
            ACR_SpawnObject("abr_cr_an_w_gator2", OBJECT_TYPE_CREATURE);
            break;
        case 6:
            ACR_SpawnObject("abr_cr_an_w_gator3", OBJECT_TYPE_CREATURE);
            break;
        case 7:
            spawn_group("amphibians");
            break;			
		case 8:
            ACR_SpawnObject("010_cr_an_frog", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_frog_gold", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("010_cr_an_frog_red", OBJECT_TYPE_CREATURE);
            break;
        case 9:
            spawn_group("herbs3");
			break;
		case 10:
            ACR_SpawnObject("abr_cr_an_w_gator4", OBJECT_TYPE_CREATURE);
            break;
		case 11:	
            spawn_group("vsnakes");
			ACR_SpawnObject("abr_cr_an_dire_toad", OBJECT_TYPE_CREATURE);
			break;
		case 12:	
			ACR_SpawnObject("010_cr_plant_mound", OBJECT_TYPE_CREATURE);
            break;			
		case 13:
			ACR_SpawnObject("abr_cr_mb_swamplight_lynx", OBJECT_TYPE_CREATURE);
            break;			
		case 14:
            spawn_group("amphibians");	
            break;			
		case 15:	
			ACR_SpawnObject("009_cr_pl_darktree", OBJECT_TYPE_CREATURE);
            break;			
		case 16:	
			ACR_SpawnObject("010_cr_undead_allip", OBJECT_TYPE_CREATURE);
			break;
		case 17:
			ACR_SpawnObject("abr_c_hoid_tren3", OBJECT_TYPE_CREATURE);	
            break;			
		case 18:	
			ACR_SpawnObject("abr_cr_vm_beetle_swamp", OBJECT_TYPE_CREATURE);
			ACR_SpawnObject("abr_cr_vm_beetle_swamp", OBJECT_TYPE_CREATURE);
            break;			
		default:
		
			switch (Random(3)) {
				case 0:
					ACR_SpawnObject("abr_cr_an_dire_toad", OBJECT_TYPE_CREATURE);
					break;
				case 1:
					ACR_SpawnObject("abr_cr_ab_willowisp", OBJECT_TYPE_CREATURE);
					break;
				case 2:
            		ACR_SpawnObject("abr_cr_an_w_turtle,snap", OBJECT_TYPE_CREATURE);
					ACR_SpawnObject("abr_cr_an_w_turtle,snap", OBJECT_TYPE_CREATURE);
					ACR_SpawnObject("abr_cr_an_w_turtle,snap", OBJECT_TYPE_CREATURE);
					break;
					}
        }
}	
    
			
   
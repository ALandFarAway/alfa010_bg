////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//	 Filename : as_group_example.nss
//	  Version : 1.0
//		 Date : 2006-9-17
//	   Author : Ronan
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
	object o;
		
	spawn_placeable("phat_lewt_corpse_male",0.1);

	switch(Random(15)) {
		case 0:
			spawn_hostile_npc("abr_cr_cn_niblewright");
			break;
		case 1:
			spawn_hostile_npc("abr_cr_cn_dreadguard");
			spawn_hostile_npc("abr_cr_cn_dreadguard",0.5);
			spawn_hostile_npc("abr_cr_cn_dreadguard",0.5);
			spawn_hostile_npc("abr_cr_cn_dreadguard",0.5);
			break;
		case 2:
			spawn_hostile_npc("abr_cr_cn_helmedhorror");
			break;
		case 3:
			spawn_nonambient_npc("abr_cr_cn_platinumhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_goldhorror");
			spawn_nonambient_npc("abr_cr_cn_goldhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_electrumhorror");
			spawn_nonambient_npc("abr_cr_cn_electrumhorror");
			spawn_nonambient_npc("abr_cr_cn_electrumhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_electrumhorror",0.5);
			break;
		case 4:
			spawn_nonambient_npc("abr_cr_cn_goldhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_electrumhorror");
			spawn_nonambient_npc("abr_cr_cn_electrumhorror");
			spawn_nonambient_npc("abr_cr_cn_electrumhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_electrumhorror",0.5);
			spawn_nonambient_npc("abr_cr_cn_electrumhorror",0.5);
			break;
		case 5:
			spawn_hostile_npc("abr_cr_cn_animatedarmor_blue",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_green",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_red",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_blue",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_green",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_red",0.3);
			spawn_hostile_npc("abr_cr_cn_animated_sword",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_mace",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_halberd",0.5);
			break;
		case 6:
			spawn_hostile_npc("abr_cr_cn_animated_greatsword",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_greatsword",0.5);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_blue",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_green",0.3);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_red",0.3);
			break;
		case 7:
			spawn_hostile_npc("abr_cr_cn_animated_halberd",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_sword",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_mace",0.5);
			break;
		case 8:
			spawn_hostile_npc("abr_cr_cn_animated_dagger",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_dagger",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_dagger",0.5);
			spawn_hostile_npc("abr_cr_cn_animated_dagger",0.5);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_blue",0.2);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_green",0.2);
			spawn_hostile_npc("abr_cr_cn_animatedarmor_red",0.2);
			break;
		case 9:
			spawn_hostile_npc("abr_cr_cn_fleshgolem");
			break;
		case 10:
			spawn_hostile_npc("abr_cr_cn_stonegolem");
			break;
		case 11:
			spawn_hostile_npc("abr_cr_cn_stainedglassgolem");
			break;
		case 12:
			spawn_hostile_npc("010_con_scaladar");
			spawn_hostile_npc("010_con_scaladar");
			break;
		case 13:
			spawn_hostile_npc("abr_cr_cn_platinumhorror2");
			spawn_hostile_npc("abr_cr_cn_platinumhorror2");
			spawn_hostile_npc("abr_cr_cn_platinumhorror2");
			break;
		case 14:
			spawn_hostile_npc("009_cr_con_golem_alchem");
			break;	
		
	}
}
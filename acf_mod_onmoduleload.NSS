////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onmoduleload.nss
//    $Revision:: 197        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Ronan
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnLoad event, and any custom code added by
//  this server. It is usually used to set up server-specific options, such as
//  the population system (see below).
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//   2010/12/24  AcadiusLost - interim ModuleLoad code hack for server population and IP Address
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"
#include "acr_db_persist_i"
#include "010_door_i"
#include "010_throrgar_spire_i"
#include "acr_quest_i"

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

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void InitializeSpawnResets()
{
	object area,o;
	string str;
	int lock, open;

	for (area = GetFirstArea(); GetIsObjectValid(area); area = GetNextArea()) {
		for (o = GetFirstObjectInArea(area); GetIsObjectValid(o); o = GetNextObjectInArea(area)) {

			
			/* ignore non-whatever this is */
			if (GetObjectType(o) != OBJECT_TYPE_WAYPOINT)
				continue;

			if (GetLocalInt(o, "ACR_SPAWN_TYPE") != 0)
				SetLocalInt(o, "ACR_SPAWN_RESPAWN_COUNT", -1);
		}

	}
}

void main() {

	InitializeThrorgarSpire(GetObjectByTag("ud_t0_throgar_spire"));

    SetGlobalInt(_ACR_SETTINGS_SERVER_ID, 10);
	SetGlobalInt(_ACR_SETTINGS_SERVER_REGION, 3559);
	SetGlobalString(_ACR_SETTINGS_SERVER_NAME, "ALFA 010 Baldur's Gate");
	SetGlobalString(_ACR_SETTINGS_SERVER_IP, "bg.alandfaraway.org");
	
    ACR_ModuleOnModuleLoad();

    // Custom code goes below this line.

	DelayCommand(6.0, InitializeDoors());
	DelayCommand(12.0, InitializeSpawnResets());

	SetLocalInt(GetModule(), "ACR_HEALTHMONITOR_GAMEOBJUPDATE_BACKOFF", 1);
	
	ExecuteScript("nwnx_craft_init", GetModule());

	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_low_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_LOW")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_med_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_MED")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_high_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_HIGH")));
	CreateObject(OBJECT_TYPE_PLACEABLE, "x0_mod_treasure_uniq_admin", GetLocation(GetWaypointByTag("WP_ADMIN_LOOT_UNIQ")));
	
	
	//================================================================
	//=========== Define spawn tables for random dungeons ============
	//================================================================
	
	// Monsters for a rat-themed dungeon
	AddSpawnToDungeonTable("rats", 0, "010_cr_ratdire");
	AddSpawnToDungeonTable("rats", 0, "010_cr_ratdire2");
	AddSpawnToDungeonTable("rats", 1, "010_cr_ratdire3");
	AddSpawnToDungeonTable("rats", 1, "010_cr_ratdire4");
	AddSpawnToDungeonTable("rats", 2, "010_cr_ratdire5");
	AddSpawnToDungeonTable("rats", 2, "010_cr_ratdire6");
	
	// Monsters for an insect-themed dungeon
	AddSpawnToDungeonTable("bugs", 0, "abr_cr_ve_centi_tiny");
	AddSpawnToDungeonTable("bugs", 0, "abr_cr_ve_centi_small");
	AddSpawnToDungeonTable("bugs", 0, "abr_cr_ve_centi_medium");
	AddSpawnToDungeonTable("bugs", 0, "abr_cr_vm_spider_tinyhunt");
	AddSpawnToDungeonTable("bugs", 0, "abr_cr_vm_spider_smallhunt");
	AddSpawnToDungeonTable("bugs", 1, "abr_cr_ve_centi_large");
	AddSpawnToDungeonTable("bugs", 1, "abr_cr_vm_spider_mediumhunt");
	AddSpawnToDungeonTable("bugs", 2, "abr_cr_ve_centi_huge");
	AddSpawnToDungeonTable("bugs", 2, "abr_cr_vm_spider_largehunt");
	// TODO: Find a CR 3-4 bug
	AddSpawnToDungeonTable("bugs", 5, "abr_cr_vm_spider_hugehunt");
	AddSpawnToDungeonTable("bugs", 6, "abr_cr_ve_centi_garg");
	// TODO: Find a CR 5 bug
	AddSpawnToDungeonTable("bugs", 8, "abr_cr_vm_spider_gargantuanhunt");
	AddSpawnToDungeonTable("bugs", 9, "abr_cr_ve_centi_colos");
	
	// Traps that operate by hitting or shooting the target with physical things
	AddTrapToDungeonTable("physical", 0, "shooting_spikes_1");
	AddTrapToDungeonTable("physical", 1, "shooting_spikes_1");
	AddTrapToDungeonTable("physical", 2, "shooting_spikes_2");
	AddTrapToDungeonTable("physical", 3, "shooting_spikes_3");
	AddTrapToDungeonTable("physical", 4, "shooting_spikes_4");
	AddTrapToDungeonTable("physical", 5, "shooting_spikes_5");
	AddTrapToDungeonTable("physical", 6, "shooting_spikes_6");
	AddTrapToDungeonTable("physical", 7, "shooting_spikes_7");
	AddTrapToDungeonTable("physical", 8, "shooting_spikes_8");
	AddTrapToDungeonTable("physical", 9, "shooting_spikes_9");
	AddTrapToDungeonTable("physical", 10, "shooting_spikes_10");
	AddTrapToDungeonTable("physical", 11, "shooting_spikes_11");
	AddTrapToDungeonTable("physical", 12, "shooting_spikes_12");
	AddTrapToDungeonTable("physical", 13, "shooting_spikes_13");
	AddTrapToDungeonTable("physical", 14, "shooting_spikes_14");
	AddTrapToDungeonTable("physical", 15, "shooting_spikes_15");
	AddTrapToDungeonTable("physical", 16, "shooting_spikes_16");
	AddTrapToDungeonTable("physical", 17, "shooting_spikes_17");
	AddTrapToDungeonTable("physical", 18, "shooting_spikes_18");
	AddTrapToDungeonTable("physical", 19, "shooting_spikes_19");
	AddTrapToDungeonTable("physical", 20, "shooting_spikes_20");
}
#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Candlekeep Wilds North (General) [Night]
//	  1-35	35% Hostile Animals
//	 36-60	25% Nonhostile Animals
//	 61-85	25% Goblins (Medium)
//	 86-98	13% Gibberlings
//	99-100	 2% Ogres

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 35 ) {
		spawn_group( "wild" );
	} else if ( nSpawnSeed <= 60 ) {
		spawn_group( "wild_nonhostile" );
	} else if ( nSpawnSeed <= 85 ) {
		spawn_group( "goblins_med" );
	} else if ( nSpawnSeed <= 98 ) {
		spawn_group( "gibberlings" );
		spawn_group( "gibberlings", 0.1 );
	} else {
		spawn_hostile_npc( "abr_cr_gt_ogre" );
	}
}	
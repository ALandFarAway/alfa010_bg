#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Candlekeep Wilds North (General) [Day]
//	  1-45	45% Nonhostile Animals
//	 46-70	25% Hostile Animals
//	 71-86	16% Goblins (Low)
//	 87-96	10% Gibberlings
//	 97-99	 3% Bandits
//	   100	 1% Ogres

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 45 ) {
		spawn_group( "wild_nonhostile" );
	} else if ( nSpawnSeed <= 70 ) {
		spawn_group( "wild" );
	} else if ( nSpawnSeed <= 86 ) {
		spawn_group( "goblins_low" );
	} else if ( nSpawnSeed <= 96 ) {
		spawn_group( "gibberlings" );
	} else if ( nSpawnSeed <= 99 ) {
		spawn_group( "bandits_low" );
	} else {
		spawn_hostile_npc( "abr_cr_gt_ogre" );
	}
}	
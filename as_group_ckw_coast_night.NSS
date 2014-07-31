#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Candlekeep Wilds North (Coastal) [Night]
//	  1-40	40% Kobolds
//	 41-75	35% Hostile Animals
//	76-100	25% Nonhostile Animals

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 40 ) {
		spawn_group( "kobolds_low" );
	} else if ( nSpawnSeed <= 75 ) {
		spawn_group( "wild_nonhostile" );
	} else {
		spawn_hostile_npc( "wild" );
	}
}	
#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Trade Way (South, 5b) [Day]
//	  1-45	45% Nonhostile Animals
//	 46-70	25% Hostile Animals
//	 71-83	13% Goblins (Low)
//	 84-95	12% Hobgoblins (Low)
//	96-100	 5% Bandits

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 45 ) {
		spawn_group( "wild_nonhostile" );
	} else if ( nSpawnSeed <= 70 ) {
		spawn_group( "wild" );
	} else if ( nSpawnSeed <= 83 ) {
		spawn_group( "goblins_low" );
	} else if ( nSpawnSeed <= 95 ) {
		spawn_group( "hobgoblins_low" );
	} else {
		spawn_group( "bandits_low" );
	}
}	
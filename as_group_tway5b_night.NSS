#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Trade Way (South, 5b) [Night]
//	  1-35	35% Hostile Animals
//	 36-60	25% Nonhostile Animals
//	 61-80	20% Goblins (Low)
//	81-100	20% Hobgoblins (Low)

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 36 ) {
		spawn_group( "wild" );
	} else if ( nSpawnSeed <= 60 ) {
		spawn_group( "wild_nonhostile" );
	} else if ( nSpawnSeed <= 80 ) {
		spawn_group( "goblins_low" );
	} else {
		spawn_group( "hobgoblins_low" );
	}
}	
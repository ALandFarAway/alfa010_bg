#include "acr_spawn_i"
#include "010_spawn_ex"

// Spawn Table: Candlekeep Wilds North (Coastal) [Day]
//	  1-45	45% Nonhostile Animals
//	 46-74	29% Kobolds (Low)
//	 75-99	25% Hostile Animals
//	   100	 1% Sirine     

void main() {
	int nSpawnSeed = Random( 100 ) + 1;
	if ( nSpawnSeed <= 45 ) {
		spawn_group( "wild_nonhostile" );
	} else if ( nSpawnSeed <= 74 ) {
		spawn_group( "kobolds_low" );
	} else if ( nSpawnSeed <= 99 ) {
		spawn_group( "wild" );
	} else {
		spawn_hostile_npc( "abr_cr_fy_sirine" );
	}
}	
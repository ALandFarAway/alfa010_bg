// BG: TSCC Heartbeat script. JayNi 11th of august 2009.

#include "hench_i0_ai"

void main()
{
	// * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
	
	if (GetIsInCombat(OBJECT_SELF)){ 
		HenchDetermineCombatRound();
	}
	else {
   		if (d2() == 1)
		ActionRandomWalk();
	
		else ClearAllActions();	
	}
}
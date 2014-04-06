// BG: TSCC EndOfCombat script. JayNi 11th of august 2009.

#include "hench_i0_ai"
#include "ginc_behavior"


void main()
{

   	HenchResetCombatRound();

    int iFocused = GetIsFocused();
 
    if (iFocused <= FOCUSED_STANDARD)
    {
		if (!HenchCheckEventClearAllActions(TRUE))
		{
		    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
		    {
		        HenchDetermineSpecialBehavior();
		    }
		    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
		    {
		        HenchDetermineCombatRound();
		    }
		}
	}
}
// BG: TSCC OnAttacked script. JayNi 11th of august 2009.

#include "hench_i0_ai"
#include "ginc_behavior"


void main()
{
    int iFocused = GetIsFocused();

	// I've been attacked so no longer partially focused
	if (iFocused == FOCUSED_PARTIAL)
	{
		SetLocalInt(OBJECT_SELF, VAR_FOCUSED, FOCUSED_STANDARD); // no longer focused
	}
    if (iFocused == FOCUSED_FULL)
	{
        return;
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        object oAttacker = GetLastAttacker();

        if (!GetIsObjectValid(oAttacker))
        {
            return;
        }
        else if (!GetIsFighting(OBJECT_SELF))
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                if(GetArea(GetLastAttacker()) == GetArea(OBJECT_SELF))
                {
					CheckRemoveStealth();
                }
                SetSummonHelpIfAttacked();
			
                HenchDetermineSpecialBehavior(GetLastAttacker());	
            }
    	}
	}
}
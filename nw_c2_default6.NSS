// BG: TSCC OnDamaged script. JayNi 11th of august 2009.

#include "hench_i0_ai"
#include "ginc_behavior"


void main()
{
	
	// I've been damaged so no longer partially focused
	if (GetIsFocused() == FOCUSED_PARTIAL)
	{
		SetLocalInt(OBJECT_SELF, VAR_FOCUSED, FOCUSED_STANDARD); // no longer focused
	}
    else
    {
        object oDamager = GetLastDamager();
		
		int nMaxHitPoints = GetMaxHitPoints();
		
		int nCurrentHitPoints = GetCurrentHitPoints();
		
		if ((nMaxHitPoints / nCurrentHitPoints) > 3){
			// force heal
            HenchDetermineCombatRound(OBJECT_INVALID, TRUE);
		}
	}
     
}
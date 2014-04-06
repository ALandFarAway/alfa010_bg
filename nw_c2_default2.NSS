// BG: TSCC Perception script. JayNi 11th of august 2009.

#include "hench_i0_ai"
#include "ginc_behavior"


void main()
{
	// * if not running normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
	
	if (GetIsInCombat(OBJECT_SELF)) return;

    // script hidden object shouldn't react (for cases where AI not turned off)
    if (GetScriptHidden(OBJECT_SELF)) return;

    int iFocused = GetIsFocused();

    object oLastPerceived = GetLastPerceived();

    if (iFocused <= FOCUSED_STANDARD)
    { 
		SetFacingPoint(GetPosition(oLastPerceived));
        HenchDetermineCombatRound(oLastPerceived);
    }   
}
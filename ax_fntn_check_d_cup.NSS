//::///////////////////////////////////////////////
//:: check to see whether PC has Drinking Cup
//:: author: tax_5-07 with credit to Lilac Soul
//:://////////////////////////////////////////////

#include "ax_gizmo_user_settings"

int StartingConditional()
{
string sItemDrinkingCup = GetLocalString(OBJECT_SELF, "sItemDrinkingCup");
if (sItemDrinkingCup == "") sItemDrinkingCup = ITEM_DRINKING_CUP;

if (GetItemPossessedBy(GetPCSpeaker(), sItemDrinkingCup) == OBJECT_INVALID) return FALSE;
return TRUE;
}
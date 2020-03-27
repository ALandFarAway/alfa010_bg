//::////////////////////////////////////////////////////
//:: check to see whether the fountain will require gold
//:: author: tax_5-07 with credit to Lilac Soul
//::////////////////////////////////////////////////////

#include "ax_gizmo_include"

int StartingConditional()
{
int nTakeGoldFlag = ParseFlag(GetLocalString(OBJECT_SELF, "sTakeGold"));
int nTakeGoldMag  = StringToInt(ParseParameter1(GetLocalString(OBJECT_SELF, "sTakeGold")));

if ((nTakeGoldFlag > 0) & (nTakeGoldMag > 0)) return TRUE;

return FALSE;
}
//::///////////////////////////////////////////////////////
//:: check to see whether the fountain will require an Item
//:: author: tax_5-07 with credit to Lilac Soul
//::///////////////////////////////////////////////////////

#include "ax_gizmo_include"

int StartingConditional()
{
int nTakeItem1Flag = ParseFlag(GetLocalString(OBJECT_SELF, "sTakeItem1"));
int nTakeItem2Flag = ParseFlag(GetLocalString(OBJECT_SELF, "sTakeItem2"));
int nTakeItem3Flag = ParseFlag(GetLocalString(OBJECT_SELF, "sTakeItem3"));
int nTakeItem4Flag = ParseFlag(GetLocalString(OBJECT_SELF, "sTakeItem4"));

int nCostItem = nTakeItem1Flag + nTakeItem2Flag + nTakeItem3Flag + nTakeItem4Flag;

if (nCostItem == 0) return FALSE;

return TRUE;
}
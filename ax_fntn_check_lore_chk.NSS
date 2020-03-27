//::////////////////////////////////////////////////////////////////
//:: check to see whether the fountain has Lore information attached
//:: author: tax_5-07 with credit to Lilac Soul
//::////////////////////////////////////////////////////////////////

int StartingConditional()
{
if (GetLocalString(OBJECT_SELF, "sLore") == "") return FALSE;

return TRUE;
}
//  magic fountain script for Conversation

#include "ax_gizmo_include"

void main()
{
object oPC = GetPCSpeaker();
if (!GetIsPC(oPC)) return;

// populate the name of the magic Items
//SetCustomToken(660, ITEM_GOLDEN_CHALICE_NAME);
//SetCustomToken(661, ITEM_UNICORN_HORN_NAME);

FountainMain(OBJECT_SELF, oPC, 0);

}
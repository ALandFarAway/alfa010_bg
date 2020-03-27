//  magic fountain script for OnEnter for triggers

#include "ax_gizmo_include"

void main()
{
object oPC = GetEnteringObject();
if (!GetIsPC(oPC)) return;

/// populate the names of the magic Items
//string sItemGoldenChaliceName = GetLocalString(OBJECT_SELF, "sItemGoldenChaliceName");
//string sItemUnicornHornName   = GetLocalString(OBJECT_SELF, "sItemUnicornHornName");
//string sItemKeyName           = GetLocalString(OBJECT_SELF, "sItemKeyName");
string sItemDrinkingCup       = GetLocalString(OBJECT_SELF, "sItemDrinkingCup");
if (sItemDrinkingCup == "") sItemDrinkingCup = ITEM_DRINKING_CUP;
//if (sItemUnicornHornName == "") sItemUnicornHornName = ITEM_UNICORN_HORN_NAME;
//if (sItemKeyName == "") sItemKeyName = ITEM_DEFAULT_KEY_NAME;
//if (sItemGoldenChaliceName == "") sItemGoldenChaliceName = ITEM_GOLDEN_CHALICE_NAME;

//SetCustomToken(660, sItemGoldenChaliceName);
//SetCustomToken(661, sItemUnicornHornName);
//SetCustomToken(662, sItemKeyName);

string sPLCclass = GetLocalString(OBJECT_SELF, "sPLCclass");
string sConversation = GetLocalString(OBJECT_SELF, "sConversation");
if (sConversation == "") sConversation = GetLocalString(OBJECT_SELF, "Conversation");
if (sConversation == "") sConversation = DEFAULT_TRIGGER_CONVERSATION;

if (sPLCclass == "fountain")
    {
		if (GetItemPossessedBy(oPC, sItemDrinkingCup)== OBJECT_INVALID) 
    	{
	    ActionStartConversation(oPC, sConversation);
    	}
	    else
	   	{
	    FountainMain(OBJECT_SELF, oPC, 0);
	    } 
	}
	else
	{
	ActionStartConversation(oPC, sConversation);
	}
}
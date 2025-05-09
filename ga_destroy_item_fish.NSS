// ga_destroy_item
/*
    This takes an item from a player
        sItemTag    = This is the string name of the item's tag
        nQuantity   = The number of items to destroy. -1 is all of the Player's items of that tag.
        nPCFaction  = Take from the whole PC faction
*/
// FAB 9/30
// DBR 8/10/6

#include "nw_i0_plot"
#include "acr_xp_i"

#define CR_XP_SCALE 1.0f

int Ggold = 0;

void DestroyItems(object oTarget,string sItem,int nNumItems,int gold, int xp)
{
    int nCount = 0;
    int Gxp = 0;
    float cr = 0.0f;
    object oItem = GetFirstItemInInventory(oTarget);

    cr = xp/CR_XP_SCALE;

    while (GetIsObjectValid(oItem) == TRUE && nCount < nNumItems)
    {
        if (GetTag(oItem) == sItem)
        {
            //ActionTakeItem(oItem,oTarget);
			DestroyObject(oItem,0.0f);
			Gxp = Gxp + xp;
			Ggold = Ggold + gold;
            nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

    ACR_AwardStaticQuestXP(oTarget,"Collected: Fish "+sItem, Gxp, cr); 
}


void main(string sItemTag)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory



    nTotalItem = GetNumItems( oPC,"it_dcrab" );
    DestroyItems( oPC,"it_dcrab",nTotalItem,2,1 );
	
	nTotalItem = GetNumItems( oPC,"it_fish" );
    DestroyItems( oPC,"it_fish",nTotalItem,5,3 );
	
	nTotalItem = GetNumItems( oPC,"it_scallop" );
    DestroyItems( oPC,"it_scallop",nTotalItem,4,2 );
    
	
	GiveGoldToCreature(oPC,Ggold);
}
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

void DestroyItems(object oTarget,string sItem,int nNumItems,int gold,int xp)
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
			int nStack = GetItemStackSize(oItem);	
			DestroyObject(oItem,0.0f);
			Gxp += xp * nStack;
			Ggold += gold * nStack;
        	nCount++;
        }
        oItem = GetNextItemInInventory(oTarget);
    }

    ACR_AwardStaticQuestXP(oTarget,"Collected: Pelts "+sItem, Gxp, cr); 
}


void main(string sItemTag)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory


	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_badger" ));
    DestroyItems( oPC,"it_plot_hide_badger",nTotalItem,2,1 );

	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_bear" ));
    DestroyItems( oPC,"it_plot_hide_bear",nTotalItem,10,5 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_boar" ));
    DestroyItems( oPC,"it_plot_hide_boar",nTotalItem,5,3 );
			
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_berry" ));
    DestroyItems( oPC,"it_plot_hide_berry",nTotalItem,1,1 );
	
    nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_cat" ));
    DestroyItems( oPC,"it_plot_hide_cat",nTotalItem,2,1 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_deer" ));
    DestroyItems( oPC,"it_plot_hide_deer",nTotalItem,3,2 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_rabbit" ));
    DestroyItems( oPC,"it_plot_hide_rabbit",nTotalItem,1,1 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_weasel" ));
    DestroyItems( oPC,"it_plot_hide_weasel",nTotalItem,1,1 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_wolf" ));
    DestroyItems( oPC,"it_plot_hide_wolf",nTotalItem,5,3 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_wolverine" ));
    DestroyItems( oPC,"it_plot_hide_wolverine",nTotalItem,3,2 );	
	
	GiveGoldToCreature(oPC,Ggold);
}
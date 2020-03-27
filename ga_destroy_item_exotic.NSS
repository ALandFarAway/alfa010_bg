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

    ACR_AwardStaticQuestXP(oTarget,"Collected: ExoticItems "+sItem, Gxp, cr); 
}


void main(string sItemTag)
{
    int nTotalItem;
    object oPC = GetPCSpeaker();
    object oItem;       // Items in inventory


	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_winterwolf" ));
    DestroyItems( oPC,"it_plot_hide_winterwolf",nTotalItem,50,50 );

	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_swpltlynx" ));
    DestroyItems( oPC,"it_plot_hide_swpltlynx",nTotalItem,20,20 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_owlbear" ));
    DestroyItems( oPC,"it_plot_hide_owlbear",nTotalItem,75,75 );
			
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_leucrotta" ));
    DestroyItems( oPC,"it_plot_hide_leucrotta",nTotalItem,50,50 );
	
    nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_dweasel" ));
    DestroyItems( oPC,"it_plot_hide_dweasel",nTotalItem,25,20 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_displacer" ));
    DestroyItems( oPC,"it_plot_hide_displacer",nTotalItem,30,75 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_hide_gorgon" ));
    DestroyItems( oPC,"it_plot_hide_gorgon",nTotalItem,50,40 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_misc_ankheg_acid_gland" ));
    DestroyItems( oPC,"it_misc_ankheg_acid_gland",nTotalItem,2,1 );
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_plot_beetle_fire" ));
    DestroyItems( oPC,"it_plot_beetle_fire",nTotalItem,2,1 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_qst_bomb_beetle_gland" ));
    DestroyItems( oPC,"it_qst_bomb_beetle_gland",nTotalItem,2,1 );	
	
	nTotalItem = GetNumStackedItems(GetItemPossessedBy( oPC,"it_qst_stag_beetle_horn" ));
    DestroyItems( oPC,"it_qst_stag_beetle_horn",nTotalItem,3,2 );
	
	GiveGoldToCreature(oPC,Ggold);
}
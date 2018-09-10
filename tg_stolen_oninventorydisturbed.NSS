void main()
{
    object oNPC = OBJECT_SELF;
    object oPC = GetLastDisturbed();
    object oItem = GetInventoryDisturbItem();
    int nAction = GetInventoryDisturbType();


    if(nAction == INVENTORY_DISTURB_TYPE_STOLEN && GetTag(oItem) == "it_quest_mer_ledger")
    {
        if(GetJournalEntry("bg_tg_2_ledger", oPC) > 0){
            AddJournalQuestEntry("bg_tg_2_ledger", 4, oPC, FALSE, FALSE, FALSE);
			SendMessageToPC(GetFirstPC(), "Set journal entry on "+GetName(oPC));
        }
        else{
            DestroyObject(oItem);
            SendMessageToPC(oPC, "You cannot steal this item");
        }

        CreateItemOnObject(GetResRef(oItem));
    }
}
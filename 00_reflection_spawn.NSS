// Copy a character 
//Does not work from converstation nodes
//include script?



object CopyCharacter(object oPC, location lLoc, 
object oOwner=OBJECT_INVALID, string sNewTag="", 
int nFaction=STANDARD_FACTION_HOSTILE, int bEquipItems=TRUE){
	object oCopy = CopyObject(oPC, lLoc, oOwner, sNewTag);
	SetLocalString(oCopy, "cleaner_action", "destroy");
	SetLootable(oCopy, FALSE);
	TakeGoldFromCreature(GetGold(oCopy), oCopy, TRUE);
	AssignCommand(oCopy, SetIsDestroyable(TRUE, FALSE, FALSE));
	SetCreatureScriptsToSet(oCopy, 9);
	ChangeToStandardFaction(oCopy, nFaction);

	if(bEquipItems){
		AssignCommand(oCopy, ClearAllActions(TRUE));
		if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST, oCopy)))
			AssignCommand(oCopy, ActionEquipMostEffectiveArmor());
		if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oCopy)))
			AssignCommand(oCopy, ActionEquipMostDamagingMelee(oPC));

		int bHasUnequippedItems = FALSE;
		int i;
		for(i = 0 ; i <= INVENTORY_SLOT_BELT ; i++)
		{
			if(i == INVENTORY_SLOT_LEFTHAND || i == INVENTORY_SLOT_RIGHTHAND || i == INVENTORY_SLOT_CHEST)
				continue;
			if(!GetIsObjectValid(GetItemInSlot(i, oCopy))){
				bHasUnequippedItems = TRUE;
				break;
			}
		}

		// Find most expensive equip-able items
		if(bHasUnequippedItems){
			object oHead = GetItemInSlot(INVENTORY_SLOT_HEAD, oCopy);
			object oBoots = GetItemInSlot(INVENTORY_SLOT_BOOTS, oCopy);
			object oArms = GetItemInSlot(INVENTORY_SLOT_ARMS, oCopy);
			object oCloak = GetItemInSlot(INVENTORY_SLOT_CLOAK, oCopy);
			object oLeftring = GetItemInSlot(INVENTORY_SLOT_LEFTRING, oCopy);
			object oRightring = GetItemInSlot(INVENTORY_SLOT_RIGHTRING, oCopy);
			object oNeck = GetItemInSlot(INVENTORY_SLOT_NECK, oCopy);
			object oBelt = GetItemInSlot(INVENTORY_SLOT_BELT, oCopy);

			object oItem = GetFirstItemInInventory(oCopy);
			while(GetIsObjectValid(oItem))
			{
				int nSlot = -1;
				switch(GetBaseItemType(oItem)){
					case BASE_ITEM_HELMET: nSlot = INVENTORY_SLOT_HEAD; break;
					case BASE_ITEM_BOOTS:  nSlot = INVENTORY_SLOT_BOOTS; break;
					case BASE_ITEM_BRACER:
					case BASE_ITEM_GLOVES: nSlot = INVENTORY_SLOT_ARMS; break;
					case BASE_ITEM_CLOAK:  nSlot = INVENTORY_SLOT_CLOAK; break;
					case BASE_ITEM_RING:   nSlot = INVENTORY_SLOT_LEFTRING; break;
					case BASE_ITEM_AMULET: nSlot = INVENTORY_SLOT_NECK; break;
					case BASE_ITEM_BELT:   nSlot = INVENTORY_SLOT_BELT; break;
				}

				if(nSlot >= 0){
					if(nSlot == INVENTORY_SLOT_LEFTRING){
						int nPriceL = GetGoldPieceValue(oLeftring);
						int nPriceR = GetGoldPieceValue(oRightring);
						if(nPriceL > nPriceR)
							nSlot = INVENTORY_SLOT_RIGHTRING;
					}

					object oCurrentItem;
					switch(nSlot){
						case INVENTORY_SLOT_HEAD:      oCurrentItem = oHead; break;
						case INVENTORY_SLOT_BOOTS:     oCurrentItem = oBoots; break;
						case INVENTORY_SLOT_ARMS:      oCurrentItem = oArms; break;
						case INVENTORY_SLOT_CLOAK:     oCurrentItem = oCloak; break;
						case INVENTORY_SLOT_LEFTRING:  oCurrentItem = oLeftring; break;
						case INVENTORY_SLOT_RIGHTRING: oCurrentItem = oRightring; break;
						case INVENTORY_SLOT_NECK:      oCurrentItem = oNeck; break;
						case INVENTORY_SLOT_BELT:      oCurrentItem = oBelt; break;
						//default: SignalBug(__FILE__ + ":" + IntToString(__LINE__));
					}

					if(GetGoldPieceValue(oItem) > GetGoldPieceValue(oCurrentItem)){
						switch(nSlot){
							case INVENTORY_SLOT_HEAD:      oHead      = oItem; break;
							case INVENTORY_SLOT_BOOTS:     oBoots     = oItem; break;
							case INVENTORY_SLOT_ARMS:      oArms      = oItem; break;
							case INVENTORY_SLOT_CLOAK:     oCloak     = oItem; break;
							case INVENTORY_SLOT_LEFTRING:  oLeftring  = oItem; break;
							case INVENTORY_SLOT_RIGHTRING: oRightring = oItem; break;
							case INVENTORY_SLOT_NECK:      oNeck      = oItem; break;
							case INVENTORY_SLOT_BELT:      oBelt      = oItem; break;
						//	default: SignalBug(__FILE__ + ":" + IntToString(__LINE__));
						}
					}
				}

				oItem = GetNextItemInInventory(oCopy);
			}

			// Equip the items
			int i;
			for(i = 0 ; i <= INVENTORY_SLOT_BELT ; i++)
			{
				if(i == INVENTORY_SLOT_LEFTHAND || i == INVENTORY_SLOT_RIGHTHAND || i == INVENTORY_SLOT_CHEST)
					continue;
				object oItemToEquip;
				switch(i){
					case INVENTORY_SLOT_HEAD:      oItemToEquip = oHead; break;
					case INVENTORY_SLOT_BOOTS:     oItemToEquip = oBoots; break;
					case INVENTORY_SLOT_ARMS:      oItemToEquip = oArms; break;
					case INVENTORY_SLOT_CLOAK:     oItemToEquip = oCloak; break;
					case INVENTORY_SLOT_LEFTRING:  oItemToEquip = oLeftring; break;
					case INVENTORY_SLOT_RIGHTRING: oItemToEquip = oRightring; break;
					case INVENTORY_SLOT_NECK:      oItemToEquip = oNeck; break;
					case INVENTORY_SLOT_BELT:      oItemToEquip = oBelt; break;
					//default: SignalBug(__FILE__ + ":" + IntToString(__LINE__));
				}
				if(oItemToEquip != GetItemInSlot(i, oCopy)){
					AssignCommand(oCopy, ActionEquipItem(oItemToEquip, i));
				}
			}

		}
	}

	// Make items impossible to drop / steal / sell
	int i;
	for(i = 0 ; i < NUM_INVENTORY_SLOTS ; i++){
		object oItem = GetItemInSlot(i, oCopy);
		SetItemCursedFlag(oItem, TRUE);
		SetPlotFlag(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
		SetStolenFlag(oItem, TRUE);
	}

	object oItem = GetFirstItemInInventory(oCopy);
	while(GetIsObjectValid(oItem))
	{
		SetItemCursedFlag(oItem, TRUE);
		SetPlotFlag(oItem, TRUE);
		SetDroppableFlag(oItem, FALSE);
		SetStolenFlag(oItem, TRUE);
		oItem = GetNextItemInInventory(oCopy);
	}

	return oCopy;
}
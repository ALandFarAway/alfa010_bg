void main()
{
	object oPC=GetLastUsedBy();
//	object oToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2_B");

//	if (!GetIsObjectValid(oToken)) {
    object oFirstToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2a_B");
    object oSecondToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2_B");
	int nDeactivated = GetLocalInt(OBJECT_SELF, "Deactivated");
	
   if (!GetIsObjectValid(oFirstToken) && !GetIsObjectValid(oSecondToken) && nDeactivated == 0) 
	{
		SendMessageToPC(oPC,"You feel dizzy and nauseaus, doubling over in pain as you approach the portal.");

		AssignCommand(oPC,(ActionSpeakString("*Doubles over in nausea*")));

		/* TODO:
		 * 
		 * put this in ACR
		 */
		// failed saving throw, uh oh! SICK!
		effect eDamageDown = EffectDamageDecrease(2);
		effect eThrow = EffectSavingThrowDecrease(SAVING_THROW_ALL, 2);
		effect eAttackDown = EffectAttackDecrease(2);
		// not linking because I think immunity to one could limit all
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eDamageDown, oPC, RoundsToSeconds(10));
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eThrow, oPC, RoundsToSeconds(10));	
		ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eAttackDown, oPC, RoundsToSeconds(10));

		return;
	}

	ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oPC));

	DelayCommand(0.5,AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_PORTAL_UDA3_A"))));
	SetLocalInt(OBJECT_SELF, "Deactivated", 1);
	DelayCommand(120.0, SetLocalInt(OBJECT_SELF, "Deactivated", 0));
	
	}
	
	
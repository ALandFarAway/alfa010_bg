void main()
{
	object oPC=GetEnteringObject();
//	object oToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2_B");
    object oFirstToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2a_B");
    object oSecondToken=GetItemPossessedBy(oPC,"PORTAL_TOKEN_UDA2_B");
	int nDeactivated = GetLocalInt(OBJECT_SELF, "Deactivated");
	
    if (!GetIsObjectValid(oFirstToken) && !GetIsObjectValid(oSecondToken) && nDeactivated == 0) 
	{
//	if (!GetIsObjectValid(oToken))
//	{
		AssignCommand(oPC,ClearAllActions());
		AssignCommand(oPC,ActionMoveToObject(GetWaypointByTag("WP_PORTAL_UDA2_B_REBOUND"),FALSE,0.0));
		DelayCommand(0.5,SetCommandable(FALSE,oPC));
		SendMessageToPC(oPC,"You feel dizzy and nauseous and find yourself back were you started from.");
		DelayCommand(6.0,SetCommandable(TRUE,oPC));
	}
	else
	{
		AssignCommand(oPC,(ActionSpeakString("*Closes eyes tightly*")));
		SetLocalInt(OBJECT_SELF, "Deactivated", 1);
		DelayCommand(120.0, SetLocalInt(OBJECT_SELF, "Deactivated", 0));
	}	
}
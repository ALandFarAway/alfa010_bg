// Put this script OnEnter.


void main()
{
object oPC = GetEnteringObject();
	object oTarget;
	int n;
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))
	
	int nState = ACR_RetrieveQuestState("bg_arsa_bloodwine_shrooms", oPC);
		if(nState == 1)
	{
	SendMessageToPC(oPC, "you enter a dark, dank cave");
	}
   //int n = 0;
//object oTarget = GetObjectByTag("wp_qst_arsa_bwmush");
while (GetIsObjectValid(oTarget))
{
    CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_bw_mshrm", GetLocation(oTarget));
    n++;
    oTarget = GetObjectByTag("wp_qst_arsa_bwmush", n);
}
}



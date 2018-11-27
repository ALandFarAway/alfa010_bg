// Put this script OnEnter of a Trigger
// lines with  // after them work to spawn the mushrooms


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_arsa_bw_shrooms";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;


{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
  SendMessageToPC(oPC, "you enter a dark, dank cave");
 
  
int n = 0;//
//object oTarget = GetObjectByTag("wp_qst_arsa_bwmush");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_bw_mshrm", GetLocation(oTarget));//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE);
    n++;//
    oTarget = GetObjectByTag("wp_qst_arsa_bwmush", n);//
	
	AddJournalQuestEntry("bg_arsa_bw_shrooms", 2, oPC, TRUE, FALSE);
	}
	 }//
 }
}//
// Put this script OnEnter of a Trigger
// lines with  // after them work to spawn the mushrooms


#include "acr_quest_i"


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_arsa_strangleweed";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
  SendMessageToPC(oPC, "you enter a desolate area");
 
int n = 0;//
object oTarget = GetObjectByTag("wp_qst_arsa_strgweed");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_strangleweed", GetLocation(oTarget));//
	
    n++;//
    oTarget = GetObjectByTag("wp_qst_arsa_strgweed", n);//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
	
	ACR_AddPersistentJournalQuestEntry("bg_arsa_strangleweed", 2, oPC, TRUE, FALSE);// 
	}
	 }//
 }
}//
// Put this script OnEnter of a Trigger
// lines with  // after them work to spawn the mushrooms


#include "acr_quest_i"


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_arsa_harpyeggs";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
  SendMessageToPC(oPC, "The air is rife with the sound of screaching");
 
int n = 0;//
object oTarget = GetObjectByTag("WP_arsa_harpy_egg");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_harpy_egg", GetLocation(oTarget));//
	
    n++;//
    oTarget = GetObjectByTag("WP_arsa_harpy_egg", n);//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
	
	ACR_AddPersistentJournalQuestEntry("bg_arsa_harpyeggs", 2, oPC, TRUE, FALSE);// 
	}
	 }//
 }
}//
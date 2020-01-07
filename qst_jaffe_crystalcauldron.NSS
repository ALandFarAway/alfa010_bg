

#include "acr_quest_i"


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_jaffee_skullcrystal";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
 
int n = 0;//
object oTarget = GetObjectByTag("wp_quest_crystalskull");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_qst_cc2a_crystalskull", GetLocation(oTarget));//

	
    n++;//
    oTarget = GetObjectByTag("wp_quest_crystalskull", n);//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
	
	}
	 }//
 }
}//
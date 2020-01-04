

#include "acr_quest_i"


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "qst_bg_jaffee_crystalflower";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
 
int n = 0;//
object oTarget = GetObjectByTag("wp_crystalflower");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "plc_qst_clkwd02_crystalflower", GetLocation(oTarget));//

	
    n++;//
    oTarget = GetObjectByTag("wp_crystalflower", n);//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
	
	}
	 }//
 }
}//
//Put this script OnEnter


#include "acr_quest_i"


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_qst_wood_arrows";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
 
int n = 0;//
object oTarget = GetObjectByTag("wp_crate_arrows");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "box_bg_qst_wood_arrows", GetLocation(oTarget));//

	
    n++;//
    oTarget = GetObjectByTag("box_bg_qst_wood_arrows", n);//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
	
	}
	 }//
 }
}//
/*
void main()
{

object oPC = GetEnteringObject();

 if(!GetIsPC(oPC) || GetIsDM(oPC))  //If not a PC or is a DM, do nothing and return
    return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYbg_qst_wood_arrows");

if (nInt == 1)
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("wp_crate_arrows");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "box_bg_qst_wood_arrows", lTarget);

}*/
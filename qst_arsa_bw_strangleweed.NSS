// Put this script OnEnter of a Trigger
// lines with  // after them work to spawn the mushrooms


void main()//
 {//
    object oPC = GetEnteringObject();//
	object oTarget;//
	int n;//
	string sQuestToken = "bg_arsa_strangleweed";

	
		
	if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
	if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);
{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == 1)
	 {//
  SendMessageToPC(oPC, "you enter a desolate area");
 
int n = 0;//
object oTarget = GetObjectByTag("wp_qst_arsa_strgweed");//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_strangleweed", GetLocation(oTarget));//
	SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
    n++;//
    oTarget = GetObjectByTag("wp_qst_arsa_strgweed", n);//
	
	}
	 }//
 }
}//

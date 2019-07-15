// Put this script OnEnter of a Trigger
// lines with  // after them work to spawn the placeables
// Written by Saaz


#include "acr_quest_i"

// These local variables on the trigger control the execution of the script
const string QUEST_TOKEN_VAR = "sQuestToken"; // string of sQuestToken in NW_JOURNAL_ENTRY
const string QUEST_JOURNAL_VAR = "nQuestJournal"; // integer, value of NW_JOURNAL_ENTRY+sQuestToken to check for
const string ACR_JOURNAL_QUEST_VAR = "sACRQuest"; // string, ACR Persistent Journal entry
const string ACR_JOURNAL_VAR = "nACRJournal"; // integer, ACR Persistent Journal entry value
const string QUEST_CREATE_MARKER_VAR = "sQuestCreateMarker"; // string, tag of placeable to create objects at
const string QUEST_CREATE_RESREF_VAR = "sQuestCreateResref"; // string ,resref of object to create at placeable
const string PC_MESSAGE_VAR = "sMessage"; // string, message to send to PC who entered trigger

void main()//
 {//
    object oPC = GetEnteringObject();//
    object oTarget;//
    int n;//
    string sQuestToken = GetLocalString(OBJECT_SELF,QUEST_TOKEN_VAR);

    
        
    if ((GetIsPC(oPC) || GetIsDM(oPC) || GetIsDMPossessed(oPC)) && !GetLocalInt(OBJECT_SELF, "DoOnce"))//
    if (!GetIsPC(oPC)) return;

{

    if(GetLocalInt(oPC, "NW_JOURNAL_ENTRY" + sQuestToken) == GetLocalInt(OBJECT_SELF,QUEST_JOURNAL_VAR))
     {//
	string sMessage = GetLocalString(OBJECT_SELF,PC_MESSAGE_VAR);
  if (sMessage != "") SendMessageToPC(oPC,sMessage);
 
int n = 0;//
string sACRQuest = GetLocalString(OBJECT_SELF,ACR_JOURNAL_QUEST_VAR);
int nACRQuest = GetLocalInt(OBJECT_SELF,ACR_JOURNAL_VAR);
string sMarkerTag = GetLocalString(OBJECT_SELF,QUEST_CREATE_MARKER_VAR);
string sCreateResref = GetLocalString(OBJECT_SELF,QUEST_CREATE_RESREF_VAR);
object oTarget = GetObjectByTag(sMarkerTag);//
while (GetIsObjectValid(oTarget))//
    {//
    CreateObject(OBJECT_TYPE_PLACEABLE, sCreateResref, GetLocation(oTarget));//
    
    n++;//
    oTarget = GetObjectByTag(sMarkerTag, n);//
    SetLocalInt(OBJECT_SELF, "DoOnce", TRUE); ///
    
    ACR_AddPersistentJournalQuestEntry(sACRQuest, nACRQuest, oPC, TRUE, FALSE);// 
    }
     }//
 }
}//
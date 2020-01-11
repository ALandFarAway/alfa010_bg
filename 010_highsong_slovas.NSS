#include "acr_quest_i"

void main()
{
	object oPC = GetLastPerceived();
	if(GetIsPC(oPC) &&
		!IsInConversation(oPC) &&
		!IsInConversation(OBJECT_SELF) &&
	    !ACR_RetrieveQuestState("highsong_ankheg_woes", oPC))
	{
		SpeakString("HELP!");
		ActionStartConversation(oPC);
	}
	ExecuteScript("acf_cre_onperception", OBJECT_SELF);
}
#include "acr_quest_i"

void main()
{
	if(d6(1) == 1)
	{
		int nPCs = 0;
		object oPC = GetFirstPC(TRUE);
		while(GetIsObjectValid(oPC))
		{
			nPCs++;
			oPC = GetNextPC(TRUE);
		}
		
		int nPickedPC = Random(nPCs);
		nPCs = 0;
		oPC = GetFirstPC(TRUE);
		while(nPCs < nPickedPC)
		{
			nPCs++;
			oPC = GetNextPC(TRUE);
		}
		
		string areaTag = GetTag(GetArea(oPC));
		string utterance = GetLocalString(OBJECT_SELF, areaTag);
		if(utterance != "")
		{
			string utterance2 = GetLocalString(OBJECT_SELF, areaTag+"2");
			string sName = "someone";
			string callBack = "Oh, I wonder what that's about.";
			
			string sQuest = GetLocalString(OBJECT_SELF, "REP_QUEST");
			int nQuestState = ACR_RetrieveQuestState(sQuest, oPC);
			
			if(nQuestState != 0) 
			{
				sName = GetName(oPC);
				if(sName == "Persephone") sName = "Lady Teresa";
			}
			
			if(nQuestState >= 800) callBack = "Really? Would think they'd take a hint.";
			else if(nQuestState >= 500) callBack = "What? Oh, I hope there's not going to be a fight.";
			else if(nQuestState > 0) callBack = "Certainly good to see them around.";
			else
			{
				int nPCsInArea = 0;	
				object oNearbyPC = GetFirstPC(TRUE);
				while(GetIsObjectValid(oNearbyPC))
				{
					if(GetArea(oNearbyPC) == GetArea(oPC))
					{
						nPCsInArea++;
					}
					oNearbyPC = GetNextPC(TRUE);
				}
				if(nPCsInArea > 4) sName = "a bunch of people";
				else if(nPCsInArea > 2) sName = "a few people";
				else if(nPCsInArea == 2) sName = "a couple people";
			}			

			
			SpeakString(utterance + sName + utterance2);
			AssignCommand(GetNearestObjectByTag("010_sel_gossip2", OBJECT_SELF), SpeakString(callBack));
		}
	}
	ExecuteScript("acf_cre_onheartbeat", OBJECT_SELF);
}
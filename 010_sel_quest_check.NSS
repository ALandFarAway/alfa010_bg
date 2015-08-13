#include "acr_quest_i"

int StartingConditional(string sChain, int nCheck)
{
	object oPC = GetPCSpeaker();
	string sPC = GetName(oPC);
	if(GetStringLength(sPC) > 15)
		sPC = GetStringLeft(sPC, 15);
	if(sChain == "skill")
	{
		if(GetSkillRank(nCheck, oPC) > 0)
			return TRUE;	
	}
	else if(sChain == "ssil")
	{
		if(nCheck == 1)
		{
		/* Check 1 checks if Ssil is willing to give the PC has failed a job from Ssil. */	
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 1)
			/* The work Ssil has given is complete, but failed. */
				return TRUE;
		}
		else if(nCheck == 2)
		/* Check 2 checks if Ssil knows the PC is evil. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 2)
			/* Ssil remembers this PC, and knows he/she is evil. */
				return TRUE;
		}
		else if(nCheck == 3)
		/* Check 3 checks if Ssil has given the PC work. */
		{
			object oPCInParty = GetFirstFactionMember(oPC, TRUE);
			while(GetIsObjectValid(oPCInParty))
			{
				string sThisPC = GetName(oPCInParty);
				if(GetStringLength(sThisPC) > 15)
					sThisPC = GetStringLeft(sThisPC, 15);	
				int nVar = GetLocalInt(GetModule(), sThisPC+"SSIL_WORK");
				if(nVar == 3)
				/* The work Ssil has given is already in progress. */
					return TRUE;
				oPCInParty = GetNextFactionMember(oPC, TRUE);
			}
		}
		else if(nCheck == 4)
		/* Check 4 checks if the work is unrewarded. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 4)
			/* The work Ssil has given is complete and unrewarded. */
				return TRUE;	
		}
		else if(nCheck == 5)
		/* Check 4 checks if the work is complete. */
		{
			int nVar = GetLocalInt(GetModule(), sPC+"SSIL_WORK");
			if(nVar == 5)
			/* The work Ssil has given is complete. */
				return TRUE;		
		}
	}
	else if(sChain == "member")
	{
		object oItem = GetFirstItemInInventory(oPC);
		while(GetIsObjectValid(oItem))
		{
			if(GetStringLeft(GetTag(oItem), 12) == "010_sel_room")
				return TRUE;
			else if(GetTag(oItem) == "010_sel_hghprsts")
				return TRUE;
			oItem = GetNextItemInInventory(oPC);
		}
	}
	else if(sChain == "Evil")
	{
		if(GetLocalInt(GetModule(), sPC+"SSIL_EVIL"))
			return TRUE;
	}
	else if(sChain == "minrep")
	{
		int nRep = ACR_RetrieveQuestState("sel_reputation", oPC);
		if(nRep > 899) return FALSE; // These are the bad reputations resulting from betrayal or quest failure
		else if(nRep >= nCheck) return TRUE;
	}
	else if(sChain == "exped")
	{
		if(GetLocalInt(GetArea(OBJECT_SELF), "EXPED"+IntToString(nCheck)))
			return TRUE;
		return FALSE;
	}
	else if(sChain == "bloodmaw_3_ship")
	{
		object oAlly = GetFirstFactionMember(oPC, TRUE);
		while(GetIsObjectValid(oAlly))
		{
			int nQuest = ACR_RetrieveQuestState("sel_bloodmaw_3", oAlly);
			if(nQuest == 9) return TRUE;
			else if(nQuest > 5 && nQuest < 10 && nCheck == 1) return TRUE;
			oAlly = GetNextFactionMember(oPC, TRUE);
		}
	}
	return FALSE;
}
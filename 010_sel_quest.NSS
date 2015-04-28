#include "acr_quest_i"

int GoldToXP(int nGold, object oPC)
{
	int nHD = GetHitDice(oPC);
	int nXP = nGold;
	if(nHD < 9)
	/* 1.25 gold/xp */
		nXP = (nXP*4)/5;
	else if(nHD < 13)
	/* 2.5 gold/xp */
		nXP = (nXP*2)/5;
	else if(nHD < 17)
	/* 5 gold/xp */
		nXP = nXP/5;
	else
	/* 10 gold/xp */
		nXP = nXP/10;
	return nXP;
}

void main(string sQuest, int nAct)
{
	object oPC = GetPCSpeaker();
	string sPC = GetName(oPC);
	if(GetStringLength(sPC) > 15)
		sPC = GetStringLeft(sPC, 15);
	if(sQuest == "ssil")
	{
		if(nAct == 1)
		/* Failed a quest that Ssil has given. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 1);
		else if(nAct == 2)
		/* Ssil has learned that the PC is evil. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 2);
		else if(nAct == 3)
		/* Ssil has given the PC quest #1. */
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 3);
		else if(nAct == 4)
		{
		/* Quest #1 from Ssil is complete, but the PC has not been paid. */
			object oPCInParty = GetFirstFactionMember(oPC, TRUE);
			while(GetIsObjectValid(oPCInParty))
			{
				string sThisPC = GetName(oPCInParty);
				if(GetStringLength(sThisPC) > 15)
					sThisPC = GetStringLeft(sThisPC, 15);
				int currentState = GetLocalInt(GetModule(), sThisPC+"SSIL_WORK");
				if(currentState == 1 || currentState == 3)
					SetLocalInt(GetModule(), sThisPC+"SSIL_WORK", 4);
				oPCInParty = GetNextFactionMember(oPC, TRUE);
			}
		}
		else if(nAct == 5)
		/* Quest #1 from Ssil is complete, and the PC is getting paid. */
		{
			SetLocalInt(GetModule(), sPC+"SSIL_WORK", 5);
			int nGold = 5;
			int nXP = GoldToXP(5, oPC);
			ACR_AwardStaticQuestXP(oPC, "010_sel_ssildiplo", nXP);
			GiveGoldToCreature(oPC, nGold, TRUE);
		}
	}
	else if(sQuest == "Evil")
	{
		/* This action simply marks the PC as having been subjected to a detect evil */
		SetLocalInt(GetModule(), sPC+"SSIL_EVIL", 1);
	}
	else if(sQuest == "rep")
	{
		int nRep = ACR_RetrieveQuestState("sel_reputation", oPC);
		if(nRep < nAct) nRep++;
		else if(nRep == 900) nRep = 0;
		ACR_AddPersistentJournalQuestEntry("sel_reputation", nRep, oPC, FALSE, FALSE, FALSE, 0, 0.0f);
	}
	else if(sQuest == "expedstart")
	{
		if(!GetLocalInt(GetArea(OBJECT_SELF), "EXPED"+IntToString(nAct)))
		{
			string tileSet = "sunken";
			string spawnType = "rats";
			switch(d3(1))
				case 1: spawnType = "bugs";
				case 2: spawnType = "undead";
				default: spawnType = "rats";
			CreateRandomDungeon("EXPED"+IntToString(nAct), tileSet, nAct);
			AssignSpawnTableToDungeon("EXPED"+IntToString(nAct), spawnType);
			AssignTrapTableToDungeon("EXPED"+IntToString(nAct), "physical");
			AssignQuestToDungeon("EXPED"+IntToString(nAct), "sel_exped"+IntToString(nAct));
			SetLocalInt(GetArea(OBJECT_SELF), "EXPED"+IntToString(nAct), 1);
		}
		SendCreatureToDungeon(GetPCSpeaker(), "EXPED"+IntToString(nAct));
	}
	else if(sQuest == "expedend")
	{
		int bDispose = TRUE;
		object oPC = GetFirstPC(FALSE);
		while(GetIsObjectValid(oPC))
		{
			if(GetLocalString(GetArea(oPC), "DUNGEON_NAME") == "EXPED"+IntToString(nAct))
			{
				bDispose = FALSE;
			}
			oPC = GetNextPC(FALSE);
		}
		if(bDispose)
		{
			DisposeDungeon("EXPED"+IntToString(nAct));
			DeleteLocalInt(GetArea(OBJECT_SELF), "EXPED"+IntToString(nAct));
		}
	}
}
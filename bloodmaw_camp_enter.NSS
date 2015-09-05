#include "acr_quest_i"
#include "acr_notifications_i"
#include "acr_skills_i"

const string campWP = "SEL_BLOODMAW_4_CAMP_0";
const string WestSpawn = "SEL_BLOODMAW_4_CAMP_1";
const string NorthWestSpawn = "SEL_BLOODMAW_4_CAMP_2";
const string NorthEastSpawn = "SEL_BLOODMAW_4_CAMP_3";
const string EastSpawn = "SEL_BLOODMAW_4_CAMP_4";

void SpawnBoss();

void RegularWolves();

void FinishCamp();

void _runToWP(object oRunner, object oTarget)
{
	if(!GetIsObjectValid(oRunner)) return;
	if(GetIsDead(oRunner)) return;
	if(GetCurrentAction(oRunner) == ACTION_INVALID)
	{
		AssignCommand(oRunner, ActionMoveToObject(oTarget, TRUE, 1.0f));
	}
	DelayCommand(6.0f, _runToWP(oRunner, oTarget));
}

void _regularWolves(object spawnPoint)
{
	object oWolf1 = CreateObject(OBJECT_TYPE_CREATURE, "abr_werewolf", GetLocation(spawnPoint), TRUE);
	object oWolf2 = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_an_wolf", GetLocation(spawnPoint), TRUE);
	object oWolf3 = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_an_wolf", GetLocation(spawnPoint), TRUE);
	object oRunWP = GetWaypointByTag(campWP);
	_runToWP(oWolf1, oRunWP);
	_runToWP(oWolf2, oRunWP);
	_runToWP(oWolf3, oRunWP);
}

void _boss(object spawnPoint, object oPC)
{
	object oWolf = CreateObject(OBJECT_TYPE_CREATURE, "abr_werewolf_5", GetLocation(spawnPoint), TRUE);
    SetLocalString(oWolf, ACR_QST_NAME, "sel_bloodmaw_4");
    SetLocalInt(oWolf, ACR_QST_UPPER_STATE, 9);
	SetLocalInt(oWolf, ACR_QST_PARTY, 1);
	SetLocalInt(oWolf, ACR_QST_BACKUPSTATE, 8);
	SetLocalObject(oWolf, ACR_QST_PC, oPC);	
	object oRunWP = GetWaypointByTag(campWP);
	_runToWP(oWolf, oRunWP);
}

void SpawnBoss()
{
	string direction;
	object spawnPoint;
	object spawnPC;
	switch(d4(1))
	{
		case 1:
			direction = "west";
			spawnPoint = GetWaypointByTag(WestSpawn);
			break;
		case 2:
			direction = "northwest";
			spawnPoint = GetWaypointByTag(NorthWestSpawn);
			break;
		case 3:
			direction = "northeast";
			spawnPoint = GetWaypointByTag(NorthEastSpawn);
			break;
		default:
			direction = "east";
			spawnPoint = GetWaypointByTag(EastSpawn);
			break;
	}
		
	object oPC = GetFirstPC(1);
	while(GetIsObjectValid(oPC))
	{
		if(GetArea(oPC) == OBJECT_SELF)
		{
			if(ACR_SkillCheck(SKILL_LISTEN, oPC, 15))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_WARNING, "Threat coming from the "+direction+".", "You hear the sounds of great beasts scrambling through the brush. You believe they will approach your camp from the "+direction+".", "", "", "", "OK", "");
			}
			spawnPC = oPC;
		}
		oPC = GetNextPC();
	}
	DelayCommand(60.0f, _boss(spawnPoint, spawnPC));
}


void RegularWolves()
{
	string direction;
	object spawnPoint;
	switch(d4(1))
	{
		case 1:
			direction = "west";
			spawnPoint = GetWaypointByTag(WestSpawn);
			break;
		case 2:
			direction = "northwest";
			spawnPoint = GetWaypointByTag(NorthWestSpawn);
			break;
		case 3:
			direction = "northeast";
			spawnPoint = GetWaypointByTag(NorthEastSpawn);
			break;
		default:
			direction = "east";
			spawnPoint = GetWaypointByTag(EastSpawn);
			break;
	}
		
	object oPC = GetFirstPC(1);
	while(GetIsObjectValid(oPC))
	{
		if(GetArea(oPC) == OBJECT_SELF)
		{
			if(ACR_SkillCheck(SKILL_LISTEN, oPC, 15))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_WARNING, "Threat coming from the "+direction+".", "You hear the sounds of great beasts scrambling through the brush. You believe they will approach your camp from the "+direction+".", "", "", "", "OK", "");
			}
		}
		oPC = GetNextPC();
	}
	DelayCommand(60.0f, _regularWolves(spawnPoint));
}

void FinishCamp()
{
	object oPC = GetFirstPC(TRUE);
	while(GetIsObjectValid(oPC))
	{
		if(GetArea(oPC) == OBJECT_SELF)
		{
			int nState = ACR_RetrieveQuestState("sel_bloodmaw_4", oPC);
			if(nState == 4)
			{
				ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_4", 5, oPC, 0, 0, 0, 50, 5.0f);
			}
			else if(nState == 5)
			{
				ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_4", 6, oPC, 0, 0, 0, 50, 5.0f);
			}
			else if(nState == 6)
			{
				ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_4", 7, oPC, 0, 0, 0, 50, 5.0f);
			}
			else if(nState == 7)
			{
				ACR_AddPersistentJournalQuestEntry("sel_bloodmaw_4", 8, oPC, 0, 0, 0, 50, 5.0f);
			}
		}
		oPC = GetNextPC(TRUE);
	}
	DeleteLocalInt(OBJECT_SELF, "SPAWN_STARTED");
}

void _delayMain(object oPC)
{
	if(!GetLocalInt(OBJECT_SELF, "SPAWN_STARTED"))
	{
		int nQuestState = ACR_RetrieveQuestState("sel_bloodmaw_4", oPC);
		SendMessageToPC(oPC, IntToString(nQuestState));
		SendMessageToPC(oPC, GetName(oPC));
		if(nQuestState > 3 && nQuestState < 8)
		{
			// regular camp
			float currentDelay = d10(1) * 60.0f;
			DelayCommand(currentDelay, RegularWolves());
			currentDelay += 60.0f + (d10(1) * 60.0f);
			DelayCommand(currentDelay, RegularWolves());
			currentDelay += 60.0f + (d10(1) * 60.0f);
			if(currentDelay < 29.0f * 60.0f) DelayCommand(currentDelay, RegularWolves());
			currentDelay += 60.0f + (d10(1) * 60.0f);
			if(currentDelay < 29.0f * 60.0f) DelayCommand(currentDelay, RegularWolves());
			currentDelay += 60.0f + (d10(1) * 60.0f);
			if(currentDelay < 29.0f * 60.0f) DelayCommand(currentDelay, RegularWolves());
			DelayCommand(30.0f * 60.0f, FinishCamp());
			SetLocalInt(OBJECT_SELF, "SPAWN_STARTED", 1);
		}
		else if(nQuestState == 8)
		{
			// boss camp
			DelayCommand(30.0f * 60.0f, SpawnBoss());
			SetLocalInt(OBJECT_SELF, "SPAWN_STARTED", 1);
		}
	}
}


void main()
{
	object oPC = GetEnteringObject();
	DelayCommand(0.0f, _delayMain(oPC));
	ExecuteScript("acf_area_onenter", OBJECT_SELF);
}
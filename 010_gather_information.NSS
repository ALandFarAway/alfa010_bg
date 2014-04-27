#include "acr_quest_i"
#include "acr_notifications_i"
#include "acr_skills_i"
#include "acr_i"

void main()
{
	object oPC = GetEnteringObject();
	if(!GetIsPC(oPC)) return;
	string sLocale = GetLocalString(OBJECT_SELF, "GI_REGION");
	int nID = GetLocalInt(oPC, "ACR_CID");
	if(sLocale == "BG_CITY")
	{
		int nIntro = ACR_RetrieveQuestState("010_intro", oPC);
		if(nIntro == 1)
		{
			// If this PC hasn't yet been told about BG city, give them a blurb.
			if(!GetLocalInt(oPC, "GI_BG_CITY"))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nBaldur's Gate.", 
							"Baldur's Gate is a wealthy city state on the Chionthar river, focused on trade. It is ruled by a council of four dukes: Eltan, Belt, Jannath, and Silvershield. Each having significant power and position in their own right, though Eltan is often most prominent for his leadership of the Flaming Fist, which is the power behind many of the city's military expeditions.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
				SetLocalInt(oPC, "GI_BG_CITY", 1);
			}
			
			// If we've already passed this trigger for this quest, give this a miss.
			if(GetLocalInt(OBJECT_SELF, IntToString(nID) + "_1")) return;
			
			// Otherwise, roll GI and flag this trigger to not repeat for this PC.
			if(ACR_SkillCheck(SKILL_GATHER_INFORMATION, oPC, 15, TRUE, FALSE))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"You catch word of where Beryl is.", 
							"A man with Beryl's description has been seen in the Elfsong tavern, which is a bar just east of the market square, a short walk in from the city's western gate.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
			}
			SetLocalInt(OBJECT_SELF, IntToString(nID) + "_1", 1);
		}
		else if(nIntro == 2)
		{
			// If we've already passed this trigger for this quest, give this a miss.
			if(GetLocalInt(OBJECT_SELF, IntToString(nID) + "_2")) return;
			
			// Otherwise, roll GI and flag this trigger to not repeat for this PC.
			if(ACR_SkillCheck(SKILL_GATHER_INFORMATION, oPC, 15, TRUE, FALSE))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"You catch word of where Ginny is.", 
							"A woman like the one Beryl described has been seen heading to the guard post, which is a good walk west of the Elfsong, near the temple of Umberlee.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
			}
			SetLocalInt(OBJECT_SELF, IntToString(nID) + "_2", 1);		
		}
	}
}
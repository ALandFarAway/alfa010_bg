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
							"A man with Beryl's description has been seen in the Elfsong tavern, which is a bar just east of the market square, a short walk in from the city's eastern gate.", 
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
		else if(nIntro == 200 || nIntro == 400 || nIntro == 500)
		{
			if(GetLocalInt(OBJECT_SELF, IntToString(nID) + "_200")) return;
			
			if(ACR_SkillCheck(SKILL_GATHER_INFORMATION, oPC, 15, TRUE, FALSE))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nWork may be available.", 
							"It sounds from chatter on the streets like Beryl, who you recall from his abuse of his partner and her conversation at the watch post, has been captured and the city is hoping to bring in more help moving him back to the city.\n\nDetails would be available at the Baldur's Gate watch post.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
			}
			SetLocalInt(OBJECT_SELF, IntToString(nID) + "_200", 1);
		}
		else if(nIntro == 100 || nIntro == 300)
		{
			if(GetLocalInt(OBJECT_SELF, IntToString(nID) + "_100")) return;
			
			if(ACR_SkillCheck(SKILL_GATHER_INFORMATION, oPC, 15, TRUE, FALSE))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nWork may be available.", 
							"It sounds from chatter on the streets like there is some fuss about the capture of a young man in Ulgoth's Beard, and there might be some work had in response. Near as you can tell, there would be someone to ask outside the eastern gate, near the river.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
			}
			SetLocalInt(OBJECT_SELF, IntToString(nID) + "_100", 1);
		}
		else if(nIntro == 104 || nIntro == 204 || nIntro == 304 || nIntro == 404 || nIntro == 504)
		{
			if(GetLocalInt(OBJECT_SELF, IntToString(nID) + "_104")) return;
			
			if(ACR_SkillCheck(SKILL_GATHER_INFORMATION, oPC, 15, TRUE, FALSE))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nSomeone is looking for you.", 
							"You catch word that there was a man looking for someone with your description. The last anyone saw him, he was heading into the post office near the city's eastern gate.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
			}
			SetLocalInt(OBJECT_SELF, IntToString(nID) + "_104", 1);
		}
	}
	else if(sLocale == "ULGOTH")
	{
		int nIntro = ACR_RetrieveQuestState("010_intro", oPC);
		if(nIntro == 101 || nIntro == 201 || nIntro == 301 || nIntro == 401 || nIntro == 501)
		{
						// If this PC hasn't yet been told about BG city, give them a blurb.
			if(!GetLocalInt(oPC, "GI_ULGOTH"))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nUlgoth's Beard.", 
							"Ulgoth's Beard is a settlement existing primarily to warn Baldur's Gate in the event of river pirates, who might seek to move up the Chionthar River and attack the valuable Baldurian port. It keeps a very small population and, in recent years, its management and protection has been assigned to a group of Banites calling themselves the Iron Gauntlet, though they are apparently unrelated to the Zhent order.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
				SetLocalInt(oPC, "GI_ULGOTH", 1);
			}
		}
	}
	else if(sLocale == "BEREGOST")
	{
		int nIntro = ACR_RetrieveQuestState("010_intro", oPC);
		if(nIntro == 105 || nIntro == 205 || nIntro == 305 || nIntro == 405 || nIntro == 505)
		{
						// If this PC hasn't yet been told about BG city, give them a blurb.
			if(!GetLocalInt(oPC, "GI_BEREGOST"))
			{
				NotifyPlayer(oPC, NOTIFY_TYPE_INFO, 
							"\nBeregost.", 
							"Beregost is a village on the Trade Way which centers on a large temple to the Morninglord, Lathander. The people are goodly and simple, lead primarily by their governor Kelddath Ormlyr, but the village has traditionally remained neutral to avoid being caught up in the frequent conflicts between Baldurian and Amnian interests.", 
							NOTIFY_WINDOW_MESSAGE_BOX,"","","OK");
				SetLocalInt(oPC, "GI_BEREGOST", 1);
			}
		}
	}
}
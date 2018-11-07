// place in OnEnter of a Trigger 
//works  11/2018  
#include "acr_quest_i"
#include "acr_placeable_i"
#include "acr_notifications_i"

void main()
{
	object oEnterer = GetEnteringObject();
	object oArea = GetArea(oEnterer); // only look for WP in the area oEnterer is in
	object oTarget = GetFirstObjectInArea(oArea);
	object oSpawn;
	int nInt;
	
	 //check that the entering creature is a PC or DM
    oEnterer = GetEnteringObject();
    if (GetIsPC(oEnterer) && !GetIsDM(oEnterer))
	return;

	// Check If the PC is at least at stage 1 of journal quest "qst_arsa_bloodwine_shrooms".
    //if ( GetLocalInt(oEnterer, "NW_JOURNAL_ENTRYbg_arsa_bloodwine_shrooms") == 1 )
	//int nInt;
   // nInt=GetLocalInt(oEnterer, "ACR_JOURNAL_ENTRYbg_arsa_bloodwine_shrooms");
     //if (nInt < 1)
		int nState = ACR_RetrieveQuestState("bg_arsa_bloodwine_shrooms", oEnterer);
		if(nState == 1)
	//	if(!GetLocalInt(GetArea(OBJECT_SELF), "bg_arsa_bloodwine_shrooms"))
      // nInt=GetLocalInt(oEnterer, "ACR_RetrieveQuestStatebg_arsa_bloodwine_shrooms");
      // if (nInt == 1)
    
    //return;
 // {
	 
 // if(!GetLocalInt(oEnterer, "bg_arsa_bloodwine_shrooms"))
  {
    // Send a message to the player's chat window.
    SendMessageToPC(oEnterer, "you enter a dark, dank cave");
}
	//spawn Mushrooms
	int n = GetLocalInt(OBJECT_SELF, "Done");

//	if (n != 0) return;
	//check that the entering creature is a PC or DM
	while (oTarget != OBJECT_INVALID)
	{	// Only look for objects that are Waypoints, if they are not, ignore and go on to the next object in the area
		if (GetObjectType(oTarget) == OBJECT_TYPE_WAYPOINT)
		{ // If we do find an object that is a Waypoint check the found wp tag
			if (GetTag(oTarget)== "wp_qst_arsa_bw_mush")
			{ // then create the placeable
				n++;
				oSpawn= CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_bw_mshrm", GetLocation(oTarget),FALSE, "placeable_" + IntToString(n));
				oTarget = GetNextObjectInArea(oArea); // we just added a new object at the top of the list, so let's move one rank down or we'll come back to the current oTarget!
			}
		}
		oTarget = GetNextObjectInArea(oArea); // whether it was the right object or not, we’re done with it. Let’s get to the next one
	}
  }
 //}

//}
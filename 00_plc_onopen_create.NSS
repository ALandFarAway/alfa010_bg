//Wynna July 2020


#include "acr_placeable_i"
#include "acr_xp_i"
#include "acr_quest_i"
#include "acr_spawn_i"




void main()
{
	ACR_PlaceableOnOpen();

	object oPC = GetLastOpenedBy();
	string sCreateType = GetLocalString(OBJECT_SELF, "OBJECT_TYPE_STRING");
	int nCreateType = OBJECT_TYPE_CREATURE;
	if(sCreateType == "Placeable")
		{nCreateType = OBJECT_TYPE_PLACEABLE;}
	if(sCreateType == "Item")
		{nCreateType = OBJECT_TYPE_ITEM;}
	string sCreate = GetLocalString(OBJECT_SELF, "RESREF_TO_CREATE");
	string sCreateLocation = GetLocalString(OBJECT_SELF, "LOCATION_WP_STRING");
	object oCreateLocation = GetNearestObjectByTag(sCreateLocation);
	location lCreateLocation = GetLocation(oCreateLocation);
	if(oCreateLocation == OBJECT_INVALID)
		{lCreateLocation = GetLocation(OBJECT_SELF);}
	
	string sMessage = GetLocalString(OBJECT_SELF, "CREATE_MESSAGE_STRING");
	string sBroadcast = GetLocalString(OBJECT_SELF, "CREATE_BROADCAST_STRING");
	int nDelay = GetLocalInt(OBJECT_SELF, "CREATE_DELAY_INT");
	float fDelay = IntToFloat(nDelay);
	int nPlayOnce = GetLocalInt(OBJECT_SELF, "PLAY_ONCE");
	int nNumberCreate = GetLocalInt(OBJECT_SELF, "CREATE_NUMBER");
	if (nNumberCreate == 0) {
		nNumberCreate = 1;
	}
	if(nPlayOnce == 1) {
			int a = 0;
			while(a < nNumberCreate) {
			object oCreate = CreateObject(nCreateType, sCreate, lCreateLocation, FALSE);
			a++;
			}
			SetLocalInt(OBJECT_SELF, "PLAY_ONCE", 2);
		}
		
	if(nPlayOnce == 0) {
		SendMessageToPC(oPC, sMessage);
		SetLocalInt(OBJECT_SELF, "PLAY_ONCE", 1);
		ActionSpeakString(sBroadcast, TALKVOLUME_TALK);
		DelayCommand(fDelay, ExecuteScript("00_plc_onopen_create", OBJECT_SELF));
		}
	
			
}
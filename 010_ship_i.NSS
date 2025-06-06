// Operates a ship trip.
// =======================================================================================
// startWP -- the waypoint representing the start of the trip
// endWP -- the waypoint representing the end of the trip
// tripLength -- the length of time, in minutes, that the trip should last
// =======================================================================================
// of note that the ship stays at the dock before the trip starts for two minutes. This is
// to allow full groups time to board. One of the main uses of a ship ride is to get to
// talk without all of those disruptive ATs.
// =======================================================================================

#include "acr_area_instance_i"

void CreateObjectNoReturn(int a, string b, location c, int d, string e)
{
	CreateObject(a,b,c,d,e);
}

void _AddDock(object oArea, object oStartWP, object oEndWP, int tripEnd=FALSE)
{
	object oPlac = GetFirstObjectInArea(oArea);
	if((FindSubString(GetStringLowerCase(GetTag(oEndWP)), "pirate") == -1 && tripEnd == TRUE) ||
	   (FindSubString(GetStringLowerCase(GetTag(oStartWP)), "pirate") == -1 && tripEnd == FALSE))
	{
		while(GetIsObjectValid(oPlac))
		{
			if(GetTag(oPlac) == "PLANK_POSITION")     DelayCommand(1.0f, CreateObjectNoReturn(OBJECT_TYPE_PLACEABLE, "plc_hss_plank_str", GetLocation(oPlac), TRUE, "TEMP"));
			else if(GetTag(oPlac) == "DOCK_POSITION") DelayCommand(1.0f, CreateObjectNoReturn(OBJECT_TYPE_PLACEABLE, "plc_bc_dockg8", GetLocation(oPlac), TRUE, "TEMP"));
			oPlac = GetNextObjectInArea(oArea);
		}
	}
	else
	{
		while(GetIsObjectValid(oPlac))
		{
			if(GetTag(oPlac) == "PLANK_POSITION")     DelayCommand(1.0f, CreateObjectNoReturn(OBJECT_TYPE_PLACEABLE, "plc_hss_plank_str", GetLocation(oPlac), TRUE, "TEMP"));
			else if(GetTag(oPlac) == "SHIP_POSITION") DelayCommand(1.0f, CreateObjectNoReturn(OBJECT_TYPE_PLACEABLE, "bc_shipwar1_t01", GetLocation(oPlac), TRUE, "TEMP"));
			oPlac = GetNextObjectInArea(oArea);
		}
	}
}

void _RemoveDock(object oArea)
{
	object oPlac = GetFirstObjectInArea(oArea);
	while(GetIsObjectValid(oPlac))
	{
		if(GetTag(oPlac) == "TEMP") DestroyObject(oPlac, 0.0f);
		oPlac = GetNextObjectInArea(oArea);
	}
}

void GarbageCollection(object oShip, object oStartWP, object oEndWP)
{
	int notEmpty = 0;
	object oPC = GetFirstObjectInArea(oShip);
	while(GetIsObjectValid(oPC))
	{
		if(GetIsPC(oPC))
		{
			if(FindSubString(GetStringLowerCase(GetTag(oEndWP)), "pirate") > -1)
			{
				SendMessageToPC(oPC, "The ship is being attacked! Pass through the area transition to resolve the fight.");
			}
			else
			{
				SendMessageToPC(oPC, "The ship remains at the dock, and the sailors stop by on occasion, letting you know that it's time to get out.");
			}
			notEmpty++;
		}
		oPC = GetNextObjectInArea(oShip);
	}
	if(notEmpty) 
	{
		DelayCommand(60.0f, GarbageCollection(oShip, oStartWP, oEndWP));
		return;
	}
	int count = 0;
	object oArea = GetLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count));
	while(GetIsObjectValid(oArea))
	{
		if(oArea == oShip)
		{
			DeleteLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count));
		}
		count++;
		oArea = GetLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count));
	}
	ACR_ReleaseAreaInstance(oShip);
}

void StartShipTrip(object oShip)
{
	object oPC = GetFirstObjectInArea(oShip);
	while(GetIsObjectValid(oPC))
	{
		if(GetIsPC(oPC)) SendMessageToPC(oPC, "The ship pulls away, and you are now traveling to your destination.");
		oPC = GetNextObjectInArea(oShip);
	}
	DeleteLocalObject(oShip, "EXIT_WP");
	_RemoveDock(oShip);
}

void EndShipTrip(object oShip, object oStart, object oDest)
{
	object oPC = GetFirstObjectInArea(oShip);
	if(FindSubString(GetStringLowerCase(GetTag(oDest)), "pirate") > -1)
	{
		while(GetIsObjectValid(oPC))
		{
			if(GetIsPC(oPC)) SendMessageToPC(oPC, "A thinner, faster ship rapidly begins to gain on yours, and soon after has thrown a volley of grapples on-- it seems that pirates wish to have your ship!");
			oPC = GetNextObjectInArea(oShip);
		}
	}
	else
	{
		while(GetIsObjectValid(oPC))
		{
			if(GetIsPC(oPC)) SendMessageToPC(oPC, "The ship sails comfortably to the new dock, and you may now leave the ship.");
			oPC = GetNextObjectInArea(oShip);
		}	
	}	
	SetLocalObject(oShip, "EXIT_WP", oDest);
	DelayCommand(60.0f, GarbageCollection(oShip, oStart, oDest));
	_AddDock(oShip, oStart, oDest);
}

object GetShipTemplate(object oPC)
{
	if(GetIsObjectValid(GetLocalObject(GetModule(), "SHIP_TEMPLATE"))) return GetLocalObject(GetModule(), "SHIP_TEMPLATE");
	
	object oShipWP = GetWaypointByTag("WP_SHIP_ENTER");
	object oTemplateArea = GetArea(oShipWP);
	if(GetIsObjectValid(oTemplateArea))
	{
		return oTemplateArea;
	}
	else
	{
		SendMessageToPC(oPC, "Error: Could not find the ship's template area.");
		return OBJECT_INVALID;
	}
}
object GetShip(object oStartWP, object oEndWP, object oPC, float tripLength)
{
	int count = 0;
	object oArea = GetLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count));
	while(GetIsObjectValid(oArea))
	{
		if(GetLocalObject(oArea, "EXIT_WP") == oStartWP)
		{
			return oArea;
		}
		count++;
		oArea = GetLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count));
	}
	oArea = GetShipTemplate(oPC);
	if(!GetIsObjectValid(oArea)) return OBJECT_INVALID;
	oArea = ACR_CreateAreaInstance(oArea);
	SetLocalObject(OBJECT_SELF, ObjectToString(oStartWP) + "_" + ObjectToString(oEndWP) + "_" + IntToString(count), oArea);
	SetLocalObject(oArea, "EXIT_WP", oStartWP);
	_AddDock(oArea, oStartWP, oEndWP, TRUE);
	DelayCommand(2.0f * 60.0f, StartShipTrip(oArea));
	DelayCommand((2.0f + tripLength) * 60.0f, EndShipTrip(oArea, oStartWP, oEndWP));
	return oArea;
}

object GetShipWaypoint(object oShip, object oPC)
{
	object oWP = GetFirstObjectInArea(oShip);
	while(GetIsObjectValid(oWP))
	{
		if(GetTag(oWP) == "WP_SHIP_ENTER") return oWP;
		oWP = GetNextObjectInArea(oShip);
	}
	SendMessageToPC(oPC, "Error: could not find ship's entry waypoint");
	return OBJECT_INVALID;
}

void ManageShip(string startWP, string endWP, object oPC, float tripLength)
{
	object oStartWP = GetWaypointByTag(startWP);
	object oEndWP = GetWaypointByTag(endWP);
	object oShip = GetShip(oStartWP, oEndWP, oPC, tripLength);
	if(!GetIsObjectValid(oShip)) return;
	object oWP = GetShipWaypoint(oShip, oPC);
	if(!GetIsObjectValid(oWP)) return;
	AssignCommand(oPC, JumpToObject(oWP));
}
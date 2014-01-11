void main()
{
	int nObject = GetObjectType(OBJECT_SELF);
	object oUser = GetEnteringObject();
//=== They might be coming out of the area. Check that. ===//
//===== We're on the dynamic side. =====//	
	if(nObject == OBJECT_TYPE_AREA_OF_EFFECT)
	{
		if(GetLocalInt(oUser, "secs_at") == 0)
		{			
			string sTag = GetStringLeft(GetTag(OBJECT_SELF), 9)+"INT";
			object oTarget = GetWaypointByTag(sTag);
			location lLoc = GetLocation(oTarget);
			AssignCommand(oUser, JumpToLocation(lLoc));				
		}
	}
//===== Must be a door; working from that. =====//	
	else
	{
		SetLocalInt(oUser, "secs_at", 1);		
		string sTag = GetStringLeft(GetTag(OBJECT_SELF), 9)+"EXT";
		object oTarget = GetObjectByTag(sTag);
		location lLoc = GetLocation(oTarget);
		AssignCommand(oUser, JumpToLocation(lLoc));	
	}
}
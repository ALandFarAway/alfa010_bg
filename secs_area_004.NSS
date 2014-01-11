void main()
{	
	CreateObject(OBJECT_TYPE_PLACEABLE, "secs_004_ext", GetLocation(OBJECT_SELF), FALSE);
//	CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetLocation(OBJECT_SELF), FALSE, "secs_001_EXT");
	effect eEffect = SupernaturalEffect(EffectAreaOfEffect(AOE_PER_INVIS_SPHERE, "secs_area_transition", "****", "secs_post_transition", "secs_004_EXT"));
	float fFace = GetFacing(OBJECT_SELF);
	vector vPosition = GetPosition(OBJECT_SELF);
	fFace += 125.0f;
	float fYdiff = 6.403 * sin(fFace);
	float fXdiff = 6.403 * cos(fFace);
	float fX = vPosition.x + fXdiff;
	float fY = vPosition.y + fYdiff;
	float fZ = vPosition.z;
	location lAoE = Location(GetArea(OBJECT_SELF), Vector(fX, fY, fZ), fFace);
	ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEffect, lAoE);	
}
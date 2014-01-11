void main()
{	
	CreateObject(OBJECT_TYPE_PLACEABLE, "secs_002_ext", GetLocation(OBJECT_SELF), FALSE);
//	CreateObject(OBJECT_TYPE_WAYPOINT, "nw_waypoint001", GetLocation(OBJECT_SELF), FALSE, "secs_001_EXT");
	effect eEffect = SupernaturalEffect(EffectAreaOfEffect(AOE_PER_INVIS_SPHERE, "secs_area_transition", "****", "secs_post_transition", "secs_002_EXT"));
	ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, eEffect, GetLocation(OBJECT_SELF));	
}
void main()
{
object oPC=GetLastUsedBy();
ApplyEffectAtLocation(0,EffectVisualEffect(33),GetLocation(oPC));
DelayCommand(0.5,AssignCommand(oPC,ActionJumpToObject(GetWaypointByTag("WP_PORTAL_UDA5_C"))));
}
void main()
{
    object oPC, oDestinationWaypoint;
    string sClimbTopWP= GetLocalString(
        OBJECT_SELF,
        "climb_top_wp"
    );  // Tag of waypoint that represents the top

    oPC = GetPCSpeaker();
    oDestinationWaypoint = GetWaypointByTag(sClimbTopWP);

    DelayCommand(
        1.0,
        AssignCommand(
            oPC,
            ActionJumpToObject(oDestinationWaypoint)
        )
    );
}

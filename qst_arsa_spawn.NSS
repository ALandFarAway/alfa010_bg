// Put this script OnEnter.


void main()
{
    object oTarget;
    object oSpawn;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Spawn "qst_arsa_bw_mush".
    oTarget = GetWaypointByTag("qst_arsa_bw_mush");
    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "qst_arsa_bw_mushroom", GetLocation(oTarget));
}

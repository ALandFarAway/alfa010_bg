// Put this script OnEnter.

#include "acr_trigger_i"

const string SKILL_VAR = "nSkill";
const string SKILL_DC_VAR = "nDC";
const string RESREF_VAR = "sResRef";
const string WP_TAG_VAR = "sWayPointTag";

void main()
{
ACR_TriggerOnEnter();

    object oTarget;
    object oSpawn;

    // Get the creature who triggered this event.
    object oPC = GetEnteringObject();

    // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
        return;

    // Abort if a skill check (spot) is failed.
    if ( d20() + GetSkillRank(GetLocalInt(OBJECT_SELF,SKILL_VAR), oPC) < GetLocalInt(OBJECT_SELF,SKILL_DC_VAR) )
        return;

    // Spawn "secret door".
    oTarget = GetWaypointByTag(GetLocalString(OBJECT_SELF,WP_TAG_VAR));
    oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE,GetLocalString(OBJECT_SELF,RESREF_VAR), GetLocation(oTarget));
}
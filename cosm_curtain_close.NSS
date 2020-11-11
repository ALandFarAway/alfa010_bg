//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("cosm_curtain1");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "trdwy_reflection_rm_curtain1", lTarget);

oTarget = GetWaypointByTag("cosm_curtain2");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "trdwy_reflection_rm_curtain2", lTarget);

}

/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnOpen
void main()
{

object oPC = GetLastOpenedBy();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(OBJECT_SELF, GetTag(OBJECT_SELF), TRUE);

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("hallambush1");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "decrepitskeleton", lTarget);

oTarget = GetWaypointByTag("hallambush2");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "decrepitskeleton", lTarget);

oTarget = GetWaypointByTag("undeadhorror3");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "undeadhorror1", lTarget);

AssignCommand(GetObjectByTag("undeadhorror1"), ActionSpeakString("Slay the intruders!  Suffer not the living!"));

oTarget = GetObjectByTag("undeadhorror1");

AssignCommand(oTarget, ActionMoveToObject(GetObjectByTag("undeadhorror2")));

DelayCommand(5.0, DestroyObject(oTarget, 0.0));

}
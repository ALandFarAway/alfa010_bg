
//Put this on action taken in the conversation editor
#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("wp_cc2a_minotaur80");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "009_cr_mhg_minotaur80", lTarget);

oTarget = oSpawn;

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

AssignCommand(oTarget, DetermineCombatRound(oPC));

}
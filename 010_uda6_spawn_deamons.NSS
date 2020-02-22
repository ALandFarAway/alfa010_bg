//this script is applied to the  010_cn_uda6  dlg

//Put this on action taken in the conversation editor

#include "nw_i0_generic"
void main()
{

object oPC = GetPCSpeaker();

AddJournalQuestEntry("tt_uda6_dwarventomb", 3, oPC, TRUE, FALSE);

object oTarget;
object oTarget2;

object oSpawn;
object oSpawn2;

location lTarget;
location lTarget2;

oTarget = GetWaypointByTag("wp_deamon_spawn");
oTarget2 = GetWaypointByTag("wp_deamon_spawn2");

lTarget = GetLocation(oTarget);
lTarget2 = GetLocation(oTarget2);
oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_ou_demon_babau", lTarget);
oSpawn2 = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_ou_tanarri_tanarukk", lTarget2);
oTarget = oSpawn;
oTarget2 = oSpawn2;

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

AssignCommand(oTarget, DetermineCombatRound(oPC));

//Visual effects can't be applied to waypoints, so if it is a WP
//the VFX will be applied to the WP's location instead

int nInt;
nInt = GetObjectType(oTarget);

if (nInt != OBJECT_TYPE_WAYPOINT) DelayCommand(0.5, ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DEMON_HAND), oTarget));
else DelayCommand(0.5, ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_DEMON_HAND), GetLocation(oTarget)));

}
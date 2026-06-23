//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYgullykin_gobband_1");

if (nInt < 1)
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYgullykin_gobband_1");

if (nInt >= 12)
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("wp_gullykin_gob1");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_melee_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob2");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_gob_ftr_2_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob3");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob4");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_melee_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob5");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_gob_ftr_2_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob6");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob7");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_melee_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob8");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_gob_ftr_2_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob9");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob10");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_melee_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob11");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_gob_ftr_2_qst1", lTarget);

oTarget = GetWaypointByTag("wp_gullykin_gob12");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_hu_goblin_qst1", lTarget);

}

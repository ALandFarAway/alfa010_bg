//Put this script OnEnter


void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYqst_bg_missing_ore");

if (nInt < 2)
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYqst_bg_missing_ore");

if (nInt >= 3)
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("wp_qst_ore_crate1");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "box_bg_qst_ore", lTarget);

object oTarget2;
object oSpawn2;
location lTarget2;

oTarget2 = GetWaypointByTag("wp_qst_ore_crate2");

lTarget2 = GetLocation(oTarget2);

oSpawn2 = CreateObject(OBJECT_TYPE_PLACEABLE, "box_bg_qst_goods", lTarget2);

}





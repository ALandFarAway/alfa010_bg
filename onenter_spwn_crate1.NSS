//Put this script OnEnter


void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYbg_qst_wood_arrows");

if (nInt < 1)
   return;

nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYbg_qst_wood_arrows");

if (nInt >= 2)
   return;

object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("wp_crate_arrows");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "box_bg_qst_wood_arrows", lTarget);

}


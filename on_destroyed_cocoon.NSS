/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

For download info, please visit:
http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnDeath
#include  "acr_quest_i"
void main()
{

object oPC = GetLastKiller();

while (GetIsObjectValid(GetMaster(oPC)))
   {
   oPC=GetMaster(oPC);
   }

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYnkl_ret_2_froze_fiasco");

if (nInt !=7);
SendMessageToPC(oPC, "This is empty");

   return; 


object oTarget;
object oSpawn;
location lTarget;
oTarget = GetWaypointByTag("sm_spider_snow");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_CREATURE, "abr_cr_vm_spider_sm_snow", lTarget);

oTarget = oSpawn;

SetIsTemporaryEnemy(oPC, oTarget);

AssignCommand(oTarget, ActionAttack(oPC));

AssignCommand(oTarget, DetermineCombatRound(oPC));

oTarget = GetWaypointByTag("wp_qst_corpse_rt2");

lTarget = GetLocation(oTarget);

oSpawn = CreateObject(OBJECT_TYPE_PLACEABLE, "qst_corpse_rt2_nklpass03", lTarget);

}
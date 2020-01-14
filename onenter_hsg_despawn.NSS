
//For download info, please visit:
//http://nwvault.ign.com/View.php?view=Other.Detail&id=4683&id=625    */

//Put this script OnEnter
void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYhighsong_ankheg_woes");

if (nInt != 1)
   return;

object oTarget;
oTarget = GetObjectByTag("010_cr_hu_hhsg_corvas");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("010_cr_hin_highsong_slovas");

DestroyObject(oTarget, 0.0);

}

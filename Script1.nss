
//Put this script OnClose
#include "acr_tools_i"
void main()
{

object oPC = GetLastClosedBy();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYBG_tg_OL_challenge1");

if (nInt < 1)
   return;

   GiveXP(OPC)(10, oPC, FALSE));

}
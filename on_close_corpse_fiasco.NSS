//on_close_corpse_fiasco   

//Put this script OnClose

#include "acr_placeable_i"
#include "acr_quest_i"

void main()
{
 ACR_PlaceableOnClose();
 
 
object oPC = GetLastClosedBy();


if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "NW_JOURNAL_ENTRYnkl_ret_2_froze_fiasco");

if (nInt < 7)
   return;

//AddPersistentJournalQuestEntry(oPC, "nkl_ret_2_froze_fiasco", "8");
AddJournalQuestEntry("nkl_ret_2_froze_fiasco",8,oPC,1,0,0);

SendMessageToPC(oPC, "*This looks like the stolen necklace described by the captain*");

}
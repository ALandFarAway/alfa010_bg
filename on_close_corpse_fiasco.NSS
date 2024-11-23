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
//GetJournalEntry("nkl_ret_2_froze_fiasco",8);
if (nInt <= 7);
else if (nInt = 9)
   return;


ACR_AddPersistentJournalQuestEntry("nkl_ret_2_froze_fiasco",8,oPC,1,0,0,10,0.3f);

SendMessageToPC(oPC, "*This looks like the stolen necklace described by the captain*");

//DestroyObject(OBJECT_SELF);
DelayCommand(1800.0, DestroyObject(OBJECT_SELF, 0.0)); //30 min
}
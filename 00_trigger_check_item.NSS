// returns the OwnedPC object of oCreature
//    - oCreature must be PC-faction;
//        else, returns OBJECT_INVALID
/*  (string) sCategoryTag = "sQuestName";
    (string) sItem = "sItemTag";
    (int)    nEntryID = 99;
^
The variables above control what item to check and what journal quest entry to add.
sCategoryTag : the plot identifier used in the toolset's Journal Editor
nEntryID : the state of the plot as seen in the toolset's Journal Editor
sItem  : the tag of the item you want to check.(edited)[Place them in the variables of the 
trigger]*/
//Put this script in the OnEnter slot of the selected trigger

#include "acr_trigger_i"

object kL_GetRealPC(object oCreature = OBJECT_SELF);

//
void main()
{
    object oPC = GetEnteringObject();
    string sCategoryTag = "sQuestName";
    string sItem = "sItemTag";
    int nEntryID = 99;

    if (GetIsPC(oPC) && !GetIsDM(oPC) && GetJournalEntry(sCategoryTag, kL_GetRealPC(oPC)) > 0)
    {
        object oFM = GetFirstFactionMember(oPC, FALSE);
        while (GetIsObjectValid(oFM))
        {
            if (GetIsObjectValid(GetItemPossessedBy(oFM, sItem)))
            {
                AddJournalQuestEntry(sCategoryTag, nEntryID, kL_GetRealPC(oPC), FALSE, FALSE, FALSE);
                break;
            }
            oFM = GetNextFactionMember(oPC, FALSE);
        }
    }
}

// returns the Owned PC object of oCreature in SP
// or the Owned PC Faction Leader of oCreature in MP.
//    - oCreature must be PC-faction; else, returns OBJECT_INVALID
object kL_GetRealPC(object oCreature = OBJECT_SELF)
{
    object oMaster = GetMaster(oCreature);
    while (GetIsObjectValid(oMaster))
    {
        oCreature = oMaster;
        oMaster = GetMaster(oMaster);
    }

    if (GetIsOwnedByPlayer(oCreature))
    {
        return oCreature;
    }
    else if (GetIsRosterMember(oCreature))
    {
        oCreature = GetFactionLeader(oCreature);
        oCreature = GetOwnedCharacter(oCreature);

        return oCreature;
    }
    else
    {
        return OBJECT_INVALID;
    }
}
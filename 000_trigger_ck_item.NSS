


#include "acr_trigger_i"
#include "acr_quest_i"


object kL_GetRealPC(object oCreature = OBJECT_SELF);

//
void main()
{
    object oPC = GetEnteringObject();
    string sCategoryTag = "yoloquest";
    string sItem = "test_item_tag";
    int nEntryIDFrom = GetLocalInt(OBJECT_SELF, "from");
    int nEntryIDTo = GetLocalInt(OBJECT_SELF, "to");

    SendMessageToPC(oPC, "OnEnter");

    if (GetIsPC(oPC) && !GetIsDM(oPC) && GetJournalEntry(sCategoryTag, kL_GetRealPC(oPC)) == nEntryIDFrom)
    {
        object oFM = GetFirstFactionMember(oPC, FALSE);
        while (GetIsObjectValid(oFM))
        {
            if (GetIsObjectValid(GetItemPossessedBy(oFM, sItem)))
            {
                AddJournalQuestEntry(sCategoryTag, nEntryIDTo, kL_GetRealPC(oPC), FALSE, FALSE, FALSE);
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
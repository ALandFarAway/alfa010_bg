


#include "acr_trigger_i"
#include "acr_quest_i"


object kL_GetRealPC(object oCreature = OBJECT_SELF);

//
void main()
{
    object oPC = GetEnteringObject();
    string ACR_QST_NAME = "sQuestName";
    string sItem = "sItemTag";
    int ACR_QST_LOWER_STATE = GetLocalInt(OBJECT_SELF, "from");
    int ACR_QST_UPPER_STATE = GetLocalInt(OBJECT_SELF, "to");

    SendMessageToPC(oPC, "OnEnter");

    if (GetIsPC(oPC) && !GetIsDM(oPC) && GetJournalEntry(ACR_QST_NAME, kL_GetRealPC(oPC)) == ACR_QST_LOWER_STATE)
    {
        object oFM = GetFirstFactionMember(oPC, FALSE);
        while (GetIsObjectValid(oFM))
        {
            if (GetIsObjectValid(GetItemPossessedBy(oFM, sItem)))
            {
                ACR_AddPersistentJournalQuestEntry(ACR_QST_NAME, ACR_QST_UPPER_STATE, kL_GetRealPC(oPC), FALSE, FALSE, FALSE);
                break;
            }
            oFM = GetNextFactionMember(oPC, FALSE);
			SendMessageToPC(oPC, "Found Item");
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
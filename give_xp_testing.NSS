void main(int nXP, int bAllPartyMembers)
{
    object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());

    if ( bAllPartyMembers == 0 ) GiveXPToCreature(oPC, nXP );
    else
    {
        object oTarg = GetFirstFactionMember(oPC);
        while(GetIsObjectValid(oTarg))
        {
            GiveXPToCreature( oTarg,nXP );
            oTarg = GetNextFactionMember(oPC);
        }
    }

}
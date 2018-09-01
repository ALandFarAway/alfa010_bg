// gc_align_ext



int CheckAlignment(object oPC, int nLawChaosCheck, int nGoodEvilCheck)
{
    switch (nLawChaosCheck)
    {
        case -1: nLawChaosCheck = ALIGNMENT_CHAOTIC; break;
        case  0: nLawChaosCheck = ALIGNMENT_NEUTRAL; break;
        case  1: nLawChaosCheck = ALIGNMENT_LAWFUL; break;
        default: nLawChaosCheck = ALIGNMENT_NEUTRAL;
    }

    switch (nGoodEvilCheck)
    {
        case -1: nGoodEvilCheck = ALIGNMENT_EVIL; break;
        case  0: nGoodEvilCheck = ALIGNMENT_NEUTRAL; break;
        case  1: nGoodEvilCheck = ALIGNMENT_GOOD; break;
        default: nGoodEvilCheck = ALIGNMENT_NEUTRAL;
    }

    if (GetAlignmentLawChaos(oPC) == nLawChaosCheck
     && GetAlignmentGoodEvil(oPC) == nGoodEvilCheck)
    {
        return TRUE;
    }

    return FALSE;
}

int StartingConditional(int nLawChaosCheck, int nGoodEvilCheck)
{
    object oPC = GetPCSpeaker();
    return CheckAlignment(oPC, nLawChaosCheck, nGoodEvilCheck);
}
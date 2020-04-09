void main()
{
    object oPC = GetPCSpeaker();
    int nSkillRoll, nPCSkill;
    string sClimbRopeTiedGlobal, sClimbRopeBadGlobal, sClimbRopeFixedGlobal;
    sClimbRopeTiedGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_tied_global"
    );  // Name of global that is used to store that rope is tied
    sClimbRopeBadGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_bad_global"
    );  // Name of global that is used to store that rope will unravel with weight put on it
    sClimbRopeFixedGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_fixed_global"
    );  // Name of global that is used to store that rope is fixed

    nPCSkill = GetSkillRank(SKILL_SPOT, oPC);
    nSkillRoll = d20() + nPCSkill;

    // Passed DC 20 spot check: rope is fixed
    if (nSkillRoll >= 20) {
        SetGlobalInt(sClimbRopeBadGlobal, 0);
        SetGlobalInt(sClimbRopeFixedGlobal, 1);
    }
}



/*void main()
{
	object o = GetPCSpeaker();
	
	int check = d20() + GetSkillRank(SKILL_SPOT, o);
	
	if (check >= 20) {
		SetGlobalInt("sinkhole_rope_bad",0);
		SetGlobalInt("sinkhole_rope_fix",1);
	}
}*/
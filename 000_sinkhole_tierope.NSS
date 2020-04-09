




#include "acr_i"  // Needed for SKILL_USE_ROPE

void main()
{
    object oPC = GetPCSpeaker();
    int nSkillRoll, nPCSkill;
    string sClimbRopeTiedGlobal, sClimbRopeBadGlobal;
    sClimbRopeTiedGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_tied_global"
    );  // Name of global that is used to store that rope is tied
    sClimbRopeBadGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_bad_global"
    );  // Name of global that is used to store that rope will unravel with weight put on it
    
    nPCSkill = GetSkillRank(SKILL_USE_ROPE, oPC);
    nSkillRoll = d20() + nPCSkill;
    
    SetGlobalInt(sClimbRopeTiedGlobal, 1);
    
    // Failed DC15 Use Rope check: rope isn't correctly tied (and will unravel)
    if (nSkillRoll < 15) {
        SetGlobalInt(sClimbRopeBadGlobal, 1);
    }
}/*#include "acr_i"

void main()
{
	object o = GetPCSpeaker();
	
	int check = d20() + GetSkillRank(SKILL_USE_ROPE, o);
	
	SetGlobalInt("sinkhole_rope",1);
	
	if (check < 15)
		SetGlobalInt("sinkhole_rope_bad",1);
}*/
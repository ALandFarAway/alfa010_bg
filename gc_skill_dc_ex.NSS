// gc_skill_dc(int nSkill, int nDC)
/*
	Determine if PC Speaker's skill roll is successful.
	
	Parameters:
		int nSkill 	= skill int to check
		int nDC		= difficulty class to beat
	
	Remarks:
		skill ints
		1	CONCENTRATION							35  ESCAPE ARTIST
		2	DISABLE DEVICE							36  FORGERY
		3   DELETED									37  GATHER INFO
		4	HEAL                                    38  HANDLE ANIMAL                
		5	HIDE								    39  JUMP
		6	LISTEN									40  KNOWLEDGE - ARCANA
		7   DELETED									41  KNOWLEDGE - HISTORY
		8	MOVE SILENTLY							42  KNOWLEDGE - NATURE
		9	OPEN LOCKS								43  KNOWLEDGE - RELIGION
		10	PARRY									44  KNOWLEDGE - THE PLANES
		11	DELETED									45  PERFORM - ACTING
		12	DIPLOMACY								46	PERFORM - DANCE
		13	SLEIGHT OF HANDLE						47  PERFORM - ORATORY 
		14	SEARCH									48  PERFORM - STRINGED INSTRUMENTS
		15  DELETED									49  PERFORM - SING
		16	SPELL CRAFT								50  PROFESSION
		17	SPOT									51  SENSE MOTIVE
		18	RIDE									52  SPEAK LANGUAGE
		19	USE MAGIC DEVICE						53  SWIM
		20	APPRAISE								54  USE ROPE
		21	TUMBLE									55  KNOWLEDGE - GEOGRAPHY
		22	DELETED									56  KNOWLEDGE - NOBILITY
		23	BLUFF									57  DELETED
		24	INTIMIDATE 								58  KNOWLEDGE - ENGINEERING
		25	TAUNT									59  KNOWLEDGE - LOCAL 
		26	DELETED									60  PERFORM - PERCUSSION
		27	DELETED									61  PERFORM - KEYBOARD
		28  DELETED									62  PERFORM - WIND INSTRUMENTS
		29  SURVIVAL								63  PERFORM - COMEDY 
		30  BALANCE									64  CRAFT - ALCHEMY
		31  CLIMB									65  CRAFT - ARMORSMITHING
		32  DECIPHER SCRIPT							66  CRAFT - BOW MAKING
		33  KNOWLEDGE - DUNGEONEERING				67  CRAFT - WEAPONSMITH
		34  DISGUISE
*/
// BMA-OEI 9/02/05

#include "ginc_param_const"
#include "acr_skills_i"

int StartingConditional(int nSkill, int nDC)
{
	object oPC = GetPCSpeaker();

	if (ACR_SkillCheck(nSkill, oPC, nDC, TRUE) == TRUE)
	{
		return TRUE;
	}
	else
	{
		return FALSE;
	}
}
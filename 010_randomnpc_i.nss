#include "acr_tools_i"
#include "acr_zspawn_i"
#include "010_namegen_i"

const float _SIZE_STD_X = 0.04f;
const float _SIZE_STD_Y = 0.04f;
const float _SIZE_STD_Z = 0.04f;

const float _SIZE_MEAN_MALE = 1.0f;
const float _SIZE_MEAN_FEMALE = 0.925f;

const string VAR_RANDOMIZE_NPC = "010_RANDOMIZE_NPC";
const string VAR_RANDOMIZE_NPC_EQUIP = "010_RANDOMIZE_NPC_EQUIP";
const string VAR_RANDOMIZE_NPC_NAME = "010_RANDOMIZE_NPC_NAME";


void RandomizeNPCName(object oNPC = OBJECT_SELF)
{
	string s0="",s1="";
	int gender = GetGender(oNPC);

	switch (GetRacialType(oNPC)) {
		case RACIAL_TYPE_DWARF:
			s0 = RandomNameDwarf(gender);
			break;
		case RACIAL_TYPE_GNOME:
			s0 = RandomNameGnome(gender);
			if (!Random(4))
				s1 = RandomNameGnome(gender,1);
			break;
		case RACIAL_TYPE_ELF:
			switch ( GetSubRace( oNPC ) ) {
				case RACIAL_SUBTYPE_DROW:
					s0 = RandomNameDrow(gender);
					break;
				default:
					s0 = RandomNameHuman(gender);
					s1 = RandomNameHuman(0);
			}
			break;
		default:
			s0 = RandomNameHuman(gender);
			s1 = RandomNameHuman(0);
	}

	s1 += "{Random}";

	SetFirstName(oNPC, s0);
	SetLastName(oNPC, s1);
}

void RandomizeNPCAppearance(object oNPC = OBJECT_SELF)
{
	// Racial overrides.
	float fFacialHairChance = 0.5;
	int nHair1Color = ACR_FEATURE_TYPE_RANDOM;
	int nHair2Color = ACR_FEATURE_TYPE_RANDOM;
	switch( GetSubRace( oNPC ) ) {
		case RACIAL_SUBTYPE_GOLD_DWARF:
		case RACIAL_SUBTYPE_GRAY_DWARF:
		case RACIAL_SUBTYPE_SHIELD_DWARF:
			// Dwarves have a higher beard chance.
			fFacialHairChance = 0.8;
			break;
		case RACIAL_SUBTYPE_DROW:
			// Drow only have white hair.
			nHair1Color = 1;
			nHair2Color = 0;
		case RACIAL_SUBTYPE_MOON_ELF:
		case RACIAL_SUBTYPE_SUN_ELF:
		case RACIAL_SUBTYPE_WILD_ELF:
		case RACIAL_SUBTYPE_WOOD_ELF:
			// Elves don't get beards.
			fFacialHairChance = 0.0;
			break;
			
	}

	ACR_RandomizeAppearance( oNPC, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, nHair1Color, nHair2Color, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, ACR_FEATURE_TYPE_RANDOM, fFacialHairChance );
}

void RandomizeNPCScale(object oNPC = OBJECT_SELF, int autoscale = 1, float std_x = _SIZE_STD_X, float std_y = _SIZE_STD_Y, float std_z = _SIZE_STD_Z)
{
	vector scale;

	scale.x = ACR_RandomNormal(_SIZE_MEAN_MALE, std_x);
	scale.y = ACR_RandomNormal(_SIZE_MEAN_MALE, std_y);
	scale.z = ACR_RandomNormal(_SIZE_MEAN_MALE, std_z);

	if (autoscale) {
		// scale smaller for female
		if (GetGender(oNPC) == GENDER_FEMALE) {
			scale.x *= _SIZE_MEAN_FEMALE;
			scale.y *= _SIZE_MEAN_FEMALE;
			scale.z *= _SIZE_MEAN_FEMALE;
		}
	}
	else {
		scale.x *= GetScale(oNPC, SCALE_X);
		scale.y *= GetScale(oNPC, SCALE_Y);
		scale.z *= GetScale(oNPC, SCALE_Z);
	}

	SetScale(oNPC,scale.x,scale.y,scale.z);
}


void RandomNPCEquip(object oArmour, object oBoots)
{
	if ((GetItemInSlot(INVENTORY_SLOT_CHEST, OBJECT_SELF) == oArmour) &&
		(GetItemInSlot(INVENTORY_SLOT_BOOTS, OBJECT_SELF) == oBoots))
		return;

	ClearAllActions(TRUE);

	DelayCommand(9.0, RandomNPCEquip(oArmour, oBoots));

	ActionEquipItem(oArmour,1);
	ActionEquipItem(oBoots,2);
}

void RandomizeNPCClothing(object oNPC = OBJECT_SELF)
{
	string sArmType,sBootType;
	int rCloth,rBoots,gender=GetGender(oNPC);

	
	///RANDOM EQUIP/////
	rCloth=Random(20)+1;
	rBoots=Random(10)+1;
	
	//create clothing  ALFA_Clothing|Random - Do Not Delete
	switch (rCloth)
		{
		case 1:sArmType="abr_it_clx_thayrobe";break;//
		case 2:sArmType="aca_it_ar_cloth05";break;//
		case 3:sArmType="10_it_arm_l_gr_140";break;//
		case 4:sArmType="10_it_arm_l_gr_140";break;//
		case 5:sArmType="09_it_cloth_u_travellers10";break;//
		case 6:sArmType="010_it_clothcomb";break;//
		case 7:sArmType="010_it_clothcomb0";break;//
		case 8:sArmType="010_it_clothcomb1";break;//
		case 9:sArmType="010_it_clothcomb2";break;//
		case 10:sArmType="010_it_clothcomb3";break;//
		case 11:sArmType="010_it_clothcomb4";break;//
		case 12:sArmType="010_it_clothcomb5";break;//
		case 13:sArmType="09_it_cloth_u_galictunic1";break;//
		case 14:sArmType="010_it_clothcomc0";break;//
		case 15:sArmType="nw_cloth0120";break;//
		case 16:sArmType="09_it_cloth_u_noble_garb";break;//
		case 17:sArmType="abr_it_clx_clothlegs";break;//
		case 18:sArmType="010_it_clothcomd";break;//
		case 19:sArmType="010_it_clothmida2";break;//
		case 20:sArmType="09_it_cloth_u_travellers1";break;//
		}
	object oArmour=CreateItemOnObject(sArmType);
	//create boots   ALFA_Boot|Random - Do NOT Delete
	switch (rBoots)
		{
		case 1:sBootType="010_it_boots";break;
		case 2:sBootType="010_it_boots1";break;
		case 3:sBootType="010_it_boots2";break;
		case 4:sBootType="010_it_bootscloth";break;
		case 5:sBootType="010_it_bootscloth0";break;
		case 6:sBootType="010_it_bootscloth2";break;
		case 7:sBootType="010_it_bootscloth3";break;
		case 8:sBootType="010_it_bootscloth4";break;
		case 9:sBootType="010_it_boots0";break;
		case 10:sBootType="010_it_boots3";break;
		}
	object oBoots=CreateItemOnObject(sBootType);

	RandomNPCEquip(oArmour, oBoots);
}

void RandomizeNPC(object oNPC = OBJECT_SELF, int nEquip=1, int nName=1)
{
	RandomizeNPCAppearance(oNPC);
	RandomizeNPCScale(oNPC);

/*
	// pick a randomly distributed heartbeat
	SetCustomHeartbeat(OBJECT_SELF, FloatToInt(1000.0*ACR_RandomNormal(6.0,1.0)));
*/

	if (nName)
		RandomizeNPCName(oNPC);

	if (nEquip)
		RandomizeNPCClothing(oNPC);
}

string RandomNPCResref(int race=RACIAL_TYPE_HUMAN, float prob = 0.2)
{
	string sResRef="";

	if (ACR_RandomFloat() < prob)
		return "";

	switch (race) {
		case RACIAL_TYPE_DWARF:
			switch (Random(8)) {
				case 0:
					switch (Random(6)) {
						case 0:
							sResRef="abr_cr_DwarfExpertM";
							break;
						case 1:
							sResRef="abr_cr_DwarfExpertF";
							break;
						case 2:
							sResRef="abr_cr_DwarfWarriorA";
							break;
						case 3:
							sResRef="abr_cr_DwarfWarriorH";
							break;
						case 4:
							sResRef="abr_cr_DwarfAdeptM";
							break;
						case 5:
							sResRef="abr_cr_DwarfAdeptF";
							break;
					}
					break;
				case 1:
					sResRef="abr_cr_dwarf_commoner_m0";
					break;
				case 2:
					sResRef="abr_cr_dwarf_commoner_m1";
					break;
				case 3:
					sResRef="abr_cr_dwarf_commoner_m2";
					break;
				case 4:
					sResRef="abr_cr_dwarf_commoner_m3";
					break;
				case 5:
					sResRef="abr_cr_dwarf_commoner_f0";
					break;
				case 6:
					sResRef="abr_cr_dwarf_commoner_f1";
					break;
				case 7:
					sResRef="abr_cr_dwarf_commoner_f2";
					break;
			}
			break;
		case RACIAL_TYPE_GNOME:
			switch (Random(7)) {
				case 0:
					switch (Random(6)) {
						case 0:
							sResRef="abr_cr_GnomeExpertM";
							break;
						case 1:
							sResRef="abr_cr_GnomeExpertF";
							break;
						case 2:
							sResRef="abr_cr_GnomeWarriorX";
							break;
						case 3:
							sResRef="abr_cr_GnomeWarriorH";
							break;
						case 4:
							sResRef="abr_cr_GnomeAdeptM";
							break;
						case 5:
							sResRef="abr_cr_GnomeAdeptF";
							break;
					}
					break;
				case 1:
					sResRef="010_cr_gnome_comm0";
					break;
				case 2:
					sResRef="010_cr_gnome_comm1";
					break;
				case 3:
					sResRef="010_cr_gnome_comm2";
					break;
				case 4:
					sResRef="010_cr_gnome_comm3";
					break;
				case 5:
					sResRef="010_cr_gnome_comm4";
					break;
				case 6:
					sResRef="010_cr_gnome_comm5";
					break;
				}
			break;
		case RACIAL_TYPE_GRAYORC:
			switch(Random(4)) {
				case 0:
					sResRef = "010_cr_deepgnome0";
					break;
				case 1:
					sResRef = "010_cr_deepgnome1";
					break;
				case 2:
					sResRef = "010_cr_deepgnome2";
					break;
				case 3:
					sResRef = "010_cr_deepgnome1";
					break;
			}
			break;
		case RACIAL_TYPE_HUMAN:
		default:
			switch (Random(24)) {
				case 0:
					sResRef="010_cr_comm_human_f00";
					break;
				case 1:
					sResRef="010_cr_comm_human_f01";
					break;
				case 2:
					sResRef="010_cr_comm_human_f02";
					break;
				case 3:
					sResRef="010_cr_comm_human_f03";
					break;
				case 4:
					sResRef="010_cr_comm_human_f04";
					break;
				case 5:
					sResRef="010_cr_comm_human_f05";
					break;
				case 6:
					sResRef="010_cr_comm_human_f06";
					break;
				case 7:
					sResRef="010_cr_comm_human_f07";
					break;
				case 8:
					sResRef="010_cr_comm_human_f08";
					break;
				case 9:
					sResRef="010_cr_comm_human_f09";
					break;
				case 10:
					sResRef="010_cr_comm_human_f10";
					break;
				case 11:
					sResRef="010_cr_comm_human_f11";
					break;
				case 12:
					sResRef="010_cr_comm_human_m00";
					break;
				case 13:
					sResRef="010_cr_comm_human_m01";
					break;
				case 14:
					sResRef="010_cr_comm_human_m02";
					break;
				case 15:
					sResRef="010_cr_comm_human_m03";
					break;
				case 16:
					sResRef="010_cr_comm_human_m04";
					break;
				case 17:
					sResRef="010_cr_comm_human_m05";
					break;
				case 18:
					sResRef="010_cr_comm_human_m06";
					break;
				case 19:
					sResRef="010_cr_comm_human_m07";
					break;
				case 20:
					sResRef="010_cr_comm_human_m08";
					break;
				case 21:
					sResRef="010_cr_comm_human_m09";
					break;
				case 22:
					sResRef="010_cr_comm_human_m10";
					break;
				case 23:
					sResRef="010_cr_comm_human_m11";
					break;
					}
	
					
	
		break;
	}
	return sResRef;
}

void RandomizeNPC_OnSpawnIn( object oSpawn ) {
	// First check to see if we are calling the random NPC system.
	if ( GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC ) ) {
		RandomizeNPC( oSpawn, GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC_EQUIP ), GetLocalInt( oSpawn, VAR_RANDOMIZE_NPC_NAME ) );
	}
}
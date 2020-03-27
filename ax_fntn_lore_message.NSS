// Script: ax_fntn_lore_message

// This delivers the Lore information to the PC 
// after successful Lore task roll.
// author: tax_5-07

#include "ax_gizmo_include"

void main()
{
object oPC = GetPCSpeaker();
string sPLCclass = GetLocalString(OBJECT_SELF, "sPLCclass");

// If you have placed an sLore variable on the fountain,
// then that will be used instead of any of the default messages.
string sLore = GetLocalString(OBJECT_SELF, "sLore");

// This runs the main fountain script in Discovery mode.
// It doesn't actually run any effect modules but it will parse
// the input variables and fully populate the output variables.
FountainMain(OBJECT_SELF, oPC, 1);

// Pull all the effect flags to determine what this gizmo does.
int nSimpleHealFlag =      GetLocalInt(OBJECT_SELF, "nSimpleHealFlag");
int nCompleteHealFlag =    GetLocalInt(OBJECT_SELF, "nCompleteHealFlag");
int nRestorationFlag =     GetLocalInt(OBJECT_SELF, "nRestorationFlag");
int nRemoveCurseFlag =     GetLocalInt(OBJECT_SELF, "nRemoveCurseFlag");
int nCureDiseaseFlag =     GetLocalInt(OBJECT_SELF, "nCureDiseaseFlag");
int nHeroismPackageFlag =  GetLocalInt(OBJECT_SELF, "nHeroismPackageFlag");
int nAbilityBonusFlag =    GetLocalInt(OBJECT_SELF, "nAbilityBonusFlag");
int nConcealmentFlag =     GetLocalInt(OBJECT_SELF, "nConcealmentFlag");
int nInvisibilityFlag =    GetLocalInt(OBJECT_SELF, "nInvisibilityFlag");
int nHasteFlag =           GetLocalInt(OBJECT_SELF, "nHasteFlag");
int nVisionFlag =          GetLocalInt(OBJECT_SELF, "nVisionFlag");
int nRegenerationFlag =    GetLocalInt(OBJECT_SELF, "nRegenerationFlag");
int nArmorClassFlag =      GetLocalInt(OBJECT_SELF, "nArmorClassFlag");
int nTempHitPointsFlag =   GetLocalInt(OBJECT_SELF, "nTempHitPointsFlag");
int nIncreaseMoveFlag =    GetLocalInt(OBJECT_SELF, "nIncreaseMoveFlag");
int nAttackBonusFlag =     GetLocalInt(OBJECT_SELF, "nAttackBonusFlag");
int nSpellResistIncrFlag = GetLocalInt(OBJECT_SELF, "nSpellResistIncrFlag");
int nSkillIncreaseFlag =   GetLocalInt(OBJECT_SELF, "nSkillIncreaseFlag");
int nSaveThrowIncrFlag =   GetLocalInt(OBJECT_SELF, "nSaveThrowIncrFlag");
int nDamageFlag =          GetLocalInt(OBJECT_SELF, "nDamageFlag");
int nPoisonFlag =          GetLocalInt(OBJECT_SELF, "nPoisonFlag");
int nDiseaseFlag =         GetLocalInt(OBJECT_SELF, "nDiseaseFlag");
int nBadEffectFlag =       GetLocalInt(OBJECT_SELF, "nBadEffectFlag");
int nCurseFlag =           GetLocalInt(OBJECT_SELF, "nCurseFlag");
int nPolymorphFlag =       GetLocalInt(OBJECT_SELF, "nPolymorphFlag");
int nNegativeLevelFlag =   GetLocalInt(OBJECT_SELF, "nNegativeLevelFlag");
int nSlowFlag =            GetLocalInt(OBJECT_SELF, "nSlowFlag");
int nGiveXPsFlag =         GetLocalInt(OBJECT_SELF, "nGiveXPsFlag");
int nTakeXPsFlag =         GetLocalInt(OBJECT_SELF, "nTakeXPsFlag");
int nGiveGoldFlag =        GetLocalInt(OBJECT_SELF, "nGiveGoldFlag");
int nGiveItemFlag =        GetLocalInt(OBJECT_SELF, "nGiveItemFlag");
int nTeleportFlag =        GetLocalInt(OBJECT_SELF, "nTeleportFlag");
int nJournalEntryFlag =    GetLocalInt(OBJECT_SELF, "nJournalEntryFlag");

// figure out if it is all good or all bad
int nDoesGood = nSimpleHealFlag + nCompleteHealFlag + nRestorationFlag + nRemoveCurseFlag + nCureDiseaseFlag + nHeroismPackageFlag + nAbilityBonusFlag + nConcealmentFlag + nInvisibilityFlag + nHasteFlag + nVisionFlag + nRegenerationFlag + nArmorClassFlag + nAttackBonusFlag + nSpellResistIncrFlag + nSkillIncreaseFlag + nSaveThrowIncrFlag + nTempHitPointsFlag + nIncreaseMoveFlag + nGiveXPsFlag + nGiveGoldFlag + nGiveItemFlag + nTeleportFlag + nJournalEntryFlag;
int nDoesBad  = nDamageFlag + nPoisonFlag + nDiseaseFlag + nBadEffectFlag + nCurseFlag + nPolymorphFlag + nNegativeLevelFlag + nSlowFlag + nTakeXPsFlag;
int nDoesNothing = nDoesGood + nDoesBad;

// Remember that these are just default messages. You don't have to 
// live with them. You can give any fountain a custom message simply
// by putting the sLore variable on it and I advise doing that in any case.
// Also keep in mind that only single function scripts will have reasonable
// default messages, otherwise you could be stuck with something pretty vague.

if (sLore == "")
   {
   sLore = LORE_FOUNTAIN_DOES_NOTHING;
   
   if (nDoesBad == 0) sLore = LORE_FOUNTAIN_SAFE;
   else
      {
      sLore = LORE_FOUNTAIN_DANGEROUS;
      }
   if ((nDoesBad == 0) & (nDoesGood > 0) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_GOOD;
   if ((nSimpleHealFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_SIMPLE_HEAL;
   if ((nCompleteHealFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_COMPLETE_HEAL;
   if ((nRestorationFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_RESTORATION;
   if ((nRemoveCurseFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_REMOVE_CURSE;
   if ((nCureDiseaseFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_CURE_DISEASE;
   if ((nHeroismPackageFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_HEROISM_PACKAGE;
   if ((nAbilityBonusFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_ABILITY_BONUS;
   if ((nInvisibilityFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_INVISIBILITY;
   if ((nConcealmentFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_CONCEALMENT;
   if ((nHasteFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_HASTE;
   if ((nIncreaseMoveFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_INCREASE_MOVE;
   if ((nVisionFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_VISION;
   if ((nRegenerationFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_REGENERATION;
   if ((nTempHitPointsFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_TEMP_HIT_POINTS;
   if ((nArmorClassFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_ARMOR_CLASS;   
   if ((nAttackBonusFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_ATTACK_BONUS;
   if ((nSpellResistIncrFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_SPELL_RESIST_INCR;
   if ((nSkillIncreaseFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_SKILL_INCREASE;
   if ((nSaveThrowIncrFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_SAVE_THROW_INCR;
   if ((nDamageFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_DAMAGE;
   if ((nPoisonFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_POISON;
   if ((nDiseaseFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_DISEASE;
   if ((nBadEffectFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_BAD_EFFECT;
   if ((nCurseFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_CURSE;
   if ((nPolymorphFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_POLYMORPH;
   if ((nNegativeLevelFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_NEGATIVE_LEVEL;
   if ((nSlowFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_SLOW;
   if ((nGiveXPsFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_GIVE_XP;
   if ((nTakeXPsFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_TAKE_XP;
   if ((nGiveGoldFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_GIVE_GOLD;
   if ((nGiveItemFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_GIVE_ITEM;
   if ((nTeleportFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_TELEPORT;
   if ((nJournalEntryFlag == 1) & (nDoesNothing == 1)) sLore = LORE_FOUNTAIN_JOURNAL_ENTRY;
   }

SendMessageToPC(GetPCSpeaker(), sLore);
}
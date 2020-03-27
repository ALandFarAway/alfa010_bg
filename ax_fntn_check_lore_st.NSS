//::///////////////////////////////////////////////
//:: check to see whether PC makes Lore ST
//:: author: tax_5-07 with credit to Lilac Soul
//:://////////////////////////////////////////////

#include "ax_gizmo_user_settings"

int StartingConditional()
{
// initialize variables
object oPC = GetPCSpeaker();
int nLoreFail = GetLocalInt(OBJECT_SELF, "nLoreFail");

// If a fountain doesn't have this set, use the global default.
int nLoreOnceOnly = GetLocalInt(OBJECT_SELF, "nLoreOnceOnly");
if (nLoreOnceOnly == 0) nLoreOnceOnly = LORE_ONCE_ONLY;

// If a particular fountain doesn't have Lore turned off, use the global default.
int nLoreNever = GetLocalInt(OBJECT_SELF, "nLoreNever");
if (nLoreNever == 0) nLoreNever = LORE_NEVER;
if (nLoreNever == 1) return FALSE;

// figure out PC current level
int nPClevel = GetTotalLevels(oPC, FALSE);

// if PC failed before then he can try again once he has gone up a level
if ((nLoreOnceOnly == 1) & !(nPClevel > nLoreFail)) return FALSE;

// if the PC was ever successful then he is always successful
if ((nLoreOnceOnly == 1) & (nLoreFail < 0))  return TRUE;

// make skill roll
if (!GetIsSkillSuccessful(oPC, SKILL_LORE, GetLocalInt(OBJECT_SELF, "nLoreST")))
{
// failed roll case
SetLocalInt(OBJECT_SELF, "nLoreFail", nPClevel);
return FALSE;
}
// successful roll case
SetLocalInt(OBJECT_SELF, "nLoreFail", -1);
return TRUE;

}
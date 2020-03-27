//  Gortan's Gizmos Main Function script
//  this is the work-horse script for all the Gortan Gizmos thingamabobs
//  author: tax_5-07 with credit to Lilac Soul, Bioware and Obsidian

/*
  additional ideas: 
      cast a spell
	  do one and only one arbitrary thing from a list
	  if the PC specified in a dialog that he wanted the whole party to drink then they will
*/

#include "ax_gizmo_user_settings"

// :: //////////////////////////////////////////
// :: DECLARATIONS
// :: //////////////////////////////////////////
void FountainMain(object oFountain, object oPC, int nQueryFountainFlag = 0);
void DoesNothing(object oPC, int nFeedback=0, string sMessage="");

// list of GOOD effects
void SimpleHeal(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1);
void CompleteHeal(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1);
void Restoration(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1);
void RemoveCurse(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1);
void CureDisease(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void HeroismPackage(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void AbilityBonus(object oPC, string sMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void Concealment(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void Invisibility(object oPC, string sInvisibilityType, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void Haste(object oPC, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void Vision(object oPC, string sVariety, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void Regeneration(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void ArmorClass(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void AttackBonus(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void SpellResistIncr(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void SkillIncrease(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void SaveThrowIncr(object oPC, int nMagnitude, string sSaveThrowIncrType, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void TempHitPoints(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void GiveXPs(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1);
//void TakeXPs(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1);
void GiveGold(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=0);
void GiveItem(object oPC, string sResRef, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Teleport(object oPC, string sWayPointTag, int nFeedback=0, string sMessage="");
void JournalEntry(object oPC, string sCategoryTag, int nEntryID, int nFeedback=0, string sMessage="", int nWholeParty=0);

// list of BAD effects
void Damage(object oPC, int nMagnitude, string sType, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Poison(object oPC, string sPoison, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Disease(object oPC, string sDisease, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void BadEffect(object oPC, string sBadEffect, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Curse(object oPC, string sCurse, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Polymorph(object oPC, string sPolymorph, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void NegativeLevel(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);
void Slow(object oPC, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0);


// :: //////////////////////////////////////////
// :: STRING FUNCTIONS
// :: //////////////////////////////////////////

// this function returns everything in front of the search string
string ParseBeginning(string sString, string sSearchString)
{
int nPosition = FindSubString(sString, sSearchString);
string sFoundString = GetStringLeft(sString, nPosition);
return sFoundString;
}

// this function returns everything after the search string
string ParseEnd(string sString, string sSearchString)
{
int nPosition = FindSubString(sString, sSearchString);
int nLength = GetStringLength(sString);
string sFoundString = GetStringRight(sString, nLength-nPosition-1);
return sFoundString;
}

// returns True if the PC has the item
int HasItem(object oPC, string sItem)
{
   int nHasItem;
   object oItem = GetItemPossessedBy(oPC, sItem);
   if (GetIsObjectValid(oItem)) return TRUE;
   return FALSE;
}

// removes any dud characters from a string, only valid letters and 
// numbers will be allowed, nothing else, not even blanks
string CleanString(string sInput)
{
string sDigit;
int nSubString;
string sOutput = "";
string sValidCharacters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
int nLength = GetStringLength(sInput);
while (nLength >0)
   {
   sDigit = GetStringLeft(sInput, 1);
   nSubString = FindSubString(sValidCharacters, sDigit) + 1;
//   SendMessageToPC(GetPCSpeaker(), sDigit + "=" + IntToString(nSubString));
   if (!(nSubString) > 0) sDigit = "";
   if (sDigit == " ") sDigit = "";
   if (sDigit == ",") sDigit = "";
   if (sDigit == ";") sDigit = "";
   if (sDigit == ":") sDigit = "";
   if (sDigit == "'") sDigit = "";
   if (sDigit == "-") sDigit = "";
   if (sDigit == "+") sDigit = "";
   if (sDigit == "=") sDigit = "";
   sOutput = sOutput + sDigit;
   sInput = GetStringRight(sInput, GetStringLength(sInput)-1);
   nLength = GetStringLength(sInput);
   }
return sOutput;
}

// removes any specified character from a string
string StripString(string sInput, string sRemoveChar)
{
// cancel this whole thing if sRemoveChar isn't a single character
if (GetStringLength(sRemoveChar) > 1) return sInput;

string sDigit;
int nSubString;
string sOutput = "";
int nLength = GetStringLength(sInput);

while (nLength >0)
   {
   sDigit = GetStringLeft(sInput, 1);
//   SendMessageToPC(GetPCSpeaker(), sDigit + "=" + IntToString(nSubString));
   if (sDigit == sRemoveChar) sDigit = "";
   sOutput = sOutput + sDigit;
   sInput = GetStringRight(sInput, GetStringLength(sInput)-1);
   nLength = GetStringLength(sInput);
   }

return sOutput;
}


// :: //////////////////////////////////////////
// :: FUNCTION-FLAG PARSING FUNCTIONS
// :: //////////////////////////////////////////

// this returns the activation state flag
int ParseFlag(string sString)
{
string sTemp;
int nTemp;

// if the flag is empty then it is NO
if (sString == "") return 0;

sString = GetStringLowerCase(sString); // make it lower case

// if first two digits are recognized as NO then return FALSE
sTemp = GetStringLeft(sString, 2);
if (sTemp == "of") return 0;
if (sTemp == "no") return 0;
if (sTemp == "fa") return 0;
if (sTemp == "0,") return 0;
if (sTemp == "00") return 0;

// if 100% specified
sTemp = GetStringLeft(sString, 3);
if (sTemp == "100") return 1;

// if decimal percentage specified then convert to xx% notation by removing the decimal.
sTemp = GetStringLeft(sString, 1);
if (sTemp == ".") sString = GetStringRight(sString, GetStringLength(sString)-1);

// check if is 1-digit number
nTemp = StringToInt(GetStringLeft(sString, 2));
if (GetStringRight(GetStringLeft(sString, 2),1) == ",") nTemp = StringToInt(GetStringLeft(sString, 1));
else nTemp = StringToInt(GetStringLeft(sString, 2));  // check if is 2-digit number

if ((GetStringLength(sString) == 1) & (StringToInt(sTemp) > 0)) nTemp = StringToInt(sTemp);

// if so then roll under that percentage
if (nTemp > 0)
   {
   if (nTemp > Random(100)) return 1;
   else                     return 0;
   }

// if not any of the above then return TRUE
return 1;
}


// this function returns first parameter
string ParseParameter1(string sString)
{
int nPosition = FindSubString(sString, "="); // get location of first '='

if (nPosition < 1) return sString;  // if no parameter exists, return the raw string

//throw away everything in front of the first '='
int nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

nPosition = FindSubString(sString, ","); // look for trailing comma

// if trailing comma then strip everything after it
if (nPosition > 0) sString = GetStringLeft(sString, nPosition);

return sString;
}

// this function returns second parameter
string ParseParameter2(string sString)
{
//throw away everything in front of the first '='
int nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
int nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the second '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

// look for trailing comma
nPosition = FindSubString(sString, ",");

// if trailing comma then strip everything after it
if (nPosition > 0) sString = GetStringLeft(sString, nPosition);

return sString;
}

// this function returns third parameter
string ParseParameter3(string sString)
{
//throw away everything in front of the first '='
int nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
int nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the second '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the third '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

// look for trailing comma
nPosition = FindSubString(sString, ",");

// if trailing comma then strip everything after it
if (nPosition > 0) sString = GetStringLeft(sString, nPosition);

return sString;
}

// this function returns fourth parameter
string ParseParameter4(string sString)
{
//throw away everything in front of the first '='
int nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
int nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the second '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the third '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

//throw away everything in front of the fourth '='
nPosition = FindSubString(sString, "=");
if (nPosition < 1) return "";  // if no parameter exists, return ""
nLength = GetStringLength(sString);
sString = GetStringRight(sString, nLength-nPosition-1);

// look for trailing comma
nPosition = FindSubString(sString, ",");

// if trailing comma then strip everything after it
if (nPosition > 0) sString = GetStringLeft(sString, nPosition);

return sString;
}



// :: //////////////////////////////////////////
// :: Remove XPs - credit to Lilac Soul
// :: //////////////////////////////////////////
void RemoveXPFromParty(int nXP, object oPC, int bAllParty=TRUE)
{

if (!bAllParty)
   {
   nXP=(GetXP(oPC)-nXP)>=0 ? GetXP(oPC)-nXP : 0;
   SetXP(oPC, nXP);
   }
else
   {
   object oMember=GetFirstFactionMember(oPC, TRUE);

   while (GetIsObjectValid(oMember))
      {
      nXP=(GetXP(oMember)-nXP)>=0 ? GetXP(oMember)-nXP : 0;
      SetXP(oMember, nXP);
      oMember=GetNextFactionMember(oPC, TRUE);
      }
   }
}

// :: //////////////////////////////////////////
// :: DOES NOTHING - the ordinary water case
// :: //////////////////////////////////////////
void DoesNothing(object oPC, int nFeedback=0, string sMessage="")
{
   if (sMessage == "") sMessage = MESSAGE_DOES_NOTHING;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   // set Rest variables on PC
   // These are for future use, they will tell a script when the PC last took a drink.
   // Presumably this might be of use for an OnRest script.
   // In any case they are harmless.
   // I also decided to add these to the 'healing'-type effects.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: SIMPLE HEALING routine - only heals damage
// :: //////////////////////////////////////////
void SimpleHeal(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);

   if (sMessage == "") sMessage = MESSAGE_SIMPLE_HEAL;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eEffect = EffectHeal(nMagnitude);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_G);

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 1.0);
         oTarget=GetNextFactionMember(oPC, FALSE);
         }
      }
      else
      {
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, 1.0);
      }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: COMPLETE HEALING routine - like Temple Healing, gets everything
// :: //////////////////////////////////////////
void CompleteHeal(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);

   if (sMessage == "") sMessage = MESSAGE_COMPLETE_HEAL;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_X);
   effect eEffect;

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHeal(1000), oTarget, 1.0);
		 //ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oTarget);
		 ActionCastSpellAtObject(SPELL_REMOVE_CURSE, oTarget);
		 eEffect = GetFirstEffect(oTarget);
         while (GetIsEffectValid(eEffect))
            {
            if (GetEffectType(eEffect)==EFFECT_TYPE_DISEASE) RemoveEffect(oTarget, eEffect);
            eEffect = GetNextEffect(oTarget);
            }
         oTarget=GetNextFactionMember(oPC, FALSE);
         }
      }
      else
      {
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHeal(1000), oPC, 1.0);
	   ActionCastSpellAtObject(SPELL_GREATER_RESTORATION, oPC);
	   ActionCastSpellAtObject(SPELL_REMOVE_CURSE, oPC);
	   eEffect = GetFirstEffect(oPC);
       while (GetIsEffectValid(eEffect))
          {
          if (GetEffectType(eEffect)==EFFECT_TYPE_DISEASE) RemoveEffect(oPC, eEffect);
          eEffect = GetNextEffect(oPC);
          }
      }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: RESTORATION spell routine
// :: //////////////////////////////////////////
void Restoration(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_S);

   if (sMessage == "") sMessage = MESSAGE_RESTORATION;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
          ActionCastSpellAtObject(SPELL_RESTORATION, oTarget);
          oTarget=GetNextFactionMember(oPC, FALSE);
         }  
      }
      else
      {
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
       ActionCastSpellAtObject(SPELL_RESTORATION, oPC);
      }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: REMOVE CURSE spell routine
// :: //////////////////////////////////////////
void RemoveCurse(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_G);

   if (sMessage == "") sMessage = MESSAGE_REMOVE_CURSE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
          ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
          ActionCastSpellAtObject(SPELL_REMOVE_CURSE, oTarget);
          oTarget=GetNextFactionMember(oPC, FALSE);
         }  
      }
      else
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
      ActionCastSpellAtObject(SPELL_REMOVE_CURSE, oPC);
      }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: CURE DISEASE routine - removes all disease effects
// :: //////////////////////////////////////////
void CureDisease(object oPC, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_G);

   if (sMessage == "") sMessage = MESSAGE_CURE_DISEASE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
         effect eEffect = GetFirstEffect(oTarget);
         while (GetIsEffectValid(eEffect))
            {
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
            if (GetEffectType(eEffect)==EFFECT_TYPE_DISEASE) RemoveEffect(oTarget, eEffect);
            eEffect = GetNextEffect(oTarget);
            }
         oTarget=GetNextFactionMember(oPC, FALSE);
         }  
      }
      else
      {
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
		 effect eEffect = GetFirstEffect(oPC);
         while (GetIsEffectValid(eEffect))
            {
            if (GetEffectType(eEffect)==EFFECT_TYPE_DISEASE) RemoveEffect(oPC, eEffect);
            eEffect = GetNextEffect(oPC);
            }
      }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: HEROISM PACKAGE routine - adds a pre-fabricated laundry-list of positive effects
// :: this is only part of the old system but I am leaving it in for now
// :: //////////////////////////////////////////
void HeroismPackage(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);
   
   if (sMessage == "") sMessage = MESSAGE_HEROISM_PACKAGE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
     {
         while (GetIsObjectValid(oTarget))
         {
		 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(), oTarget, fDuration);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nMagnitude), oTarget, fDuration);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(nMagnitude), oTarget, fDuration);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(50), oTarget, fDuration);
         oTarget=GetNextFactionMember(oPC, FALSE);
         }
     }
     else
	 {
	 ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectUltravision(), oPC, fDuration);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nMagnitude), oPC, fDuration);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(nMagnitude), oPC, fDuration);
     ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(50), oPC, fDuration);
     }
}

// :: //////////////////////////////////////////
// :: ABILITY BONUS routine - adds attribute buffs
// :: //////////////////////////////////////////
void AbilityBonus(object oPC, string sMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_ABILITY_BONUS;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   string sTemp = sMagnitude;
   int nStr = StringToInt(GetStringLeft(sTemp, 1));
   sTemp = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nDex = StringToInt(GetStringLeft(sTemp, 1));
   sTemp = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nCon = StringToInt(GetStringLeft(sTemp, 1));
   sTemp = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nInt = StringToInt(GetStringLeft(sTemp, 1));
   sTemp = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nWis = StringToInt(GetStringLeft(sTemp, 1));
   sTemp = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nCha = StringToInt(GetStringLeft(sTemp, 1));

   if (nWholeParty == 1)
     {
	  while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      effect eEffect = EffectAbilityIncrease(ABILITY_STRENGTH, nStr);
      if (nStr > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, nDex);
      if (nDex > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, nCon);
      if (nCon > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nInt);
      if (nInt > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_WISDOM, nWis);
      if (nWis > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_CHARISMA, nCha);
      if (nCha > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
      ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
      effect eEffect = EffectAbilityIncrease(ABILITY_STRENGTH, nStr);
      if (nStr > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY, nDex);
      if (nDex > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION, nCon);
      if (nCon > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE, nInt);
      if (nInt > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_WISDOM, nWis);
      if (nWis > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      eEffect = EffectAbilityIncrease(ABILITY_CHARISMA, nCha);
      if (nCha > 0) ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
} 

// :: /////////////////////////////////////////////////////////////////
// :: INVISIBILITY - and related effects
// :: multiple possibilities: normal, darkness, improved
// :: /////////////////////////////////////////////////////////////////
void Invisibility(object oPC, string sInvisibilityType, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   
   if (sMessage == "") sMessage = MESSAGE_INVISIBILITY;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   effect eEffect = EffectInvisibility(INVISIBILITY_TYPE_NORMAL);
   sInvisibilityType = GetStringUpperCase(sInvisibilityType);

   if (sInvisibilityType == "DARKNESS") eEffect = EffectInvisibility(INVISIBILITY_TYPE_DARKNESS);
   if (sInvisibilityType == "IMPROVED") eEffect = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
   if (sInvisibilityType == "INVISIBILITY_TYPE_DARKNESS") eEffect = EffectInvisibility(INVISIBILITY_TYPE_DARKNESS);
   if (sInvisibilityType == "INVISIBILITY_TYPE_IMPROVED") eEffect = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
   if (sInvisibilityType == "DARK") eEffect = EffectInvisibility(INVISIBILITY_TYPE_DARKNESS);
   if (sInvisibilityType == "IMP")  eEffect = EffectInvisibility(INVISIBILITY_TYPE_IMPROVED);
  
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: HASTE
// :: //////////////////////////////////////////
void Haste(object oPC, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_HASTE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectHaste(), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: CONCEALMENT
// :: //////////////////////////////////////////
void Concealment(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_CONCEALMENT;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConcealment(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectConcealment(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: INCREASE MOVEMENT
// :: //////////////////////////////////////////
void IncreaseMove(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_INCREASE_MOVE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectMovementSpeedIncrease(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: VISION - and related effects
// :: variety = True Seeing
// :: variety = See Invisible
// :: variety = Ultravision
// :: //////////////////////////////////////////
void Vision(object oPC, string sVariety, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_VISION;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eEffect = EffectUltravision();
   
   sVariety = GetStringLeft(GetStringLowerCase(sVariety), 1);  // change case

   if (sVariety == "s") eEffect = EffectSeeInvisible();
   if (sVariety == "t") eEffect = EffectTrueSeeing();
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: REGENERATION
// :: //////////////////////////////////////////
void Regeneration(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_S);

   if (sMessage == "") sMessage = MESSAGE_REGENERATION;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(nMagnitude, fDuration), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectRegenerate(nMagnitude, fDuration), oTarget, fDuration);
   }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: TEMPORARY HIT POINTS
// :: //////////////////////////////////////////
void TempHitPoints(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_S);

   if (sMessage == "") sMessage = MESSAGE_TEMP_HIT_POINTS;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectTemporaryHitpoints(nMagnitude), oPC, fDuration);   
   }
// This also counts as good drinking water. See additional notes in DoesNothing section.
  if (GetLocalString(OBJECT_SELF, "sPLCclass") == "fountain")
  {
  SetLocalInt(oPC, "nDrinkDay", GetCalendarDay());
  SetLocalInt(oPC, "nDrinkHour", GetTimeHour());
  }
}

// :: //////////////////////////////////////////
// :: ARMOR CLASS buff
// :: //////////////////////////////////////////
void ArmorClass(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_ARMOR_CLASS;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectACIncrease(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: ATTACK INCREASE buff
// :: //////////////////////////////////////////
void AttackBonus(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_ATTACK_BONUS;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectAttackIncrease(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: SPELL RESIST INCREASE buff
// :: //////////////////////////////////////////
void SpellResistIncr(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_SPELL_RESIST_INCR;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSpellResistanceIncrease(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSpellResistanceIncrease(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: SKILL INCREASE buff
// :: //////////////////////////////////////////
void SkillIncrease(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_SKILL_INCREASE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_ALL_SKILLS, nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSkillIncrease(SKILL_ALL_SKILLS, nMagnitude), oTarget, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: SAVING THROW INCREASE buff
// ::
// :: I made a decision that Fortitude, Will & Reflex STs would be affected equally. Otherwise I'd have to do this three times and I don't see the value in that...
// ::
// :: ALL, ACID, CHAOS, COLD, DEATH, DISEASE, DIVINE, ELECTRICITY, EVIL, FEAR, FIRE, GOOD, LAW, MIND_SPELLS, NEGATIVE, POISON, POSITIVE, SONIC, SPELL, TRAP
// :: //////////////////////////////////////////
void SaveThrowIncr(object oPC, int nMagnitude, string sSaveThrowIncrType, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_SAVE_THROW_INCR;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   sSaveThrowIncrType = GetStringLeft(GetStringLowerCase(sSaveThrowIncrType), 3);  // change case
	  
   effect eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_ALL);
   if (sSaveThrowIncrType == "ACI") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_ACID);
   if (sSaveThrowIncrType == "CHA") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_CHAOS);
   if (sSaveThrowIncrType == "COL") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_COLD);
   if (sSaveThrowIncrType == "DEA") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_DEATH);
   if (sSaveThrowIncrType == "DIS") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_DISEASE);
   if (sSaveThrowIncrType == "DIV") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_DIVINE);
   if (sSaveThrowIncrType == "ELE") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_ELECTRICITY);
   if (sSaveThrowIncrType == "EVI") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_EVIL);
   if (sSaveThrowIncrType == "FEA") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_FEAR);
   if (sSaveThrowIncrType == "FIR") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_FIRE);
   if (sSaveThrowIncrType == "GOO") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_GOOD);
   if (sSaveThrowIncrType == "LAW") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_LAW);
   if (sSaveThrowIncrType == "MIN") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_MIND_SPELLS);
   if (sSaveThrowIncrType == "NEG") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_NEGATIVE);
   if (sSaveThrowIncrType == "POI") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_POISON);
   if (sSaveThrowIncrType == "POS") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_POSITIVE);
   if (sSaveThrowIncrType == "SON") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_SONIC);
   if (sSaveThrowIncrType == "SPE") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_SPELL);
   if (sSaveThrowIncrType == "TRA") eEffect = EffectSavingThrowIncrease(SAVING_THROW_ALL, nMagnitude, SAVING_THROW_TYPE_TRAP);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// :: //////////////////////////////////////////
// :: DAMAGE routine
// :: //////////////////////////////////////////
void Damage(object oPC, int nMagnitude, string sType, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_ACID_S);

   if (sMessage == "") sMessage = MESSAGE_DAMAGE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);

   sType = GetStringLeft(GetStringUpperCase(sType), 2);  // change case
   
   if (sType == "CO") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);
   if (sType == "FR") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);
   if (sType == "DI") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_DIVINE, DAMAGE_POWER_NORMAL);
   if (sType == "EL") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_ELECTRICAL, DAMAGE_POWER_NORMAL);
   if (sType == "FI") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
   if (sType == "FL") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_FIRE, DAMAGE_POWER_NORMAL);
   if (sType == "MA") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_NORMAL);
   if (sType == "NE") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_NEGATIVE, DAMAGE_POWER_NORMAL);
   if (sType == "PO") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_POSITIVE, DAMAGE_POWER_NORMAL);
   if (sType == "SO") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_SONIC, DAMAGE_POWER_NORMAL);
   if (sType == "BL") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_BLUDGEONING, DAMAGE_POWER_NORMAL);
   if (sType == "PI") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_PIERCING, DAMAGE_POWER_NORMAL);
   if (sType == "SL") eEffect = EffectDamage(nMagnitude, DAMAGE_TYPE_SLASHING, DAMAGE_POWER_NORMAL);
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oTarget);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
   }
}

// :: //////////////////////////////////////////
// :: POISON routine
// :: //////////////////////////////////////////
void Poison(object oPC, string sPoison, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_POISON_L);

   if (sMessage == "") sMessage = MESSAGE_POISON;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eEffect = EffectPoison(POISON_SMALL_SPIDER_VENOM);
   
   sPoison = GetStringUpperCase(sPoison);  // change case
   
   if (sPoison == "ARANEA_VENOM") eEffect = EffectPoison(POISON_ARANEA_VENOM);
   if (sPoison == "ARSENIC") eEffect = EffectPoison(POISON_ARSENIC);
   if (sPoison == "BEBILITH_VENOM") eEffect = EffectPoison(POISON_BEBILITH_VENOM);
   if (sPoison == "BLACK_ADDER_VENOM") eEffect = EffectPoison(POISON_BLACK_ADDER_VENOM);
   if (sPoison == "BLACK_LOTUS_EXTRACT") eEffect = EffectPoison(POISON_BLACK_LOTUS_EXTRACT);
   if (sPoison == "BLADE_BANE") eEffect = EffectPoison(POISON_BLADE_BANE);
   if (sPoison == "BLOODROOT") eEffect = EffectPoison(POISON_BLOODROOT);
   if (sPoison == "BLUE_WHINNIS") eEffect = EffectPoison(POISON_BLUE_WHINNIS);
   if (sPoison == "BURNT_OTHUR_FUMES") eEffect = EffectPoison(POISON_BURNT_OTHUR_FUMES);
   if (sPoison == "CARRION_CRAWLER_BRAIN_JUICE") eEffect = EffectPoison(POISON_CARRION_CRAWLER_BRAIN_JUICE);
   if (sPoison == "CHAOS_MIST") eEffect = EffectPoison(POISON_CHAOS_MIST);
   if (sPoison == "COLOSSAL_SPIDER_VENOM") eEffect = EffectPoison(POISON_COLOSSAL_SPIDER_VENOM);
   if (sPoison == "DARK_REAVER_POWDER") eEffect = EffectPoison(POISON_DARK_REAVER_POWDER);
   if (sPoison == "DEATHBLADE") eEffect = EffectPoison(POISON_DEATHBLADE);
   if (sPoison == "DRAGON_BILE") eEffect = EffectPoison(POISON_DRAGON_BILE);
   if (sPoison == "ETTERCAP_VENOM") eEffect = EffectPoison(POISON_ETTERCAP_VENOM);
   if (sPoison == "GARGANTUAN_SPIDER_VENOM") eEffect = EffectPoison(POISON_GARGANTUAN_SPIDER_VENOM);
   if (sPoison == "GIANT_WASP_POISON") eEffect = EffectPoison(POISON_GIANT_WASP_POISON);
   if (sPoison == "GREENBLOOD_OIL") eEffect = EffectPoison(POISON_GREENBLOOD_OIL);
   if (sPoison == "HUGE_SPIDER_VENOM") eEffect = EffectPoison(POISON_HUGE_SPIDER_VENOM);
   if (sPoison == "ID_MOSS") eEffect = EffectPoison(POISON_ID_MOSS);
   if (sPoison == "IRON_GOLEM") eEffect = EffectPoison(POISON_IRON_GOLEM);
   if (sPoison == "LARGE_SCORPION_VENOM") eEffect = EffectPoison(POISON_LARGE_SCORPION_VENOM);
   if (sPoison == "LARGE_SPIDER_VENOM") eEffect = EffectPoison(POISON_LARGE_SPIDER_VENOM);
   if (sPoison == "LICH_DUST") eEffect = EffectPoison(POISON_LICH_DUST);
   if (sPoison == "MALYSS_ROOT_PASTE") eEffect = EffectPoison(POISON_MALYSS_ROOT_PASTE);
   if (sPoison == "MEDIUM_SPIDER_VENOM") eEffect = EffectPoison(POISON_MEDIUM_SPIDER_VENOM);
   if (sPoison == "NIGHTSHADE") eEffect = EffectPoison(POISON_NIGHTSHADE);
   if (sPoison == "NITHARIT") eEffect = EffectPoison(POISON_NITHARIT);
   if (sPoison == "OIL_OF_TAGGIT") eEffect = EffectPoison(POISON_OIL_OF_TAGGIT);
   if (sPoison == "PHASE_SPIDER_VENOM") eEffect = EffectPoison(POISON_PHASE_SPIDER_VENOM);
   if (sPoison == "PIT_FIEND_ICHOR") eEffect = EffectPoison(POISON_PIT_FIEND_ICHOR);
   if (sPoison == "PURPLE_WORM_POISON") eEffect = EffectPoison(POISON_PURPLE_WORM_POISON);
   if (sPoison == "QUASIT_VENOM") eEffect = EffectPoison(POISON_QUASIT_VENOM);
   if (sPoison == "SASSONE_LEAF_RESIDUE") eEffect = EffectPoison(POISON_SASSONE_LEAF_RESIDUE);
   if (sPoison == "SHADOW_ESSENCE") eEffect = EffectPoison(POISON_SHADOW_ESSENCE);
   if (sPoison == "SMALL_CENTIPEDE_POISON") eEffect = EffectPoison(POISON_SMALL_CENTIPEDE_POISON);
   if (sPoison == "STRIPED_TOADSTOOL ") eEffect = EffectPoison(POISON_STRIPED_TOADSTOOL );
   if (sPoison == "TERINAV_ROOT") eEffect = EffectPoison(POISON_TERINAV_ROOT);
   if (sPoison == "TINY_SPIDER_VENOM") eEffect = EffectPoison(POISON_TINY_SPIDER_VENOM);
   if (sPoison == "UNGOL_DUST") eEffect = EffectPoison(POISON_UNGOL_DUST);
   if (sPoison == "WRAITH_SPIDER_VENOM") eEffect = EffectPoison(POISON_WRAITH_SPIDER_VENOM);
   if (sPoison == "WYVERN_POISON") eEffect = EffectPoison(POISON_WYVERN_POISON);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}   

// :: //////////////////////////////////////////
// :: DISEASE routine
// :: //////////////////////////////////////////
void Disease(object oPC, string sDisease, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_DISEASE_S);

   if (sMessage == "") sMessage = MESSAGE_DISEASE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   effect eEffect = EffectDisease(DISEASE_VERMIN_MADNESS);
   
   sDisease = GetStringUpperCase(sDisease);  // change case
   
   if (sDisease == "BLINDING_SICKNESS") eEffect = EffectDisease(DISEASE_BLINDING_SICKNESS);
   if (sDisease == "BURROW_MAGGOTS") eEffect = EffectDisease(DISEASE_BURROW_MAGGOTS);
   if (sDisease == "CACKLE_FEVER") eEffect = EffectDisease(DISEASE_CACKLE_FEVER);
   if (sDisease == "DEMON_FEVER") eEffect = EffectDisease(DISEASE_DEMON_FEVER);
   if (sDisease == "DEVIL_CHILLS") eEffect = EffectDisease(DISEASE_DEVIL_CHILLS);
   if (sDisease == "DREAD_BLISTERS") eEffect = EffectDisease(DISEASE_DREAD_BLISTERS);
   if (sDisease == "FILTH_FEVER") eEffect = EffectDisease(DISEASE_FILTH_FEVER);
   if (sDisease == "GHOUL_ROT") eEffect = EffectDisease(DISEASE_GHOUL_ROT);
   if (sDisease == "MINDFIRE") eEffect = EffectDisease(DISEASE_MINDFIRE);
   if (sDisease == "MUMMY_ROT") eEffect = EffectDisease(DISEASE_MUMMY_ROT);
   if (sDisease == "RED_ACHE") eEffect = EffectDisease(DISEASE_RED_ACHE);
   if (sDisease == "RED_SLAAD_EGGS") eEffect = EffectDisease(DISEASE_RED_SLAAD_EGGS);
   if (sDisease == "SHAKES") eEffect = EffectDisease(DISEASE_SHAKES);
   if (sDisease == "SLIMY_DOOM") eEffect = EffectDisease(DISEASE_SLIMY_DOOM);
   if (sDisease == "SOLDIER_SHAKES") eEffect = EffectDisease(DISEASE_SOLDIER_SHAKES);
   if (sDisease == "ZOMBIE_CREEP") eEffect = EffectDisease(DISEASE_ZOMBIE_CREEP);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }   
}  


// :: //////////////////////////////////////////
// :: CURSE spell routine - this is the literal 'curse' fountain
// :: //////////////////////////////////////////
void Curse(object oPC, string sCurse, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_CURSE;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   string sTemp = sCurse;
   int nStr = StringToInt(GetStringLeft(sTemp, 1));
   sTemp    = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nDex = StringToInt(GetStringLeft(sTemp, 1));
   sTemp    = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nCon = StringToInt(GetStringLeft(sTemp, 1));
   sTemp    = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nInt = StringToInt(GetStringLeft(sTemp, 1));
   sTemp    = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nWis = StringToInt(GetStringLeft(sTemp, 1));
   sTemp    = GetStringRight(sTemp, GetStringLength(sTemp)-1);
   int nCha = StringToInt(GetStringLeft(sTemp, 1));

   effect eEffect = EffectCurse(nStr, nDex, nCon, nInt, nWis, nCha);
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}   

// :: //////////////////////////////////////////
// :: POLYMORPH routine
// :: obviously this might be highly valuable in some cases, nevertheless I chose to call it a bad thing
// :: //////////////////////////////////////////
void Polymorph(object oPC, string sPolymorph, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);

   if (sMessage == "") sMessage = MESSAGE_POLYMORPH;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   // the hard-coded default is chicken because I think that is the funniest option
   effect eEffect = EffectPolymorph(POLYMORPH_TYPE_CHICKEN);
   
   sPolymorph = GetStringUpperCase(sPolymorph);  // change case
   
   if (sPolymorph == "BADGER") eEffect = EffectPolymorph(POLYMORPH_TYPE_BADGER);
   if (sPolymorph == "BALOR") eEffect = EffectPolymorph(POLYMORPH_TYPE_BALOR);
   if (sPolymorph == "BOAR") eEffect = EffectPolymorph(POLYMORPH_TYPE_BOAR);
   if (sPolymorph == "BROWN_BEAR") eEffect = EffectPolymorph(POLYMORPH_TYPE_BROWN_BEAR);
   if (sPolymorph == "COW") eEffect = EffectPolymorph(POLYMORPH_TYPE_COW);
   if (sPolymorph == "DIRE_BADGER") eEffect = EffectPolymorph(POLYMORPH_TYPE_DIRE_BADGER);
   if (sPolymorph == "DIRE_BOAR") eEffect = EffectPolymorph(POLYMORPH_TYPE_DIRE_BOAR);
   if (sPolymorph == "DIRE_BROWN_BEAR") eEffect = EffectPolymorph(POLYMORPH_TYPE_DIRE_BROWN_BEAR);
   if (sPolymorph == "DIRE_WOLF") eEffect = EffectPolymorph(POLYMORPH_TYPE_DIRE_WOLF);
   if (sPolymorph == "DOOM_KNIGHT") eEffect = EffectPolymorph(POLYMORPH_TYPE_DOOM_KNIGHT);
   if (sPolymorph == "ELDER_AIR_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_ELDER_AIR_ELEMENTAL);
   if (sPolymorph == "ELDER_EARTH_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_ELDER_EARTH_ELEMENTAL);
   if (sPolymorph == "ELDER_FIRE_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_ELDER_FIRE_ELEMENTAL);
   if (sPolymorph == "ELDER_WATER_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_ELDER_WATER_ELEMENTAL);
   if (sPolymorph == "FIRE_GIANT") eEffect = EffectPolymorph(POLYMORPH_TYPE_FIRE_GIANT);
   if (sPolymorph == "GARGOYLE") eEffect = EffectPolymorph(POLYMORPH_TYPE_GARGOYLE);
   if (sPolymorph == "GIANT_SPIDER") eEffect = EffectPolymorph(POLYMORPH_TYPE_GIANT_SPIDER);
   if (sPolymorph == "HUGE_AIR_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_HUGE_AIR_ELEMENTAL);
   if (sPolymorph == "HUGE_EARTH_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_HUGE_EARTH_ELEMENTAL);
   if (sPolymorph == "HUGE_FIRE_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_HUGE_FIRE_ELEMENTAL);
   if (sPolymorph == "HUGE_WATER_ELEMENTAL") eEffect = EffectPolymorph(POLYMORPH_TYPE_HUGE_WATER_ELEMENTAL);
   if (sPolymorph == "IMP") eEffect = EffectPolymorph(POLYMORPH_TYPE_IMP);
   if (sPolymorph == "IRON_GOLEM") eEffect = EffectPolymorph(POLYMORPH_TYPE_IRON_GOLEM);
   if (sPolymorph == "PIXIE") eEffect = EffectPolymorph(POLYMORPH_TYPE_PIXIE);
   if (sPolymorph == "RED_DRAGON") eEffect = EffectPolymorph(POLYMORPH_TYPE_RED_DRAGON);
   if (sPolymorph == "SUCCUBUS") eEffect = EffectPolymorph(POLYMORPH_TYPE_SUCCUBUS);
   if (sPolymorph == "TROLL") eEffect = EffectPolymorph(POLYMORPH_TYPE_TROLL);
   if (sPolymorph == "UMBER_HULK") eEffect = EffectPolymorph(POLYMORPH_TYPE_UMBER_HULK);
   if (sPolymorph == "WEREWOLF") eEffect = EffectPolymorph(POLYMORPH_TYPE_WEREWOLF);
   if (sPolymorph == "WOLF") eEffect = EffectPolymorph(POLYMORPH_TYPE_WOLF);
   if (sPolymorph == "ZOMBIE") eEffect = EffectPolymorph(POLYMORPH_TYPE_ZOMBIE);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }   
}

// :: //////////////////////////////////////////
// :: NEGATIVE LEVEL
// :: //////////////////////////////////////////
void NegativeLevel(object oPC, int nMagnitude, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_REDUCE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_NEGATIVE_LEVEL;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectNegativeLevel(nMagnitude), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectNegativeLevel(nMagnitude), oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: SLOW
// :: //////////////////////////////////////////
void Slow(object oPC, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_SLOW);

   if (sMessage == "") sMessage = MESSAGE_SLOW;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectSlow(), oTarget, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: BAD EFFECT routine - cursed fountain various effects
// :: //////////////////////////////////////////
void BadEffect(object oPC, string sBadEffect, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_DAZED_S);

   if (sMessage == "") sMessage = MESSAGE_BAD_EFFECT;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   sBadEffect = GetStringLowerCase(sBadEffect);
   effect eEffect = EffectDazed();
   
   sBadEffect = GetStringLeft(GetStringLowerCase(sBadEffect), 4);  // change case

   if (sBadEffect == "blin") eEffect = EffectBlindness();
   if (sBadEffect == "stun") eEffect = EffectStunned();
   if (sBadEffect == "slee") eEffect = EffectSleep();
   if (sBadEffect == "deaf") eEffect = EffectDeaf();
   if (sBadEffect == "deat") eEffect = EffectDeath();
   if (sBadEffect == "dead") eEffect = EffectDeath();
   if (sBadEffect == "frig") eEffect = EffectFrightened();
   if (sBadEffect == "para") eEffect = EffectParalyze();
   if (sBadEffect == "sile") eEffect = EffectSilence();
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
   }
}

// :: //////////////////////////////////////////
// :: GIVE XPs
// :: //////////////////////////////////////////
void GiveXPs(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_GIVE_XP;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      GiveXPToCreature(oTarget, nMagnitude);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   GiveXPToCreature(oPC, nMagnitude);
   }
}

// :: //////////////////////////////////////////
// :: TAKE XPs
// :: //////////////////////////////////////////
void TakeXPs(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_DAZED_S);

   if (sMessage == "") sMessage = MESSAGE_TAKE_XP;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

   if (nWholeParty == 1)
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
   RemoveXPFromParty(nMagnitude, oPC, TRUE);
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   RemoveXPFromParty(nMagnitude, oPC, FALSE);
   }
}

// :: //////////////////////////////////////////
// :: GIVE GOLD
// :: //////////////////////////////////////////
void GiveGold(object oPC, int nMagnitude, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_GIVE_GOLD;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
      GiveGoldToCreature(oTarget, nMagnitude);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   GiveGoldToCreature(oPC, nMagnitude);
   }
}

// :: //////////////////////////////////////////
// :: GIVE ITEM
// :: //////////////////////////////////////////
void GiveItem(object oPC, string sResRef, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_IMPROVE_ABILITY_SCORE);

   if (sMessage == "") sMessage = MESSAGE_GIVE_ITEM;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
	  CreateItemOnObject(sResRef, oTarget);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
   CreateItemOnObject(sResRef, oPC);
   }
}

// :: //////////////////////////////////////////
// :: TELEPORTATION - limited static portal
// :: //////////////////////////////////////////

// This is only intended to produce a limited Static Portal effect and can
// only go to a waypoint. It always teleports the whole party.
void Teleport(object oPC, string sWayPointTag, int nFeedback=0, string sMessage="")
{
//   AssignCommand(oPC, ClearAllActions());
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_UNSUMMON);
   ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);

   object   oTarget = GetWaypointByTag(sWayPointTag);
   location lTarget = GetLocation(oTarget);

   if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

   location lLastTeleportLoc = GetLocation(oPC);
   SetLocalLocation(oPC, "lLastTeleportLoc", lLastTeleportLoc);

   oTarget=GetFirstFactionMember(oPC, FALSE);

   while (GetIsObjectValid(oTarget))
      {
	  AssignCommand(oTarget, ClearAllActions());
      AssignCommand(oTarget, ActionJumpToLocation(lTarget));
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
}

// :: //////////////////////////////////////////
// :: JOURNAL ENTRY
// :: //////////////////////////////////////////
void JournalEntry(object oPC, string sCategoryTag, int nEntryID, int nFeedback=0, string sMessage="", int nWholeParty=0)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);

   if (sMessage == "") sMessage = MESSAGE_JOURNAL_ENTRY;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);
   
   if (nWholeParty == 1)
   {
      while (GetIsObjectValid(oTarget))
      {
	  AddJournalQuestEntry(sCategoryTag, nEntryID, oTarget, TRUE, FALSE);
      oTarget=GetNextFactionMember(oPC, FALSE);
      }
   }
   else
   {
   AddJournalQuestEntry(sCategoryTag, nEntryID, oPC, FALSE, FALSE);
   }
}

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// :: ////////////////////////////////////////////////////////////////////////////////////
// :: this begins the MAIN routine
// :: ////////////////////////////////////////////////////////////////////////////////////
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

void FountainMain(object oFountain, object oPC, int nQueryFountainFlag = 0)
{
// :: //////////////////////////////////////////
// :: initialize variables
// :: //////////////////////////////////////////
effect eVis;
string sTemp;
int nTemp;
int nPassFlag;
int nTemp1;
int nTemp2;
int nTemp3;
int nTemp4;

// pull the override flag from the PC
int nFtnSafeOverride = GetLocalInt(oPC, "nFtnSafeOverride");

// pull the variable values from the placeable
int nFeedback             = GetLocalInt(oFountain, "nFeedback");
string sPLCclass          = GetLocalString(oFountain, "sPLCclass");
string sItemDescript      = GetLocalString(oFountain, "sItemDescript");
string sItemGoldenChalice = GetLocalString(oFountain, "sItemGoldenChalice");
string sItemUnicornHorn   = GetLocalString(oFountain, "sItemUnicornHorn");
float  fDuration          = GetLocalFloat(oFountain, "fDuration");
string sDoesNothingMsg    = GetLocalString(oFountain, "sDoNothingMsg");

// parse TakeGold commands: flag & magnitude
string sTakeGoldMsg  = GetLocalString(oFountain, "sTakeGoldMsg");
int nTakeGoldFlag = ParseFlag(GetLocalString(oFountain, "sTakeGold"));
int nTakeGoldMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sTakeGold")));
SetLocalInt(oFountain, "nTakeGoldFlag", nTakeGoldFlag);
SetLocalInt(oFountain, "nTakeGoldMag",  nTakeGoldMag);

// parse TakeItem1 commands: flag & tag & description
string sTakeItem1Msg  = GetLocalString(oFountain, "sTakeItem1Msg");
int nTakeItem1Flag = ParseFlag(GetLocalString(oFountain, "sTakeItem1"));
string sTakeItem1Tag = ParseParameter1(GetLocalString(oFountain, "sTakeItem1"));
string sTakeItem1Desc = ParseParameter2(GetLocalString(oFountain, "sTakeItem1"));
SetLocalInt(oFountain, "nTakeItem1Flag", nTakeItem1Flag);
SetLocalString(oFountain, "sTakeItem1Tag", sTakeItem1Tag);
SetLocalString(oFountain, "sTakeItem1Desc", sTakeItem1Desc);

// parse TakeItem2 commands: flag & tag & description
string sTakeItem2Msg  = GetLocalString(oFountain, "sTakeItem2Msg");
int nTakeItem2Flag = ParseFlag(GetLocalString(oFountain, "sTakeItem2"));
string sTakeItem2Tag = ParseParameter1(GetLocalString(oFountain, "sTakeItem2"));
string sTakeItem2Desc = ParseParameter2(GetLocalString(oFountain, "sTakeItem2"));
SetLocalInt(oFountain, "nTakeItem2Flag", nTakeItem2Flag);
SetLocalString(oFountain, "sTakeItem2Tag", sTakeItem2Tag);
SetLocalString(oFountain, "sTakeItem2Desc", sTakeItem2Desc);

// parse TakeItem3 commands: flag & tag & description
string sTakeItem3Msg  = GetLocalString(oFountain, "sTakeItem3Msg");
int nTakeItem3Flag = ParseFlag(GetLocalString(oFountain, "sTakeItem3"));
string sTakeItem3Tag = ParseParameter1(GetLocalString(oFountain, "sTakeItem3"));
string sTakeItem3Desc = ParseParameter2(GetLocalString(oFountain, "sTakeItem3"));
SetLocalInt(oFountain, "nTakeItem3Flag", nTakeItem3Flag);
SetLocalString(oFountain, "sTakeItem3Tag", sTakeItem3Tag);
SetLocalString(oFountain, "sTakeItem3Desc", sTakeItem3Desc);

// parse TakeItem4 commands: flag & tag & description
string sTakeItem4Msg  = GetLocalString(oFountain, "sTakeItem4Msg");
int nTakeItem4Flag = ParseFlag(GetLocalString(oFountain, "sTakeItem4"));
string sTakeItem4Tag = ParseParameter1(GetLocalString(oFountain, "sTakeItem4"));
string sTakeItem4Desc = ParseParameter2(GetLocalString(oFountain, "sTakeItem4"));
SetLocalInt(oFountain, "nTakeItem4Flag", nTakeItem4Flag);
SetLocalString(oFountain, "sTakeItem4Tag", sTakeItem4Tag);
SetLocalString(oFountain, "sTakeItem4Desc", sTakeItem4Desc);

/*
string sTakeItem1         = GetLocalString(oFountain, "sTakeItem1");
string sItem1Descript     = GetLocalString(oFountain, "sItem1Descript");
string sTakeItem2         = GetLocalString(oFountain, "sTakeItem2");
string sItem2Descript     = GetLocalString(oFountain, "sItem2Descript");
string sTakeItem3         = GetLocalString(oFountain, "sTakeItem3");
string sItem3Descript     = GetLocalString(oFountain, "sItem3Descript");
string sTakeItem4         = GetLocalString(oFountain, "sTakeItem4");
string sItem4Descript     = GetLocalString(oFountain, "sItem4Descript");
*/

// :: //////////////////////////////////////////
// :: pull User-Defined Function variables from the fountain
// :: //////////////////////////////////////////

string sUserDef1Flag    = GetLocalString(oFountain, "sUserDef1Flag");
int    nUserDef1Mag     = GetLocalInt(oFountain,    "nUserDef1Mag");
string sUserDef1String  = GetLocalString(oFountain, "sUserDef1String");
int    nUserDef1Mag2    = GetLocalInt(oFountain,    "nUserDef1Mag2");
string sUserDef1String2 = GetLocalString(oFountain, "sUserDef1String2");
string sUserDef1Msg     = GetLocalString(oFountain, "sUserDef1Msg");

string sUserDef2Flag    = GetLocalString(oFountain, "sUserDef2Flag");
int    nUserDef2Mag     = GetLocalInt(oFountain,    "nUserDef2Mag");
string sUserDef2String  = GetLocalString(oFountain, "sUserDef2String");
int    nUserDef2Mag2    = GetLocalInt(oFountain,    "nUserDef2Mag2");
string sUserDef2String2 = GetLocalString(oFountain, "sUserDef2String2");
string sUserDef2Msg     = GetLocalString(oFountain, "sUserDef2Msg");

// generate flag variables using similar system to my functions
int nUserDef1Flag = ParseFlag(sUserDef1Flag);
SetLocalInt(oFountain, "nUserDef1Flag", nUserDef1Flag);

int nUserDef2Flag = ParseFlag(sUserDef2Flag);
SetLocalInt(oFountain, "nUserDef2Flag", nUserDef2Flag);

// SendMessageToPC(GetPCSpeaker(), IntToString(nUserDef1Flag));
// SendMessageToPC(GetPCSpeaker(), IntToString(nUserDef2Flag));

// :: //////////////////////////////////////////
// :: parse out the command strings
// :: //////////////////////////////////////////

// parse sSimpleHeal commands: flag & magnitude
string sSimpleHealMsg  = GetLocalString(oFountain, "sSimpleHealMsg");
int nSimpleHealFlag = ParseFlag(GetLocalString(oFountain, "sSimpleHeal"));
int nSimpleHealMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sSimpleHeal")));
SetLocalInt(oFountain, "nSimpleHealFlag", nSimpleHealFlag);
SetLocalInt(oFountain, "nSimpleHealMag",  nSimpleHealMag);

// parse sCompleteHeal commands: flag
string sCompleteHealMsg  = GetLocalString(oFountain, "sCompleteHealMsg");
int nCompleteHealFlag = ParseFlag(GetLocalString(oFountain, "sCompleteHeal"));
SetLocalInt(oFountain, "nCompleteHealFlag", nCompleteHealFlag);

// parse sRestoration command: flag
string sRestorationMsg  = GetLocalString(oFountain, "sRestorationMsg");
int nRestorationFlag = ParseFlag(GetLocalString(oFountain, "sRestoration"));
SetLocalInt(oFountain, "nRestorationFlag", nRestorationFlag);

// parse RemoveCurse commands: flag
string sRemoveCurseMsg  = GetLocalString(oFountain, "sRemoveCurseMsg");
int nRemoveCurseFlag = ParseFlag(GetLocalString(oFountain, "sRemoveCurse"));
SetLocalInt(oFountain, "nRemoveCurseFlag", nRemoveCurseFlag);

// parse sCureDisease commands: flag
string sCureDiseaseMsg  = GetLocalString(oFountain, "sCureDiseaseMsg");
int nCureDiseaseFlag = ParseFlag(GetLocalString(oFountain, "sCureDisease"));
SetLocalInt(oFountain, "nCureDiseaseFlag", nCureDiseaseFlag);

// parse sHeroismPackage commands: flag & magnitude
string sHeroismPackageMsg  = GetLocalString(oFountain, "sHeroismPackageMsg");
int nHeroismPackageFlag = ParseFlag(GetLocalString(oFountain, "sHeroismPackage"));
int nHeroismPackageMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sHeroismPackage")));
SetLocalInt(oFountain, "nHeroismPackageFlag", nHeroismPackageFlag);
SetLocalInt(oFountain, "nHeroismPackageMag",  nHeroismPackageMag);

// parse sAbilityBonus commands: flag & type (=sMag)
string sAbilityBonusMsg  = GetLocalString(oFountain, "sAbilityBonusMsg");
int nAbilityBonusFlag = ParseFlag(GetLocalString(oFountain, "sAbilityBonus"));
string sAbilityBonusMag  = ParseParameter1(GetLocalString(oFountain, "sAbilityBonus"));
sAbilityBonusMag = StripString(sAbilityBonusMag, " ");  // remove blanks
SetLocalInt(oFountain, "nAbilityBonusFlag", nAbilityBonusFlag);
SetLocalString(oFountain, "sAbilityBonusMag", sAbilityBonusMag);

// parse sConcealment commands: flag & magnitude
string sConcealmentMsg  = GetLocalString(oFountain, "sConcealmentMsg");
int nConcealmentFlag = ParseFlag(GetLocalString(oFountain, "sConcealment"));
int nConcealmentMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sConcealment")));
SetLocalInt(oFountain, "nConcealmentFlag", nConcealmentFlag);
SetLocalInt(oFountain, "nConcealmentMag", nConcealmentMag);

// parse sInvisibility commands: flag & type
string sInvisibilityMsg  = GetLocalString(oFountain, "sInvisibilityMsg");
int nInvisibilityFlag = ParseFlag(GetLocalString(oFountain, "sInvisibility"));
string sInvisibilityType  = ParseParameter1(GetLocalString(oFountain, "sInvisibility"));
sInvisibilityType = StripString(sInvisibilityType, " ");  // remove blanks
SetLocalInt(oFountain, "nInvisibilityFlag", nInvisibilityFlag);
SetLocalString(oFountain, "sInvisibilityType", sInvisibilityType);

// parse Haste commands: flag
string sHasteMsg  = GetLocalString(oFountain, "sHasteMsg");
int nHasteFlag = ParseFlag(GetLocalString(oFountain, "sHaste"));
SetLocalInt(oFountain, "nHasteFlag", nHasteFlag);

// parse Vision commands: flag & type
string sVisionMsg  = GetLocalString(oFountain, "sVisionMsg");
int nVisionFlag = ParseFlag(GetLocalString(oFountain, "sVision"));
string sVisionType  = ParseParameter1(GetLocalString(oFountain, "sVision"));
sVisionType = StripString(sVisionType, " ");  // remove blanks
SetLocalInt(oFountain, "nVisionFlag", nVisionFlag);
SetLocalString(oFountain, "sVisionType", sVisionType);

// parse Regeneration commands: flag & magnitude
string sRegenerationMsg  = GetLocalString(oFountain, "sRegenerationMsg");
int nRegenerationFlag = ParseFlag(GetLocalString(oFountain, "sRegeneration"));
int nRegenerationMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sRegeneration")));
SetLocalInt(oFountain, "nRegenerationFlag", nRegenerationFlag);
SetLocalInt(oFountain, "nRegenerationMag", nRegenerationMag);

// parse ArmorClass commands: flag & magnitude
string sArmorClassMsg  = GetLocalString(oFountain, "ArmorClassMsg");
int nArmorClassFlag = ParseFlag(GetLocalString(oFountain, "sArmorClass"));
int nArmorClassMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sArmorClass")));
SetLocalInt(oFountain, "nArmorClassFlag", nArmorClassFlag);
SetLocalInt(oFountain, "nArmorClassMag", nArmorClassMag);

// parse TempHitPoints commands: flag & magnitude
string sTempHitPointsMsg  = GetLocalString(oFountain, "sTempHitPointsMsg");
int nTempHitPointsFlag = ParseFlag(GetLocalString(oFountain, "sTempHitPoints"));
int nTempHitPointsMag  = StringToInt(ParseParameter1(GetLocalString(oFountain, "sTempHitPoints")));
SetLocalInt(oFountain, "nTempHitPointsFlag", nTempHitPointsFlag);
SetLocalInt(oFountain, "nTempHitPointsMag", nTempHitPointsMag);

// parse IncreaseMove commands: flag & magnitude
string sIncreaseMoveMsg = GetLocalString(oFountain, "sIncreaseMoveMsg");
int nIncreaseMoveFlag = ParseFlag(GetLocalString(oFountain, "sIncreaseMove"));
int nIncreaseMoveMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sIncreaseMove")));
SetLocalInt(oFountain, "nIncreaseMoveFlag", nIncreaseMoveFlag);
SetLocalInt(oFountain, "nIncreaseMoveMag", nIncreaseMoveMag);

// parse AttackBonus commands: flag & magnitude
string sAttackBonusMsg = GetLocalString(oFountain, "sAttackBonusMsg");
int nAttackBonusFlag = ParseFlag(GetLocalString(oFountain, "sAttackBonus"));
int nAttackBonusMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sAttackBonus")));
SetLocalInt(oFountain, "nAttackBonusFlag", nAttackBonusFlag);
SetLocalInt(oFountain, "nAttackBonusMag", nAttackBonusMag);

// parse SpellResistIncr commands: flag & magnitude
string sSpellResistIncrMsg = GetLocalString(oFountain, "sSpellResistIncrMsg");
int nSpellResistIncrFlag = ParseFlag(GetLocalString(oFountain, "sSpellResistIncr"));
int nSpellResistIncrMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sSpellResistIncr")));
SetLocalInt(oFountain, "nSpellResistIncrFlag", nSpellResistIncrFlag);
SetLocalInt(oFountain, "nSpellResistIncrMag", nSpellResistIncrMag);

// parse SkillIncrease commands: flag & magnitude
string sSkillIncreaseMsg = GetLocalString(oFountain, "sSkillIncreaseMsg");
int nSkillIncreaseFlag = ParseFlag(GetLocalString(oFountain, "sSkillIncrease"));
int nSkillIncreaseMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sSkillIncrease")));
SetLocalInt(oFountain, "nSkillIncreaseFlag", nSkillIncreaseFlag);
SetLocalInt(oFountain, "nSkillIncreaseMag", nSkillIncreaseMag);

// parse SaveThrowIncr commands: flag & magnitude & type
string sSaveThrowIncrMsg = GetLocalString(oFountain, "sSaveThrowIncrMsg");
int nSaveThrowIncrFlag = ParseFlag(GetLocalString(oFountain, "sSaveThrowIncr"));
int nSaveThrowIncrMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sSaveThrowIncr")));
string sSaveThrowIncrType = ParseParameter2(GetLocalString(oFountain, "sSaveThrowIncr"));
sSaveThrowIncrType = StripString(sSaveThrowIncrType, " ");  // remove blanks
SetLocalInt(oFountain, "nSaveThrowIncrFlag", nSaveThrowIncrFlag);
SetLocalInt(oFountain, "nSaveThrowIncrMag", nSaveThrowIncrMag);
SetLocalString(oFountain, "sSaveThrowIncrType", sSaveThrowIncrType);

// parse Damage commands: flag & magnitude & type
string sDamageMsg = GetLocalString(oFountain, "sDamageMsg");
int nDamageFlag = ParseFlag(GetLocalString(oFountain, "sDamage"));
int nDamageMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sDamage")));
string sDamageType = ParseParameter2(GetLocalString(oFountain, "sDamage"));
sDamageType = StripString(sDamageType, " ");  // remove blanks
SetLocalInt(oFountain, "nDamageFlag", nDamageFlag);
SetLocalInt(oFountain, "nDamageMag", nDamageMag);
SetLocalString(oFountain, "sDamageType", sDamageType);

// parse Poison commands: flag & type
string sPoisonMsg  = GetLocalString(oFountain, "sPoisonMsg");
int nPoisonFlag = ParseFlag(GetLocalString(oFountain, "sPoison"));
string sPoisonType  = ParseParameter1(GetLocalString(oFountain, "sPoison"));
sPoisonType = StripString(sPoisonType, " ");  // remove blanks
SetLocalInt(oFountain, "nPoisonFlag", nPoisonFlag);
SetLocalString(oFountain, "sPoisonType", sPoisonType);

// parse Disease commands: flag & type
string sDiseaseMsg  = GetLocalString(oFountain, "sDiseaseMsg");
int nDiseaseFlag = ParseFlag(GetLocalString(oFountain, "sDisease"));
string sDiseaseType  = ParseParameter1(GetLocalString(oFountain, "sDisease"));
sDiseaseType = StripString(sDiseaseType, " ");  // remove blanks
SetLocalInt(oFountain, "nDiseaseFlag", nDiseaseFlag);
SetLocalString(oFountain, "sDiseaseType", sDiseaseType);

// parse BadEffect commands: flag & type
string sBadEffectMsg  = GetLocalString(oFountain, "sBadEffectMsg");
int nBadEffectFlag = ParseFlag(GetLocalString(oFountain, "sBadEffect"));
string sBadEffectType  = ParseParameter1(GetLocalString(oFountain, "sBadEffect"));
sBadEffectType = StripString(sBadEffectType, " ");  // remove blanks
SetLocalInt(oFountain, "nBadEffectFlag", nBadEffectFlag);
SetLocalString(oFountain, "sBadEffectType", sBadEffectType);

// parse Curse commands: flag & type
string sCurseMsg  = GetLocalString(oFountain, "sCurseMsg");
int nCurseFlag = ParseFlag(GetLocalString(oFountain, "sCurse"));
string sCurseType  = ParseParameter1(GetLocalString(oFountain, "sCurse"));
sCurseType = StripString(sCurseType, " ");  // remove blanks
SetLocalInt(oFountain, "nCurseFlag", nCurseFlag);
SetLocalString(oFountain, "sCurseType", sCurseType);

// parse Polymorph commands: flag & type
string sPolymorphMsg  = GetLocalString(oFountain, "sPolymorphMsg");
int nPolymorphFlag = ParseFlag(GetLocalString(oFountain, "sPolymorph"));
string sPolymorphType  = ParseParameter1(GetLocalString(oFountain, "sPolymorph"));
sPolymorphType = StripString(sPolymorphType, " ");  // remove blanks
SetLocalInt(oFountain, "nPolymorphFlag", nPolymorphFlag);
SetLocalString(oFountain, "sPolymorphType", sPolymorphType);

// parse NegativeLevel commands: flag & magnitude
string sNegativeLevelMsg = GetLocalString(oFountain, "sNegativeLevelMsg");
int nNegativeLevelFlag = ParseFlag(GetLocalString(oFountain, "sNegativeLevel"));
int nNegativeLevelMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sNegativeLevel")));
SetLocalInt(oFountain, "nNegativeLevelFlag", nNegativeLevelFlag);
SetLocalInt(oFountain, "NegativeLevelMag", nNegativeLevelMag);

// parse Slow commands: flag
string sSlowMsg  = GetLocalString(oFountain, "sSlowMsg");
int nSlowFlag = ParseFlag(GetLocalString(oFountain, "sSlow"));
SetLocalInt(oFountain, "nSlowFlag", nSlowFlag);

// parse GiveXPs commands: flag & magnitude
string sGiveXPsMsg = GetLocalString(oFountain, "sGiveXPsMsg");
int nGiveXPsFlag = ParseFlag(GetLocalString(oFountain, "sGiveXPs"));
int nGiveXPsMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sGiveXPs")));
SetLocalInt(oFountain, "nGiveXPsFlag", nGiveXPsFlag);
SetLocalInt(oFountain, "GiveXPsMag", nGiveXPsMag);

// parse TakeXPs commands: flag & magnitude
string sTakeXPsMsg = GetLocalString(oFountain, "sTakeXPsMsg");
int nTakeXPsFlag = ParseFlag(GetLocalString(oFountain, "sTakeXPs"));
int nTakeXPsMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sTakeXPs")));
SetLocalInt(oFountain, "nTakeXPsFlag", nTakeXPsFlag);
SetLocalInt(oFountain, "TakeXPsMag", nTakeXPsMag);

// parse GiveGold commands: flag & magnitude
string sGiveGoldMsg = GetLocalString(oFountain, "sGiveGoldMsg");
int nGiveGoldFlag = ParseFlag(GetLocalString(oFountain, "sGiveGold"));
int nGiveGoldMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sGiveGold")));
SetLocalInt(oFountain, "nGiveGoldFlag", nGiveGoldFlag);
SetLocalInt(oFountain, "GiveGoldMag", nGiveGoldMag);

// parse GiveItem commands: flag & item_resref
string sGiveItemMsg  = GetLocalString(oFountain, "sGiveItemMsg");
int nGiveItemFlag = ParseFlag(GetLocalString(oFountain, "sGiveItem"));
string sGiveItemResRef  = ParseParameter1(GetLocalString(oFountain, "sGiveItem"));
sGiveItemResRef = StripString(sGiveItemResRef, " ");  // remove blanks
SetLocalInt(oFountain, "nGiveItemFlag", nGiveItemFlag);
SetLocalString(oFountain, "sGiveItemResRef", sGiveItemResRef);

// parse Teleport commands: flag & waypoint_tag
// this is the Fountain version so it is only simple teleportation
string sTeleportMsg  = GetLocalString(oFountain, "sTeleportMsg");
int nTeleportFlag = ParseFlag(GetLocalString(oFountain, "sTeleport"));
string sTeleportWPtag  = ParseParameter1(GetLocalString(oFountain, "sTeleport"));
sTeleportWPtag = StripString(sTeleportWPtag, " ");  // remove blanks
SetLocalInt(oFountain, "nTeleportFlag", nTeleportFlag);
SetLocalString(oFountain, "sTeleportWPtag", sTeleportWPtag);

// parse JournalEntry commands: flag & magnitude & type
string sJournalEntryMsg = GetLocalString(oFountain, "sJournalEntryMsg");
int nJournalEntryFlag = ParseFlag(GetLocalString(oFountain, "sJournalEntry"));
int nJournalEntryMag = StringToInt(ParseParameter1(GetLocalString(oFountain, "sJournalEntry")));
string sJournalEntryType = ParseParameter2(GetLocalString(oFountain, "sJournalEntry"));
sJournalEntryType = StripString(sJournalEntryType, " ");  // remove blanks
SetLocalInt(oFountain, "nJournalEntryFlag", nJournalEntryFlag);
SetLocalInt(oFountain, "nJournalEntryMag", nJournalEntryMag);
SetLocalString(oFountain, "sJournalEntryType", sJournalEntryType);


// :: //////////////////////////////////////////
// :: set DEFAULT values
// :: //////////////////////////////////////////

// Whenever possible I try to make variables case insensitive.
// For obvious reasons I had to stop short of doing this with Item tags.
sPLCclass = GetStringLowerCase(sPLCclass);

if (sPLCclass == "")          sPLCclass = DEFAULT_PLC_CLASS;
if (fDuration == 0.0f)        fDuration = DEFAULT_DURATION;
if (sItemGoldenChalice == "") sItemGoldenChalice = ITEM_GOLDEN_CHALICE;
if (sItemUnicornHorn == "")   sItemUnicornHorn = ITEM_UNICORN_HORN;
if (nFeedback == 0)           nFeedback = FEEDBACK_DEFAULT;

if (nSimpleHealMag == 0)      nSimpleHealMag = DEFAULT_SIMPLEHEAL_MAG;
if (sAbilityBonusMag == "")   sAbilityBonusMag = DEFAULT_ABILITY_BONUS_MAG;
if (nConcealmentMag == 0)     nConcealmentMag = DEFAULT_CONCEALMENT_MAG;
if (sInvisibilityType == "")  sInvisibilityType = DEFAULT_INVISIBILITY_TYPE;
if (sVisionType == "")        sVisionType = DEFAULT_VISION_TYPE;
if (nRegenerationMag == 0)    nRegenerationMag = DEFAULT_REGENERATION_MAG;
if (nArmorClassMag == 0)      nArmorClassMag = DEFAULT_ARMOR_CLASS_MAG;
if (nTempHitPointsMag == 0)   nTempHitPointsMag = DEFAULT_TEMP_HP_MAG;
if (nIncreaseMoveMag == 0)    nIncreaseMoveMag = DEFAULT_INCR_MOVE_MAG;
if (nAttackBonusMag == 0)     nAttackBonusMag = DEFAULT_ATTACK_BONUS_MAG;
if (nSpellResistIncrMag == 0) nSpellResistIncrMag = DEFAULT_SPELL_RESIST_INCR_MAG;
if (nSkillIncreaseMag == 0)   nSkillIncreaseMag = DEFAULT_SKILL_INCR_MAG;
if (nSaveThrowIncrMag == 0)   nSaveThrowIncrMag = DEFAULT_SAVETHROWINCR_MAG;
if (sSaveThrowIncrType == "") sSaveThrowIncrType = DEFAULT_SAVETHROWINCR_TYPE;
if (nDamageMag == 0)          nDamageMag = DEFAULT_DAMAGE_MAG;
if (sDamageType == "")        sDamageType = DEFAULT_DAMAGE_TYPE;
if (sPoisonType == "")        sPoisonType = DEFAULT_POISON_TYPE;
if (sDiseaseType == "")       sDiseaseType = DEFAULT_DISEASE_TYPE;
if (sBadEffectType == "")     sBadEffectType = DEFAULT_BAD_EFFECT_TYPE;
if (sCurseType == "")         sCurseType = DEFAULT_CURSE_TYPE;
if (sPolymorphType == "")     sPolymorphType = DEFAULT_POLYMORPH_TYPE;
if (nNegativeLevelMag == 0)   nNegativeLevelMag = DEFAULT_NEG_LEVEL_MAG;
if (nGiveXPsMag == 0)         nGiveXPsMag = DEFAULT_GIVE_XP_MAG;
if (nTakeXPsMag == 0)         nTakeXPsMag = DEFAULT_TAKE_XP_MAG;
if (nGiveGoldMag == 0)        nGiveGoldMag = DEFAULT_GIVE_GOLD_MAG;


// :: //////////////////////////////////////////
// :: check for required conditions
// :: //////////////////////////////////////////

// Check the number of times this fountain is useable and whether that
// limit has been reached. nUseOnce = 1 means only useable once per PC,
// nUseOnce = 2 means once per level, nUseOnce = 3 means once per day
// nUsedAlready is set to either current level or day

// This generalizes for multiple fountains and players by using the PC name
// as the name of the variable to store the nUsedAlready information on the fountain.

string sUseFlagName       = CleanString(GetName(oPC));
int    nUseOnce           = GetLocalInt(oFountain, "nUseOnce");
int    nUsedAlready       = GetLocalInt(oFountain, sUseFlagName);

if ((nUseOnce > 0) & (nQueryFountainFlag == 0))
{
   if (nUsedAlready == 0) nUsedAlready = 1;
   int nUseTest;
   
   if (nUseOnce == 1) nUseTest = 1;
   if (nUseOnce == 2) nUseTest = GetCalendarDay();
   if (nUseOnce == 3) nUseTest = GetTotalLevels(oPC, FALSE);

   string sUseMessage;
   if (nUseOnce == 1) sUseMessage = MESSAGE_USED_ONCE;
   if (nUseOnce == 2) sUseMessage = MESSAGE_USED_TODAY;
   if (nUseOnce == 3) sUseMessage = MESSAGE_USED_THIS_LEVEL;

   // check for custom failure message for this fountain
   string sUseLimitMsg = GetLocalString(oFountain, "sUseLimitMsg");
   
   if (!(sUseLimitMsg == "")) sUseMessage = sUseLimitMsg;

   if ((nUseOnce > 0) & (nUsedAlready > nUseTest))
      {
      SendMessageToPC(oPC, sUseMessage);
      return;
      }

   nUsedAlready = nUsedAlready + 1;
   SetLocalInt(oFountain, sUseFlagName, nUsedAlready);
}

// Check for Gold requirement
// Check that this is a 'fountain' rather than something else and
// the player does not possess a Golden Chalice item.
if ((nQueryFountainFlag == 0) & (nTakeGoldFlag > 0))
{
  if ((sPLCclass == "fountain") & (GetItemPossessedBy(oPC, sItemGoldenChalice)== OBJECT_INVALID))
  {
     if (nTakeGoldMag > 0)
     {
        if (GetGold(oPC) >= nTakeGoldMag)
        {
        AssignCommand(oPC, TakeGoldFromCreature(nTakeGoldMag, oPC, TRUE));
        SendMessageToPC(oPC, MESSAGE_TAKE_GOLD);
        }
        else
        {
	    SendMessageToPC(oPC, MESSAGE_INSUFFICIENT_GOLD+IntToString(nTakeGoldMag)+" gp.");
	    return;
	    }
     }
  }
}

// Check for Item requirement
// the golden chalice only works for gold requirement and not for materials
// the odd-ball coding was intended to make it a bit more forgiving with
// respect to the case-sensitivity of Tag and ResRef input data

int nTakeItemFlag = nTakeItem1Flag + nTakeItem2Flag + nTakeItem3Flag + nTakeItem4Flag;

if ((nQueryFountainFlag == 0) & (nTakeItemFlag > 0))
{
  if ((sTakeItem1Tag != "") | (sTakeItem2Tag != "") | (sTakeItem3Tag != "") | (sTakeItem4Tag != ""))
  {
  // see if he has everything he needs
  if (HasItem(oPC, sTakeItem1Tag) == TRUE) nTemp1 = TRUE;
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem1Tag)) == TRUE) nTemp1 = TRUE;
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem1Tag)) == TRUE) nTemp1 = TRUE;
	       else if (sTakeItem1Tag == "") nTemp1 = TRUE;
	    	    else nTemp1 == FALSE;
			
  if (HasItem(oPC, sTakeItem2Tag) == TRUE) nTemp2 = TRUE;
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem2Tag)) == TRUE) nTemp2 = TRUE;
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem2Tag)) == TRUE) nTemp2 = TRUE;
	       else if (sTakeItem2Tag == "") nTemp2 = TRUE;
		      else nTemp2 == FALSE;
	  
  if (HasItem(oPC, sTakeItem3Tag) == TRUE) nTemp3 = TRUE;
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem3Tag)) == TRUE) nTemp3 = TRUE;
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem3Tag)) == TRUE) nTemp3 = TRUE;
	       else if (sTakeItem3Tag == "") nTemp3 = TRUE;
		      else nTemp3 == FALSE;
			
  if (HasItem(oPC, sTakeItem4Tag) == TRUE) nTemp4 = TRUE;
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem4Tag)) == TRUE) nTemp4 = TRUE;
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem4Tag)) == TRUE) nTemp4 = TRUE;
	       else if (sTakeItem4Tag == "") nTemp4 = TRUE;
		      else nTemp4 == FALSE;
			
  // take each and issue message
  if (nTemp1 & nTemp2 & nTemp3 & nTemp4) 
     {
     if (HasItem(oPC, sTakeItem1Tag) == TRUE) DestroyObject(GetItemPossessedBy(oPC, sTakeItem1Tag));
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem1Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringLowerCase(sTakeItem1Tag)));
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem1Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringUpperCase(sTakeItem1Tag)));
				
     if (HasItem(oPC, sTakeItem2Tag) == TRUE) DestroyObject(GetItemPossessedBy(oPC, sTakeItem2Tag));
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem2Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringLowerCase(sTakeItem2Tag)));
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem2Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringUpperCase(sTakeItem2Tag)));

     if (HasItem(oPC, sTakeItem3Tag) == TRUE) DestroyObject(GetItemPossessedBy(oPC, sTakeItem3Tag));
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem3Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringLowerCase(sTakeItem3Tag)));
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem3Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringUpperCase(sTakeItem3Tag)));

     if (HasItem(oPC, sTakeItem4Tag) == TRUE) DestroyObject(GetItemPossessedBy(oPC, sTakeItem4Tag));
     else if (HasItem(oPC, GetStringLowerCase(sTakeItem4Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringLowerCase(sTakeItem4Tag)));
        else if (HasItem(oPC, GetStringUpperCase(sTakeItem4Tag)) == TRUE) DestroyObject(GetItemPossessedBy(oPC, GetStringUpperCase(sTakeItem4Tag)));
		   
     SendMessageToPC(oPC, MESSAGE_TAKE_ITEM);
     }
     else
     {
     SendMessageToPC(oPC, MESSAGE_TAKE_ITEM_DESC);
     SendMessageToPC(oPC, sTakeItem1Desc + " " + sTakeItem2Desc + " " + sTakeItem3Desc + " " + sTakeItem4Desc);
     return;
     } 
  }
}

// ::  ////////////////////////////////////////////////////////////////////////////////
// :: begin applying GOOD effects routines
// ::  ////////////////////////////////////////////////////////////////////////////////

// figure out whether this is a good or bad fountain (or maybe just does nothing)
int nDoesGood = nSimpleHealFlag + nCompleteHealFlag + nRestorationFlag + nRemoveCurseFlag + nCureDiseaseFlag + nHeroismPackageFlag + nAbilityBonusFlag + nConcealmentFlag + nInvisibilityFlag + nHasteFlag + nVisionFlag + nRegenerationFlag + nArmorClassFlag + nAttackBonusFlag + nSpellResistIncrFlag + nSkillIncreaseFlag + nSaveThrowIncrFlag + nTempHitPointsFlag + nIncreaseMoveFlag + nGiveXPsFlag + nGiveGoldFlag + nUserDef1Flag;
int nDoesBad  = nDamageFlag + nPoisonFlag + nDiseaseFlag + nBadEffectFlag + nCurseFlag + nPolymorphFlag + nNegativeLevelFlag + nSlowFlag + nTakeXPsFlag + nUserDef2Flag;
int nDoesNothing = nDoesGood + nDoesBad;

// SendMessageToPC(oPC, sHeroismPackage+"="+IntToString(nDoesGood)+IntToString(nDoesBad)+IntToString(nDoesNothing));

// Check to see whether this is merely a query (rather than a request to actually do anything).
// The point of this whole QueryFlag business is to make it possible for a Conversation to know whether the fountain is good or bad before the
// PC has experienced the effects.
if (nQueryFountainFlag == 1)
  {
  SetLocalInt(oFountain, "nDoesGood", nDoesGood);
  SetLocalInt(oFountain, "nDoesBad",  nDoesBad);
  SetLocalInt(oPC, "nFtnSafeOverride", 0);
  return;
  }

// check to see whether effects should apply to the whole party or just the PC
// start with the assumption that only the PC will drink
   int nWholeParty=0;
// if it is completely safe then everyone drinks
   if (nDoesBad == 0) nWholeParty = 1;
// if the PC specified in a dialog that he wanted the whole party to drink then they will
// @@@ need to add this code @@@

// the global setting for party never drinking automatically 
// prevents the flag from ever becoming 1 (which would allow auto-drinking).
   nWholeParty = nWholeParty - PARTY_NEVER_DRINKS;
   
// SendMessageToPC(GetPCSpeaker(), IntToString(nWholeParty) + "," + IntToString(nDoesBad));
   
// start doing things
   if (nDoesNothing == 0)         DoesNothing(oPC, nFeedback, sDoesNothingMsg);
   if (nSimpleHealFlag == 1)      SimpleHeal(oPC, nSimpleHealMag, nFeedback, sSimpleHealMsg, nWholeParty);
   if (nCompleteHealFlag == 1)    CompleteHeal(oPC, nFeedback, sCompleteHealMsg, nWholeParty);
   if (nRestorationFlag == 1)     Restoration(oPC, nFeedback, sRestorationMsg, nWholeParty);
   if (nRemoveCurseFlag == 1)     RemoveCurse(oPC, nFeedback, sRemoveCurseMsg, nWholeParty);
   if (nCureDiseaseFlag == 1)     CureDisease(oPC, nFeedback, sCureDiseaseMsg, nWholeParty);
   if (nHeroismPackageFlag == 1)  HeroismPackage(oPC, nHeroismPackageMag, fDuration, nFeedback, sHeroismPackageMsg, nWholeParty);
   if (nAbilityBonusFlag == 1)    AbilityBonus(oPC, sAbilityBonusMag, fDuration, nFeedback, sAbilityBonusMsg, nWholeParty);
   if (nConcealmentFlag == 1)     Concealment(oPC, nConcealmentMag, fDuration, nFeedback, sConcealmentMsg, nWholeParty);
   if (nInvisibilityFlag == 1)    Invisibility(oPC, sInvisibilityType, fDuration, nFeedback, sInvisibilityMsg, nWholeParty);
   if (nHasteFlag == 1)           Haste(oPC, fDuration, nFeedback, sHasteMsg, nWholeParty);
   if (nVisionFlag == 1)          Vision(oPC, sVisionType, fDuration, nFeedback, sVisionMsg, nWholeParty);
   if (nRegenerationFlag == 1)    Regeneration(oPC, nRegenerationMag, fDuration, nFeedback, sRegenerationMsg, nWholeParty);
   if (nArmorClassFlag == 1)      ArmorClass(oPC, nArmorClassMag, fDuration, nFeedback, sArmorClassMsg, nWholeParty);
   if (nAttackBonusFlag == 1)     AttackBonus(oPC, nAttackBonusMag, fDuration, nFeedback, sAttackBonusMsg, nWholeParty);
   if (nSpellResistIncrFlag == 1) SpellResistIncr(oPC, nSpellResistIncrMag, fDuration, nFeedback, sSpellResistIncrMsg, nWholeParty);
   if (nSkillIncreaseFlag == 1)   SkillIncrease(oPC, nSkillIncreaseMag, fDuration, nFeedback, sSkillIncreaseMsg, nWholeParty);
   if (nSaveThrowIncrFlag == 1)   SaveThrowIncr(oPC, nSaveThrowIncrMag, sSaveThrowIncrType, fDuration, nFeedback, sSaveThrowIncrMsg, nWholeParty);
   if (nTempHitPointsFlag == 1)   TempHitPoints(oPC, nTempHitPointsMag, fDuration, nFeedback, sTempHitPointsMsg, nWholeParty);
   if (nIncreaseMoveFlag == 1)    IncreaseMove(oPC, nIncreaseMoveMag, fDuration, nFeedback, sIncreaseMoveMsg, nWholeParty);
   if (nGiveXPsFlag == 1)         GiveXPs(oPC, nGiveXPsMag, nFeedback, sGiveXPsMsg, nWholeParty);
   if (nGiveGoldFlag == 1)        GiveGold(oPC, nGiveGoldMag, nFeedback, sGiveGoldMsg, nWholeParty);
   if (nGiveItemFlag == 1)        GiveItem(oPC, sGiveItemResRef, nFeedback, sGiveItemMsg, nWholeParty);
   if (nTeleportFlag == 1)        Teleport(oPC, sTeleportWPtag, nFeedback, sTeleportMsg);
   if (nJournalEntryFlag == 1)    JournalEntry(oPC, sJournalEntryType, nJournalEntryMag, nFeedback, sJournalEntryMsg, nWholeParty);

   // the user defined Good function
   if (nUserDef1Flag == 1) UserDef1(oPC, nUserDef1Mag, nUserDef1Mag2, sUserDef1String, sUserDef1String2, fDuration, nFeedback, sUserDef1Msg, nWholeParty);
   
// ::  ////////////////////////////////////////////////////////////////////////////////
// ::  end GOOD effects and begin BAD ones
// ::  ////////////////////////////////////////////////////////////////////////////////

// Obviously this is bad but I haven't put it with the other bad effects because a designer
// shouldn't put something like this in without really intending that it operate.
// Therefore, it should not be preventable with a magic item.
   if (nTakeXPsFlag == 1) TakeXPs(oPC, nTakeXPsMag, nFeedback, sTakeXPsMsg, nWholeParty);

// the point of all this odd conditional coding is to make the unicorn cup work
// the point of breaking the logic out into multiple lines is to enable me to
// more easily append to it for new conditions, specifically for other sPLCclass's
   nPassFlag = 0;
// do the fountain if the PC has Unicorn Horn but has decided not to use it (an Override has been ordered)
   if ((sPLCclass == "fountain") & (GetItemPossessedBy(oPC, sItemUnicornHorn)!= OBJECT_INVALID) & (nFtnSafeOverride == 1)) nPassFlag = 1;
// OR do the fountain if the PC doesn't have a Unicorn Horn
   if (GetItemPossessedBy(oPC, sItemUnicornHorn)== OBJECT_INVALID) nPassFlag = 1;
// otherwise (in the UnicHorn case) skip the Bad fountain and jump down to the message about its danger
   if (nPassFlag == 1)
    {

    if (nDamageFlag == 1) Damage(oPC, nDamageMag, "ACID", nFeedback, sDamageMsg, nWholeParty);
    if (nPoisonFlag == 1) Poison(oPC, sPoisonType, fDuration, nFeedback, sPoisonMsg, nWholeParty);
    if (nDiseaseFlag == 1) Disease(oPC, sDiseaseType, fDuration, nFeedback, sDiseaseMsg, nWholeParty);
    if (nBadEffectFlag == 1) BadEffect(oPC, sBadEffectType, fDuration, nFeedback, sBadEffectMsg, nWholeParty);
    if (nCurseFlag == 1) Curse(oPC, sCurseType, fDuration, nFeedback, sCurseMsg, nWholeParty);
    if (nPolymorphFlag == 1) Polymorph(oPC, sPolymorphType, fDuration, nFeedback, sPolymorphMsg, nWholeParty);
    if (nNegativeLevelFlag == 1) NegativeLevel(oPC, nNegativeLevelMag, fDuration, nFeedback, sNegativeLevelMsg, nWholeParty);
    if (nSlowFlag == 1) Slow(oPC, fDuration, nFeedback, sSlowMsg, nWholeParty);

   // the user defined Bad function
   if (nUserDef2Flag == 1) UserDef2(oPC, nUserDef2Mag, nUserDef2Mag2, sUserDef2String, sUserDef2String2, fDuration, nFeedback, sUserDef2Msg, nWholeParty);

   // this is necessary to prevent a single override from becoming permanent   
    SetLocalInt(oPC, "nFtnSafeOverride", 0);
   // this ends the IF for unicorn horn saving PC from bad fountains
    }
    else
    {
    // tell the PC that this fountain is too dangerous to drink from
    if (nDoesBad > 0) SendMessageToPC(oPC, MESSAGE_UNICORN_WARNING);
    }
// this ends everything
}


// :: ////////////////////////////////////////////////////////////////////////////////////
// :: PORTAL MAIN ROUTINE
// :: ////////////////////////////////////////////////////////////////////////////////////
/*
void PortalMain(object oPortal, object oPC, int nQueryFlag = 0)
{
// Notation: dynamic = programmable, static = not, P2P = portal-to-portal, P2L = portal-to-location
// L2P = location-to-portal

// portal programming techniques: dialing device, item point & click, token_address,
// walk-to-connect (W2C)

// the simplest static portal effect will just use the fountain teleportal function

// walk-to-connect (W2C): touch the first portal, walk to the next and touch it, they are connected

//  

}
*/
// ax_gizmo_user_settings

/*  User Settings and Language Strings
	The point of this script is to pull into a single spot all the values that
	a game designer might want to over-write for his module. It also contains
	all the language dependant portions (at least what will be visible to players).
	Benefits to this approach:
       - easier for novice designers to use.
       - easier for me to upgrade later without over-writing user customizations.
       - practical to produce foreign language versions.
*/
// author: tax_5-07

// VERSION: 1.0.0.0 of Gortan's Magic Gizmos published 19JUN2007
// VERSION: 1.0.0.1 of Gortan's Magic Gizmos 

// :: ////////////////////////////////////////////////////////////////////
// :: GLOBAL USER SETTINGS - these settings apply to every gizmo in module
// :: ////////////////////////////////////////////////////////////////////

// Setting this constant to 1 will cause each individual gizmo to allow
// only a single Lore roll attempt until the PC goes up a level. Otherwise, 
// a PC can simply keep trying until he is eventually successful.
// Setting nLoreOnceOnly on an individual fountain will override this.
const int LORE_ONCE_ONLY = 1;

// Setting this constant to 1 will turn off the whole Lore checking system
// for all fountains. Setting nLoreNever=1 on a single fountain will prevent
// anyone from ever using Lore on that fountain. You can get a similar effect
// simply by setting sLore on the fountain and then saying nothing useful.
const int LORE_NEVER = 0;

// When a player uses a gadget, does everyone in the party do it too?
// In some cases you'd want to, while in others you wouldn't. 
// So the main script uses logic to decide what to do in each instance.
// Setting this constant to 1 will over-ride that logic and globally
// prohibit anyone but a live player from ever participating.
// This does not count for teleportation, in which case the whole
// party will always go.
const int PARTY_NEVER_DRINKS = 0;

/*  The various scripts recognize four different custom Items. In each case 
    the PC need only have the item in inventory to get credit for its effect.
    The "Drinking Cup" will allow the PC to bypass the conversation dialog
	and go straight to drinking from the fountain. This can be useful in
	cases where the monsters are nipping at your heels or after you've
	gotten tired of seeing the same dialog over-and-over again.
    The "Golden Chalice") will allow the PC to get around any requirement
	for payment (either gold or items), though it will not work on gizmos
	that give items to the PC (in such cases the gizmo is effectively a forge).
	The "Unicorn Horn" will automatically protect the user from cursed or
	'bad' fountains (presumably by changing color when it is dipped in 
	the water).
	The "Default Key" will either activate or deactivate a properly setup
	gizmo. Preparing this requires some extra steps which are not ordinarily
	necessary. Everything else works immediately, but switchability is harder to achieve.
*/
// Set default item tags & names. I don't know why you'd want to
// change these tag names, but you can if you want to.
const string ITEM_DRINKING_CUP        = "i_ax_fnt_d_cup";
const string ITEM_GOLDEN_CHALICE      = "i_ax_fnt_g_cup";
const string ITEM_UNICORN_HORN        = "i_ax_fnt_u_cup";
const string ITEM_DEFAULT_KEY_TAG     = "i_ax_fntn_key";
// If you change one of these names don't forget to change the matching message strings below.
const string ITEM_GOLDEN_CHALICE_NAME = "Golden Chalice";
const string ITEM_UNICORN_HORN_NAME   = "Unicorn Horn";
const string ITEM_DRINKING_CUP_NAME   = "Drinking Cup";
const string ITEM_DEFAULT_KEY_NAME    = "Fountain Activation Crystal";

// Every gizmo will have its own value for the duration of its effects.
// This constant is the universal default which will be used in cases where
// the duration of the fountain's effects have not been set on the fountain
// using the fDuration variable.
const float DEFAULT_DURATION = 120.0f;

// Ditto for the placeable type. Remember that this is just the assumption 
// if there is no variable on the PLC saying otherwise. Normally a fountain
// will need to have the sPLCclass variable set on it to = "fountain".
// The other types of gizmos should be "portal", "trap", "device".
const string DEFAULT_PLC_CLASS = "fountain";

// This controls the messages echoed back to the PC when a fountain is
// used. This switch is binary, where 0 means that feedback messages
// will be displayed and 1 means that they will be surpressed.
const int FEEDBACK_DEFAULT = 0;

// the default name of the conversation to use for area triggers
// ordinarily this would be set using the sConversation string on the trigger
const string DEFAULT_TRIGGER_CONVERSATION = "ax_spring_area_conv";

// Default FUNCTION settings
// Keep in mind that these will be used globally in cases where these values
// are called but not specified in the variables on the fountain.
// If you want a particular fountain to do a particular thing, then set it on
// the fountain. If you want all your fountains (which exhibit a particular 
// functionality) to use a setting and want to be able to change it globally,
// then set it here and leave it blank on the fountain.
const int    DEFAULT_SIMPLEHEAL_MAG = 200;
const string DEFAULT_ABILITY_BONUS_MAG = "111111";
const int    DEFAULT_CONCEALMENT_MAG = 15;
const string DEFAULT_INVISIBILITY_TYPE = "NORMAL";
const string DEFAULT_VISION_TYPE = "ULTRAVISION";
const int    DEFAULT_REGENERATION_MAG = 1;
const int    DEFAULT_ARMOR_CLASS_MAG = 4;
const int    DEFAULT_TEMP_HP_MAG = 10;
const int    DEFAULT_INCR_MOVE_MAG = 50;
const int    DEFAULT_ATTACK_BONUS_MAG = 1;
const int    DEFAULT_SPELL_RESIST_INCR_MAG = 15;
const int    DEFAULT_SKILL_INCR_MAG = 15;
const int    DEFAULT_SAVETHROWINCR_MAG = 1;
const string DEFAULT_SAVETHROWINCR_TYPE = "ALL";
const int    DEFAULT_DAMAGE_MAG = 5;
const string DEFAULT_DAMAGE_TYPE = "ACID";
const string DEFAULT_POISON_TYPE = "SMALL_SPIDER_VENOM";
const string DEFAULT_DISEASE_TYPE = "VERMIN_MADNESS";
const string DEFAULT_BAD_EFFECT_TYPE = "DAZED";
const string DEFAULT_CURSE_TYPE = "111111";
const string DEFAULT_POLYMORPH_TYPE = "CHICKEN";
const int    DEFAULT_NEG_LEVEL_MAG = 1;
const int    DEFAULT_GIVE_XP_MAG = 0;
const int    DEFAULT_TAKE_XP_MAG = 0;
const int    DEFAULT_GIVE_GOLD_MAG = 0;

// :: ////////////////////////////////////////////////////////////////////
// :: DEFAULT LANGUAGE STRINGS
// :: ////////////////////////////////////////////////////////////////////

// The Unicorn Horn warning message
const string MESSAGE_UNICORN_WARNING = "Your Unicorn Horn warns you that the water in the fountain is dangerous.";

// These are the messages for frequency-of-use feedback on refusal.
const string MESSAGE_USED_ONCE       = "This has already been used once and cannot be used again.";
const string MESSAGE_USED_TODAY      = "This cannot be used again until tomorrow.";
const string MESSAGE_USED_THIS_LEVEL = "This cannot be used again until after you go up another level.";

// These are the messages for taking gold or items.
const string MESSAGE_TAKE_GOLD = "The fountain takes payment.";
// The number portion of this will be filled in by the main script, so watch your wording and the blank space as the last character.
const string MESSAGE_INSUFFICIENT_GOLD = "You don't have enough gold to pay the fountain. You need ";
// This is when you give the fountain some item it needs in order to function.
const string MESSAGE_TAKE_ITEM = "You give the fountain what it needs.";
const string MESSAGE_TAKE_ITEM_DESC = "You don't have what the fountain requires.";

// Next are the default Lore descriptions. They are issued when the player makes
// a successful Lore roll to examine the device. Don't forget that they can be over-ridden
// with an sLore string on the fountain.

// Generic Descriptions
const string LORE_FOUNTAIN_GOOD      = "This fountain seems to have some positive effect.";
const string LORE_FOUNTAIN_DANGEROUS = "This fountain looks like it might be dangerous to use.";
const string LORE_FOUNTAIN_SAFE      = "This fountain looks like it should be safe to use.";
// Specific Descriptions
const string LORE_FOUNTAIN_DOES_NOTHING      = "Despite an initial appearance to the contrary, this fountain does not seem to be magical in any meaningful way.";
const string LORE_FOUNTAIN_SIMPLE_HEAL       = "This appears to be a Healing Fountain.";
const string LORE_FOUNTAIN_COMPLETE_HEAL     = "This appears to be a Complete Healing Fountain.";
const string LORE_FOUNTAIN_RESTORATION       = "This appears to be a Restoration Fountain.";
const string LORE_FOUNTAIN_REMOVE_CURSE      = "This fountain appears to remove curses.";
const string LORE_FOUNTAIN_CURE_DISEASE      = "This fountain appears to cure diseases.";
const string LORE_FOUNTAIN_HEROISM_PACKAGE   = "This looks like it might be a Heroism Fountain.";
const string LORE_FOUNTAIN_ABILITY_BONUS     = "This seems to be a blessing fountain. It should raise your abilities.";
const string LORE_FOUNTAIN_INVISIBILITY      = "This seems to be an invisibility fountain.";
const string LORE_FOUNTAIN_CONCEALMENT       = "This seems to be similar to an invisibility fountain, maybe Concealment.";
const string LORE_FOUNTAIN_HASTE             = "This seems to be a Haste fountain.";
const string LORE_FOUNTAIN_INCREASE_MOVE     = "This seems to be a speed buff fountain.";
const string LORE_FOUNTAIN_VISION            = "This seems to be some sort of magical sight fountain.";
const string LORE_FOUNTAIN_REGENERATION      = "This seems to be a regeneration fountain.";
const string LORE_FOUNTAIN_TEMP_HIT_POINTS   = "This seems to be a hit point buff fountain.";
const string LORE_FOUNTAIN_ARMOR_CLASS       = "This seems to be an AC buff fountain.";
const string LORE_FOUNTAIN_ATTACK_BONUS      = "This seems to be an attack buff fountain.";
const string LORE_FOUNTAIN_SPELL_RESIST_INCR = "This seems to be a spell resistance buff fountain.";
const string LORE_FOUNTAIN_SKILL_INCREASE    = "This seems to be a skill buff fountain.";
const string LORE_FOUNTAIN_SAVE_THROW_INCR   = "This seems to be a saving throw buff fountain.";
const string LORE_FOUNTAIN_DAMAGE            = "This fountain appears to be filled with some extremely dangerous liquid.";
const string LORE_FOUNTAIN_POISON            = "This fountain appears to be filled with poison.";
const string LORE_FOUNTAIN_DISEASE           = "This fountain seems to be contaminated.";
const string LORE_FOUNTAIN_CURSE             = "This fountain looks like it might curse whoever drinks from it.";
const string LORE_FOUNTAIN_POLYMORPH         = "This appears to be a polymorph fountain.";
const string LORE_FOUNTAIN_NEGATIVE_LEVEL    = "This seems to be a curse level-sucking fountain.";
const string LORE_FOUNTAIN_SLOW              = "This seems to be a Slow spell fountain.";
const string LORE_FOUNTAIN_BAD_EFFECT        = "This fountain appears to be cursed.";
const string LORE_FOUNTAIN_GIVE_XP           = "This appears to be a legendary Fountain of Enlightenment.";
const string LORE_FOUNTAIN_TAKE_XP           = "This appears to be something bad.";
const string LORE_FOUNTAIN_GIVE_GOLD         = "This fountain appears to have gold in it.";
const string LORE_FOUNTAIN_GIVE_ITEM         = "It looks like this fountain might be able to produce something.";
const string LORE_FOUNTAIN_TELEPORT          = "It looks like this fountain might take you somewhere.";
const string LORE_FOUNTAIN_JOURNAL_ENTRY     = "It looks like this fountain might be what you've been looking for.";

// These are the default effect feedback messages. They differ from the 
// Lore messages above in that they are issued AFTER the player drinks.
const string MESSAGE_DOES_NOTHING      = "The water is cool and refreshing...";
const string MESSAGE_SIMPLE_HEAL       = "Be thou Healed...";
const string MESSAGE_COMPLETE_HEAL     = "Be thou healed of All ills...";
const string MESSAGE_RESTORATION       = "Be thou Restored...";
const string MESSAGE_REMOVE_CURSE      = "Be no longer Cursed...";
const string MESSAGE_CURE_DISEASE      = "Let your illness be cured...";
const string MESSAGE_HEROISM_PACKAGE   = "Be thou more Heroic...";
const string MESSAGE_ABILITY_BONUS     = "Be thou a better person...";
const string MESSAGE_INVISIBILITY      = "Be thou hidden from sight...";
const string MESSAGE_CONCEALMENT       = "You blend into the terrain...";
const string MESSAGE_HASTE             = "Be thou more swift...";
const string MESSAGE_INCREASE_MOVE     = "Be thou more fleet of foot...";
const string MESSAGE_VISION            = "May thy eyes be more perceptive...";
const string MESSAGE_REGENERATION      = "Be thou blessed with the Troll's Gift...";
const string MESSAGE_TEMP_HIT_POINTS   = "May your foes find you more difficult to kill...";
const string MESSAGE_ARMOR_CLASS       = "May your skin be like armor...";
const string MESSAGE_ATTACK_BONUS      = "May you crush your enemies...";
const string MESSAGE_SPELL_RESIST_INCR = "May you be warded from mystic forces...";
const string MESSAGE_SKILL_INCREASE    = "May you be more adept in all you do...";
const string MESSAGE_SAVE_THROW_INCR   = "May good fortune guard you...";
const string MESSAGE_DAMAGE            = "This wicked liquid burns!";
const string MESSAGE_POISON            = "You taste poison in this foul brew!";
const string MESSAGE_DISEASE           = "This water is contaminated with filth and corruption!";
const string MESSAGE_CURSE             = "You have been cursed!";
const string MESSAGE_POLYMORPH         = "This water is strange!";
const string MESSAGE_NEGATIVE_LEVEL    = "This terrible, cursed fluid drains part of your soul!";
const string MESSAGE_SLOW              = "The world speeds-up around you!";
const string MESSAGE_BAD_EFFECT        = "This water has been infused with some evil!";
const string MESSAGE_GIVE_XP           = "You learn wonderful things...";
const string MESSAGE_TAKE_XP           = "A piece of your soul is torn away!";
const string MESSAGE_GIVE_GOLD         = "You find gold!";
const string MESSAGE_GIVE_ITEM         = "You have acquired something.";
const string MESSAGE_TELEPORT          = "And away we go...";
const string MESSAGE_JOURNAL_ENTRY     = "You found it...";


// :: ////////////////////////////////////////////////////////////////////
// :: USER-DEFINED EFFECT FUNCTIONS
// :: I've included two user defined functions. Basically they are just 
// :: places to hang your own code. You can do anything you want. The 
// :: only limitations are the variables that I am passing in.
// :: Instead of using the complicated parsing scheme for these I am
// :: just leaving each as a separate variable.
// :: 
// :: These are the variables that I pull from the fountain:
// :: string sUserDef1Flag, int nUserDef1Mag, string sUserDef1String, int nUserDef1Mag2, 
// :: string sUserDef1String2, string sUserDef1Msg, string sUserDef2Flag, int nUserDef2Mag,
// :: string sUserDef2String, int nUserDef2Mag2, string sUserDef2String2, string sUserDef2Msg
// :: 
// :: If you don't need them, then just ignore them.
// :: ////////////////////////////////////////////////////////////////////

//  these show-up beforehand
const string LORE_FOUNTAIN_USER_DEF_1 = "This fountain looks like it might do something.";
const string LORE_FOUNTAIN_USER_DEF_2 = "This fountain looks like it might do something.";

//  these show-up afterwards
const string MESSAGE_USER_DEF_1 = "You feel strange...";
const string MESSAGE_USER_DEF_2 = "You feel strange...";

// declare routines
void UserDef1(object oPC, int nUserDef1Mag, int nUserDef1Mag2, string sUserDef1String, string sUserDef1String2, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);
void UserDef2(object oPC, int nUserDef2Mag, int nUserDef2Mag2, string sUserDef2String, string sUserDef2String2, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1);

// :: //////////////////////////////////////////
// :: USER-DEFINED Number 1
// :: this one is grouped with the GOOD effects
// :: //////////////////////////////////////////
void UserDef1(object oPC, int nUserDef1Mag, int nUserDef1Mag2, string sUserDef1String, string sUserDef1String2, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
//   object oTarget=GetFirstFactionMember(oPC);

   if (sMessage == "") sMessage = MESSAGE_USER_DEF_1;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

// //////////////////////////////////////////////////////////////////
// In many cases you will only need to replace these two lines.
// Don't forget that you have two integers and two strings and duration
// to work with. This is where you put in your effect. Just replace Heal...
//   effect eEffect = EffectHeal(nUserDef1Mag);
   effect eEffect = EffectDamage(nUserDef1Mag, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
   
// This is where you put in your visual effect.
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_HEALING_G);
// //////////////////////////////////////////////////////////////////

   object oTarget=GetFirstFactionMember(oPC, FALSE);
   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
		 // this is what happens if the party is included
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
         oTarget=GetNextFactionMember(oPC, FALSE);
         }
      }
      else
      {
	  // this is what happens if it is a single person
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      }
}

// :: //////////////////////////////////////////
// :: USER-DEFINED Number 2
// :: this one is grouped with the BAD effects
// :: //////////////////////////////////////////
void UserDef2(object oPC, int nUserDef2Mag, int nUserDef2Mag2, string sUserDef2String, string sUserDef2String2, float fDuration, int nFeedback=0, string sMessage="", int nWholeParty=1)
{
   object oTarget=GetFirstFactionMember(oPC, FALSE);

   if (sMessage == "") sMessage = MESSAGE_USER_DEF_2;
   if (nFeedback == 0) SendMessageToPC(oPC, sMessage);

// //////////////////////////////////////////////////////////////////
// In many cases you will only need to replace these two lines.
// Don't forget that you have two integers and two strings and duration
// to work with. This is where you put in your effect. Just replace Heal...
   effect eEffect = EffectDamage(nUserDef2Mag, DAMAGE_TYPE_ACID, DAMAGE_POWER_NORMAL);
// This is where you put in your visual effect.
   effect eVisualEffect = EffectVisualEffect(VFX_IMP_NEGATIVE_ENERGY);
// //////////////////////////////////////////////////////////////////

   if (nWholeParty == 1)
      {
       while (GetIsObjectValid(oTarget))
         {
		 // this is what happens if the party is included
         ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oTarget);
         ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, fDuration);
         oTarget=GetNextFactionMember(oPC, FALSE);
         }
      }
      else
      {
	  // this is what happens if it is a single person
       ApplyEffectToObject(DURATION_TYPE_INSTANT, eVisualEffect, oPC);
       ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC, fDuration);
      }
}
////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onspawnin_buffed
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script spawns in a creature with all its long-term buffs cast.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_spawn_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


void main()
{
	ExecuteScript("acf_cre_onspawnin", OBJECT_SELF);
	ActivateLongTermBuffs(OBJECT_SELF);
	effect ac = SupernaturalEffect(EffectACIncrease(4, AC_ARMOUR_ENCHANTMENT_BONUS));
	effect sr = SupernaturalEffect(EffectSpellResistanceIncrease(GetHitDice(OBJECT_SELF) + 5));
	ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectLinkEffects(ac,sr)), OBJECT_SELF);
}
#include "ginc_param_const"
#include "ginc_item"
#include "acr_language_i"
	
void main( string sTag, int nMarkUp, int nMarkDown ) {
	object oPC = (GetPCSpeaker()==OBJECT_INVALID?OBJECT_SELF:GetPCSpeaker());
	
	// Sshamath has some special bonuses/discounts.
	int nAdjustment = -10;
	
	// Not knowing Undercommon is a 5% penalty.
	if ( !ACR_IsLanguageKnown( oPC, "undercommon" ) ) nAdjustment -= 5;
	
	// Being a drow is a 10% bonus.
	if ( GetSubRace( oPC ) == RACIAL_SUBTYPE_DROW ) nAdjustment += 10;
	
	// Being a wizard is a 10% bonus.
	if ( GetLevelByClass( CLASS_TYPE_WIZARD, oPC ) > 0 ) nAdjustment += 10;
	
	nMarkUp -= nAdjustment;
	nMarkDown += nAdjustment;
	OpenStore( GetTarget( sTag ), oPC, nMarkUp, nMarkDown );	
}
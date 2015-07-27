////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_trg_onenter.nss
//    $Revision:: 236        $ current version of the file
//        $Date:: 2007-01-21#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnEnter code for triggers, and any
//  custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
//  2007/01/20  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_trigger_i"
#include "acr_db_persist_i"

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

const string VAR_PREFIX = "QUAR_";
const string VAR_DESTINATION = VAR_PREFIX + "DESTINATION";
const string VAR_BYPASS_ITEM = VAR_PREFIX + "BYPASS_ITEM";

void main()
{
    ACR_TriggerOnEnter();
	
	object oEnterer = GetEnteringObject();
	int cID = ACR_GetCharacterID( oEnterer );
	if ( cID == 0 ) return;

    // Punt filtered characters to quarantine if they enter this trigger.
	// To use this, set "QUAR_DESTINATION" to the tag of a waypoint to send the restricted character to.
	// Then, you can restrict PCs by setting "QUAR_<CHARACTER UNIQUE ID>" on the trigger.
	// You can also override the bypass token by setting the "QUAR_BYPASS_ITEM" variable.
	if ( GetLocalInt( OBJECT_SELF, VAR_PREFIX + IntToString( cID ) ) ) {
		// A token lets them bypass the restriction.
		// This defaults to "QUAR_BYPASS_ITEM".
		string bypassItemTag = GetLocalString( OBJECT_SELF, VAR_BYPASS_ITEM );
		if ( bypassItemTag == "" ) {
			bypassItemTag = VAR_BYPASS_ITEM;
		}
		
		if ( !GetIsObjectValid( GetItemPossessedBy( oEnterer, bypassItemTag ) ) ) {
			object wpDestination = GetWaypointByTag( GetLocalString( OBJECT_SELF, VAR_DESTINATION ) );
			if ( GetIsObjectValid( wpDestination ) ) {
				WriteTimestampedLogEntry( GetName( oEnterer ) + " entered " + GetName( GetArea( oEnterer ) ) + " and was quarantined." );
				AssignCommand( oEnterer, ClearAllActions( TRUE ) );
				AssignCommand( oEnterer, JumpToLocation( GetLocation( wpDestination ) ) );
			} else {
				WriteTimestampedLogEntry( GetName( oEnterer ) + " entered " + GetName( GetArea( oEnterer ) ) + " but could not be sent to an invalid waypoint." );
			}
		} else {
			WriteTimestampedLogEntry( GetName( oEnterer ) + " entered " + GetName( GetArea( oEnterer ) ) + " with token." );
		}
	}
}
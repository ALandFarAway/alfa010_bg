////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Configuration File
//     Filename : acf_cre_onheartbeat
//    $Revision:: 280        $ current version of the file
//        $Date:: 2007-03-20#$ date the file was created or modified
//       Author : Cipher
//
//    Var Prefix:
//  Dependencies:
//
//  Description
//  This script calls the ACR's OnHeartbeat event handler for creatures
//  and any custom code a server may need. It is not updated in ACR updates.
//
//  Revision History
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

const string KENNEL_DOOR_TAG = "kennel_door";

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

int GetIsKennelDoorOpen() {
     int n = 1;
	 // Check all doors for tag kennel_door, check validity of doors, verify open
     object oDoor = GetNearestObjectByTag( KENNEL_DOOR_TAG, OBJECT_SELF, n );
     while ( GetIsObjectValid( oDoor ) ) {
          if ( GetIsOpen( oDoor ) ) return TRUE;
          n++;
          oDoor = GetNearestObjectByTag( KENNEL_DOOR_TAG, OBJECT_SELF, n );
     }   
     return FALSE;
}

object GetNearestClosedKennelDoor() {
     int n = 1;
	 // Check all doors that are closed, check validity
     object oDoor = GetNearestObjectByTag( KENNEL_DOOR_TAG, OBJECT_SELF, n );
     while ( GetIsObjectValid( oDoor ) ) {
          if ( !GetIsOpen( oDoor ) ) return oDoor;
          n++;
          oDoor = GetNearestObjectByTag( KENNEL_DOOR_TAG, OBJECT_SELF, n );
     }
     return OBJECT_INVALID;
}

void main() {
	object o = OBJECT_SELF;
	/* ignore hb if lagging */
	if (GetLocalInt(o, "ACR_NPC") == 2 && GetGlobalInt("ACR_GAMEOBJUPDATE_TIME") > 500)
		return;

	ACR_CreatureOnHeartBeat();
	
	/* Determine if creature is in combat & determine if kennel door is closed */
	if ( GetIsInCombat( OBJECT_SELF ) && GetIsKennelDoorOpen() ) {
		// Get the nearest door.
		object oDoor = GetNearestClosedKennelDoor();
		// If door is destroyed or otherwise invalid, end.
		if ( !GetIsObjectValid( oDoor ) ) return;
      
		// Open the nearest door. 
		AssignCommand( OBJECT_SELF, ClearAllActions( TRUE ) );
		AssignCommand( OBJECT_SELF, ActionOpenDoor( oDoor ) );
	}
}
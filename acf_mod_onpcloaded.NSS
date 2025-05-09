////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ALFA Configuration File
//     Filename : acf_mod_onpcloaded.nss
//    $Revision:: 198        $ current version of the file
//        $Date:: 2006-12-23#$ date the file was created or modified
//       Author : Cipher
//
//  Local Variable Prefix = None
//
//  Description
//  This script calls the module's OnPCLoaded event, and any custom code added
//  by this server. It is usually used to set up server-specific options.
//  This file should NOT be overwriten in ACR updates so as to preserve any of
//  the server's customized code they may have added.
//
//  Revision History
//  2006/12/22/  Cipher  Inception
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

#include "acr_mod_events_i"
#include "010_drugs_i"
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

void _GrantOmegaWand(object oDM);

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
    ACR_ModuleOnPCLoaded();
    
	//Hook BG Drugs System
	ACR_ApplyDrugAddictionEffects(GetEnteringObject());

	//Give DM Omega Wand
	object oEntrant = GetEnteringObject();
	if (GetIsDM(oEntrant)) {
		DelayCommand(5.0, _GrantOmegaWand(oEntrant));
	}	
}

// Omega Wand Function
void _GrantOmegaWand(object oDM) {

	if (!GetIsObjectValid(oDM)) {
		// DM has already crashed out or is otherwise invalid.
		WriteTimestampedLogEntry("Invalid call to _GrantOmegaWand() for PC: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
		return;
	} else if (!GetIsDM(oDM) && !GetIsDMPossessed(oDM)) {
		// entrant is neither a DM avatar, nor possessed by a DM avatar.
		WriteTimestampedLogEntry("Invalid (NON-DM!) call to _GrantOmegaWand() for PC: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
		return;
	}
	if (GetItemPossessedBy(oDM, "omega_wand") == OBJECT_INVALID) {
		// DM does not have an omega wand yet, notify and create.
		SendMessageToPC(oDM, "No Omega wand detected in inventory.  Creating replacement wand.");
		CreateItemOnObject("omega_wand", oDM);
		WriteTimestampedLogEntry("Omega Wand created for DM Avatar: "+GetName(oDM)+" played by "+GetPCPlayerName(oDM)+" at IP address "+GetPCIPAddress(oDM));
	} else {
		SendMessageToPC(oDM, "Omega Wand verified.");
	}
}
#include "ginc_param_const"
#include "ginc_henchman"

int ACR_GetIsHenchman(object oCreature) {
	return GetLocalObject(oCreature, sMasterRef) != OBJECT_INVALID;
}

void ACR_RemoveHenchman(object oDM, object oHenchman) {
	if(ACR_GetIsHenchman(oHenchman)) {
		HenchmanRemove(GetMaster(oHenchman), oHenchman);
		SendMessageToPC(oDM, GetName(oHenchman) + " is no longer a henchman.");
	}
}

void ACR_AddHenchman(object oDM, object oMaster, object oHenchman) {
	ACR_RemoveHenchman(oDM, oHenchman);
	HenchmanAdd(oMaster, oHenchman, TRUE, TRUE);
	SendMessageToPC(oDM, GetName(oHenchman) + " is now a henchman of " + GetName(oMaster) + ".");
}
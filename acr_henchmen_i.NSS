// THIS SCRIPT IS NOT A PART OF ACR
#include "ginc_param_const"
#include "ginc_henchman"

const string _ACR_IS_HENCHMAN = "ACR_HENCH";
const float _ACR_HENCHMAN_HB_DELAY = 6.0;

int ACR_GetIsHenchman(object oCreature) {
	return GetLocalInt(oCreature, _ACR_IS_HENCHMAN);
}

void _notifyRemove(object oHenchman) {
	SendMessageToPC(GetMaster(oHenchman), GetName(oHenchman) + " is no longer your henchman.");
}

void _henchmanHeartbeat(object oMaster, object oHenchman) {
	if(!GetIsObjectValid(oHenchman)) {
		HenchmanRemove(oMaster, oHenchman);
		_notifyRemove(oHenchman);
	} else if(ACR_GetIsHenchman(oHenchman)) {
		DelayCommand(_ACR_HENCHMAN_HB_DELAY, _henchmanHeartbeat(oMaster, oHenchman));
	}
}

void ACR_RemoveHenchman(object oDM, object oHenchman) {
	if(ACR_GetIsHenchman(oHenchman)) {
		HenchmanRemove(GetMaster(oHenchman), oHenchman);
		DeleteLocalInt(oHenchman, _ACR_IS_HENCHMAN);
		SendMessageToPC(oDM, GetName(oHenchman) + " is no longer a henchman.");
		_notifyRemove(oHenchman);
	}
}

void ACR_AddHenchman(object oDM, object oMaster, object oHenchman) {
	ACR_RemoveHenchman(oDM, oHenchman);
	HenchmanAdd(oMaster, oHenchman, TRUE, TRUE);
	SetLocalInt(oHenchman, _ACR_IS_HENCHMAN, 1);
	DelayCommand(_ACR_HENCHMAN_HB_DELAY, _henchmanHeartbeat(oMaster, oHenchman));
	SendMessageToPC(oDM, GetName(oHenchman) + " is now a henchman of " + GetName(oMaster) + ".");
	SendMessageToPC(oMaster, GetName(oHenchman) + "is now your henchman. Use the normal tools provided by NWN2 to control him or her.");
}
//::///////////////////////////////////////////////
//:: Name: 
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Have placeable start its conversation file with
    whoever just used it.
*/
//:://////////////////////////////////////////////
//:: Created By: Keith Warner
//:: Created On: Jan 16/03
//:: Updated for ALFA ON: 12/1/2020 by Arianna
//:://////////////////////////////////////////////

#include "acr_placeable_i"
#include "dmfi_inc_langexe" 
#include "acr_quest_i"

void main(){

if (!GetIsObjectValid(OBJECT_SELF))
		return;

	ACR_PlaceableOnUsed();

    ActionStartConversation(GetLastUsedBy());
}

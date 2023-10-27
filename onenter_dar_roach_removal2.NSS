// onenter script for 02a_fieldsofrest   roach quest
// written by ayergo and Arianna  10/2023
// removes the spawned creatures if PC has not taken or has finished the quest 
// [issue is that it does not work in parties where one or more of them have already finished the quest]


#include "acr_quest_i"

void main()
{
  object oPC = GetEnteringObject();
  string sTag = "009_cr_v_cockroach";
  string sTag1 = "009_cr_v_cockroach0";
  string sTag2 = "009_cr_v_cockroach2";
  object oArea = GetArea(OBJECT_SELF);
  string sCreature;

  if(!GetIsPC(oPC) || GetIsDM(oPC))  //If not a PC or is a DM, do nothing and return
    return;

  int iVar =ACR_RetrieveQuestState( "dar_frenzied_roaches_torold", oPC);  //We know its a PC so check their variables and save in iVar

  if(iVar == 0 || iVar == 15){

    //SendMessageToPC(oPC, "***");
   // SendMessageToPC(oPC, "Quest State 0 or 15 so Despawning Creature. Variable Value: " + IntToString(iVar));
  //  SendMessageToPC(oPC, "***");

    object oCreature = GetFirstObjectInArea(oArea);    //Get the first object in the area

    while(oCreature != OBJECT_INVALID){    //Destroy them until none left.  Note this might effect creatures in other areas
      if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE){
        sCreature = GetTag(oCreature);
        if(sCreature == sTag || sCreature == sTag1 || sCreature == sTag2){
          DestroyObject(oCreature);
         // SendMessageToPC(oPC, "Destroying Creature: " + GetName(oCreature));
        }
        else if(iVar < 15 || iVar > 0){
         // SendMessageToPC(oPC, "No Match, not destroying: " + GetName(oCreature));
        }
      }
      oCreature = GetNextObjectInArea(oArea);
    }
	
    return;
 // }
 // else{
 //   SendMessageToPC(oPC, "***");
 //   SendMessageToPC(oPC, "Not zero or 15.  Do Nothing. Variable Value: " + IntToString(iVar));
 //   SendMessageToPC(oPC, "***");
  }

}
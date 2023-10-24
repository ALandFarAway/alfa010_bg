
//Trigger to keep quest creatures from spawning after quest
//Arianna 10/2023


/*void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int nInt;
nInt=GetLocalInt(oPC, "PersistentJournalQuestEntrydar_frenzied_roaches_torold");
SpeakString("we got the trigger");

if (nInt < 1);

else if (nInt = 15)
   return;

object oTarget;
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach0");

DestroyObject(oCreature);

oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oCreature);
oTarget = GetObjectByTag("009_cr_v_cockroach");

DestroyObject(oCreature);

oTarget = GetObjectByTag("009_cr_v_cockroach2");

DestroyObject(oCreature);
*/

void main()
{
  object oPC = GetEnteringObject();
  string sTag = "009_cr_v_cockroach";
  string sTag1 = "009_cr_v_cockroach0";
  string sTag2 = "009_cr_v_cockroach2";
  object oArea = GetArea(OBJECT_SELF);
  string sCreature;

  //if(!GetIsPC(oPC) || GetIsDM(oPC))  //If not a PC or is a DM, do nothing and return
  //  return;

 // int iVar = GetLocalInt(oPC, "dar_frenzied_roaches_torold");  //We know its a PC so check their variables and save in iVar
  int iVar=GetLocalInt(oPC, "PersistentJournalQuestEntrydar_frenzied_roaches_torold");
  if(GetIsPC(oPC) && !GetIsDM(oPC)){

    SendMessageToPC(oPC, "***");
    SendMessageToPC(oPC, "Player detected Entering: Despawning Creature. Variable Value: " + IntToString(iVar));
    SendMessageToPC(oPC, "***");

    object oCreature = GetFirstObjectInArea(oArea);    //Get the first object in the area

    while(oCreature != OBJECT_INVALID){    //Destroy them until none left.  Note this might effect creatures in other areas
      if(GetObjectType(oCreature) == OBJECT_TYPE_CREATURE){
        sCreature = GetTag(oCreature);
        if(sCreature == sTag || sCreature == sTag1 || sCreature == sTag2){
          DestroyObject(oCreature);
          //SendMessageToPC(oPC, "Destroying Creature: " + GetName(oCreature));
        }
        //else{
          //SendMessageToPC(oPC, "No Match, not destroying: " + GetName(oCreature));
        //}
      }
      oCreature = GetNextObjectInArea(oArea);
    }

  }
  else{
    SendMessageToPC(oPC, "***");
    SendMessageToPC(oPC, "DM detected Entering.  Do Nothing. Variable Value: " + IntToString(iVar));
    SendMessageToPC(oPC, "***");
  }

}


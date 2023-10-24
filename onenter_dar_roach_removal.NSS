
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

  //if(!GetIsPC(oPC) || GetIsDM(oPC))  //If not a PC or is a DM, do nothing and return
  //  return;

  //int iVar = GetLocalInt(oPC, "VariableToCheck");  //We know its a PC so check their variables and save in iVar

  if(GetIsPC(oPC) && !GetIsDM(oPC)){

    SendMessageToPC(oPC, "***");
    SendMessageToPC(oPC, "Player detected Entering: Despawning Creature");
    SendMessageToPC(oPC, "***");

    object oCreature = GetNearestObjectByTag(sTag);    //Get the Nearest creature with the tag

    while(oCreature != OBJECT_INVALID){    //Destroy them until none left.  Note this might effect creatures in other areas
      DestroyObject(oCreature);
      oCreature = GetNearestObjectByTag(sTag);
    }

  }
  else{
    SendMessageToPC(oPC, "***");
    SendMessageToPC(oPC, "DM detected Entering.  Do Nothing. ");
    SendMessageToPC(oPC, "***");



  }

}
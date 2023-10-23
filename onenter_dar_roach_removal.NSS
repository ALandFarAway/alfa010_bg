
//Trigger to keep quest creatures from spawning after quest
//Arianna 10/2023


void main()
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
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach0");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");
DestroyObject(oTarget, 0.0);
oTarget = GetObjectByTag("009_cr_v_cockroach");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("009_cr_v_cockroach2");

DestroyObject(oTarget, 0.0);



}
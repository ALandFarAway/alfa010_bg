void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

if (!GetIsSkillSuccessful(oPC, SKILL_SEARCH, 13))
   return;

object oTarget;
oTarget = GetObjectByTag("bg_eg_hc_doorhider1");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("***enter tag of object (container / door) here***");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

}

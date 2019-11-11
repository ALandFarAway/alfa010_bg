void main()
{

object oPC = GetEnteringObject();

 // Only fire for (real) PCs.
    if ( !GetIsPC(oPC)  ||  GetIsDMPossessed(oPC) )
	 return;

if (!GetIsSkillSuccessful(oPC, SKILL_SEARCH, 13))
   return;

object oTarget;
oTarget = GetObjectByTag("bg_eg_hc_doorhider1");
//oTarget = GetObjectByTag("secret_los_uc_door");

DestroyObject(oTarget, 0.0);

oTarget = GetObjectByTag("hc_uc");

SetLocked(oTarget, TRUE);

//AssignCommand(oTarget, ActionOpenDoor(oTarget));

}
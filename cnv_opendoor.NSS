//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("dr_bg_eg_underceller_enter");

SetLocked(oTarget, FALSE);

AssignCommand(oTarget, ActionOpenDoor(oTarget));

}

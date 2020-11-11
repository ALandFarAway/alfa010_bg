//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget = GetObjectByTag("trdwy_reflection_rm_curtain");
oTarget = GetObjectByTag("trdwy_reflection_rm_curtain2");

DestroyObject(oTarget, 0.1);

}
//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oTarget2;

oTarget = GetObjectByTag("trdwy_reflection_rm_curtain1");

oTarget2 = GetObjectByTag("trdwy_reflection_rm_curtain2");

DestroyObject(oTarget, 0.1);
DestroyObject(oTarget2, 0.1);
}
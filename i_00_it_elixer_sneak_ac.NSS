/*   Script generated by
Lilac Soul's NWN Script Generator, v. 2.3

*/
//elixer of Sneaking  /00_it_elixer_sneak/1 hour game time
void main()
{
object oPC;

if (!GetIsPC(GetItemActivatedTarget())
|| (GetObjectType(GetItemActivatedTarget())!=OBJECT_TYPE_CREATURE)
){

SendMessageToPC(GetItemActivator(), "Improper use of item!");
return;}

oPC = GetItemActivator();


object oTarget;
oTarget = oPC;

effect eEffect;
eEffect = EffectSkillIncrease(SKILL_MOVE_SILENTLY, 10);

ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oTarget, 780.0f); // 13 min =1 hour game time


}
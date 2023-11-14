//created by ayergo 11/2023
// with compatability alterations by Arianna

#include "acr_spellhook_i"
#include "acr_spells_i"

void main()
{

/* 
  Spellcast Hook Code 
  Added 2003-06-23 by GeorgZ
  If you want to make changes to all spells,
  check x2_inc_spellhook.nss to find out more
  
*/

    if (!X2PreSpellCastCode())
    {
	// If code within the PreSpellCastHook (i.e. UMD) reports FALSE, do not run this spell
        return;
    }



void SetHide(object oZombie, object oTarget){
  object oTHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oTarget);


  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_STRENGTH, GetAbilityScore(oTarget, ABILITY_STRENGTH, TRUE) - 8)), oZombie);
  ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectAbilityIncrease(ABILITY_DEXTERITY, GetAbilityScore(oTarget, ABILITY_DEXTERITY, TRUE) - 12)), oZombie);

  if(oTHide == OBJECT_INVALID)
    return;

  object oZHide = GetItemInSlot(INVENTORY_SLOT_CARMOUR, oZombie);


  itemproperty ipZombie = GetFirstItemProperty(oZHide);

    while(GetIsItemPropertyValid(ipZombie)){
      AddItemProperty(DURATION_TYPE_PERMANENT, ipZombie, oTHide);
      ipZombie = GetNextItemProperty(oZHide);
    }
    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertySpecialWalk(), oTHide);


  object oSkin = CopyItem(oTHide, oZombie, TRUE);
  DestroyObject(oZHide);

  int i = 0;
  AssignCommand(oZombie, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR) );

  while(GetTag(GetItemInSlot(INVENTORY_SLOT_CARMOUR, oZombie)) != GetTag(oSkin)){
    AssignCommand(oZombie, ActionEquipItem(oSkin, INVENTORY_SLOT_CARMOUR) );
    i++;
    if(i >= 100){
      break;
      SendMessageToAllDMs("Too many tries to equip new creature skin, giving up");
    }
  }

}

void SetWeapon(object oZombie, object oTarget, int iSlot){
  object oTWeapon;
  object oZWeapon;
  int iSize = GetCreatureSize(oTarget);
  int i;

  oTWeapon = GetItemInSlot(iSlot, oTarget);
  if(oTWeapon == OBJECT_INVALID){
    oZWeapon = CreateItemOnObject("slambase", oZombie);
    SetDroppableFlag(oZWeapon, FALSE);
    if(iSize == CREATURE_SIZE_TINY)
      iSize = IP_CONST_MONSTERDAMAGE_1d3;
    else if(iSize == CREATURE_SIZE_SMALL)
      iSize = IP_CONST_MONSTERDAMAGE_1d4;
    else if(iSize == CREATURE_SIZE_MEDIUM)
      iSize = IP_CONST_MONSTERDAMAGE_1d6;
    else if(iSize == CREATURE_SIZE_LARGE)
      iSize = IP_CONST_MONSTERDAMAGE_1d8;
    else if(iSize == CREATURE_SIZE_HUGE)
      iSize = IP_CONST_MONSTERDAMAGE_2d6;
    else
      iSize = IP_CONST_MONSTERDAMAGE_1d4;

    AddItemProperty(DURATION_TYPE_PERMANENT, ItemPropertyMonsterDamage(iSize), oZWeapon);
    i = 0;
    AssignCommand(oZombie, ActionEquipItem(oZWeapon, iSlot) );

    while(GetTag(GetItemInSlot(iSlot, oZombie)) != GetTag(oZWeapon)){
      AssignCommand(oZombie, ActionEquipItem(oZWeapon, iSlot) );
      i++;
      if(i >= 100){
        break;
        SendMessageToAllDMs("Too many tries to equip new creature weapon, giving up");
      }
    }

  }
  else{
    oZWeapon = CopyItem(oTWeapon, oZombie);
    i = 0;
    AssignCommand(oZombie, ActionEquipItem(oZWeapon, iSlot) );

    while(GetTag(GetItemInSlot(iSlot, oZombie)) != GetTag(oZWeapon)){
      AssignCommand(oZombie, ActionEquipItem(oZWeapon, iSlot) );
      i++;
      if(i >= 100){
        break;
        SendMessageToAllDMs("Too many tries to equip new creature weapon, giving up");
      }
    }



  }






}

void main()
{
object oTarget = GetSpellTargetObject();
object oCaster = OBJECT_SELF; //GetLastSpellCaster();
location lLoc = GetLocation(oTarget);
location lJump = GetLocation(GetWaypointByTag("wp_animate"));




int iRace = GetRacialType(oTarget);

if(iRace == RACIAL_TYPE_UNDEAD || iRace == iRace == RACIAL_TYPE_CONSTRUCT || iRace == RACIAL_TYPE_ELEMENTAL){
  SendMessageToPC(oCaster, "This will not work on unead, elementals or constructs");
  SendMessageToAllDMs("This will not work on unead, elementals or constructs");
  return;
}


int iClass = GetLevelByClass(CLASS_TYPE_UNDEAD, oTarget) + GetLevelByClass(CLASS_TYPE_CONSTRUCT, oTarget) + GetLevelByClass(CLASS_TYPE_ELEMENTAL, oTarget);
if(iClass){
  SendMessageToPC(oCaster, "This will not work on unead, elementals or constructs levels");
  SendMessageToAllDMs("This will not work on unead, elementals or constructs levels");
  return;
}

iClass = GetHitDice(oTarget);
if(iClass > 10){
  SendMessageToPC(oCaster, "This creature has more than 10 Hit Dice.");
  SendMessageToAllDMs("This creature has more than 10 Hit Dice.");
  return;
}




//AssignCommand(oTarget, ActionSpeakString("*Jaggedly rises from the ground*") );
SendMessageToPC(oCaster, "You attempt to animate the body of the target.");

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(3710), lLoc);
ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oTarget);
int iAppearance = GetAppearanceType(oTarget);
AssignCommand(oTarget, ActionJumpToLocation(lJump) );


object oZombie = CreateObject(OBJECT_TYPE_CREATURE, "animatezombase", lLoc);

ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(3912), lLoc);

SetCreatureAppearanceType(oZombie, iAppearance);
AssignCommand(oZombie, PlayAnimation(ANIMATION_LOOPING_DEAD_FRONT) );

SetFirstName(oZombie, "Zombie " + GetName(oTarget) );

SetHide(oZombie, oTarget);

SetWeapon(oZombie, oTarget, INVENTORY_SLOT_CWEAPON_L);
SetWeapon(oZombie, oTarget, INVENTORY_SLOT_CWEAPON_R);
SetWeapon(oZombie, oTarget, INVENTORY_SLOT_CWEAPON_B);


AddHenchman(oCaster, oZombie);

int iHD = GetHitDice(oTarget);

int i = 1;

while(iHD > i){
  LevelUpHenchman(oZombie, CLASS_TYPE_UNDEAD, FALSE, PACKAGE_UNDEAD);
  i++;
}



AssignCommand(oTarget, SetIsDestroyable(TRUE, FALSE, FALSE) );
SetPlotFlag(oTarget, FALSE);

DestroyObject(oTarget);



}
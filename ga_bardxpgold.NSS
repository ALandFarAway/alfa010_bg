#include "acr_xp_i"  
  
void main() { 
     object oPC = ( GetPCSpeaker() == OBJECT_INVALID ? OBJECT_SELF : GetPCSpeaker() );  
     int luck = d20(1);  
     int reward = d3(1); 
 
     if( GetHitDice( oPC ) > 5 ){  
          SendMessageToPC(oPC, "You don't feel performing here is helping you grow at all.");  
          return;  
     }  
      
     if ( ( luck + GetSkillRank( SKILL_PERFORM,oPC,FALSE ) ) >= 15 ) {  
          ACR_AwardStaticQuestXP( oPC, "Bard", reward );  
          GiveGoldToCreature( oPC, reward );  
     } else { 
          SendMessageToPC( oPC, "While your performance was adequate, the audience doesn't seem very appreciative." );  
     }   
}
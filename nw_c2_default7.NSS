// BG: TSCC OnDeath script.
// Changed 30 april 2009 JayNi.
// Changed 28th of July 2009 JayNi. Combined three scripts into one.

#include "inc_death"

void main (){
	object oCreature = OBJECT_SELF;
	object oPC = GetLastKiller();
	location lLocation = GetLocation(oCreature);
	
	Death_OnDeath(oCreature, oPC);
	
	// If item is a quest-item we drop it.
	
	string sTagVariable = GetVariableValueString(oCreature, 0);
	
	if (sTagVariable != ""){
		
		ExecuteScript("destroy_item", CreateObject(OBJECT_TYPE_ITEM, sTagVariable, lLocation, TRUE)); 	
	}
	else {
		int nRacialType = GetRacialType(oCreature);
		
		if(nRacialType != RACIAL_TYPE_ANIMAL && 
		   nRacialType != RACIAL_TYPE_BEAST && d4() == 1){
			 
			object oLootBag = CreateObject(OBJECT_TYPE_PLACEABLE, "loot_bag", lLocation);
			
			int nChallengeRating = FloatToInt(GetChallengeRating(oCreature));
			
			if (d2() == 1){
				CreateItemOnObject("nw_it_gold001", oLootBag, d20() * (nChallengeRating / 5) + 10);
			}
			if (d6() == 1){
				int nToolChance = d6();
				
				if (nToolChance < 4){
					CreateItemOnObject("NW_IT_PICKS001", oLootBag, 1);
				}
				else if (nToolChance < 6 && nChallengeRating > 10){
					CreateItemOnObject("NW_IT_PICKS002", oLootBag, 1);
				}
				else if (nChallengeRating > 20) {
					CreateItemOnObject("NW_IT_PICKS003", oLootBag, 1);
				}
			}
			if (d6() == 1){
				int nKitChance = d10();
				
				if (nKitChance <= 5){
					CreateItemOnObject("NW_IT_MEDKIT001", oLootBag, 1);
				}
				else if (nKitChance <= 8 && nChallengeRating > 8){
					CreateItemOnObject("NW_IT_MEDKIT002", oLootBag, 1);
				}
				else if (nKitChance == 9 && nChallengeRating > 16){
					CreateItemOnObject("NW_IT_MEDKIT003", oLootBag, 1);
				}
				else if (nChallengeRating > 24) {
					CreateItemOnObject("NW_IT_MEDKIT004", oLootBag, 1);
				}
			}
			if (d4() == 1){
				int nPotionChance = d20();
				
				if (nPotionChance <=10){
				
					CreateItemOnObject("NW_IT_MPOTION00" + IntToString(nPotionChance), oLootBag, 1);	
				}
				else {
				    if (nPotionChance == 12){
						if (nChallengeRating > 13){
							CreateItemOnObject("NW_IT_MPOTION0" + IntToString(nPotionChance), oLootBag, 1);	
						}
					}
					else {
						CreateItemOnObject("NW_IT_MPOTION0" + IntToString(nPotionChance), oLootBag, 1);	
					}
				}
			}
			if (d10() == 1){
				int nSpiritChance = d3();
				
				CreateItemOnObject("NW_IT_MPOTION0" + IntToString(nSpiritChance), oLootBag, 1);		
			}
			if (nChallengeRating > 10 && d6() == 1){
				int nPotionChance = d6();
				
				if (nPotionChance == 1){
					CreateItemOnObject("nx1_it_mpotion001" + IntToString(nPotionChance), oLootBag, 1);		
				}
				else if (nPotionChance == 2){
					CreateItemOnObject("nx1_it_mpotion004" + IntToString(nPotionChance), oLootBag, 1);		
				}
				else if (nPotionChance == 3){
					CreateItemOnObject("nx1_it_mpotion010" + IntToString(nPotionChance), oLootBag, 1);		
				}
				else if (nPotionChance == 4){
					CreateItemOnObject("nx1_it_mpotion011" + IntToString(nPotionChance), oLootBag, 1);		
				}
				else if (nPotionChance == 5){
					CreateItemOnObject("nx1_it_mpotion041" + IntToString(nPotionChance), oLootBag, 1);		
				}
				else if (nPotionChance == 6){
					CreateItemOnObject("X2_IT_MPOTION002" + IntToString(nPotionChance), oLootBag, 1);		
				}
			}
			
			if (!GetIsObjectValid(GetFirstItemInInventory(oLootBag))){
				DestroyObject(oLootBag);
			}
			else {
				ExecuteScript("destroy_item", oLootBag); 	
			}	
		}	
	}
	
	// safety mechanism in case creature kills itself
   if(GetLastKiller() == oCreature) return;
   
   // resurrect & self kill to bypass bioware xp message
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectResurrection(), oCreature);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(10000, DAMAGE_TYPE_MAGICAL, DAMAGE_POWER_PLUS_TWENTY), oCreature);
	
	ExecuteScript("pwfxp", oCreature);
}
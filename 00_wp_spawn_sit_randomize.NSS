////////////////////////////////////////////////////////////////////////////////

//
//  Description
//  Put the name of this script into a spawnpoint's ACR_SPAWN_IN_SCRIPT_1 to run
//  the code beneath on each creature spawned by the spawnpoint

//  Revision History - Creation 05/05/22 : Wynna
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#include "acr_creature_i"
#include "acr_spawn_i"


 
void main()
{

	float f = ACR_RandomFloat(2.0,3.0);
	DelayCommand(f, ACR_CreatureOnSpawnIn());
	SetLocalFloat(OBJECT_SELF, "f", f); 
			    
	// dumb (non-combat) ai
	SetLocalInt(OBJECT_SELF,"ACR_NPC",2);

	int i = 1;
    object oChair = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, i);
	while (oChair != OBJECT_INVALID) {
		if (FindSubString(GetStringLowerCase(GetTag(oChair)), "chair") != -1) {
			int nOccupied = GetLocalInt(oChair, "Occupied");
			
			if(nOccupied == 0) {
				SetLocalInt(oChair, "Occupied", 1);
				DelayCommand(5.0, AssignCommand(OBJECT_SELF, ActionForceMoveToObject(oChair, FALSE, 0.25, 30.0)));
				DelayCommand(10.0, AssignCommand(OBJECT_SELF, ActionJumpToObject(oChair, TRUE)));
				DelayCommand(11.0, AssignCommand(OBJECT_SELF, SetFacing(GetFacing(oChair)-180.0, FALSE)));
				DelayCommand(12.0, AssignCommand(OBJECT_SELF, SetBumpState(OBJECT_SELF,BUMPSTATE_UNBUMPABLE))); //Keeps NPCs from being bumped to a standing position 
				DelayCommand(13.0, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CHAIR, 1.0, 1800.0));
			    break;
				}
			else {
				i++;
				}
			}
		oChair = GetNearestObject(OBJECT_TYPE_PLACEABLE, OBJECT_SELF, i);
		}
		

}
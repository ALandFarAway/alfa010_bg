/*
Filename:           door_auto_close
System:             miscellaneous
Author:             WizardStorm Think Group (Development@WizardStorm.com)
Date Created:       Oct 7th, 2006.
Summary:
Automatically shuts oDoor1 after an set amount of time. If oDoor1 is
connected to oDoor2 via a transition, it will close oDoor2 at the same time.
By default, doors close after 30 seconds, however you can override this by
setting a local float variable on the door called AUTO_SHUT_DELAY.
If AUTO_SHUT_DELAY equals -1.0, the door will never auto close.
-----------------

put on open script
*/
void main()
{
	object 	oDoor1 			= OBJECT_SELF;
	object 	oDoor2 			= GetTransitionTarget(oDoor1);
	float	fShutDefault	= 120.0;
	float  	fShutDelay 		= GetLocalFloat(oDoor1, "AUTO_SHUT_DELAY");
	
	ActionUnlockObject(OBJECT_SELF);
	
	if(fShutDelay == -1.0)
		return;
	else if(fShutDelay == 0.0)
		fShutDelay = fShutDefault;
		
	AssignCommand(oDoor1, DelayCommand(fShutDelay, ActionCloseDoor(oDoor1)));
	AssignCommand(oDoor2, DelayCommand(fShutDelay, ActionCloseDoor(oDoor2)));
	//AssignCommand(oDoor1, DelayCommand(fShutDelay + 5.0, ActionLockObject(OBJECT_SELF))); 
	
}
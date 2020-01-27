//Destroy self

 /* This goes in the OnUsed event handler of the actual
 * placeable door object.  use a WP tagged dst_<tagofplaceable>
 *for where you want to land after touching the placeable
*/
#include "tw_secret"

void main()
 {
 object oUser = GetLastUsedBy();
  if ( !GetIsPC(oUser)  ||  GetIsDMPossessed(oUser) )
        return;
 if (!GetIsSecretItemOpen(OBJECT_SELF))

 {
 SetIsSecretItemOpen(OBJECT_SELF, TRUE);
    } 
	else 
	{
	UseSecretTransport(GetLastUsedBy());
	}
	{
	
 object oTarget;
oTarget = OBJECT_SELF;

DelayCommand(180.0, DestroyObject(oTarget, 0.0));
}
}
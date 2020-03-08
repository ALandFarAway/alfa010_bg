// 'lever_to_door'
//
// OnUsed script placed on a lever unlocks/opens & closes/locks door.
// - set 'sDoorTag' on lever

void main()
{
    
    object oLever = OBJECT_SELF;

    string sDoorTag = GetLocalString(oLever, "sDoorTag");
    object oDoor = GetObjectByTag(sDoorTag);

    if (!GetIsOpen(OBJECT_SELF))
    {
	    PlaySound("as_sw_lever1");
        PlayAnimation(ANIMATION_PLACEABLE_OPEN);
        DelayCommand(6.0,PlayAnimation(ANIMATION_PLACEABLE_CLOSE));
        SetLocked(oDoor, FALSE);
        ActionOpenDoor(oDoor);
    }
    else
    {
     	PlaySound("as_sw_lever1");
        PlayAnimation(ANIMATION_PLACEABLE_CLOSE);
        DelayCommand(6.0,PlayAnimation(ANIMATION_PLACEABLE_OPEN));
        SetLocked(oDoor, TRUE);
        ActionCloseDoor(oDoor);
    }
}
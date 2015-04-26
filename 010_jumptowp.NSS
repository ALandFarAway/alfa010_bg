void main(string target)
{
	object oJumpTarget = GetWaypointByTag(target);
	AssignCommand(GetPCSpeaker(), JumpToObject(oJumpTarget, FALSE));
}
int StartingConditional()
{
	object oWP = GetObjectByTag("secs_002_EXT");
	if(GetIsObjectValid(oWP))
		return TRUE;
	return FALSE;
}
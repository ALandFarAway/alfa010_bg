int StartingConditional()
{
	object oWP = GetObjectByTag("secs_003_EXT");
	if(GetIsObjectValid(oWP))
		return TRUE;
	return FALSE;
}
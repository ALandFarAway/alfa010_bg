void main()
{
	object o = GetEnteringObject(); // check for rope &
	string s_r0 = "abr_it_gr_rope"; 
	string s_r1 = "010_it_ms_rope5"; // animated rope
	string s_r2 = "abr_it_ms_rope5";//animated rope
	string s_r3 = "abr_it_gr_climbkit";// has both rope and grappling hook in it
    string s_r4 = "tsm_it_gr_rope_climb";// has both rope and grappling hook
	string s_g0 = "abr_it_gr_grapplinghook";// check for grappling hook
	string s_g1 = "abr_it_gr_climbkit";  // has both rope and grappling hook in it
	string s_g2 = "tsm_it_gr_rope_climb";  // has both rope and grappling hook
	
	int r = 0;
	int g = 0;
	
	if (!GetIsPC(o))
		return;
	
	r = GetIsObjectValid(GetItemPossessedBy(o,s_r0)) +
		GetIsObjectValid(GetItemPossessedBy(o,s_r1)) + 
		GetIsObjectValid(GetItemPossessedBy(o,s_r2)) +
		GetIsObjectValid(GetItemPossessedBy(o,s_r3));
	g = GetIsObjectValid(GetItemPossessedBy(o,s_g0)) +
	    GetIsObjectValid(GetItemPossessedBy(o,s_g1));
	   
	if (((r > 0) && (g > 0)) || (GetGlobalInt("sinkhole_rope") > 0)) {
     	BeginConversation(GetLocalString(OBJECT_SELF, "sinkhole_convo"),o);
	}
}

//Written by pazzin 4-2020

// **there are a few variables that need to be set on both the top and bottom triggers**
//climb_convo - name of the dialog attached to that particular sinkhole
//climb_rope_tied_global - name of the gobal to use that sets the rope is tied and where
//climb_rope_bad_global - name of the gobal to use that sets the rope is going to unravel when weight is put on
//climb_rope_fixed_global - name of the gobal to use that sets the rope has been fixed
//climb_top_wp - name of the waypoint to go to at the top
//climb_bottom_wp - name of the waypoint to go to at the bottom

void main()
{
    object oPC = GetEnteringObject();  // check for rope & grapple
    string sRope0 = "abr_it_gr_rope";   // standard rope
    string sRope1 = "010_it_ms_rope5";  // animated rope
    string sRope2 = "abr_it_ms_rope5";  // animated rope
    string sRope3 = "abr_it_gr_climbkit";  // climbing kit has both rope and grappling hook
    string sRope4 = "tsm_it_gr_rope_climb";  // has both rope and grappling hook
    string sGrapple0 = "abr_it_gr_grapplinghook";  // grappling hook
    string sGrapple1 = "abr_it_gr_climbkit";  // climbing kit has both rope and grappling hook
    string sGrapple2 = "tsm_it_gr_rope_climb";  // has both rope and grappling hook
    string sClimbConvo = GetLocalString(
        OBJECT_SELF,
        "climb_convo"
    );  // Name of conversation for handling all climbing interactions
    string sClimbRopeGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_global"
    );  // Name of global that is used to store pit/climbing state
    
    int nHasRope = 0;
    int nHasGrapple = 0;
    
    if (!GetIsPC(oPC))
        return;
    
    nHasRope = (
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sRope0
            )
        ) +
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sRope1
            )
        ) + 
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sRope2
            )
        ) +
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sRope3
            )
        ) +
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sRope4
            )
        )
    );
    nHasGrapple = (
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sGrapple0
            )
        ) +
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sGrapple1
            )
        ) +
        GetIsObjectValid(
            GetItemPossessedBy(
                oPC,
                sGrapple2
            )
        )
    );
       
    if (
        ((nHasRope > 0) && (nHasGrapple > 0)) ||
        (GetGlobalInt(sClimbRopeGlobal) > 0)
    ) {
        BeginConversation(
            sClimbConvo,
            oPC
        );
    }
}


/*void main()
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
}*/
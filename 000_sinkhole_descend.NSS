
// there are a few variables that need to be set on the triggers
//climb_rope_tied_global - name of the gobal to use that sets the rope is tied and there
//climb_rope_bad_global - name of the gobal to use that sets the rope is going to unravel when weight is put on
//climb_rope_fixed_global - name of the gobal to use that sets the rope has been fixed
//climb_top_wp - name of the waypoint to go to at the top
//climb_bottom_wp - name of hte waypoint to go to at the bottom



void main(int type)
{
    // type - Type of descent to handle
    // 0: pc descends with no problem
    // 1: pc slips a little, failed DC 15 check
    // 2: pc falls off rope, failed DC 10 check
    // 3: pc falls because rope unties at the top
    object oPC = GetPCSpeaker();
    int nPCSkill, nDamage, nTumbled, nDoDamage, nFallDamageDice, nTumbledFallDamageDice, nSlippedFallDamageDice, nFallLength;
    string sClimbRopeTiedGlobal, sClimbRopeBadGlobal, sClimbBottomWP;

    sClimbRopeTiedGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_tied_global"
    );  // Name of global that is used to store that rope is tied
    sClimbRopeBadGlobal = GetLocalString(
        OBJECT_SELF,
        "climb_rope_bad_global"
    );  // Name of global that is used to store that rope will unravel with weight put on it
    sClimbBottomWP = GetLocalString(
        OBJECT_SELF,
        "climb_bottom_wp"
    );  // Name of bottom WP to go to

    nFallLength = GetLocalInt(
        OBJECT_SELF,
        "climb_fall_length"
    );  // Potential fall length, in feet

    nDamage = 0;
    nDoDamage = 0;
    nTumbled = 0;
    // 1d6 for every 10 feet
    nFallDamageDice = FloatToInt(
        IntToFloat(nFallLength) / 10.0
    );
    // successful tumble removes 2 dice of damage
    nTumbledFallDamageDice = (
        (nFallDamageDice >= 2) ? nFallDamageDice - 2 : 0
    );
    // slipping does 2d6 for big drops, 1d6 for small drops
    nSlippedFallDamageDice = (
        (nFallDamageDice > 2) ? 2 : 1
    );

    nPCSkill = GetSkillRank(SKILL_TUMBLE, oPC);

    if ((nPCSkill > 0) && (d20() + nPCSkill >= 15)) {
        nTumbled = 1;
    }

    switch (type) {
        case 1:
            nDamage = d6(nSlippedFallDamageDice);
            break;
        case 3:
            // Remove the rope as it comes down with the PC
            SetGlobalInt(sClimbRopeTiedGlobal, 0);
            SetGlobalInt(sClimbRopeBadGlobal, 0);
        case 2:
            if (nTumbled)
                nDamage = d6(nTumbledFallDamageDice);
            else
                nDamage = d6(nFallDamageDice);
            break;
    }

    if (nDoDamage > 0) {
        DelayCommand(
            2.5,
            AssignCommand(
                oPC,
                ApplyEffectToObject(
                    DURATION_TYPE_INSTANT,
                    EffectDamage(
                        nDamage,
                        DAMAGE_TYPE_BLUDGEONING
                    ),
                    oPC
                )
            )
        );
    }

    DelayCommand(
        0.5,
        AssignCommand(
            oPC,
            ActionJumpToObject(
                GetWaypointByTag(sClimbBottomWP)
            )
        )
    );
}


/*void main(int type)
{
	object o = GetPCSpeaker();
	int check = GetSkillRank(SKILL_TUMBLE, o);
	int damage = d6(2);
	int tumbled = 0;
	
	if ((check > 0) && (d20() + check >= 15))
		tumbled = 1;
		
	switch (type) {
		case 1:
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			break;
		case 2:
			if (tumbled)
				damage = d6(2);
			else
				damage = d6(4);
				
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			break;
		case 3:
			if (tumbled)
				damage = d6(2);
			else
				damage = d6(4);
				
			DelayCommand(2.5,AssignCommand(o,ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(damage,DAMAGE_TYPE_BLUDGEONING),o)));
			SetGlobalInt("sinkhole_rope",0);
			SetGlobalInt("sinkhole_rope_bad",0);
			break;
	}
	DelayCommand(0.5,AssignCommand(o,ActionJumpToObject(GetWaypointByTag("WP_SINKHOLE_BOTTOM"))));
}*/
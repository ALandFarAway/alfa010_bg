void main() { 
     object oPC=GetEnteringObject(); 
     if ( !GetLocalInt( oPC, "NO_AT" ) ) { 
          FloatingTextStringOnCreature( "*" + GetFirstName( oPC ) + " disappears into the mist*", oPC ); 
          location lTarget = Location( GetArea( GetObjectByTag( "underdark_a6_ethereal" ) ), GetPosition( oPC ), GetFacing( oPC ) ); 
          AssignCommand( oPC, ClearAllActions() );  
          DelayCommand( 0.5, AssignCommand( oPC, ActionJumpToLocation( lTarget ) ) ); 
     } 
     DeleteLocalInt(oPC,"NO_AT"); 
}
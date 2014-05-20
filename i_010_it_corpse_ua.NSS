void main() {
    // Get our objects.
    object oPC = GetModuleItemLostBy();
    object oItem = GetModuleItemLost();
	
	// Spawn a placeable.
	object oCorpse = CreateObject( OBJECT_TYPE_PLACEABLE, "010_herb_corpse", GetLocation( oPC ) );
	
	// Prevent infinite body searching. Searches must be before taking a corpse.
	SetLocalInt( oCorpse, "searched", 1 );
	
	// Delete the item.
	DestroyObject( oItem );
}
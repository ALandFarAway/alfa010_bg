// gc_global_int
//bg_priest_set_allied

 
//  Wynna: 9-11-2008  creation

#include "ginc_var_ops"
#include "acr_db_persist_i"

//#include "nwnx_sql"

void main()

{
	object oPC = GetPCSpeaker();
	object oOwner = OBJECT_SELF;	
	ACR_SetPersistentString(oPC, GetName(oOwner) + "Faith", "Allied" );
	 
}
void main()
{
	object oPC = GetLastUsedBy();
	string sYear = "The Number is: "+IntToString(GetGlobalInt("abacus_value"));
	FloatingTextStringOnCreature(sYear, oPC, TRUE, 3.0f);
}
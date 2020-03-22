

void main()
{
int abacus_value = GetGlobalInt("abacus_value");

int abacus_value_one = GetGlobalInt("abacus_value_one");
int abacus_value_five = GetGlobalInt("abacus_value_five");
int abacus_value_ten = GetGlobalInt("abacus_value_ten");
int abacus_value_hundred = GetGlobalInt("abacus_value_hundred");
int abacus_value_thousand = GetGlobalInt("abacus_value_thousand");

object oPC = GetLastUsedBy();

int BallValue = 0;

//Check what the local string of the object is set in 'Variables' on object
string sAbaId = GetLocalString(OBJECT_SELF, "sAbaId");

if(sAbaId == "one")
{
	if(abacus_value_one < 5)
	{
		abacus_value_one++;
	}
	else
	{
		abacus_value_one = 0;
	}
	BallValue = abacus_value_one;	
}
else if(sAbaId == "five")
{
	if(abacus_value_five < 5)
	{
		abacus_value_five++;
	}
	else
	{
		abacus_value_five = 0;
	}
	BallValue = abacus_value_five;
}
else if(sAbaId == "ten")
{
	if(abacus_value_ten < 5)
	{
		abacus_value_ten++;
	}
	else
	{
		abacus_value_ten = 0;
	}
	BallValue = abacus_value_ten;	
}
else if(sAbaId == "hundred")
{
	if(abacus_value_hundred < 5)
	{
		abacus_value_hundred++;
	}
	else
	{
		abacus_value_hundred = 0;
	}
	BallValue = abacus_value_hundred;	
}
else if(sAbaId == "thousand")
{
	if(abacus_value_thousand < 5)
	{
		abacus_value_thousand++;
	}
	else
	{
		abacus_value_thousand = 0;
	}
	BallValue = abacus_value_thousand;		
}
else
	FloatingTextStringOnCreature("Error", oPC, TRUE, 3.0f);
	
string sAbacusBall = sAbaId+"_ball";
object oAbacusBall = GetObjectByTag(sAbacusBall);	
string sAbacusWay = "first_puzzle_"+sAbaId+"_appear_"+IntToString(BallValue)+"_way";
//FloatingTextStringOnCreature(sAbacusWay, GetFirstPC(), TRUE, 5.0f);
object abacusWay = GetObjectByTag(sAbacusWay);
location lAbacusWay = GetLocation(abacusWay);
DestroyObject(oAbacusBall);
CreateObject(OBJECT_TYPE_PLACEABLE, sAbacusBall, lAbacusWay, TRUE);
	
//Assign the new concated value to abacus value (Note: 4352 is answer)
abacus_value = (abacus_value_one*1)+(abacus_value_five*5)+(abacus_value_ten*10)+(abacus_value_hundred*100)+(abacus_value_thousand*1000);

//Set all the global Ints
SetGlobalInt("abacus_value_one", abacus_value_one);
SetGlobalInt("abacus_value_five", abacus_value_five);
SetGlobalInt("abacus_value_ten", abacus_value_ten);
SetGlobalInt("abacus_value_hundred", abacus_value_hundred);
SetGlobalInt("abacus_value_thousand", abacus_value_thousand);
SetGlobalInt("abacus_value", abacus_value);	

string sDebugString = "You Pressed: "+sAbaId+" now the number is: "+IntToString(abacus_value)+"";
FloatingTextStringOnCreature(sDebugString, oPC, TRUE, 2.0f);

if(abacus_value == 4352)
FloatingTextStringOnCreature("You hear a small click", oPC, TRUE, 3.0f);

}
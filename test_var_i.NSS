#include "nwnx_time"

void print(object o, string s)
{
		SendMessageToPC(o,s);
		PrintString(s);
}

void iterate(int max, object o, object o2)
{
	int i;
	StartTimer(o,"t");
	print(o2, "Iterating + "+IntToString(max));
	for (i=0; i < max; ++i) {
		GetLocalInt(o, IntToString(i));
	}
	print(o, StopTimer(o,"t"));
}


void iterate_rev(int max, object o, object o2)
{
	int i;
	StartTimer(o,"t2");
	print(o2, "Iterating - "+IntToString(max));
	for (i=max; i >= 0; --i) {
		GetLocalInt(o, IntToString(i));
	}
	print(o, StopTimer(o,"t2"));
}


void test(int j, object o, object o2)
{
	int i,max=1;
	
	if (j > GetLocalInt(o,"TEST_MAX"))
		return;
					
	print(o, "Executing "+IntToString(j));
	
	for (i=0; i < j; ++i) {
		max *= 10;
	}
	
	DelayCommand(10.0f, iterate(max,o2,o));
	DelayCommand(20.0f, iterate_rev(max,o2,o));
	
	DelayCommand(30.0f, test(j+1,o,o2));
}

void gen(int i, int max, int incr, int total_max, object o)
{
	for (; i < max; ++i) {
		SetLocalInt(OBJECT_SELF, IntToString(i), i);
	}
	
	print(o, "gen " + IntToString(i));
		
	if (max >= total_max) {
		print(o, "generated " + IntToString(i));
	}
	else {
		DelayCommand(0.5f, gen(i, incr+max, incr, total_max, o));
	}
}
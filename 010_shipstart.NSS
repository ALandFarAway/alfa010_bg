// Operates a ship trip.
// =======================================================================================
// startWP -- the waypoint representing the start of the trip
// endWP -- the waypoint representing the end of the trip
// tripLength -- the length of time, in minutes, that the trip should last
// =======================================================================================
// of note that the ship stays at the dock before the trip starts for two minutes. This is
// to allow full groups time to board. One of the main uses of a ship ride is to get to
// talk without all of those disruptive ATs.
// =======================================================================================

#include "acr_area_instance_i"
#include "010_ship_i"

void main(string startWP, string endWP, float tripLength)
{
	object oPC = GetPCSpeaker();
	SendMessageToPC(oPC, "You're shown to the ship, and make ready to depart.");
	AssignCommand(GetModule(), ManageShip(startWP, endWP, oPC, tripLength));
}
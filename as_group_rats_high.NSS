////////////////////////////////////////////////////////////////////////////////
//
//  System Name : ACR Spawn System
//     Filename : as_group_example.nss
//      Version : 1.0
//         Date : 2006-9-17
//       Author : Ronan
//
//  Description
//  This is a simple example of a spawn group script which is used by the ACR's
//  spawn system. Though the name of the script is "as_group_example", the spawn
//  point which uses this script would simply have "example" listed as a spawn
//  group name, since the "as_group_" is always added on to the beginning. For a
//  more complex example of spawn groups, see the script "as_group_complex".
//
//  Revision History
// Rick, made several types of rats.
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Includes ////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This line is required on all spawn group scripts.
#include "acr_spawn_i"

////////////////////////////////////////////////////////////////////////////////
// Constants ///////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Structures //////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Global Variables ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
// Function Prototypes /////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

// This is the main function, which is what the spawn system runs when this
// spawn group is spawned.
void main();

////////////////////////////////////////////////////////////////////////////////
// Function Definitions ////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

void main() {
ACR_SpawnObject("010_cr_rat", OBJECT_TYPE_CREATURE);
if(Random(5) > 2)
 	{ACR_SpawnObject("010_cr_rat", OBJECT_TYPE_CREATURE);}
if(Random(5) > 2)
 	{ACR_SpawnObject("010_cr_ratdire", OBJECT_TYPE_CREATURE);}
if(Random(5) > 2)
 	{ACR_SpawnObject("010_cr_ratdire", OBJECT_TYPE_CREATURE);}
if(Random(5) > 2)
 	{ACR_SpawnObject("010_cr_rat", OBJECT_TYPE_CREATURE);}
if(Random(5) > 2)
 	{ACR_SpawnObject("010_cr_ratdire", OBJECT_TYPE_CREATURE);}

if(Random(10) == 0)
{
	ACR_SpawnObject("abr_wererat", OBJECT_TYPE_CREATURE);
}
}
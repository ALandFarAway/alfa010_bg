/* 
 *  Script generated by LS Script Generator, v.TK.0
 *
 *  For download info, please visit:
 *  http://nwvault.ign.com/View.php?view=Other.Detail&id=1502
 */
// Put this under "Actions Taken" in the conversation editor.


void main()
{
    object oTarget;

    // Get the PC who is in this conversation.
    object oPC = GetPCSpeaker();

    // Close and lock nearest test door.
    oTarget = GetNearestObjectByTag("dr_cosm_testdoor");
    AssignCommand(oTarget, ActionCloseDoor(oTarget));
    SetLocked(oTarget, TRUE);

    // Setting the requirement for a specific key to unlock "dr_knights_gambit".
    SetLockKeyRequired(oTarget);

    // Setting lock data for "dr_knights_gambit".
    SetLockLockable(oTarget, FALSE);
}
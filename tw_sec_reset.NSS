/* User-defined event script to reset a secret item after a delay of
 * 3 minutes.
 */

#include "tw_secret"

void main()
{
    if (GetUserDefinedEventNumber() == EVENT_SECRET_REVEALED) {
        DelayCommand(300.0, ResetSecretItem());
    }
}
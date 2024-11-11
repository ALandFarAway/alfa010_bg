
void main()
{
    // Get the scoundrel who's bashing a door
    object oPCDamager = GetLastDamager();
    //Size of detection range, sphere radius
    float fSphereRadius = FeetToMeters(60f);
    
    // Make sure the damaging object
    if(GetIsObjectValid(oPCDamager) && GetIsPC(oPCDamager))
    {
        // Make sure the damaging object is in the same area
        if(GetArea(oPCDamager) == GetArea(OBJECT_SELF))
        {
            object oSpotter = GetFirstObjectInShape(SHAPE_SPHERE, fSphereRadius, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            
            while(GetIsObjectValid(oSpotter))
            {
                //Make sure you aren't detected by yourself
                if(oSpotter == oPCDamager)
                    continue;
                
                if(GetObjectSeen(oPCDamager, oSpotter))
                {
                    //YOUR PC HAS BEEN SEEN, DO SOMETHING HERE.
                    
                    break; //you can probably stop iterating here
                }
                oSpotter = GetNextObjectInShape(SHAPE_SPHERE, fSphereRadius, GetLocation(OBJECT_SELF), TRUE, OBJECT_TYPE_CREATURE);
            }
            
            //Your pc did bashed a door in but wasn't found.
        }
    }
}

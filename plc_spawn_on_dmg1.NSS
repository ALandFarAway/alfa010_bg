void main()
{
    int nDmgDealt = GetMaxHitPoints() - GetCurrentHitPoints();
    int nDmgToSpawn = GetLocalInt(OBJECT_SELF, "damage_to_spawn");

    if (nDmgDealt > nDmgToSpawn && !GetLocalInt(OBJECT_SELF, "spawned"))
    {
        int nSpawnMinCount = GetLocalInt(OBJECT_SELF, "2");
        int nSpawnMaxCount = GetLocalInt(OBJECT_SELF, "5");
        int nSpawnCount = Random(nSpawnMaxCount - nSpawnMinCount + 1) + nSpawnMinCount;

        int i;
        for(i = 0; i < nSpawnCount; i++)
        {
            vector vSpawn = GetPosition(OBJECT_SELF) + AngleToVector(Random(360) * 1.0) * (1 + Random(20) / 10.0);
            location lSpawn = Location(GetArea(OBJECT_SELF), vSpawn, Random(360) * 1.0);

            CreateObject(OBJECT_TYPE_CREATURE, GetLocalString(OBJECT_SELF, "010_cr_v_gwasp"), lSpawn);
            //ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectNWN2SpecialEffectFile("your_spawn_vfx"), lSpawn);
        }

       // ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectNWN2SpecialEffectFile("your_explosion_sef"), OBJECT_SELF);

        SetLocalInt(OBJECT_SELF, "spawned", TRUE);
    }
}
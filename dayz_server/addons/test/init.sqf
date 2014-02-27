diag_log text "[TEST]: waiting for DZFL to load";
[] spawn {
    waitUntil{!(isNil "DZFL_Loaded") && !(isNil "sm_done");};
    diag_log text "[TEST]: DZFL loaded";
    while {true} do {
        diag_log text "[TEST]: DZFL DZFL_Sleep, DZFL_Equip_Unit, DZFL_Spawn_AI_Group";
        [45,10] call DZFL_Sleep;
        {
            [2,[getDir _x,position _x],EAST,[300,300],["Sniper1_DZ","Camo1_DZ","Rocket_DZ"],[[position _x,30]],[["backpacks","backpack"],["sniperrifles","cfglootweapon"],["pistols","cfglootweapon"]],DZFL_AI_Skill_Low] call DZFL_Spawn_AI_Group;
        } forEach playableUnits;
    };
};
diag_log text "[TEST]: waiting for DZFL to load";
[] spawn {
    waitUntil{!(isNil "DZFL_Loaded") && !(isNil "sm_done");};
    diag_log text "[TEST]: DZFL loaded";
    while {true} do {
        diag_log text "[TEST]: DZFL DZFL_Sleep, DZFL_Equip_Unit, DZFL_Spawn_AI_Group";
        [45,10] call DZFL_Sleep;
        {
            if(!(_x getVariable["DZFL_equipped",false])) then {
                [_x,false,[["machineguns","cfglootweapon"],["Makarov","weapon"],["ItemBloodbag","magazine"],["ItemBandage","magazine"]]] call DZFL_Equip_Unit;
                _x setVariable["DZFL_equipped",true];
            };
        } forEach playableUnits;
    };
};
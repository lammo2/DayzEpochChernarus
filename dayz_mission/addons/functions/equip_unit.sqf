/*
 *  original code by MUDZERELI
 *
 *  purpose:
 *  -equips a uniq with loot from CfgLoot
 *  -the unit must reside on the calling computer
 *
 *  syntax:
 *  [unit,wipe,loot] call DZFL_Equip_Unit;
 *
 *  arguments:
 *  unit -- <Object>                             -- unit to equip
 *  wipe -- <true/false>                         -- clear the unit's gear if true
 *  loot -- [[<CfgLoot Class>,<Loot Type>], ...] -- unit's gear, loaded from CfgLoot.cpp -- more info @ https://github.com/vbawol/DayZ-Epoch/blob/407741b7ddd3316a07cff3f16b03b12a97215a99/SQF/dayz_code/Configs/CfgLoot/CfgLoot.hpp
 *
 *  returns:
 *  the unit
 */

private ["_itemTypes","_tQty","_index","_selected","_qty","_weights","_cntWeights","_max","_mags","_class","_type","_unit","_loot","_wipe"];
_unit = _this select 0;
_wipe = _this select 1;
_loot = _this select 2;

if (_wipe) then {
    // clear the units gear
    diag_log text format["[DZFL]: DZFL_Equip_unit -- clearing equipment of %1",_unit];
    removeAllWeapons _unit;
    removeAllItems _unit;
};

// equip the unit with loot
diag_log text format["[DZFL]: DZFL_Equip_unit -- equipping %1 with  %2",_unit,_loot];
{
    _class = _x select 0;
    _type  = _x select 1;
    //### BEGIN HEAVILY MODIFIED spawn_loot.sqf CODE
    switch(_type) do {
        default
        {
            if (DZE_MissionLootTable) then {
                _itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _type)) select 0);
            } else {
                _itemTypes = ((getArray (configFile >> "cfgLoot" >> _type)) select 0);
            };
            _index = dayz_CLBase find _class;
            _weights = dayz_CLChances select _index;
            _cntWeights = count _weights;
            _qty = 0;
            _max = 1 + round(random 2);
            while {_qty < _max} do
            {
                _tQty = 1 + round(random 1);
                _index = floor(random _cntWeights);
                _index = _weights select _index;
                _selected = _itemTypes select _index;
                _unit addMagazine [_selected,_tQty];
                _qty = _qty + _tQty;
            };
            if (_type != "") then {_unit addWeapon _type;};
        };
        case "backpack":
        {
            if (DZE_MissionLootTable) then {
                _itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _class)) select 0);
            } else {
                _itemTypes = ((getArray (configFile >> "cfgLoot" >> _class)) select 0);
            };
            _index = dayz_CLBase find _class;
            _weights = dayz_CLChances select _index;
            _cntWeights = count _weights;
            _index = floor(random _cntWeights);
            _index = _weights select _index;
            _selected = _itemTypes select _index;
            _unit addBackPack _selected;
        };
        case "cfglootweapon":
        {
            if (DZE_MissionLootTable) then {
                _itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _class)) select 0);
            } else {
                _itemTypes = ((getArray (configFile >> "cfgLoot" >> _class)) select 0);
            };
            _index = dayz_CLBase find _class;
            _weights = dayz_CLChances select _index;
            _cntWeights = count _weights;
            _index = floor(random _cntWeights);
            _index = _weights select _index;
            _selected = _itemTypes select _index;
            if (_selected == "Chainsaw") then {
                _selected = ["ChainSaw","ChainSawB","ChainSawG","ChainSawP","ChainSawR"] call BIS_fnc_selectRandom;
            };
            _unit addWeapon _selected;
            _mags = [] + getArray (configFile >> "cfgWeapons" >> _selected >> "magazines");
            if ((count _mags) > 0) then {
                if (_mags select 0 == "Quiver") then { _mags set [0, "WoodenArrow"] }; // Prevent spawning a Quiver
                if (_mags select 0 == "20Rnd_556x45_Stanag") then { _mags set [0, "30Rnd_556x45_Stanag"] };
                if (_mags select 0 == "30Rnd_556x45_G36") then { _mags set [0, "30Rnd_556x45_Stanag"] };
                if (_mags select 0 == "30Rnd_556x45_G36SD") then { _mags set [0, "30Rnd_556x45_StanagSD"] };
                for "_i" from 0 to (2 + (round(random 2))) do {_unit addMagazine (_mags select 0);};
            };
        };
        case "weapon":
        {
            _unit addWeapon _class;
            _mags = [] + getArray (configFile >> "cfgWeapons" >> _class >> "magazines");
            if ((count _mags) > 0) then
            {
                if (_mags select 0 == "Quiver") then { _mags set [0, "WoodenArrow"] }; // Prevent spawning a Quiver
                if (_mags select 0 == "20Rnd_556x45_Stanag") then { _mags set [0, "30Rnd_556x45_Stanag"] };
                if (_mags select 0 == "30Rnd_556x45_G36") then { _mags set [0, "30Rnd_556x45_Stanag"] };
                if (_mags select 0 == "30Rnd_556x45_G36SD") then { _mags set [0, "30Rnd_556x45_StanagSD"] };
                for "_i" from 0 to (2 + (round(random 2))) do {_unit addMagazine (_mags select 0);};
            };
        };
        case "single": 
        {
            if (DZE_MissionLootTable) then {
                _itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _class)) select 0);
            } else {
                _itemTypes = ((getArray (configFile >> "cfgLoot" >> _class)) select 0);
            };
            _index = dayz_CLBase find _class;
            _weights = dayz_CLChances select _index;
            _cntWeights = count _weights;
            _index = floor(random _cntWeights);
            _index = _weights select _index;
            _selected = _itemTypes select _index;
            _unit addMagazine _selected;
        };
        case "magazine":
        {
            _unit addMagazine _class;
        };
    };
    //### END HEAVILY MODIFIED spawn_loot.sqf CODE
} forEach _loot;

_unit
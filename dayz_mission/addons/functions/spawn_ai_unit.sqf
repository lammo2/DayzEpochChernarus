/*
 *  original code by VAMPIRE
 *  modified by MUDZERELI
 *
 *  purpose:
 *  spawn a hostile AI unit into a given group at a given location
 *
 *  syntax:
 *  [worldspace,group,model,loot,skills] call DZFLI_Spawn_AI_Unit;
 *
 *  arguments:
 *  worldspace  -- [<Direction (0-360)>[<X Position (#f)>,<Y Position (#f)>,<Z Position> (#f)]] -- position to spawn unit 
 *  group       -- Arma 2 Group                                                                 -- group for unit to join 
 *  model       -- <Model Class>                                                                -- model for unit 
 *  loot        -- [[<CfgLoot Class>,<Loot Type>], ...]                                         -- unit's gear, loaded from CfgLoot.cpp -- more info @ https://github.com/vbawol/DayZ-Epoch/blob/407741b7ddd3316a07cff3f16b03b12a97215a99/SQF/dayz_code/Configs/CfgLoot/CfgLoot.hpp
 *  skills      -- [[<ARMA Skill Name>,<Skill Percent (#f)>], ...]                              -- array of skills and levels for unit to have
 *
 *  returns: 
 *  the spawned unit
 */

private ["_worldspace","_group","_skills","_direction","_position","_posX","_posY","_posZ","_model","_unit","_itemTypes","_tQty","_index","_qty","_weights","_cntWeights","_max","_loot","_mags","_class","_type","_selected"];
_worldspace = _this select 0;
_group      = _this select 1;
_model      = _this select 2;
_loot       = _this select 3;
_skills     = _this select 4;

_direction = _worldspace select 0;
_position  = _worldspace select 1;

_posX = _position select 0;
_posY = _position select 1;
_posZ = _position select 2;

diag_log text format["[DZFL]: DZFL_Spawn_AI_Unit -- %1 @ %2 <%3> (%4)",_model,_position,_group,_loot];
// spawn the unit into the passed group at the passed location
_unit = _group createUnit [_model, [_posX,_posY,_posZ], [], 10, "PRIVATE"];
_unit setDir _direction;

// initialize ai of unit with passed skills
[_unit] joinSilent _group;
_unit enableAI "TARGET";
_unit enableAI "AUTOTARGET";
_unit enableAI "MOVE";
_unit enableAI "ANIM";
_unit enableAI "FSM";
_unit setCombatMode "YELLOW";
_unit setBehaviour "COMBAT";
/// default all skills to 1
{_unit setSkill [_x,1]} forEach ["aimingAccuracy","aimingShake","aimingSpeed","endurance","spotDistance","spotTime","courage","reloadSpeed","commanding","general"];
/// load custom skills
{_unit setSkill [(_x select 0),(_x select 1)]} forEach _skills;

// add passed gear to unit
removeAllWeapons _unit;
removeAllItems _unit;
{
    _class = _this select 0;
    _type  = _this select 1;
    //### BEGIN HEAVILY MODIFIED spawn_loot.sqf CODE
    switch(_type) do {
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
                _unit addMagazine [(_mags select 0),2 + (round(random 2))];
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
                _unit addMagazine [(_mags select 0),2 + (round(random 2))];
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
            _unit addMagazine [_selected,1];
        };
        default
        {
            if (DZE_MissionLootTable) then {
                _itemTypes = ((getArray (missionConfigFile >> "cfgLoot" >> _class)) select 0);
            } else {
                _itemTypes = ((getArray (configFile >> "cfgLoot" >> _class)) select 0);
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
    };
    //### END HEAVILY MODIFIED spawn_loot.sqf CODE
} forEach _loot;

_unit

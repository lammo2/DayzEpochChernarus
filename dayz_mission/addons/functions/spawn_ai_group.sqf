/*
 *  original code by VAMPIRE
 *  modified by MUDZERELI
 *
 *  purpose:
 *  spawns a randomly equipped hostile group of AI units with waypoints at a given location
 *
 *  syntax:
 *  [count,worldspace,side,timers,models,loot,skills] call DZFL_Spawn_AI_Group;
 *
 *  arguments:
 *  count       -- <#Units To Spawn (#i)>                                                       -- number of units to spawn
 *  worldspace  -- [<Direction (0-360)>[<X Position (#f)>,<Y Position (#f)>,<Z Position> (#f)]] -- position to spawn group
 *  side        -- <Side>                                                                       -- what side should the units join?
 *  timers      -- [<Despawn Timer Alive (#i)>,<Despawn Timer Dead (#i)>                        -- timers in seconds to despawn live/dead units
 *  models      -- [<Model Class>, ...]                                                         -- unit's model is randomly selected from this array
 *  loot        -- [[<CfgLoot Class>,<Loot Type>], ...]                                         -- unit's gear, loaded from CfgLoot.cpp -- more info @ https://github.com/vbawol/DayZ-Epoch/blob/407741b7ddd3316a07cff3f16b03b12a97215a99/SQF/dayz_code/Configs/CfgLoot/CfgLoot.hpp
 *  skills      -- [[[<ARMA Skill Name>,<Skill Percent (#f)>], ...], ...]                       -- multiple skill arrays to randomly choose from
 *
 *  returns:
 *  the group of units
 */

private ["_timerDead","_worldspace","_count","_timers","_skills","_timerLive","_group","_models","_model","_loot","_side"];
_count      = _this select 0;
_worldspace = _this select 1;
_side       = _this select 2;
_timers     = _this select 3;
_models     = _this select 4;
_loot       = _this select 5;
_skills     = _this select 6;

_timerLive = _timers select 0;
_timerDead = _timers select 1;

_group = createGroup _side;

// spawn the proper number of units into the group
for "_i" from 0 to _count do {
    _model = _models call BIS_fnc_selectRandom;
    [_worldspace,_group,_model,_loot,_skills] call DZFL_Spawn_AI_Unit;
};

// if there's a lifespan timer, spawn a thread to despawn the groups units if they are alive past their timer
if (_timerLive > 0) then {
    [_group,_timerLive] spawn {
        private["_group","_timerLive"];
        _group     = _this select 0;
        _timerLive = _this select 1;
        [_timerLive,5] call DZFL_Sleep;
        {if (alive _x) then {_x call DZFL_Purge;};} forEach (units _group);
    };
};

// if there's a death timer, add a handler to despawn the unit's body after it's killed
if (_timerDead > 0) then {
    {_x addEventHandler ["Killed",[_x,_timerDead] call DZFLI_EH_AI_Killed];} forEach (units _group);
};

_group

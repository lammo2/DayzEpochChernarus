/*
 *  original code by VAMPIRE
 *  modified by MUDZERELI
 *
 *  purpose:
 *  spawn a hostile AI at a given location
 *
 *  syntax:
 *  [worldspace,group,model,loot,skills] call DZFLI_Spawn_AI_Unit;
 *
 *  arguments:
 *  worldspace  -- [<Direction (0-360)>[<X Position (#f)>,<Y Position (#f)>,<Z Position> (#f)]] -- position to spawn unit 
 *  group       -- Arma 2 Group                                                                 -- group for unit to join 
 *  model       -- <Model Class>                                                                -- model for unit 
 *  skills      -- [[<ARMA Skill Name>,<Skill Percent (#f)>], ...]                              -- array of skills and levels for unit to have
 *
 *  returns: 
 *  the spawned unit
 */

private ["_worldspace","_group","_skills","_direction","_position","_posX","_posY","_posZ","_model","_unit"];
_worldspace = _this select 0;
_group      = _this select 1;
_model      = _this select 2;
_skills     = _this select 3;

_direction = _worldspace select 0;
_position  = _worldspace select 1;

_posX = _position select 0;
_posY = _position select 1;
_posZ = _position select 2;

diag_log text format["[DZFL]: DZFL_Spawn_AI_Unit -- %1 @ %2 (%3) -- spawning unit",_model,_position,_group];
// spawn the unit into the passed group at the passed location
_unit = _group createUnit [_model, [_posX,_posY,_posZ], [], 10, "PRIVATE"];
_unit setDir _direction;

// initialize ai of unit with passed skills
diag_log text format["[DZFL]: DZFL_Spawn_AI_Unit -- %1 @ %2 (%3) -- enabling AI behavior",_model,_position,_group];
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

_unit

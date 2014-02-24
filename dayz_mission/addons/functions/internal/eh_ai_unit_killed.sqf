/*
 *  original code by MUDZERELI
 *
 *  purpose:
 *  purge AI units after they are killed
 *
 *  syntax:
 *  [unit,timerDead] call EH_AI_Unit_Killed;
 *
 *  arguments:
 *  unit      -- <Object>           -- unit to purge 
 *  timerDead -- <Death Timer (#i)> -- time in seconds before purge occurs 
 */

private["_unit","_timerDead"];
_unit      = _this select 0;
_timerDead = _this select 1;
// sleep for the passed death timer
[_timerDead,20] call DZFL_Sleep;
// purge the unit
_unit call DZFL_Purge;
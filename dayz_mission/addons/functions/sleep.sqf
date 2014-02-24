/*
 *  original code by MUDZERELI
 *
 *  purpose:
 *  sleep for a designated amount of time
 *
 *  syntax:
 *  [sleepTime,checkInterval] call DZFL_Sleep;
 *
 *  arguments:
 *  sleepTime     -- <Sleep Time (#i)>     -- sleep time in seconds  
 *  checkInterval -- <Check Interval (#i)> -- checks are done at this interval to see if timer is up
 */

private["_sleepTime","_checkInterval","_startTime"];
_sleepTime = _this select 0;
_checkInterval = _this select 1;
diag_log text format["[DZFL]: DZFL_Sleep -- waiting %1 seconds",_sleepTime];
// mark the time the function was called
_startTime = diag_tickTime;
// wait until the time passed from the marked start time until now is greater than the sleep time
waitUntil{sleep _checkInterval; (diag_tickTime - _startTime) > _sleepTime;};
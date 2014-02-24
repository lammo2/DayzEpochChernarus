/*
 *  original code by EPOCH CLEANUP
 *
 *  purpose:
 *  completely purge an object
 *
 *  syntax:
 *  [object] call DZFL_Purge;
 *
 *  arguments:
 *  object -- <Object> -- object to purge 
 */

diag_log text format["[DZFL]: DZFL_Purge -- purging %1 @ %2",typeOf _this,position _this];
_this enableSimulation false;
_this removeAllMPEventHandlers "mpkilled";
_this removeAllMPEventHandlers "mphit";
_this removeAllMPEventHandlers "mprespawn";
_this removeAllEventHandlers "FiredNear";
_this removeAllEventHandlers "HandleDamage";
_this removeAllEventHandlers "Killed";
_this removeAllEventHandlers "Fired";
_this removeAllEventHandlers "GetOut";
_this removeAllEventHandlers "GetIn";
_this removeAllEventHandlers "Local";
clearVehicleInit _this;
deleteVehicle _this;
deleteGroup (group _this);
_this = nil;
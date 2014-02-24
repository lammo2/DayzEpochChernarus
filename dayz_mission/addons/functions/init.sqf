diag_log text "[DZFL]: loading function library";
// load config file
diag_log text "[DZFL]: loading config file";
call compile preprocessFileLineNumbers "config.sqf";

// common functions
diag_log text "[DZFL]: loading external function: DZFL_Sleep";
DZFL_Sleep = compile preprocessFileLineNumbers "sleep.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Purge";
DZFL_Purge = compile preprocessFileLineNumbers "purge.sqf";

// ai spawning functions
diag_log text "[DZFL]: loading internal function: DZFLI_EH_AI_Killed";
DZFLI_EH_AI_Killed = compile preprocessFileLineNumbers "internal\eh_ai_unit_killed.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Spawn_AI_Unit";
DZFL_Spawn_AI_Unit = compile preprocessFileLineNumbers "spawn_ai_unit.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Spawn_AI_Group";
DZFL_Spawn_AI_Group = compile preprocessFileLineNumbers "spawn_ai_group.sqf";



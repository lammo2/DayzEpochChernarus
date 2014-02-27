diag_log text "[DZFL]: loading function library";
// load config file
diag_log text "[DZFL]: loading config file";
call compile preprocessFileLineNumbers "addons\functions\config.sqf";

// common functions
diag_log text "[DZFL]: loading external function: DZFL_Sleep";
DZFL_Sleep = compile preprocessFileLineNumbers "addons\functions\sleep.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Purge";
DZFL_Purge = compile preprocessFileLineNumbers "addons\functions\purge.sqf";

// gear equipping function
diag_log text "[DZFL]: loading external function: DZFL_Equip_Unit";
DZFL_Equip_Unit = compile preprocessFileLineNumbers "addons\functions\equip_unit.sqf";

// ai spawning functions
diag_log text "[DZFL]: loading internal function: DZFLI_EH_AI_Killed";
DZFLI_EH_AI_Killed = compile preprocessFileLineNumbers "addons\functions\internal\eh_ai_unit_killed.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Spawn_AI_Unit";
DZFL_Spawn_AI_Unit = compile preprocessFileLineNumbers "addons\functions\spawn_ai_unit.sqf";
diag_log text "[DZFL]: loading external function: DZFL_Spawn_AI_Group";
DZFL_Spawn_AI_Group = compile preprocessFileLineNumbers "addons\functions\spawn_ai_group.sqf";

diag_log text "[DZFL]: done loading";
DZFL_Loaded = true;




/*
	Medical Crate by lazyink (Full credit for original code to TheSzerdi & TAW_Tonic)
	Updated to new format by Vampire
*/

private ["_missName","_coords","_net","_vehicle","_vehicle1","_crate"];

//Name of the Mission
_missName = "Medical Cache";

//DZMSFindPos loops BIS_fnc_findSafePos until it gets a valid result
_coords = call DZMSFindPos;

[nil,nil,rTitleText,"Bandits have Taken Over a Survivor Medical Cache!", "PLAIN",10] call RE;

//DZMSAddMajMarker is a simple script that adds a marker to the location
[_coords,_missname] ExecVM DZMSAddMajMarker;

//Lets add the scenery
_net = createVehicle ["Land_CamoNetB_NATO",[(_coords select 0) - 0.0649, (_coords select 1) + 0.6025,0],[], 0, "CAN_COLLIDE"];
[_net] call DZMSProtectObj;

//We create the vehicles like normal
_vehicle = createVehicle ["SUV_TK_CIV_EP1",[(_coords select 0) + 10.0303, (_coords select 1) - 12.2979,10],[], 0, "CAN_COLLIDE"];
_vehicle1 = createVehicle ["Ural_INS",[(_coords select 0) - 4869.2983, (_coords select 1) - 9663.6406,10],[], 0, "CAN_COLLIDE"];

//DZMSSetupVehicle prevents the vehicle from disappearing and sets fuel and such
[_vehicle] call DZMSSetupVehicle;
[_vehicle1] call DZMSSetupVehicle;

_crate = createVehicle ["USVehicleBox",_coords,[], 0, "CAN_COLLIDE"];
_crate1 = createVehicle ["MedBox0",[(_coords select 0) - 3.7251,(_coords select 1) - 2.3614, 0],[], 0, "CAN_COLLIDE"];
_crate2 = createVehicle ["MedBox0",[(_coords select 0) - 3.4346, 0, 0],[], 0, "CAN_COLLIDE"];
_crate3 = createVehicle ["MedBox0",[(_coords select 0) + 4.0996,(_coords select 1) + 3.9072, 0],[], 0, "CAN_COLLIDE"];

//DZMSBoxFill fills the box, DZMSProtectObj prevents it from disappearing
[_crate,"medical"] ExecVM DZMSBoxSetup;
[_crate] call DZMSProtectObj;
[_crate1] call DZMSProtectObj;
[_crate2] call DZMSProtectObj;
[_crate3] call DZMSProtectObj;

//DZMSAISpawn spawns AI to the mission.
//Usage: [_coords, count, skillLevel]
[[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],6,1] ExecVM DZMSAISpawn;
sleep 5;
[[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],6,1] ExecVM DZMSAISpawn;
sleep 5;
[[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],4,1] ExecVM DZMSAISpawn;
sleep 5;
[[(_coords select 0) + 0.0352,(_coords select 1) - 6.8799, 0],4,1] ExecVM DZMSAISpawn;
sleep 5;

//Wait until the player is within 30meters
waitUntil{ {isPlayer _x && _x distance _coords <= 30 } count playableunits > 0 }; 

//Call DZMSSaveVeh to attempt to save the vehicles to the database
//If saving is off, the script will exit.
[_vehicle] ExecVM DZMSSaveVeh;
[_vehicle1] ExecVM DZMSSaveVeh;

//Let everyone know the mission is over
[nil,nil,rTitleText,"The Medical Cache is Under Survivor Control!", "PLAIN",6] call RE;
diag_log format["[DZMS]: Major SM6 Medical Cache Mission has Ended."];
deleteMarker "DZMSMajMarker";
deleteMarker "DZMSMajDot";

//Let the timer know the mission is over
DZMSMajDone = true;
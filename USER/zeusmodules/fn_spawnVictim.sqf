params ["_position"];

private _vehicle = "BWA3_Eagle_Tropen" createVehicle _position;

private _damageLevel = 0.8; 
private _hitpoints = getAllHitPointsDamage _vehicle select 0;
{
	_vehicle setHitPointDamage [_x, _damageLevel];
} forEach _hitpoints;

_vehicle allowDamage false;

[_vehicle] remoteExec ["grad_zeusmodules_fnc_spawnVictimVehicleFX", 0, true];

private _victim = (creategroup civilian) createUnit ["BWA3_Rifleman_lite_Tropen", _position, [], 0, "None"];
[_victim, 0.8, "rightleg", "bullet"] call ace_medical_fnc_addDamageToUnit;
_victim setCaptive true;
_victim setBehaviour "CARELESS";
_victim setCombatMode "BLUE";
_victim setVariable ["lambs_danger_disableAI", true, true];

_victim setUnitLoadout [["BWA3_G36A3_tan_ZO4x30_RSAS_pointer","","BWA3_acc_VarioRay_irlaser","BWA3_optic_ZO4x30_RSAS_brown",["BWA3_30Rnd_556x45_G36",30],[],""],[],["BWA3_P8","","","",["BWA3_15Rnd_9x19_P8",15],[],""],["BWA3_Uniform_tee_Tropen",[["FirstAidKit",1],["BWA3_30Rnd_556x45_G36",3,30],["BWA3_DM25",1,1]]],["BWA3_Vest_Tropen",[["BWA3_15Rnd_9x19_P8",2,15]]],[],"H_HeadBandage_bloody_F","",[],["ItemMap","","ItemRadio","ItemCompass","ItemWatch",""]];







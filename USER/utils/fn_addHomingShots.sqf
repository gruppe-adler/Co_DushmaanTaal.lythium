// if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

params ["_unit"];

_unit addEventHandler ["Fired", {
	params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

	private _target = missionNamespace getVariable ["GRAD_ambushVehicle", Grad_AmbushTarget];

	if (isNull _target) exitWith {};

	// [_target, _projectile] remoteExec ["GRAD_UTILS_fnc_guideMissile", _projectile];
	[_target, _projectile] call GRAD_UTILS_fnc_guideMissile;
}];

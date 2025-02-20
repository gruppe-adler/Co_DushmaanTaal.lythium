if (!hasInterface) exitWith {};


["ace_common_playActionNow", {
	params ["_unit", "_animation"];

	if (_unit == player) then {
		if (_animation == "gestureGo") then {
			[false] call grad_traffic_controlVehicle;
		};
		if (_animation == "gestureFreeze") then {
			[true] call grad_traffic_controlVehicle;
		};
	};

}] call CBA_fnc_addEventhandler;


grad_traffic_controlVehicle = {
	params ["_stopVehicle"];
	
	private _existingTraffic = missionNamespace getVariable ["grad_traffic", []];
	private _index = _existingTraffic find cursorObject;
	private _distance = 10000;

	if (_index > -1) then {
		private _vehicle = _existingTraffic select _index;
		_distance = player distance _vehicle;
		if (_distance < 100) then {
			if (_stopVehicle) then {
				_vehicle setVariable ["grad_traffic_stopped", true, true];
			} else {
				_vehicle setVariable ["grad_traffic_stopped", false, true];
			};
		};
	} else {
		"No Vehicle to signal to" call CBA_fnc_notify;
	};
};

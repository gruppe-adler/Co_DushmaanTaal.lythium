params ["_unit"];

if (hasInterface) then {
	private _animation = "Acts_CivilListening_1";
	_unit switchMove _animation;

	_unit addEventHandler ["AnimDone", {
		params ["_unit"];

		if (!alive _unit) then { _unit removeEventHandler ["AnimDone", _thisEventhandler]; };
		
		private _animation = _unit getVariable ["animationLoop", "Acts_CivilListening_1"];
		if (_animation != "") then { _unit switchmove _animation; };
	}];
};

if (!isServer) exitWith {};

private _animation = selectRandom [
				"Acts_Explaining_EW_Idle01",
				"Acts_Explaining_EW_Idle02",
				"Acts_Explaining_EW_Idle03",
				"Acts_Gallery_Visitor_01",
				"","","",""
			];
_unit setVariable ["animationLoop", _animation, true];

private _group = group _unit;
private _units = units _group;

doStop _unit;
// _unit doWatch zementska;

[{
	params ["_unit"];

	[{
		params ["_args", "_handle"];
		_args params ["_unit"];

		if (!isNil "zementska") then {

			if (isNull _unit) exitWith {
				[_handle] call CBA_fnc_removePerFrameHandler;
			};

			if ((_unit distance2D zementska) > 70) exitWith {};
			
			_unit dofollow _unit;
			_unit setformdir (_unit getDir zementska);
			_unit moveTo (getpos zementska);
			// _unit setDir (_unit getRelDir zementska);
		};

	}, 1, [_unit]] call CBA_fnc_addPerFrameHandler;

}, [_unit], random 1] call CBA_fnc_waitAndExecute;

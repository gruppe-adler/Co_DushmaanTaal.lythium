if (!isServer) exitWith {};


/// MOTORIZED

{
	private _identifier = _x;
	private _reinforcements1 = getMissionLayerEntities _identifier;
	_reinforcements1 params [["_objects1", []], ["_markers", []], ["_groups1", []]];

	// assign convoy order by checking how vehicles are aligned to each other
	[_objects1] call grad_zeusmodules_fnc_sortConvoy;

	{
		_x hideObjectGlobal true;
	} forEach _objects1;

	[{
		params ["_objects", "_groups", "_identifier"];
		missionNameSpace getVariable [_identifier, false]
	},{
		params ["_objects", "_groups"];

		// show all attached ladepritschen and their cargo
		{
			_x enableSimulationGlobal true;
			_x hideObjectGlobal false;

			{ 
				_x hideObjectGlobal false;
				{ _x hideObjectGlobal false; } forEach attachedObjects _x;
			} forEach attachedObjects _x;
		} forEach _objects;
		
		// sort leader to beginning
		private _unitsFound = [];
		private _targetDestination = [0,0,0];
		{ 
			private _index = _x getVariable ["grad_convoy_index", -1];
			if (_index > -1) then {
				_unitsFound set [_index, _x];
				if (_index == 0) then {
					_targetDestination = _x getVariable ["grad_convoy_destination", [0,0,0]];
				};
			};
		} forEach _objects;
		// systemchat str _unitsFound;

		[_unitsFound, _targetDestination] call grad_zeusmodules_fnc_simpleConvoy;	

	}, [_objects1, _groups1, _identifier]] call CBA_fnc_waitUntilAndExecute;

} forEach [];
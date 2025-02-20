if (!isServer || !canSuspend) exitWith { _this remoteExec [_fnc_scriptName, 2]; };

private _heliArr = [[random 300, random 300, 200 + random 100], 0, "UK3CB_C_Bell412_Luxury", civilian] call BIS_fnc_spawnVehicle;
_heliArr params ["_heli", "_heliCrewObjects", "_heliCrew"];
_heli allowDamage false;
_heliCrew setBehaviour "CARELESS";

sleep 0.5;

[_heli] call GRAD_UTILS_fnc_playPresidentEvac_Landing;

private _heliWaypoint = _heliCrew addWaypoint [[11023.2,5749.54,0], 0];
_heliWaypoint setWaypointType "SCRIPTED";
_heliWaypoint setWaypointScript "A3\functions_f\waypoints\fn_wpLand.sqf";


[
	{
		params ["_heli"];
		(isTouchingGround _heli) && (alive _heli)
	},
	{
		params ["_heli", "_heliCrew"];

		_heli disableAI "ALL";
		
		[
			{
				params ["_heli", "_crew"];

				[
					{
						params ["_args", "_handle"];
						_args params ["_heli"];

						if (missionNamespace getVariable ["GRAD_takeOffPresident", false]) exitWith {
							[_handle] call CBA_fnc_removePerFrameHandler;
							[_heli] call GRAD_UTILS_fnc_playPresidentEvac_TakeOff;
							[
								{
									params ["_heli", "_crew"];
									{
										deleteVehicle _x;										
									} forEach ([units _crew] + [_heli]);
								},
								[_heli, _heliCrew],
								60
							] call CBA_fnc_waitAndExecute;
						};
						
						// STOP BOUNCE
						private _vel = velocity _heli;
						_heli setVelocity [_vel # 0, _vel # 1, -1.5];
					},
					0,
					[_heli]
				] call CBA_fnc_addPerFrameHandler;
			},
			[_heli, _heliCrew],
			3
		] call CBA_fnc_waitAndExecute;
	},
	[_heli, _heliCrew],
	300
] call CBA_fnc_waitUntilAndExecute;

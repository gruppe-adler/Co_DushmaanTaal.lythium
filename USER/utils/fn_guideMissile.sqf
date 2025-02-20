params ["_target", "_projectile"];

[
	{
		params ["_args", "_handle"];
		_args params ["_target", "_projectile"];

		if ((isNull _projectile) || !(alive _target)) exitWith {
			[_handle] call CBA_fnc_removePerFrameHandler;
		};

		// private _distance = _target distance _projectile;
		private _targetPos = getPosASL _target;		
		private _targetVel = velocity _target;
		private _projectilePos = getPosASL _projectile;
		private _projectileTarget = _targetPos;
		_projectileTarget set [2, (_projectileTarget # 2) + 0.5];
		private _flightVec = _projectilePos vectorFromTo _projectileTarget;
		private _missileSpeed = ((velocityModelSpace _projectile select 1) * 1.0001) min 190;
		// systemChat format["Speed: %1", _missileSpeed];
		private _velP = _flightVec vectorMultiply _missileSpeed;
		
		private _projVec = vectorNormalized (velocity _projectile);
		private _dot = _projVec vectorDotProduct _flightVec;
		private _cross = _projVec vectorCrossProduct _flightVec;
		private _angle = (vectorMagnitude _cross) atan2 _dot;
		// if ((_angle > MAX_ANGLE) && (_currentDistance > 50)) then {
		// 	// systemChat format["Angle: %1", _angle];
		// 	private _rate = (MAX_ANGLE / _angle) max 0.08;
		// 	private _interpolated = _rate bezierInterpolation [_projVec, _flightVec];
		// 	_flightVec = _interpolated;
		// 	_velP = _interpolated vectorMultiply _missileSpeed;
		// };

		_projectile setVelocity _velP;
		_projectile setVectorDir _flightVec;
		_projectile setVectorUp (_flightVec vectorCrossProduct [_flightVec # 1, _flightVec # 0, 0]);
	},
	0,
	[_target, _projectile]
] call CBA_fnc_addPerFrameHandler;

params ["_position"];

[_position] spawn {

	params ["_position"];

	{
		_x addEventHandler ["fired",{
			deleteVehicle (_this select 6);
			(_this select 0) removeEventHandler ["fired", _thisEventhandler];
		}];
	} forEach [grad_arty1, grad_arty2, grad_arty3];

	{
			private _ammo = (getArtilleryAmmo [_x]) param [0, ""];
			private _target = [5162.02,1144.24,0];
			_x doArtilleryFire  [_target, _ammo, 1];

			sleep (1 +  random 3);
	} forEach [grad_arty1, grad_arty2, grad_arty3];

	sleep 17 + random 3;

	{
		private _randomPosition =  [[[_position, 17]],[]] call BIS_fnc_randomPos; 
		private _shell = "Sh_82mm_AMOS" createVehicle [_randomPosition#0, _randomPosition#1, 500];
		_shell setVectorUp [0,0,-1];
		_shell setVelocity [0,0,-150];

		sleep random 2;

	} forEach [grad_arty1, grad_arty2, grad_arty3];

};

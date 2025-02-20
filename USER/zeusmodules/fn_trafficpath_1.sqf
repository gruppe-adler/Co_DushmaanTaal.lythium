private _path = [];


for "_i" from 1 to 33 do {
	
	private _speedhelper = missionNameSpace getVariable [("trafficpath_" + str _i), objNull];
	private _position = getPos _speedhelper;
	private _speed = _speedhelper getVariable ["grad_speed", 10];
	_position set [3, _speed/3.6];
	_path pushBackUnique _position;

 };

 _path
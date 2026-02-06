params [
    ["_displayX", (["hatg_setting_ui_x", 0, uiNamespace] call HATG_fnc_getVariable)],
    ["_displayY", (["hatg_setting_ui_y", 0, uiNamespace] call HATG_fnc_getVariable)],
    ["_width", (["hatg_setting_ui_width", 0.45, uiNamespace] call HATG_fnc_getVariable)],
    ["_height", (["hatg_setting_ui_height", 1.7, uiNamespace] call HATG_fnc_getVariable)]
];

private _display = call HATG_fnc_getDisplay;

if (_display isEqualTo []) exitWith {};

private _displayHidden = _display#1;

private _interfaceSizeFix = -1;
private _interfaceSize = (getResolution select 5); // Hacky fix but womp womp, cry about it
switch (_interfaceSize) do { // Large is not handled here due to Arma bullshit
	case 1: 
	{ // Very Large
		_interfaceSizeFix = 0.7;
	};
	case 0.7: 
	{ // Normal
		_interfaceSizeFix = 0.3;
	};
	case 0.55: 
	{ // Small
		_interfaceSizeFix = -0.1;
	};
	case 0.47: 
	{ // Very Small
		_interfaceSizeFix = -0.4;
	};
};

_displayX = _displayX + ( ( safeZoneX + ( safeZoneWAbs / 2 )) - ( _width / 2 ) );

if (_interfaceSizeFix isEqualTo -1) then { // hacky fix for large interface size, as it doesn't return the correct value...?
	_displayY = _displayY + ( ( safeZoneY + safeZoneH ) - _height - (-0.5));
} else {
	_displayY = _displayY + ( ( safeZoneY + safeZoneH ) - _height + _interfaceSizeFix );
};

_displayHidden ctrlSetPosition [_displayX, _displayY, _width, _height];
_displayHidden ctrlCommit 0;
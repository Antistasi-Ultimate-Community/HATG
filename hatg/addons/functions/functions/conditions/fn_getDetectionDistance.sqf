/*
    Author:
        Silence
    
    Description:
        Checks all the different factors in detection distance, returns the result
    
    Params:
        _unit <OBJECT>
        _stance <STRING>
    
    Dependencies:
        global variables:
        > hatg_setting_distance_close <INT>
        > hatg_setting_distance_close_multiplier <INT>
    
    Usage:
        [player, "PRONE"] call HATG_fnc_getDetectionDistance;
    
    Return:
        _distanceClose <FLOAT>
*/

params ["_unit", ["_stance", "PRONE"]];

private _distanceClose = hatg_setting_distance_close;
private _distanceCloseMultiplier = hatg_setting_distance_close_multiplier;

// Can't think of a better way to do these if statements, there will be a more efficient way. Brain doesn't brain rn
if (hatg_setting_simple) then {
    _distanceClose = 5;
    _distanceCloseMultiplier = 2;
};

if (_stance == "CROUCH") then {
    _distanceClose = _distanceClose * _distanceCloseMultiplier;
};

if (_stance == "STAND") then {
    _distanceClose = _distanceClose * (_distanceCloseMultiplier * 2);
};

// Can't exactly merge these into 1 statement since the effects are meant to stack
if (call HATG_fnc_isNight) then {
    _distanceClose = _distanceClose / 2;
};

if (call HATG_fnc_isRaining) then {
    _distanceClose = _distanceClose / 2;
};

if (call HATG_fnc_isFoggy) then {
    _distanceClose = _distanceClose / 2;
};

if ([_unit] call HATG_fnc_isInBuilding) then {
    _distanceClose = _distanceClose / 2;
};

if ([_unit] call HATG_fnc_hasGhillie) then { // ghillie should ideally have no benefit if standing
    _distanceClose = _distanceClose / 2;
};

_distanceClose = _distanceClose max 5;

_distanceClose;
/*
    Author:
        Silence
    
    Description:
        Deletes _mirror and removes it from the _unit namespace
        (As of 19/07/2026 DD/MM/YY) hides the mirror instead of deleting it
    
    Params:
        _unit <OBJECT> <Default: ObjNull>
        _mirror <OBJECT> <Default: ObjNull>
    
    Dependencies:
        _unit variables:
        > "hatg_mirror_toggle" <OBJECT>
        > "hatg_mirror_visible" <OBJECT>

    Scope:
        Local, Remote
    
    Environment:
        Unscheduled
    
    Usage:
        [player] call HATG_fnc_NAME;
    
    Return:
        _return <TYPE>
*/

params [
    ["_unit", ObjNull],
    ["_mirror", ObjNull]
];

if (_mirror isEqualTo ObjNull) then {
    _mirror = [_unit] call HATG_fnc_getMirror
};

if (_unit isEqualTo ObjNull) exitWith {false};
if (_mirror isEqualTo ObjNull) exitWith {false}; // if mirror is still ObjNull then we can assume it does not exist

[format["Hiding a mirror at position (ATL: %1)", getPosATL _mirror], 1, _fnc_scriptName] call HATG_fnc_log;

private _toggle = ["hatg_mirror_toggle", false, _unit] call HATG_fnc_getVariable;
if (_toggle) then {
    deleteVehicle _mirror;
    _unit setVariable ["hatg_mirror", ObjNull, true];
    ["Mirror deleted due to toggle", 1, _fnc_scriptName] call HATG_fnc_log;
} else {
    _mirror hideObjectGlobal true;
    _unit setVariable ["hatg_mirror_visible", false, true];
};

if (isPlayer _unit) then {
    [_unit] call HATG_fnc_handleDisplayText;
};

true;

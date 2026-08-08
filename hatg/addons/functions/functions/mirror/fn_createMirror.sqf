/*
    Author:
        Silence
    
    Description:
        Creates a "mirror" on _unit and attaches it to them.
        Handles the mirror already existing to prevent duplication.
        Attaches the "mirror" object to the _unit namespace under "hatg_mirror" for easy retrieval.
    
    Params:
        _unit <OBJECT> <Default: ObjNull>

    Dependencies:
        hatg_setting_simple_object <BOOL>

    Scope:
        Local, Remote* (?)
    
    Environment:
        Unscheduled
    
    Usage:
        [player] call HATG_fnc_createMirror;
    
    Return:
        _mirror <OBJECT>
*/

params [
    ["_unit", ObjNull],
    ["_stance", "PRONE"]
];

if (_unit isEqualTo ObjNull) exitWith {false};

private _mirror = [_unit] call HATG_fnc_getMirror;
if (_mirror isNotEqualTo ObjNull) exitWith {false};

[format["Creating a mirror for %1 (ATL: %2)", name _unit, getPosATL _unit], 1, _fnc_scriptName] call HATG_fnc_log;

private _mirrorType = "";
private _mirrorCoords = [0,0,0];

if (hatg_setting_simple_object && {isPlayer _unit}) then {
    _mirrorType = ["hatg_mirror_new", "hatg_mirror_debug_new"] select (call HATG_fnc_isDebug);
    _mirrorCoords = [0,2,1];
} else {
    _mirrorType = ["hatg_mirror", "hatg_mirror_debug"] select (call HATG_fnc_isDebug);
};

private _mirror = _mirrorType createVehicle [0,0,0];

_mirror setPosATL getPosATL _unit;
_mirror attachTo [_unit, _mirrorCoords];

_unit setVariable ["hatg_mirror", _mirror, true];

if (isPlayer _unit) then {
    [_unit] call HATG_fnc_handleDisplayText;
};

_mirror;
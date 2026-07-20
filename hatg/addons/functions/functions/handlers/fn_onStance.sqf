/*
    Author:
        Silence
    
    Description:
        The associated code with "handleStance"
    
    Params:
        _unit <OBJECT>
    
    Dependencies:
        _unit variables:
        > "hatg_mirror_disable" <BOOL>
        > "hatg_mirror_visible" <BOOL>
    
    Usage:
        [player] call HATG_fnc_onStance;
    
    Return:
        true, if we should exit
*/

params ["_unit"];

if !(alive _unit) exitWith {true};
if (["hatg_mirror_disable", false, _unit] call HATG_fnc_getVariable isEqualTo true) exitWith {true};

private _stance = stance _unit;
private _stances = ["PRONE", "STAND"];

if (hatg_setting_enable_crouch) then {
    _stances pushBack "CROUCH";
};

private _mirrorVisible = _unit getVariable ["hatg_mirror_visible", false];

if !(_stance in _stances) exitWith {
    if (_mirrorVisible) then {
        [_unit] call HATG_fnc_deleteMirror;
    };
    false
};

if ([_unit, _stance] call HATG_fnc_canCreateMirror) exitWith {
    if !(_mirrorVisible) then {
        [_unit] call HATG_fnc_createMirror;
    };
    false;
};

if (_mirrorVisible) then {
    [_unit] call HATG_fnc_deleteMirror;
};

false;

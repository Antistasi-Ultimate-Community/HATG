params [
    ["_id", 0], 
    ["_displayName", "RscTitleDisplayEmpty"],
    ["_width", (["hatg_setting_ui_x", 0.45] call HATG_fnc_getVariable)],
    ["_height", (["hatg_setting_ui_y", 1.7] call HATG_fnc_getVariable)]
];

disableSerialization;

#define IDC_HIDDENTEXT 10000

private _id = ["HATG_layer" + _displayName] call BIS_fnc_rscLayer;
_id cutRsc [_displayName, "PLAIN", 0, false, true];
private _display = uiNamespace getVariable _displayName;

private _vignette = _display displayCtrl 1202;
_vignette ctrlShow false;

private _hiddenDisplayText = _display ctrlCreate ["RscStructuredText", IDC_HIDDENTEXT];
[_width, _height] call HATG_fnc_handleDisplayPosition;
_hiddenDisplayText ctrlEnable false;

["hatg_display_hidden", [_display, _hiddenDisplayText], uiNamespace] call HATG_fnc_setVariable;

[_display, _hiddenDisplayText];
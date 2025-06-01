#ifdef DISABLE_COMPILE_CACHE
    #define LINKFUNC(x) {call FUNC(x)}
    #define PREP_RECOMPILE_START    if (isNil "MEOW_PREP_RECOMPILE") then {MEOW_RECOMPILES = []; MEOW_PREP_RECOMPILE = {{call _x} forEach MEOW_RECOMPILES;}}; private _recomp = {
    #define PREP_RECOMPILE_END      }; call _recomp; MEOW_RECOMPILES pushBack _recomp;
#else
    #define LINKFUNC(x) FUNC(x)
    #define PREP_RECOMPILE_START ; /* disabled */
    #define PREP_RECOMPILE_END ; /* disabled */
#endif

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) FUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#ifdef DEBUG_MODE_FULL
    #define PARAM_INVALID(paramVar,type) if (ISNIL_1(paramVar) || IS_NOTTYPE(paramVar,type)) then { TRACE_1("Invalid parameter:",paramVar); };
    #define GVAR_ISNIL(var) if (ISNIL_1(GVAR(var))) then { TRACE_1('GVAR(var) is nil:',GVAR(var)); };
    #define EGVAR_ISNIL(var1,var2) if (ISNIL_1(EGVAR(var1,var2))) then { TRACE_1('EGVAR(var1,var2) is nil:',EGVAR(var1,var2)); };
#else
    #define PARAM_INVALID(paramVar,type) /* disabled */
    #define GVAR_ISNIL(var) /* disabled */
    #define EGVAR_ISNIL(var1,var2) /* disabled */
#endif
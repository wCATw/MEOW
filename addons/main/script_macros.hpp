#include "\z\meow\addons\main\script_mod.hpp"
#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #undef PREP2
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
    #define PREP2(folder,fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\#folder\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #undef PREP2
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
    #define PREP2(folder,fncName) [QPATHTOF(functions\#folder\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

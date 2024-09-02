#include "\z\meow\addons\main\script_mod.hpp"
`
#define Q(x) #x

#define FUNC(x) ADDON##_fnc_##x
#define GVAR(x) ADDON##_##x

#define FUNC2(x,y) x##_fnc_##y
#define GVAR2(x,y) x##_##y
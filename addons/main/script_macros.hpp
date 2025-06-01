#include "\x\cba\addons\main\script_macros_common.hpp"
#include "\x\cba\addons\xeh\script_xeh.hpp"

#include "\a3\ui_f\hpp\defineDIKCodes.inc"
#include "\a3\ui_f\hpp\defineResincl.inc"
#include "\a3\ui_f\hpp\defineResinclDesign.inc"

#define ISNIL_1(var1) (isNil {var1})
#define ISNIL_2(var1,var2) (isNil {var1} || isNil {var2})
#define ISNIL_3(var1,var2,var3) (isNil {var1} || isNil {var2} || isNil {var3})
#define ISNIL_4(var1,var2,var3,var4) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4})
#define ISNIL_5(var1,var2,var3,var4,var5) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4} || isNil {var5})
#define ISNIL_6(var1,var2,var3,var4,var5,var6) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4} || isNil {var5} || isNil {var6})
#define ISNIL_7(var1,var2,var3,var4,var5,var6,var7) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4} || isNil {var5} || isNil {var6} || isNil {var7})
#define ISNIL_8(var1,var2,var3,var4,var5,var6,var7,var8) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4} || isNil {var5} || isNil {var6} || isNil {var7} || isNil {var8})
#define ISNIL_9(var1,var2,var3,var4,var5,var6,var7,var8,var9) (isNil {var1} || isNil {var2} || isNil {var3} || isNil {var4} || isNil {var5} || isNil {var6} || isNil {var7} || isNil {var8} || isNil {var9})
#define IS_TYPE(var,type) ((typeName var) == type)
#define IS_NOTTYPE(var,type) ((typeName var) != type)

#define SETTING(var) class GVAR(var) { movedToSQF = 1; };

#include "script_debug.hpp"
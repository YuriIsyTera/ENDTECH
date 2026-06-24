//CoT ZS By Hikari_Nova.
//ALL RIGHTS RESERVED
//在未经过原作者的允许下,你不能应用于任何服务器,以及任何更改。
//Under the permission of the author, you cannot be applied to any server, as well as any changes.

#priority 1000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;

//压缩超光速奇点
var SSS0 = VanillaFactory.createItem("sssssscore");
SSS0.maxStackSize = 64;
SSS0.register();

//暴乱数据
var RDA0 = VanillaFactory.createItem("riotdata");
RDA0.maxStackSize = 1;
RDA0.register();

//星体磁令
var PEF0 = VanillaFactory.createItem("planet_ff");
PEF0.maxStackSize = 64;
PEF0.register();
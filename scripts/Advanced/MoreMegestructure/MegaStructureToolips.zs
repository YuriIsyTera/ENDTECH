#sideonly client
#priority -100
#reloadable

import crafttweaker.mods.ILoadedMods;
import mods.modularmachinery.MachineModifier;
import crafttweaker.item.IItemStack;
import mods.zenutils.I18n;

<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e前往§4新秩序§e的必经之路。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§0负相§e收集者大致分为两个部分——物质解压单元和负相采集单元。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e为了驱动此机器，你需要向机器中输入超维度计算机与'合金'完成超维计算单元的建造：§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e您可以通过继续向机器中输入超维度计算机与'合金'以升级超维计算单元。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e初始状态(未建造超维计算单元)时为 0 级，每级将为每个线程提供 1024并行 与 0.8x 时间修正。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e为了驱动负相物质采集单元，你需要完成以下步骤：§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§eI.向机器中输入 0x00 电路以启动暗物质收集单元，暗物质采集单元每 10分钟 会产出在1 ~ 10000中任意一个数的暗物质(整数)。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e暗物质收集单元每工作一次需要冷却 10分钟 ，且此进程不可快进，暗物质采集单元运行完成后将进入下一步骤。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§eII.您需要在 100秒 内输入 暗物质的产出量 * 超维计算单元等级 mB的抗熵增流质且误差不超过 5%。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e输入完成且配方结束后将进入下一步骤。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§eIII.在此步骤，机器会在控制器正上方一格的红石逻辑端口中输出随机 1~4 的红石信号。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§e您需要输入 暗物质的产出量 * 输出的红石信号 mB的液态稀有金属且误差不超过 5%。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§eIV.完成上述所有步骤时，机器将进入 1小时 的 ‘维度突破’ 模式，在此模式下，您可以输入指定的材料以制造负相物质。§f");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("");
<modularmachinery:giga_negativephasecollector_factory_controller>.addTooltip("§4注意 : 拆除结构方块可能导致机器被重置!§f");

<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("向其输入中子源以加速内部中子，特定动能的中子对硅岩等物质有奇效。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("当中子动能大于 0MeV 时，每 40Tick 减少 40MeV 中子动能。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("当中子动能大于 6000MeV 时，红石逻辑端口将输出强度为 10 的红石信号。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("当中子动能大于 8000MeV 时，红石逻辑端口将输出强度为 12 的红石信号。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("当中子动能大于 10000MeV 时，红石逻辑端口将输出强度为 14 的红石信号。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("当中子动能大于 12000MeV 时，中子活化器将启动自毁程序。");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("");
<modularmachinery:mega_neutronactivator_factory_controller>.addTooltip("§4它，无可避免。§f");

<modularmachinery:blockenergyoutputhatch:*>.addTooltip("§7§o//////// 已被[EndTech]终末工程修改 ////////");
<modularmachinery:blockenergyinputhatch:*>.addTooltip("§7§o//////// 已被[EndTech]终末工程修改 ////////");
<modularmachinery:blockenergyoutputhatch:0>.addTooltip(I18n.format("new.energy.storge","§c5M RF"));
<modularmachinery:blockenergyoutputhatch:0>.addTooltip(I18n.format("new.energy.max_output","§c250k RF/t"));
<modularmachinery:blockenergyoutputhatch:1>.addTooltip(I18n.format("new.energy.storge","§c40M RF"));
<modularmachinery:blockenergyoutputhatch:1>.addTooltip(I18n.format("new.energy.max_output","§c2M RF/t"));
<modularmachinery:blockenergyoutputhatch:2>.addTooltip(I18n.format("new.energy.storge","§c160M RF"));
<modularmachinery:blockenergyoutputhatch:2>.addTooltip(I18n.format("new.energy.max_output","§c8M RF/t"));
<modularmachinery:blockenergyoutputhatch:3>.addTooltip(I18n.format("new.energy.storge","§c1G RF"));
<modularmachinery:blockenergyoutputhatch:3>.addTooltip(I18n.format("new.energy.max_output","§c50M RF/t"));
<modularmachinery:blockenergyoutputhatch:4>.addTooltip(I18n.format("new.energy.storge","§c40G RF"));
<modularmachinery:blockenergyoutputhatch:4>.addTooltip(I18n.format("new.energy.max_output","§c2G RF/t"));
<modularmachinery:blockenergyoutputhatch:5>.addTooltip(I18n.format("new.energy.storge","§c4T RF"));
<modularmachinery:blockenergyoutputhatch:5>.addTooltip(I18n.format("new.energy.max_output","§c200G RF/t"));
<modularmachinery:blockenergyoutputhatch:6>.addTooltip(I18n.format("new.energy.storge","§c20T RF"));
<modularmachinery:blockenergyoutputhatch:6>.addTooltip(I18n.format("new.energy.max_output","§c2T RF/t"));
<modularmachinery:blockenergyoutputhatch:7>.addTooltip(I18n.format("new.energy.storge","§c200P RF"));
<modularmachinery:blockenergyoutputhatch:7>.addTooltip(I18n.format("new.energy.max_output","§c20P RF/t"));

<modularmachinery:blockenergyinputhatch:0>.addTooltip(I18n.format("new.energy.storge","§c5M RF"));
<modularmachinery:blockenergyinputhatch:0>.addTooltip(I18n.format("new.energy.max_input","§c250k RF/t"));
<modularmachinery:blockenergyinputhatch:1>.addTooltip(I18n.format("new.energy.storge","§c40M RF"));
<modularmachinery:blockenergyinputhatch:1>.addTooltip(I18n.format("new.energy.max_input","§c2M RF/t"));
<modularmachinery:blockenergyinputhatch:2>.addTooltip(I18n.format("new.energy.storge","§c160M RF"));
<modularmachinery:blockenergyinputhatch:2>.addTooltip(I18n.format("new.energy.max_input","§c8M RF/t"));
<modularmachinery:blockenergyinputhatch:3>.addTooltip(I18n.format("new.energy.storge","§c1G RF"));
<modularmachinery:blockenergyinputhatch:3>.addTooltip(I18n.format("new.energy.max_input","§c50M RF/t"));
<modularmachinery:blockenergyinputhatch:4>.addTooltip(I18n.format("new.energy.storge","§c40G RF"));
<modularmachinery:blockenergyinputhatch:4>.addTooltip(I18n.format("new.energy.max_input","§c2G RF/t"));
<modularmachinery:blockenergyinputhatch:5>.addTooltip(I18n.format("new.energy.storge","§c4T RF"));
<modularmachinery:blockenergyinputhatch:5>.addTooltip(I18n.format("new.energy.max_input","§c200G RF/t"));
<modularmachinery:blockenergyinputhatch:6>.addTooltip(I18n.format("new.energy.storge","§c20T RF"));
<modularmachinery:blockenergyinputhatch:6>.addTooltip(I18n.format("new.energy.max_input","§c2T RF/t"));
<modularmachinery:blockenergyinputhatch:7>.addTooltip(I18n.format("new.energy.storge","§c200P RF"));
<modularmachinery:blockenergyinputhatch:7>.addTooltip(I18n.format("new.energy.max_input","§c20P RF/t"));
<modularmachinery:blockenergyinputhatch:*>.addTooltip("§7§o具体数值请以实际情况为准");
<modularmachinery:blockenergyoutputhatch:*>.addTooltip("§7§o具体数值请以实际情况为准");
# var edited_by_endtech = mods.rainbowtooltip.RainbowTooltip.formatWithColorsAndSpeed("由[EndTech]终末工程修改",400,["#FF0000","#FF7F00","#FFFF00","#00FF00","#00FFFF","#0000FF","#8B00FF"]);
# <modularmachinery:blockenergyoutputhatch:*>.addTooltip(edited_by_endtech);
# <modularmachinery:blockenergyinputhatch:*>.addTooltip(edited_by_endtech);

<contenttweaker:space_array>.addTooltip("在机器内部创造一个§3全新§f的§7宇宙§f");
<contenttweaker:space_array>.addTooltip("手持§1星阵§f并对机器右键以安装§1星阵§f");
<contenttweaker:space_array>.addTooltip("可以为部分机器提供§3更多§f的§a并行数§f");
<contenttweaker:space_array>.addTooltip("目前支持的机器:");
<contenttweaker:space_array>.addTooltip("├§b太空电梯资源采集模块§f");
<contenttweaker:space_array>.addTooltip("└§1量子操纵者§f");
<contenttweaker:space_array>.addTooltip("§7§o以上机器均自带一枚星阵");
<modularmachinery:giga_qft_factory_controller>.addTooltip("当结构中的§7恒星级§b虚空§9量子海§7腔室§f被替换为§5§l奥术§8§l时空§9§l膨胀§b§l发生器§f时，产出将变为原来的 64x。");

<contenttweaker:lightspeed_overclock_array>.addTooltip("对§e光速§f进行§3超频§f以调整机器的时空曲率");
<contenttweaker:lightspeed_overclock_array>.addTooltip("手持§9光速超频矩阵§f并对机器右键以安装§9光速超频矩阵§f");
<contenttweaker:lightspeed_overclock_array>.addTooltip("可以为部分机器提供 §e1024x §a速度加成§f");
// <contenttweaker:lightspeed_overclock_array>.addTooltip("可以为部分发电机器提供 §e1024x §c发电加成§f");
<contenttweaker:lightspeed_overclock_array>.addTooltip("可以为部分发电机器提供 §e64x §c发电加成§f");
<contenttweaker:lightspeed_overclock_array>.addTooltip("§4注意:安装多个§9光速超频矩阵§4是无效的!§f");
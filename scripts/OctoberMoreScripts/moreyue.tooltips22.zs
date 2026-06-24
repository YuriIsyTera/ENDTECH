/*
    CrT ZS By Hikari_Nova & EringMantis831.
    在未经过原作者的允许下,你不能应用于任何服务器,以及任何更改。
    Under the permission of the author, you cannot be applied to any server, as well as any changes.
*/

#reloadable

import crafttweaker.mods.ILoadedMods;
import mods.modularmachinery.MachineModifier;
import crafttweaker.item.IItemStack;
import mods.zenutils.I18n;

//难度变量
static diffs as string[int] = {
    1:"§9难度: §a§l§n1§a.",
    2:"§9难度: §a§l§n2§a.",
    3:"§9难度: §a§l§n3§a.",
    4:"§9难度: §b§l§n4§b.",
    5:"§9难度: §b§l§n5§b.",
    6:"§9难度: §5§l§n6§5.",
    7:"§9难度: §5§l§n7§5.",
    8:"§9难度: §5§l§n8§5.",
    9:"§9难度: §6§l§n9§6.",
    10:"§9难度: §6§l§n10§6.",
    11:"§9难度: §c§l§n11§c.",
    12:"§9难度: §c§l§n12§c.",
    13:"§9难度: §4§l§n13§c.",
    14:"§9难度: §4§l§n14§c.",
};

<advancedrocketry:hotturf>.addTooltip("§3注意，鉴于玩家无法前往火星，应有其他办法主动合成该物品");

<contenttweaker:overworld_block>.addTooltip("§1{无梯阶星球}");
<contenttweaker:overworld_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:overworld_block>.addTooltip("§5唯一之星");
<contenttweaker:overworld_block>.addTooltip("§7§o万千造化的起源，人类文明的摇篮。");
<contenttweaker:overworld_block>.addTooltip("§7呼喊吧。");

<contenttweaker:neb_block>.addTooltip("§1{无梯阶星球}");
<contenttweaker:neb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:neb_block>.addTooltip("§5地狱之星");
<contenttweaker:neb_block>.addTooltip("§4§o永恒燃烧，永久暴虐。");
<contenttweaker:neb_block>.addTooltip("§4堕落吧。");

<contenttweaker:edb_block>.addTooltip("§1{无梯阶星球}");
<contenttweaker:edb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:edb_block>.addTooltip("§5末影之星");
<contenttweaker:edb_block>.addTooltip("§5§o终末的创造，无限广远的梦境。");
<contenttweaker:edb_block>.addTooltip("§5结束吧。");

<contenttweaker:moonb_block>.addTooltip("§3{第零梯阶星球}");
<contenttweaker:moonb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:moonb_block>.addTooltip("§5冕月之星");
<contenttweaker:moonb_block>.addTooltip("§7§o与我等最接近的星辰，古老的起源。");
<contenttweaker:moonb_block>.addTooltip("§7呐喊吧。");

<contenttweaker:meb_block>.addTooltip("§3{第壹梯阶星球}");
<contenttweaker:meb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:meb_block>.addTooltip("§5辰耀之星");
<contenttweaker:meb_block>.addTooltip("§7§o直面毁灭的英雄，不朽的故事从中完著。");
<contenttweaker:meb_block>.addTooltip("§7前进吧。");

<contenttweaker:mab_block>.addTooltip("§3{第贰梯阶星球}");
<contenttweaker:mab_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:mab_block>.addTooltip("§5烨明之星");
<contenttweaker:mab_block>.addTooltip("§c§o于烈焰中参悟，于痛苦中站立。");
<contenttweaker:mab_block>.addTooltip("§7挺身吧。");

<contenttweaker:veb_block>.addTooltip("§3{第叁梯阶星球}");
<contenttweaker:veb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:veb_block>.addTooltip("§5刚殷之星");
<contenttweaker:veb_block>.addTooltip("§e§o将力量化为爱抚，使美与之共生。");
<contenttweaker:veb_block>.addTooltip("§7觉悟吧。");

<contenttweaker:plb_block>.addTooltip("§3{第肆梯阶星球}");
<contenttweaker:plb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:plb_block>.addTooltip("§5命煜之星");
<contenttweaker:plb_block>.addTooltip("§8§o抗争死亡，虚视辉煌。");
<contenttweaker:plb_block>.addTooltip("§7坚持吧。");

<contenttweaker:ceb_block>.addTooltip("§5{第伍梯阶星球}");
<contenttweaker:ceb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:ceb_block>.addTooltip("§5唯褔之星");
<contenttweaker:ceb_block>.addTooltip("§3§o将希望尽数盛装，我将再次启航。");
<contenttweaker:ceb_block>.addTooltip("§7追求吧。");

<contenttweaker:mmb_block>.addTooltip("§5{第陆梯阶星球}");
<contenttweaker:mmb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:mmb_block>.addTooltip("§5亢辉之星");
<contenttweaker:mmb_block>.addTooltip("§6§o于变革中不变，于已有中造就。");
<contenttweaker:mmb_block>.addTooltip("§7升华吧。");

<contenttweaker:hab_block>.addTooltip("§5{第柒梯阶星球}");
<contenttweaker:hab_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:hab_block>.addTooltip("§5堰秉之星");
<contenttweaker:hab_block>.addTooltip("§5§o抬手间，我已目睹无穷未来。");
<contenttweaker:hab_block>.addTooltip("§7招手吧。");

<contenttweaker:npb_block>.addTooltip("§5{第捌梯阶星球}");
<contenttweaker:npb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:npb_block>.addTooltip("§2绿化之星");
<contenttweaker:npb_block>.addTooltip("§2§o顺便一提，保护环境，人人有责捏（）");
<contenttweaker:npb_block>.addTooltip("§7听话吧。");

<contenttweaker:anb_block>.addTooltip("§6{第玖梯阶星球}");
<contenttweaker:anb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:anb_block>.addTooltip("§5死神之星");
<contenttweaker:anb_block>.addTooltip("§8§o注视着这颗荒凉的星球，你有了超越死亡的力量。");
<contenttweaker:anb_block>.addTooltip("§7直面吧。");

<contenttweaker:mhb_block>.addTooltip("§6{第玖梯阶星球}");
<contenttweaker:mhb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:mhb_block>.addTooltip("§5繁曳之星");
<contenttweaker:mhb_block>.addTooltip("§3§o超乎奇迹，超乎色彩。");
<contenttweaker:mhb_block>.addTooltip("§7挽救吧。");

<contenttweaker:hob_block>.addTooltip("§6{第玖梯阶星球}");
<contenttweaker:hob_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:hob_block>.addTooltip("§5极撼之星");
<contenttweaker:hob_block>.addTooltip("§5§o哪怕是...压倒性的命运，我也已经做出颠覆。");
<contenttweaker:hob_block>.addTooltip("§7肩负吧。");

<contenttweaker:seb_block>.addTooltip("§6{第玖梯阶星球}");
<contenttweaker:seb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:seb_block>.addTooltip("§5极寒之星");
<contenttweaker:seb_block>.addTooltip("§b§o冰封星辰，冰封希望。");
<contenttweaker:seb_block>.addTooltip("§7永灭吧。");

<contenttweaker:ddb_block>.addTooltip("§4{第拾梯阶星球}");
<contenttweaker:ddb_block>.addTooltip("§e—— —— —— —— —— —— —— —— —— —— —— —— —— —— —— —— ——");
<contenttweaker:ddb_block>.addTooltip("§0极暗之星");
<contenttweaker:ddb_block>.addTooltip("§5§o蔑视命运，蔑视过往，跨越明日，跨越一切");
<contenttweaker:ddb_block>.addTooltip("§7再一次。");

function tooltipRecipe(machine as string,level as int,difficulty as int,factory as bool = true,two as bool = false,twolevel as int = 1,twodiffculty as int = 0) as void{
    if (utils.isClient()){
        if (two && !factory){
            val item as IItemStack = <item:modularmachinery:${machine}_controller>;
            item.addTooltip(utils.getText("new.ctrl.tooltip.info"));
            item.addTooltip(utils.getDifficulty(level,difficulty));
            var tooltipRegister = 0;
            while (I18n.hasKey("new." + machine + ".tooltip" + tooltipRegister)){
                item.addTooltip(I18n.format("new." + machine + ".tooltip" + tooltipRegister));
                tooltipRegister += 1;
            }
            item.addTooltip(utils.getText("new.ctrl.tooltip.help"));
            item.addTooltip(utils.getText("new.ctrl.tooltip.base"));
            item.addTooltip(utils.getText("new.ctrl.tooltip.structure"));
            item.addTooltip(utils.getText("new.ctrl.tooltip.assembly",[<minecraft:stick>.displayName,<novaeng_core:machine_assembly_tool>.displayName]));

            tooltipRecipe(machine,twolevel,twodiffculty);
            MachineModifier.setMachinePrefix(machine, utils.getDifficulty(level,difficulty));
            return;
        } else {
            var name as string = machine;
            if (factory){name = machine + "_factory";}
            val item as IItemStack = <item:modularmachinery:${name}_controller>;
            item.addTooltip(utils.getText("new.ctrl.tooltip.info"));
            item.addTooltip(utils.getDifficulty(level,difficulty));
            var tooltipRegister = 0;
            while (I18n.hasKey("new." + machine + ".tooltip" + tooltipRegister)){
                item.addTooltip(I18n.format("new." + machine + ".tooltip" + tooltipRegister));
                tooltipRegister += 1;
            }
            item.addTooltip(utils.getText("new.ctrl.tooltip.help"));
            if (factory) {
                item.addTooltip(utils.getText("new.ctrl.tooltip.factory"));
            } else {
                item.addTooltip(utils.getText("new.ctrl.tooltip.base"));
            }
            item.addTooltip(utils.getText("new.ctrl.tooltip.structure"));
            item.addTooltip(utils.getText("new.ctrl.tooltip.assembly",[<minecraft:stick>.displayName,<novaeng_core:machine_assembly_tool>.displayName]));
        }

        MachineModifier.setMachinePrefix(machine, utils.getDifficulty(level,difficulty));
    }
}

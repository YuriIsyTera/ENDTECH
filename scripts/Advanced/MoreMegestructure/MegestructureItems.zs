#priority 10000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;
import mods.contenttweaker.Block;
import mods.contenttweaker.CreativeTab;

function regItem(name as string) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.register();
}

function regItemWithStackSize(name as string, maxStackSize as int) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.maxStackSize = maxStackSize;
    item.register();
}

function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}

//§5新星合金
regItem("nova_ingot");
//§b太空电梯§f蓝图
regItem("SE_blueprint");
//§b太空电梯§f核心
regItem("SE_core");
//§f矿物
regItem("mineral");
//§f异星天然气
regItem("exoticgases");
//§5虚境§8刺针§f
regItem("shroud_needle");
//§5虚境§e观测站§f蓝图
regItem("SN_blueprint");
//§5虚境§e观测站§f核心
regItem("SN_core");
//§5虚境星球§e观测数据§f
regItem("shroudplanet");
//§5虚境§e区块§f
regItem("shroudchunk");
//§3超立方体§f
regItem("hyperspacecube");
//§d奥术§b装配线§f蓝图
regItem("AAL_blueprint");
//§d奥术§b装配线§f核心
regItem("AAL_core");
//§1超维度等离子锻炉§f蓝图
regItem("DTPF_blueprint");
//§1超维度等离子锻炉§f核心
regItem("DTPF_core");
//§1超维度§9激光蚀刻§e矩阵§f蓝图
regItem("DFEA_blueprint");
//§1超维度§9激光蚀刻§e矩阵§f核心
regItem("DFEA_core");
//§b超时空§3装配线§f蓝图
regItem("TAL_blueprint");
//§b超时空§3装配线§f核心
regItem("TAL_core");
//§d灵能§e虹吸§c矩阵§f蓝图
regItem("PSM_blueprint");
//§d灵能§e虹吸§c矩阵§f核心
regItem("PSM_core");
//§8时空§1奇点§e稳定器§f蓝图
regItem("timespacesingularity_blueprint");
//§8时空§1奇点§e稳定器§f核心
regItem("timespacesingularity_core");
//§7熵能§5奇点§e演算阵列§f蓝图
regItem("cosmiccasket_blueprint");
//§7熵能§5奇点§e演算阵列§f核心
regItem("cosmiccasket_core");
//§5救赎者§b空间站-§9III级§e深空巨构装配体§f蓝图
regItem("level_iii_spacestation_blueprint");
//§5救赎者§b空间站-§9III级§e深空巨构装配体§f核心
regItem("level_iii_spacestation_core");
//§9HYPERDIMENSION§b集成系统芯片§f
regItem("hyperdimensional_soc");
//§dARCANCE§b集成系统芯片§f
regItem("arcance_soc");
//§9寰宇§f数据
regItem("cosmic_data");
//§9超维度§b计算机§f
regItem("hyperdimensional_computer");
//§5虚境区块§e演算阵列§f
regItem("phantom_calculation_array");
//§d奥术合金§f
regItem("arcance_ingot");
//§§8时空锭§f
regItem("timespace_ingot");
//§9超维度§b透镜§f
regItem("hyperdimensional_lens");
//§d奥术§b透镜§f
regItem("arcance_lens");
//§1超维度§f蓝图§b基质§f
regItem("hyperdimensional_blueprint");
//§3超空间§f蓝图§b基质§f
regItem("overreachedspace_blueprint");
//§0负相物质§f
regItem("negativephase_matter");
//§f合金
regItem("alloy");
//§7熵能§5奇点§f
regItem("space_array");
//§1星阵§f
regItem("entropy_singularity");
//§f编程电路
regItem("advanced_programming_circuit_0");
regItem("advanced_programming_circuit_a");
regItem("advanced_programming_circuit_b");
regItem("advanced_programming_circuit_c");
regItem("advanced_programming_circuit_d");
regItem("advanced_programming_circuit_e");
regItem("advanced_programming_circuit_f");
//§9超光速驱动返回单元§f
regItem("hyperlightspeedplatform");
//§9光速超频矩阵§f
regItem("lightspeed_overclock_array");
//§8硅岩合金§f
regItem("nq_alloy");
//§3量子合金§f
regItem("quantum_ingot");

//§5新星力场控制矩阵§f
val NM as Block = VanillaFactory.createBlock("novamatrix",<blockmaterial:iron>);
NM.fullBlock = true;
NM.setLightOpacity(255);
NM.setLightValue(50);
NM.setBlockHardness(15.0);
NM.setBlockResistance(400.0);
NM.setToolClass("pickaxe");
NM.setToolLevel(4);
NM.setBlockSoundType(<soundtype:metal>);
NM.register();
//§8时空线圈§f
val TSC as Block = VanillaFactory.createBlock("timespace_coil_block",<blockmaterial:iron>);
TSC.fullBlock = true;
TSC.setLightOpacity(255);
TSC.setLightValue(50);
TSC.setBlockHardness(15.0);
TSC.setBlockResistance(400.0);
TSC.setToolClass("pickaxe");
TSC.setToolLevel(4);
TSC.setBlockSoundType(<soundtype:metal>);
TSC.register();
//§7γ-§8TiAl线圈§f
val GTC as Block = VanillaFactory.createBlock("gama_tial_coil_block",<blockmaterial:iron>);
GTC.fullBlock = true;
GTC.setLightOpacity(255);
GTC.setLightValue(50);
GTC.setBlockHardness(15.0);
GTC.setBlockResistance(400.0);
GTC.setToolClass("pickaxe");
GTC.setToolLevel(4);
GTC.setBlockSoundType(<soundtype:metal>);
GTC.register();
//§3永恒线圈§f
val EC as Block = VanillaFactory.createBlock("eternity_coil_block",<blockmaterial:iron>);
EC.fullBlock = true;
EC.setLightOpacity(255);
EC.setLightValue(50);
EC.setBlockHardness(15.0);
EC.setBlockResistance(400.0);
EC.setToolClass("pickaxe");
EC.setToolLevel(4);
EC.setBlockSoundType(<soundtype:metal>);
EC.register();
//§d奥术§5机械外壳§f
val AMC as Block = VanillaFactory.createBlock("arcancemachineblock",<blockmaterial:iron>);
AMC.fullBlock = true;
AMC.setLightOpacity(255);
AMC.setLightValue(50);
AMC.setBlockHardness(15.0);
AMC.setBlockResistance(400.0);
AMC.setToolClass("pickaxe");
AMC.setToolLevel(4);
AMC.setBlockSoundType(<soundtype:metal>);
AMC.register();
//§d奥术力场控制矩阵§f
val AM as Block = VanillaFactory.createBlock("arcancemartrix",<blockmaterial:iron>);
AM.fullBlock = true;
AM.setLightOpacity(255);
AM.setLightValue(50);
AM.setBlockHardness(15.0);
AM.setBlockResistance(400.0);
AM.setToolClass("pickaxe");
AM.setToolLevel(5);
AM.setBlockSoundType(<soundtype:metal>);
AM.register();
//§b太空电梯动力模块§f
val SEPM as Block = VanillaFactory.createBlock("space_elevator_power_module",<blockmaterial:iron>);
SEPM.fullBlock = true;
SEPM.setLightOpacity(255);
SEPM.setLightValue(50);
SEPM.setBlockHardness(15.0);
SEPM.setBlockResistance(400.0);
SEPM.setToolClass("pickaxe");
SEPM.setToolLevel(5);
SEPM.setBlockSoundType(<soundtype:metal>);
SEPM.register();
//§b太空电梯支撑结构§f
val SES as Block = VanillaFactory.createBlock("space_elevator_structure",<blockmaterial:iron>);
SES.fullBlock = true;
SES.setLightOpacity(255);
SES.setLightValue(50);
SES.setBlockHardness(15.0);
SES.setBlockResistance(400.0);
SES.setToolClass("pickaxe");
SES.setToolLevel(5);
SES.setBlockSoundType(<soundtype:metal>);
SES.register();
//§z无尽框架§f
val INFF as Block = VanillaFactory.createBlock("infinity_frame", <blockmaterial:iron>);
INFF.fullBlock = false;
INFF.blockLayer="CUTOUT";
INFF.setLightOpacity(0);
INFF.translucent = true;
INFF.setLightValue(0);
INFF.setBlockHardness(7.5);
INFF.setBlockResistance(100.0);
INFF.setToolClass("pickaxe");
INFF.setToolLevel(3);
INFF.setBlockSoundType(<soundtype:metal>);
INFF.register();
//§b太空电梯模块链接器§f
val SEC as Block = VanillaFactory.createBlock("space_elevator_connector", <blockmaterial:iron>);
SEC.fullBlock = true;
SEC.setLightOpacity(255);
SEC.setLightValue(50);
SEC.setBlockHardness(15.0);
SEC.setBlockResistance(400.0);
SEC.setToolClass("pickaxe");
SEC.setToolLevel(5);
SEC.setBlockSoundType(<soundtype:metal>);
SEC.register();
//§5§l奥术§8§l时空§9§l膨胀§b§l发生器§f
val ASEG as Block = VanillaFactory.createBlock("arcane_spacetime_expansion_generator", <blockmaterial:iron>);
ASEG.fullBlock = true;
ASEG.setLightOpacity(255);
ASEG.setLightValue(50);
ASEG.setBlockHardness(15.0);
ASEG.setBlockResistance(400.0);
ASEG.setToolClass("pickaxe");
ASEG.setToolLevel(5);
ASEG.setBlockSoundType(<soundtype:metal>);
ASEG.register();
//RTG3521玩偶
val RTG3521FUMO as Block = VanillaFactory.createBlock("rtg3521fumo",<blockmaterial:iron>);
RTG3521FUMO.fullBlock = false;
RTG3521FUMO.setLightOpacity(255);
RTG3521FUMO.translucent = false;
RTG3521FUMO.blockLayer = "CUTOUT";
RTG3521FUMO.setLightValue(0);
RTG3521FUMO.setBlockHardness(7.5);
RTG3521FUMO.setBlockResistance(100.0);
RTG3521FUMO.setToolClass("pickaxe");
RTG3521FUMO.setToolLevel(0);
RTG3521FUMO.setBlockSoundType(<soundtype:cloth>);
RTG3521FUMO.register();
//BaiTang233玩偶
val BAITANG233FUMO as Block = VanillaFactory.createBlock("baitang233fumo",<blockmaterial:iron>);
BAITANG233FUMO.fullBlock = false;
BAITANG233FUMO.setLightOpacity(255);
BAITANG233FUMO.translucent = false;
BAITANG233FUMO.blockLayer = "CUTOUT";
BAITANG233FUMO.setLightValue(0);
BAITANG233FUMO.setBlockHardness(7.5);
BAITANG233FUMO.setBlockResistance(100.0);
BAITANG233FUMO.setToolClass("pickaxe");
BAITANG233FUMO.setToolLevel(0);
BAITANG233FUMO.setBlockSoundType(<soundtype:cloth>);
BAITANG233FUMO.register();
//yunyouair玩偶
val YUNYOUAIRfumo as Block = VanillaFactory.createBlock("yunyouairfumo",<blockmaterial:iron>);
YUNYOUAIRfumo.fullBlock = false;
YUNYOUAIRfumo.setLightOpacity(255);
YUNYOUAIRfumo.translucent = false;
YUNYOUAIRfumo.blockLayer = "CUTOUT";
YUNYOUAIRfumo.setLightValue(0);
YUNYOUAIRfumo.setBlockHardness(7.5);
YUNYOUAIRfumo.setBlockResistance(100.0);
YUNYOUAIRfumo.setToolClass("pickaxe");
YUNYOUAIRfumo.setToolLevel(0);
YUNYOUAIRfumo.setBlockSoundType(<soundtype:cloth>);
YUNYOUAIRfumo.register();
//§1维度§9注入§7结构§f
val HSS as Block = VanillaFactory.createBlock("hyper_stablestructure", <blockmaterial:iron>);
HSS.fullBlock = true;
HSS.setLightOpacity(255);
HSS.setLightValue(50);
HSS.setBlockHardness(15.0);
HSS.setBlockResistance(400.0);
HSS.setToolClass("pickaxe");
HSS.setToolLevel(5);
HSS.setBlockSoundType(<soundtype:metal>);
HSS.register();
//§3超空间§9机械外壳§f
val DTC as Block = VanillaFactory.createBlock("dimensionally_transcendent_casing", <blockmaterial:iron>);
DTC.fullBlock = true;
DTC.setLightOpacity(255);
DTC.setLightValue(50);
DTC.setBlockHardness(15.0);
DTC.setBlockResistance(400.0);
DTC.setToolClass("pickaxe");
DTC.setToolLevel(5);
DTC.setBlockSoundType(<soundtype:metal>);
DTC.register();
//§3高强度§7抗撕裂§9机械方块§f
val HSMB as Block = VanillaFactory.createBlock("hyper_strenth_machine_block", <blockmaterial:iron>);
HSMB.fullBlock = true;
HSMB.setLightOpacity(255);
HSMB.setLightValue(50);
HSMB.setBlockHardness(15.0);
HSMB.setBlockResistance(400.0);
HSMB.setToolClass("pickaxe");
HSMB.setToolLevel(5);
HSMB.setBlockSoundType(<soundtype:metal>);
HSMB.register();
//§8硅岩合金框架§f
val NQF_FRAME as Block = VanillaFactory.createBlock("nqalloy_frame", <blockmaterial:iron>);
NQF_FRAME.fullBlock = false;
NQF_FRAME.blockLayer="CUTOUT";
NQF_FRAME.setLightOpacity(0);
NQF_FRAME.translucent = true;
NQF_FRAME.setLightValue(0);
NQF_FRAME.setBlockHardness(7.5);
NQF_FRAME.setBlockResistance(100.0);
NQF_FRAME.setToolClass("pickaxe");
NQF_FRAME.setToolLevel(3);
NQF_FRAME.setBlockSoundType(<soundtype:metal>);
NQF_FRAME.register();
//§d奥术合金框架§f
val AF_FRAME as Block = VanillaFactory.createBlock("arcance_frame", <blockmaterial:iron>);
AF_FRAME.fullBlock = false;
AF_FRAME.blockLayer="CUTOUT";
AF_FRAME.setLightOpacity(0);
AF_FRAME.translucent = true;
AF_FRAME.setLightValue(0);
AF_FRAME.setBlockHardness(7.5);
AF_FRAME.setBlockResistance(100.0);
AF_FRAME.setToolClass("pickaxe");
AF_FRAME.setToolLevel(3);
AF_FRAME.setBlockSoundType(<soundtype:metal>);
AF_FRAME.register();
//§b方舟框架§f
val ARF_FRAME as Block = VanillaFactory.createBlock("ark_frame", <blockmaterial:iron>);
ARF_FRAME.fullBlock = false;
ARF_FRAME.blockLayer="CUTOUT";
ARF_FRAME.setLightOpacity(0);
ARF_FRAME.translucent = true;
ARF_FRAME.setLightValue(0);
ARF_FRAME.setBlockHardness(7.5);
ARF_FRAME.setBlockResistance(100.0);
ARF_FRAME.setToolClass("pickaxe");
ARF_FRAME.setToolLevel(3);
ARF_FRAME.setBlockSoundType(<soundtype:metal>);
ARF_FRAME.register();
//§d奥利哈钢框架§f
val OCF_FRAME as Block = VanillaFactory.createBlock("orichalcos_frame", <blockmaterial:iron>);
OCF_FRAME.fullBlock = false;
OCF_FRAME.blockLayer="CUTOUT";
OCF_FRAME.setLightOpacity(0);
OCF_FRAME.translucent = true;
OCF_FRAME.setLightValue(0);
OCF_FRAME.setBlockHardness(7.5);
OCF_FRAME.setBlockResistance(100.0);
OCF_FRAME.setToolClass("pickaxe");
OCF_FRAME.setToolLevel(3);
OCF_FRAME.setBlockSoundType(<soundtype:metal>);
OCF_FRAME.register();
//§z无尽玻璃§f
val INFG as Block = VanillaFactory.createBlock("infinity_glass", <blockmaterial:iron>);
INFG.fullBlock = false;
INFG.blockLayer="TRANSLUCENT";
INFG.setLightOpacity(0);
INFG.translucent = true;
INFG.setLightValue(0);
INFG.setBlockHardness(7.5);
INFG.setBlockResistance(100.0);
INFG.setToolClass("pickaxe");
INFG.setToolLevel(4);
INFG.setBlockSoundType(<soundtype:glass>);
INFG.register();
//§9量子玻璃§f
val QTG as Block = VanillaFactory.createBlock("quantumgroup_glass", <blockmaterial:iron>);
QTG.fullBlock = false;
QTG.blockLayer="TRANSLUCENT";
QTG.setLightOpacity(0);
QTG.translucent = true;
QTG.setLightValue(0);
QTG.setBlockHardness(7.5);
QTG.setBlockResistance(100.0);
QTG.setToolClass("pickaxe");
QTG.setToolLevel(4);
QTG.setBlockSoundType(<soundtype:glass>);
QTG.register();
//§9量子§7机械方块§f
val MANIPULATOR_ENTROPY as Block = VanillaFactory.createBlock("manipulator", <blockmaterial:iron>);
MANIPULATOR_ENTROPY.fullBlock = true;
MANIPULATOR_ENTROPY.setLightOpacity(255);
MANIPULATOR_ENTROPY.setLightValue(50);
MANIPULATOR_ENTROPY.setBlockHardness(15.0);
MANIPULATOR_ENTROPY.setBlockResistance(400.0);
MANIPULATOR_ENTROPY.setToolClass("pickaxe");
MANIPULATOR_ENTROPY.setToolLevel(5);
MANIPULATOR_ENTROPY.setBlockSoundType(<soundtype:metal>);
MANIPULATOR_ENTROPY.register();
//§3次元§9桥接方块§f
val DBC as Block = VanillaFactory.createBlock("dimensional_bridge_casing", <blockmaterial:iron>);
DBC.fullBlock = true;
DBC.setLightOpacity(255);
DBC.setLightValue(50);
DBC.setBlockHardness(15.0);
DBC.setBlockResistance(400.0);
DBC.setToolClass("pickaxe");
DBC.setToolLevel(5);
DBC.setBlockSoundType(<soundtype:metal>);
DBC.register();
//§1维度§9激发§b线圈§f
val DSC as Block = VanillaFactory.createBlock("dimensionally_coil", <blockmaterial:iron>);
DSC.fullBlock = true;
DSC.setLightOpacity(255);
DSC.setLightValue(50);
DSC.setBlockHardness(15.0);
DSC.setBlockResistance(400.0);
DSC.setToolClass("pickaxe");
DSC.setToolLevel(5);
DSC.setBlockSoundType(<soundtype:metal>);
DSC.register();
//§3超空间§9高能§7结构§f
val HYPERS as Block = VanillaFactory.createBlock("hyperspace_structure", <blockmaterial:iron>);
HYPERS.fullBlock = true;
HYPERS.setLightOpacity(255);
HYPERS.setLightValue(50);
HYPERS.setBlockHardness(15.0);
HYPERS.setBlockResistance(400.0);
HYPERS.setToolClass("pickaxe");
HYPERS.setToolLevel(5);
HYPERS.setBlockSoundType(<soundtype:metal>);
HYPERS.register();
//NewMaa玩偶
val NEWMAAfumo as Block = VanillaFactory.createBlock("newmaafumo",<blockmaterial:iron>);
NEWMAAfumo.fullBlock = false;
NEWMAAfumo.setLightOpacity(255);
NEWMAAfumo.translucent = false;
NEWMAAfumo.blockLayer = "CUTOUT";
NEWMAAfumo.setLightValue(0);
NEWMAAfumo.setBlockHardness(7.5);
NEWMAAfumo.setBlockResistance(100.0);
NEWMAAfumo.setToolClass("pickaxe");
NEWMAAfumo.setToolLevel(0);
NEWMAAfumo.setBlockSoundType(<soundtype:cloth>);
NEWMAAfumo.register();
//MCdyc玩偶
val MCDYCFUMO as Block = VanillaFactory.createBlock("mcdycfumo",<blockmaterial:iron>);
MCDYCFUMO.fullBlock = false;
MCDYCFUMO.setLightOpacity(255);
MCDYCFUMO.translucent = false;
MCDYCFUMO.blockLayer = "CUTOUT";
MCDYCFUMO.setLightValue(0);
MCDYCFUMO.setBlockHardness(7.5);
MCDYCFUMO.setBlockResistance(100.0);
MCDYCFUMO.setToolClass("pickaxe");
MCDYCFUMO.setToolLevel(0);
MCDYCFUMO.setBlockSoundType(<soundtype:cloth>);
MCDYCFUMO.register();
//§3量子框架§f
val QT_FRAME as Block = VanillaFactory.createBlock("quantum_frame", <blockmaterial:iron>);
QT_FRAME.fullBlock = false;
QT_FRAME.blockLayer="CUTOUT";
QT_FRAME.setLightOpacity(0);
QT_FRAME.translucent = true;
QT_FRAME.setLightValue(0);
QT_FRAME.setBlockHardness(7.5);
QT_FRAME.setBlockResistance(100.0);
QT_FRAME.setToolClass("pickaxe");
QT_FRAME.setToolLevel(3);
QT_FRAME.setBlockSoundType(<soundtype:metal>);
QT_FRAME.register();
//硅岩粉
regItem("nq_powder");
#priority 2000

#loader contenttweaker

import mods.contenttweaker.Block;
import mods.contenttweaker.CreativeTab;
import mods.contenttweaker.VanillaFactory;


//恒星机械外壳
val SMB as Block = VanillaFactory.createBlock("starmachineblock", <blockmaterial:iron>);
SMB.fullBlock = true;
SMB.setLightOpacity(255);
SMB.setLightValue(0);
SMB.setBlockHardness(15.0);
SMB.setBlockResistance(400.0);
SMB.setToolClass("pickaxe");
SMB.setToolLevel(4);
SMB.setBlockSoundType(<soundtype:metal>);
SMB.register();

//测试方块
val testx as Block =VanillaFactory.createBlock("testx",<blockmaterial:glass>);
testx.fullBlock = false;
testx.blockLayer = "TRANSLUCENT";
testx.setLightOpacity(0);
testx.setLightValue(0);
testx.translucent = true;
testx.setBlockHardness(0.0);
testx.setBlockResistance(20.0);
testx.setToolClass("pickaxe");
testx.setToolLevel(1);
testx.setBlockSoundType(<soundtype:glass>);
testx.register();

//抗紊乱空间框架
val ASB as Block = VanillaFactory.createBlock("asteroidcontrolblock",<blockmaterial:iron>);
ASB.fullBlock = true;
ASB.setLightOpacity(255);
ASB.setLightValue(50);
ASB.setBlockHardness(15.0);
ASB.setBlockResistance(400.0);
ASB.setToolClass("pickaxe");
ASB.setToolLevel(4);
ASB.setBlockSoundType(<soundtype:metal>);
ASB.register();

//蓝色注能结构玻璃
val SBG as Block = VanillaFactory.createBlock("superglassbluex", <blockmaterial:glass>);
SBG.fullBlock = false;
SBG.blockLayer = "TRANSLUCENT";
SBG.setLightOpacity(0);
SBG.setLightValue(0);
SBG.translucent = true;
SBG.setBlockHardness(0.0);
SBG.setBlockResistance(20.0);
SBG.setToolClass("pickaxe");
SBG.setToolLevel(1);
SBG.setBlockSoundType(<soundtype:glass>);
SBG.register();

//红色注能结构玻璃
val SRG as Block = VanillaFactory.createBlock("superglassred", <blockmaterial:glass>);
SRG.fullBlock = false;
SRG.blockLayer = "TRANSLUCENT";
SRG.setLightOpacity(0);
SRG.setLightValue(128);
SRG.translucent = true;
SRG.setBlockHardness(0.0);
SRG.setBlockResistance(20.0);
SRG.setToolClass("pickaxe");
SRG.setToolLevel(1);
SRG.setBlockSoundType(<soundtype:glass>);
SRG.register();

//黄色注能结构玻璃
val SYG as Block = VanillaFactory.createBlock("superglassyellow", <blockmaterial:glass>);
SYG.fullBlock = false;
SYG.blockLayer = "TRANSLUCENT";
SYG.setLightOpacity(0);
SYG.setLightValue(0);
SYG.translucent = true;
SYG.setBlockHardness(0.0);
SYG.setBlockResistance(20.0);
SYG.setToolClass("pickaxe");
SYG.setToolLevel(1);
SYG.setBlockSoundType(<soundtype:glass>);
SYG.register();


//绿色注能结构玻璃
val SGG as Block = VanillaFactory.createBlock("superglassgreen", <blockmaterial:glass>);
SGG.fullBlock = false;
SGG.blockLayer = "TRANSLUCENT";
SGG.setLightOpacity(0);
SGG.setLightValue(0);
SGG.translucent = true;
SGG.setBlockHardness(0.0);
SGG.setBlockResistance(20.0);
SGG.setToolClass("pickaxe");
SGG.setToolLevel(1);
SGG.setBlockSoundType(<soundtype:glass>);
SGG.register();

//青色注能结构玻璃
val SCG as Block = VanillaFactory.createBlock("superglasscyan", <blockmaterial:glass>);
SCG.fullBlock = false;
SCG.blockLayer = "TRANSLUCENT";
SCG.setLightOpacity(0);
SCG.setLightValue(0);
SCG.translucent = true;
SCG.setBlockHardness(0.0);
SCG.setBlockResistance(20.0);
SCG.setToolClass("pickaxe");
SCG.setToolLevel(1);
SCG.setBlockSoundType(<soundtype:glass>);
SCG.register();

//紫色注能结构玻璃
val SPG as Block = VanillaFactory.createBlock("superglasspurple", <blockmaterial:glass>);
SPG.fullBlock = false;
SPG.blockLayer = "TRANSLUCENT";
SPG.setLightOpacity(0);
SPG.setLightValue(0);
SPG.translucent = true;
SPG.setBlockHardness(0.0);
SPG.setBlockResistance(20.0);
SPG.setToolClass("pickaxe");
SPG.setToolLevel(1);
SPG.setBlockSoundType(<soundtype:glass>);
SPG.register();

//白色注能结构玻璃
val SWG as Block = VanillaFactory.createBlock("superglasswhite", <blockmaterial:glass>);
SWG.fullBlock = false;
SWG.blockLayer = "TRANSLUCENT";
SWG.setLightOpacity(0);
SWG.setLightValue(0);
SWG.translucent = true;
SWG.setBlockHardness(0.0);
SWG.setBlockResistance(20.0);
SWG.setToolClass("pickaxe");
SWG.setToolLevel(1);
SWG.setBlockSoundType(<soundtype:glass>);
SWG.register();

//橙色注能结构玻璃
val SOG as Block = VanillaFactory.createBlock("superglassorange", <blockmaterial:glass>);
SOG.fullBlock = false;
SOG.blockLayer = "TRANSLUCENT";
SOG.setLightOpacity(0);
SOG.setLightValue(0);
SOG.translucent = true;
SOG.setBlockHardness(0.0);
SOG.setBlockResistance(20.0);
SOG.setToolClass("pickaxe");
SOG.setToolLevel(1);
SOG.setBlockSoundType(<soundtype:glass>);
SOG.register();

//暗物质表征框架
val DMS as Block = VanillaFactory.createBlock("darkmatterblock",<blockmaterial:iron>);
DMS.fullBlock = true;
DMS.setLightOpacity(255);
DMS.translucent = true;
DMS.setLightValue(0);
DMS.setBlockHardness(7.5);
DMS.setBlockResistance(100.0);
DMS.setToolClass("pickaxe");
DMS.setToolLevel(3);
DMS.setBlockSoundType(<soundtype:metal>);
DMS.register();

//空间稳定工程块
val SEB as Block = VanillaFactory.createBlock("space_engblock",<blockmaterial:iron>);
SEB.fullBlock = true;
SEB.setLightOpacity(255);
SEB.translucent = true;
SEB.setLightValue(0);
SEB.setBlockHardness(7.5);
SEB.setBlockResistance(100.0);
SEB.setToolClass("pickaxe");
SEB.setToolLevel(3);
SEB.setBlockSoundType(<soundtype:metal>);
SEB.register();

//维度扭曲结构
val DSB as Block = VanillaFactory.createBlock("dimensiontwistblock",<blockmaterial:iron>);
DSB.fullBlock = true;
DSB.setLightOpacity(255);
DSB.translucent = true;
DSB.setLightValue(0);
DSB.setBlockHardness(7.5);
DSB.setBlockResistance(100.0);
DSB.setToolClass("pickaxe");
DSB.setToolLevel(3);
DSB.setBlockSoundType(<soundtype:metal>);
DSB.register();

//星门结构玻璃
val BS as Block = VanillaFactory.createBlock("basicglass", <blockmaterial:glass>);
BS.fullBlock = false;
BS.blockLayer = "TRANSLUCENT";
BS.setLightOpacity(0);
BS.setLightValue(128);
BS.translucent = true;
BS.setBlockHardness(0.0);
BS.setBlockResistance(20.0);
BS.setToolClass("pickaxe");
BS.setToolLevel(1);
BS.setBlockSoundType(<soundtype:glass>);
BS.register();
//恒星机械结构框架
val PS as Block = VanillaFactory.createBlock("planetstructure",<blockmaterial:iron>);
PS.fullBlock = true;
PS.setLightOpacity(255);
PS.translucent = true;
PS.setLightValue(0);
PS.setBlockHardness(7.5);
PS.setBlockResistance(100.0);
PS.setToolClass("pickaxe");
PS.setToolLevel(3);
PS.setBlockSoundType(<soundtype:metal>);
PS.register();
//超空间蚀刻结构
val SSPS as Block = VanillaFactory.createBlock("superspacestructure",<blockmaterial:iron>);
SSPS.fullBlock = true;
SSPS.setLightOpacity(255);
SSPS.setLightValue(50);
SSPS.setBlockHardness(15.0);
SSPS.setBlockResistance(400.0);
SSPS.setToolClass("pickaxe");
SSPS.setToolLevel(4);
SSPS.setBlockSoundType(<soundtype:metal>);
SSPS.register();

//通信主机Mk1
val CHM1 as Block = VanillaFactory.createBlock("comhostmk1",<blockmaterial:iron>);
CHM1.fullBlock = true;
CHM1.setLightOpacity(255);
CHM1.translucent = true;
CHM1.setLightValue(0);
CHM1.setBlockHardness(7.5);
CHM1.setBlockResistance(100.0);
CHM1.setToolClass("pickaxe");
CHM1.setToolLevel(3);
CHM1.setBlockSoundType(<soundtype:metal>);
CHM1.register();

//余烬热能矩阵
val DHM as Block = VanillaFactory.createBlock("heatmatrix",<blockmaterial:iron>);
DHM.fullBlock = true;
DHM.setLightOpacity(255);
DHM.setLightValue(50);
DHM.setBlockHardness(15.0);
DHM.setBlockResistance(400.0);
DHM.setToolClass("pickaxe");
DHM.setToolLevel(4);
DHM.setBlockSoundType(<soundtype:metal>);
DHM.register();

//余烬-虚空力场控制矩阵
val DVCM as Block = VanillaFactory.createBlock("dustmatrix",<blockmaterial:iron>);
DVCM.fullBlock = true;
DVCM.setLightOpacity(255);
DVCM.setLightValue(50);
DVCM.setBlockHardness(15.0);
DVCM.setBlockResistance(400.0);
DVCM.setToolClass("pickaxe");
DVCM.setToolLevel(4);
DVCM.setBlockSoundType(<soundtype:metal>);
DVCM.register();

//彩虹核心
val RC as Block = VanillaFactory.createBlock("rainbowcore",<blockmaterial:iron>);
RC.fullBlock = true;
RC.setLightOpacity(255);
RC.setLightValue(50);
RC.setBlockHardness(15.0);
RC.setBlockResistance(400.0);
RC.setToolClass("pickaxe");
RC.setToolLevel(4);
RC.setBlockSoundType(<soundtype:metal>);
RC.register();

//空间高能工程结构
//stablestructure
val SES as Block = VanillaFactory.createBlock("stablestructure",<blockmaterial:iron>);
SES.fullBlock = true;
SES.setLightOpacity(255);
SES.setLightValue(50);
SES.setBlockHardness(15.0);
SES.setBlockResistance(400.0);
SES.setToolClass("pickaxe");
SES.setToolLevel(4);
SES.setBlockSoundType(<soundtype:metal>);
SES.register();

//恒星级超时空反应核心
val SSSC as Block = VanillaFactory.createBlock("superspace_star_controlmatrix",<blockmaterial:iron>);
SSSC.fullBlock = true;
SSSC.setLightOpacity(255);
SSSC.setLightValue(50);
SSSC.setBlockHardness(15.0);
SSSC.setBlockResistance(400.0);
SSSC.setToolClass("pickaxe");
SSSC.setToolLevel(4);
SSSC.setBlockSoundType(<soundtype:metal>);
SSSC.register();

//恒星级虚空量子海腔室
val SVS as Block = VanillaFactory.createBlock("starvoidstructure",<blockmaterial:iron>);
SVS.fullBlock = true;
SVS.setLightOpacity(255);
SVS.setLightValue(50);
SVS.setBlockHardness(15.0);
SVS.setBlockResistance(400.0);
SVS.setToolClass("pickaxe");
SVS.setToolLevel(4);
SVS.setBlockSoundType(<soundtype:metal>);
SVS.register();

//维度矩阵演算机Mk1
val DCD as Block = VanillaFactory.createBlock("caldevice",<blockmaterial:iron>);
DCD.fullBlock = true;
DCD.setLightOpacity(255);
DCD.setLightValue(50);
DCD.setBlockHardness(15.0);
DCD.setBlockResistance(400.0);
DCD.setToolClass("pickaxe");
DCD.setToolLevel(4);
DCD.setBlockSoundType(<soundtype:metal>);
DCD.register();

//星河天穹计算外壳
val MCM as Block = VanillaFactory.createBlock("milkmachineblock", <blockmaterial:iron>);
MCM.fullBlock = true;
MCM.setLightOpacity(255);
MCM.setLightValue(0);
MCM.setBlockHardness(15.0);
MCM.setBlockResistance(400.0);
MCM.setToolClass("pickaxe");
MCM.setToolLevel(4);
MCM.setBlockSoundType(<soundtype:metal>);
MCM.register();

//时间回旋立方体
val TRC as Block = VanillaFactory.createBlock("respacetimeblock",<blockmaterial:iron>);
TRC.fullBlock = true;
TRC.setLightOpacity(255);
TRC.setLightValue(50);
TRC.setBlockHardness(15.0);
TRC.setBlockResistance(400.0);
TRC.setToolClass("pickaxe");
TRC.setToolLevel(4);
TRC.setBlockSoundType(<soundtype:metal>);
TRC.register();

//能量立方Mk1
val ECM1 as Block = VanillaFactory.createBlock("energycube_mk1",<blockmaterial:iron>);
ECM1.fullBlock = true;
ECM1.setLightOpacity(255);
ECM1.setLightValue(50);
ECM1.setBlockHardness(15.0);
ECM1.setBlockResistance(400.0);
ECM1.setToolClass("pickaxe");
ECM1.setToolLevel(4);
ECM1.setBlockSoundType(<soundtype:metal>);
ECM1.register();

//能量立方Mk2
val ECM2 as Block = VanillaFactory.createBlock("energycube_mk2",<blockmaterial:iron>);
ECM2.fullBlock = true;
ECM2.setLightOpacity(255);
ECM2.setLightValue(50);
ECM2.setBlockHardness(15.0);
ECM2.setBlockResistance(400.0);
ECM2.setToolClass("pickaxe");
ECM2.setToolLevel(4);
ECM2.setBlockSoundType(<soundtype:metal>);
ECM2.register();

//能量立方Mk3
val ECM3 as Block = VanillaFactory.createBlock("energycube_mk3",<blockmaterial:iron>);
ECM3.fullBlock = true;
ECM3.setLightOpacity(255);
ECM3.setLightValue(50);
ECM3.setBlockHardness(15.0);
ECM3.setBlockResistance(400.0);
ECM3.setToolClass("pickaxe");
ECM3.setToolLevel(4);
ECM3.setBlockSoundType(<soundtype:metal>);
ECM3.register();

//超冷原子机械方块
val ACB as Block = VanillaFactory.createBlock("atomcoolingblock", <blockmaterial:iron>);
ACB.fullBlock = true;
ACB.setLightOpacity(255);
ACB.setLightValue(0);
ACB.setBlockHardness(15.0);
ACB.setBlockResistance(400.0);
ACB.setToolClass("pickaxe");
ACB.setToolLevel(4);
ACB.setBlockSoundType(<soundtype:metal>);
ACB.register();

//破界者能量聚焦结构
val DCEFU as Block = VanillaFactory.createBlock("dimensioncarver_energyfocusunit", <blockmaterial:iron>);
DCEFU.fullBlock = true;
DCEFU.setLightOpacity(255);
DCEFU.setLightValue(0);
DCEFU.setBlockHardness(15.0);
DCEFU.setBlockResistance(400.0);
DCEFU.setToolClass("pickaxe");
DCEFU.setToolLevel(4);
DCEFU.setBlockSoundType(<soundtype:metal>);
DCEFU.register();

//破界者强态抗撕裂方块
val DCARB as Block = VanillaFactory.createBlock("dimensioncarver_reinforcedblock", <blockmaterial:iron>);
DCARB.fullBlock = true;
DCARB.setLightOpacity(255);
DCARB.setLightValue(0);
DCARB.setBlockHardness(15.0);
DCARB.setBlockResistance(400.0);
DCARB.setToolClass("pickaxe");
DCARB.setToolLevel(4);
DCARB.setBlockSoundType(<soundtype:metal>);
DCARB.register();

//破界者能量力场
val DCEF as Block = VanillaFactory.createBlock("dimensioncarver_energyfield", <blockmaterial:glass>);
DCEF.fullBlock = false;
DCEF.blockLayer = "TRANSLUCENT";
DCEF.setLightOpacity(0);
DCEF.setLightValue(128);
DCEF.translucent = true;
DCEF.setBlockHardness(0.0);
DCEF.setBlockResistance(20.0);
DCEF.setToolClass("pickaxe");
DCEF.setToolLevel(1);
DCEF.setBlockSoundType(<soundtype:glass>);
DCEF.register();

//星河基座机械结构
val SMBX as Block = VanillaFactory.createBlock("spacexmachineblock", <blockmaterial:iron>);
SMBX.fullBlock = true;
SMBX.setLightOpacity(255);
SMBX.setLightValue(0);
SMBX.setBlockHardness(15.0);
SMBX.setBlockResistance(400.0);
SMBX.setToolClass("pickaxe");
SMBX.setToolLevel(4);
SMBX.setBlockSoundType(<soundtype:metal>);
SMBX.register();

//星河能量环流单元 
val SLB as Block = VanillaFactory.createBlock("spacexlightingblock",<blockmaterial:iron>);
SLB.fullBlock = true;
SLB.setLightOpacity(255);
SLB.setLightValue(50);
SLB.setBlockHardness(15.0);
SLB.setBlockResistance(400.0);
SLB.setToolClass("pickaxe");
SLB.setToolLevel(4);
SLB.setBlockSoundType(<soundtype:metal>);
SLB.register();

//通信主机Mk2
val CHM2 as Block = VanillaFactory.createBlock("comhostmk2",<blockmaterial:iron>);
CHM2.fullBlock = true;
CHM2.setLightOpacity(255);
CHM2.translucent = true;
CHM2.setLightValue(0);
CHM2.setBlockHardness(7.5);
CHM2.setBlockResistance(100.0);
CHM2.setToolClass("pickaxe");
CHM2.setToolLevel(3);
CHM2.setBlockSoundType(<soundtype:metal>);
CHM2.register();


//中子态素机械外壳
val NEBX as Block = VanillaFactory.createBlock("neutronismblock", <blockmaterial:iron>);
NEBX.fullBlock = true;
NEBX.setLightOpacity(255);
NEBX.setLightValue(0);
NEBX.setBlockHardness(15.0);
NEBX.setBlockResistance(400.0);
NEBX.setToolClass("pickaxe");
NEBX.setToolLevel(4);
NEBX.setBlockSoundType(<soundtype:metal>);
NEBX.register();

//多模态物质机械方块
val SIB as Block = VanillaFactory.createBlock("superinstanceblock", <blockmaterial:iron>);
SIB.fullBlock = true;
SIB.setLightOpacity(255);
SIB.setLightValue(0);
SIB.setBlockHardness(15.0);
SIB.setBlockResistance(400.0);
SIB.setToolClass("pickaxe");
SIB.setToolLevel(4);
SIB.setBlockSoundType(<soundtype:metal>);
SIB.register();

//魔力聚合机械方块
val SMBXB as Block = VanillaFactory.createBlock("supermanablock", <blockmaterial:iron>);
SMBXB.fullBlock = true;
SMBXB.setLightOpacity(255);
SMBXB.setLightValue(0);
SMBXB.setBlockHardness(15.0);
SMBXB.setBlockResistance(400.0);
SMBXB.setToolClass("pickaxe");
SMBXB.setToolLevel(4);
SMBXB.setBlockSoundType(<soundtype:metal>);
SMBXB.register();

//通信主机Mk3
val CHM3 as Block = VanillaFactory.createBlock("comhostmk3",<blockmaterial:iron>);
CHM3.fullBlock = true;
CHM3.setLightOpacity(255);
CHM3.translucent = true;
CHM3.setLightValue(0);
CHM3.setBlockHardness(7.5);
CHM3.setBlockResistance(100.0);
CHM3.setToolClass("pickaxe");
CHM3.setToolLevel(3);
CHM3.setBlockSoundType(<soundtype:metal>);
CHM3.register();

//SKYLESS玩偶
val YURIISYDOLL as Block = VanillaFactory.createBlock("yuriisydoll",<blockmaterial:iron>);
YURIISYDOLL.fullBlock = false;
YURIISYDOLL.setLightOpacity(255);
YURIISYDOLL.translucent = false;
YURIISYDOLL.blockLayer = "CUTOUT";
YURIISYDOLL.setLightValue(0);
YURIISYDOLL.setBlockHardness(7.5);
YURIISYDOLL.setBlockResistance(100.0);
YURIISYDOLL.setToolClass("pickaxe");
YURIISYDOLL.setToolLevel(3);
YURIISYDOLL.setBlockSoundType(<soundtype:metal>);
YURIISYDOLL.register();

//OCTOBER玩偶
val OCTOBERDOLL as Block = VanillaFactory.createBlock("octoberdoll",<blockmaterial:iron>);
OCTOBERDOLL.fullBlock = false;
OCTOBERDOLL.setLightOpacity(255);
OCTOBERDOLL.translucent = false;
OCTOBERDOLL.blockLayer = "CUTOUT";
OCTOBERDOLL.setLightValue(0);
OCTOBERDOLL.setBlockHardness(7.5);
OCTOBERDOLL.setBlockResistance(100.0);
OCTOBERDOLL.setToolClass("pickaxe");
OCTOBERDOLL.setToolLevel(3);
OCTOBERDOLL.setBlockSoundType(<soundtype:metal>);
OCTOBERDOLL.register();
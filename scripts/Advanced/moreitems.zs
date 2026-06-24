#priority 10000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;

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



# 卡西米尔效应阵列
regItem("casmir_effect_seq");
# 微型磁极流加速器
regItem("micro_mmf_accelerator");
# 时空稳定框架
regItem("spacetimeframework");
# 屏蔽罩
regItem("shieldcase");
# 时空束流
var dimensionbeam = VanillaFactory.createFluid("dimensionbeam", Color.fromHex("000000").getIntColor());
dimensionbeam.flowingLocation = "contenttweaker:fluids/dimensionbeam";
dimensionbeam.stillLocation = "contenttweaker:fluids/dimensionbeam";
dimensionbeam.luminosity = 1;
dimensionbeam.colorize = false;
dimensionbeam.viscosity = 3000;
dimensionbeam.register();
# 超流氦
regFluid("superfluid_he",0xFFFFCC,18000);
regFluid("base_fuel",0xAAAAAA,18000);
# 反质子
regFluid("anti_protron",0x18328A,18000);
# 反电子
regFluid("anti_electron",0x139B25,18000);
# 反中子
regFluid("anti_neutron",0xCDD3DC,18000);
# 反氢
regFluid("anti_hydrogen",0x006FFF,18000);
# 反氦-4
regFluid("anti_heilum_4",0x9A7726,18000);
# 异常希格斯介质
var higgsfluid = VanillaFactory.createFluid("higgsfluid", Color.fromHex("000000").getIntColor());
higgsfluid.flowingLocation = "contenttweaker:fluids/higgsfluid";
higgsfluid.stillLocation = "contenttweaker:fluids/higgsfluid";
higgsfluid.luminosity = 1;
higgsfluid.colorize = false;
higgsfluid.viscosity = 3000;
higgsfluid.register();

# 富快子不连续时空流体
var tachyonfluid = VanillaFactory.createFluid("tachyonfluid", Color.fromHex("000000").getIntColor());
tachyonfluid.flowingLocation = "contenttweaker:fluids/tachyonfluid";
tachyonfluid.stillLocation = "contenttweaker:fluids/tachyonfluid";
tachyonfluid.luminosity = 1;
tachyonfluid.colorize = false;
tachyonfluid.viscosity = 3000;
tachyonfluid.register();


# 自递归空间结构流体
var spaceframefluid = VanillaFactory.createFluid("spaceframefluid", Color.fromHex("000000").getIntColor());
spaceframefluid.flowingLocation = "contenttweaker:fluids/spaceframefluid";
spaceframefluid.stillLocation = "contenttweaker:fluids/spaceframefluid";
spaceframefluid.luminosity = 1;
spaceframefluid.colorize = false;
spaceframefluid.viscosity = 3000;
spaceframefluid.register();

# 多边矩阵液态金属阵列
var t1000 = VanillaFactory.createFluid("t1000", Color.fromHex("000000").getIntColor());
t1000.flowingLocation = "contenttweaker:fluids/t1000";
t1000.stillLocation = "contenttweaker:fluids/t1000";
t1000.luminosity = 1;
t1000.colorize = false;
t1000.viscosity = 3000;
t1000.register();

# 玻色-爱因斯坦凝聚态物质
var BEC = VanillaFactory.createFluid("bec", Color.fromHex("000000").getIntColor());
BEC.flowingLocation = "contenttweaker:fluids/bec";
BEC.stillLocation = "contenttweaker:fluids/bec";
BEC.luminosity = 1;
BEC.colorize = false;
BEC.viscosity = 3000;
BEC.register();

# 超维度残留1
var superdimensionremains1 = VanillaFactory.createFluid("superdimensionremains1", Color.fromHex("000000").getIntColor());
superdimensionremains1.flowingLocation = "contenttweaker:fluids/superdimensionremains1";
superdimensionremains1.stillLocation = "contenttweaker:fluids/superdimensionremains1";
superdimensionremains1.luminosity = 1;
superdimensionremains1.colorize = false;
superdimensionremains1.viscosity = 3000;
superdimensionremains1.register();

# 超维度残留2
var superdimensionremains2 = VanillaFactory.createFluid("superdimensionremains2", Color.fromHex("000000").getIntColor());
superdimensionremains2.flowingLocation = "contenttweaker:fluids/superdimensionremains2";
superdimensionremains2.stillLocation = "contenttweaker:fluids/superdimensionremains2";
superdimensionremains2.luminosity = 1;
superdimensionremains2.colorize = false;
superdimensionremains2.viscosity = 3000;
superdimensionremains2.register();

# 超维度残留3
var superdimensionremains3 = VanillaFactory.createFluid("superdimensionremains3", Color.fromHex("000000").getIntColor());
superdimensionremains3.flowingLocation = "contenttweaker:fluids/superdimensionremains3";
superdimensionremains3.stillLocation = "contenttweaker:fluids/superdimensionremains3";
superdimensionremains3.luminosity = 1;
superdimensionremains3.colorize = false;
superdimensionremains3.viscosity = 3000;
superdimensionremains3.register();

# 超维度残留4
var superdimensionremains4 = VanillaFactory.createFluid("superdimensionremains4", Color.fromHex("000000").getIntColor());
superdimensionremains4.flowingLocation = "contenttweaker:fluids/superdimensionremains4";
superdimensionremains4.stillLocation = "contenttweaker:fluids/superdimensionremains4";
superdimensionremains4.luminosity = 1;
superdimensionremains4.colorize = false;
superdimensionremains4.viscosity = 3000;
superdimensionremains4.register();

# 超维度残留5
var superdimensionremains5 = VanillaFactory.createFluid("superdimensionremains5", Color.fromHex("000000").getIntColor());
superdimensionremains5.flowingLocation = "contenttweaker:fluids/superdimensionremains5";
superdimensionremains5.stillLocation = "contenttweaker:fluids/superdimensionremains5";
superdimensionremains5.luminosity = 1;
superdimensionremains5.colorize = false;
superdimensionremains5.viscosity = 3000;
superdimensionremains5.register();

# 超维度残留6
var superdimensionremains6 = VanillaFactory.createFluid("superdimensionremains6", Color.fromHex("000000").getIntColor());
superdimensionremains6.flowingLocation = "contenttweaker:fluids/superdimensionremains6";
superdimensionremains6.stillLocation = "contenttweaker:fluids/superdimensionremains6";
superdimensionremains6.luminosity = 1;
superdimensionremains6.colorize = false;
superdimensionremains6.viscosity = 3000;
superdimensionremains6.register();

# 超维度残留7
var superdimensionremains7 = VanillaFactory.createFluid("superdimensionremains7", Color.fromHex("000000").getIntColor());
superdimensionremains7.flowingLocation = "contenttweaker:fluids/superdimensionremains7";
superdimensionremains7.stillLocation = "contenttweaker:fluids/superdimensionremains7";
superdimensionremains7.luminosity = 1;
superdimensionremains7.colorize = false;
superdimensionremains7.viscosity = 3000;
superdimensionremains7.register();

# 超维度残留8
var superdimensionremains8 = VanillaFactory.createFluid("superdimensionremains8", Color.fromHex("000000").getIntColor());
superdimensionremains8.flowingLocation = "contenttweaker:fluids/superdimensionremains8";
superdimensionremains8.stillLocation = "contenttweaker:fluids/superdimensionremains8";
superdimensionremains8.luminosity = 1;
superdimensionremains8.colorize = false;
superdimensionremains8.viscosity = 3000;
superdimensionremains8.register();

# 超维度残留9
var superdimensionremains9 = VanillaFactory.createFluid("superdimensionremains9", Color.fromHex("000000").getIntColor());
superdimensionremains9.flowingLocation = "contenttweaker:fluids/superdimensionremains9";
superdimensionremains9.stillLocation = "contenttweaker:fluids/superdimensionremains9";
superdimensionremains9.luminosity = 1;
superdimensionremains9.colorize = false;
superdimensionremains9.viscosity = 3000;
superdimensionremains9.register();

# 深渊重水
var abssywater = VanillaFactory.createFluid("abysswater", Color.fromHex("000000").getIntColor());
abssywater.flowingLocation = "contenttweaker:fluids/abysswater";
abssywater.stillLocation = "contenttweaker:fluids/abysswater";
abssywater.luminosity = 1;
abssywater.colorize = false;
abssywater.viscosity = 3000;
abssywater.register();

# 超临界余烬核磁流体
var magmatter_1 = VanillaFactory.createFluid("magfluid_1", Color.fromHex("000000").getIntColor());
magmatter_1.flowingLocation = "contenttweaker:fluids/magfluid_1";
magmatter_1.stillLocation = "contenttweaker:fluids/magfluid_1";
magmatter_1.luminosity = 1;
magmatter_1.colorize = false;
magmatter_1.viscosity = 3000;
magmatter_1.register();

# 质子流体
regFluid("xprotonfluid",0x00D5FF,18000);
# 零度行星流体
regFluid("zerotempaturefluid",0x4C8DFD,18000);
# 反射力场稳定单元
regItem("reflectcore");
#  暗物质
regItem("darkmatters");
# 简并态物质
regItem("degenerationmatter");
# 星际尘埃
regItem("skydust");
# "虚空"
regItem("voidmatter");
# 模糊天体
regItem("unknownplanet");
# 引力场源核心
regItem("fieldofgravitycore");
# 采集无人机MkI
regItem("oredrone1");
# 山铜行星
regItem("orichalcosplanet");
# 虹彩行星
regItem("infinityplanet");
# 闪耀行星
regItem("shingplanet");
# 纳米残骸行星
regItem("nanoplanet");
# 重核行星
regItem("normalplanet");
# 地外重核行星
regItem("enderplanet");
# 热域重核行星
regItem("hellplanet");
# "深渊"行星
regItem("depressplanet");
# 星门框架残骸
regItem("stargateruins");
# 星门核心
regItem("stargatecore");
# 遥感卫星Mk1
regItem("mk1satellite");
# 射电望远镜阵列组件Mk1
regItem("mk1observer");
# 高能激光模块
regItem("upgradelaser1");
# H.A.R.E 泛用型约束框架-普通重核行星
regItem("lockednormalplanet");
# H.A.R.E 泛用型约束框架-热域重核行星
regItem("lockedhellplanet");
# H.A.R.E 泛用型约束框架-末地重核行星
regItem("lockedenderplanet");
# 超光速引力透镜集成平台
regItem("lightspeedmirror");
# 弱磁行星
regItem("magnetplanet");
# 微型撕裂引擎
regItem("tearenginee");
# 抑制去相干粒子井
regItem("forcemanucontainer");
# 力场操纵模型
regItem("forcecontainer");
# 空间矩阵合金
regItem("spacematrix_ingot");
# 超导胚体
regItem("superconidiosome");
# 纳米陶瓷基质
regItem("nanoglassmetal");
# "余烬"
regItem("dust");
# "井"
regItem("well");
# 虚粒子井
regItem("vpwell");
# 精加工光学组件
regItem("opticsunit");
# 超空间轨道校准器
regItem("superspaceorbit");
# 自组装单元
regItem("constructunit");
# 纳米蜂群
regItem("nanoswarm");
# 运载火箭Mk1
regItem("mk1rocket");
# 原型蓝图
regItem("terminal_blueprint");
# 碳纤维复合材料
regItem("cfcm");
# THOR蓝图
regItem("thor_blueprint");
# HARC蓝图
regItem("harc_blueprint");
# PERIHELION蓝图
regItem("perihelion_blueprint");
# ZEROPRESSURE蓝图
regItem("zero_pressure_blueprint");
# 设计蓝图
regItem("normal_blueprint");
# 拟似态粒子聚合暗物质
regItem("similardarkmatter");
# 遥感卫星Mk2
regItem("mk2satellite");
# 运载火箭Mk2
regItem("mk2rocket");
# 射电望远镜阵列组件Mk2
regItem("mk2observer");
# 采集无人机Mk2
regItem("mk2oredrone");
# OCT-超能调和锭
regItem("octingot");
# 失活的纳米致动器
regItem("inactivenanites");
# 纳米致动器
regItem("nanites");
# 行星解构机-闪耀升级组件
regItem("thorupgrade1");
# 集成智慧核心
regItem("wisecore");
# γ-TiAl深空合金线圈
regItem("gama_tialcoil");
# 基础芯片
regItem("synthesischip");
# 水晶矩阵芯片
regItem("crystalchip");
# 落星合金芯片
regItem("universalalloychip");
# 中子素芯片
regItem("neutronchip");
# 无尽芯片
regItem("infinitychip");
# 方舟芯片
regItem("arkchip");
# 富余烬物质锭
regItem("neutrondustingot");
# γ-TiAl深空合金
regItem("gama_tialalloy");
# BEC超量子计算机
regItem("beccomputer");
# BEC集成自旋态量子存储器
regItem("becmemory");
# 微型时空反冲引擎
regItem("recoilengine");
# 空间站绑定终端
regItem("scan_terminal_spacestation");
# 太空电梯绑定终端
regItem("scan_terminal_elevator");
# 星载原子钟
regItem("atomicclock");
# 异星采矿单元
regItem("ultminingdevice");
# "火种"单元
regItem("sparkunit");
# 超维度透镜
regItem("spacetime_lens");
# 星河稳态防辐射结构板
regItem("stargate_framework");
# 宇宙素态涡旋模块
regItem("stargate_structure");
# 光压驱动返回单元
regItem("lightplatform");
# 装配核心Mk1
regItem("assemblycore");
# AXIS蓝图
regItem("axis_blueprint");
# NEUTRON蓝图
regItem("neutron_similar_blueprint");
# SPACESTATION-I蓝图
regItem("spacestation_i_blueprint");
# SPACESTATION-II蓝图
regItem("spacestation_ii_blueprint");
# COLLAPSE蓝图
regItem("collapse_blueprint");
# 通信中枢量子上行链路同步器
regItem("central_saved");
# DIMENSIONCARVER-蓝图
regItem("dimensioncarver_blueprint");
# 余烬升级组件
regItem("dustupgrade");
# 恒星之光
regItem("planetoflight");
# 宇宙回响
regItem("universal_ingot");
# 方舟蜂群
regItem("arkswarm");
# 余烬蜂群
regItem("dustswarm");
# 回响蜂群
regItem("universalswarm");
# 弱磁物质
regItem("weakmag");
# 行星地质数据
regItem("small_upgrade_data");
# 粗制磁共振电路
regItem("mripcb");
# 强磁物质
regItem("strongmag");
# 磁物质蜂群
regItem("magswarm");
# 磁共振电路
regItem("smripcb");
# 封闭类时曲线计算系统
regItem("ctc_computer");
# 时空破碎单元
regItem("etherengine_upgrade");
# 战争矩阵数据存储单元
regItem("warmatrix_terminal");
# 行星解构机数据存储单元
regItem("thor_terminal");
# 深潜单元MkI
regItem("mk1_divingunit");
# HELIOS离子阱量子计算阵列
regItem("helioscomputer");
# HELIOS离子阱量子计算阵列
regItem("heliosmemory");
# 核子井
regItem("nuclear_well");
# 逐日工程同步终端
regItem("ssps_terminal");
# 高密度充能燃料-HMSFv1
regItem("charged_fuel_v1");
# 高密度充能燃料-HMSFv2
regItem("charged_fuel_v2");
# 高密度充能燃料-HMSFv3
regItem("charged_fuel_v3");
# 高密度充能燃料-HMSFv4
regItem("charged_fuel_v4");
# 富余烬高密度充能燃料-HMSFv5
regItem("charged_fuel_v5");
# 局部静滞点时空重塑发生器
regItem("zp_upgrade");
# I-黑箱模组单元
regItem("reverseunit_1");
# II-黑箱模组单元
regItem("reverseunit_2");
# III-黑箱模组单元
regItem("reverseunit_3");
# IV-黑箱模组单元
regItem("reverseunit_4");
# V-黑箱模组单元
regItem("reverseunit_5");
# TCI磁锡铜复合锭
regItem("tci");
# 余烬运算集群
regItem("dust_circuit");
# OMHD-SYSTEM蓝图
regItem("omhd_blueprint");
# CEAS-ANNIHILATION蓝图
regItem("ceas_blueprint");
# 原爆点
regItem("echo_sensor");
# 牵引卫星Mk1
regItem("mk1satellite_generator");
# 牵引卫星Mk2
regItem("mk2satellite_generator");
# 牵引卫星Mk3
regItem("mk3satellite_generator");
# 牵引卫星Mk4
regItem("mk4satellite_generator");
# 牵引卫星Mk5
regItem("mk5satellite_generator");
# 牵引卫星Mk6
regItem("mk6satellite_generator");
# 牵引卫星Mk7
regItem("mk7satellite_generator");
# 牵引卫星Mk8
regItem("mk8satellite_generator");
#loader crafttweaker reloadable

import crafttweaker.item.IItemStack;
import crafttweaker.mods.ILoadedMods;
import mods.zenutils.I18n;

import novaeng.NovaEngUtils;
import novaeng.hypernet.NetNodeCache;
import novaeng.hypernet.DataProcessor;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.DatabaseType;
import novaeng.hypernet.ResearchStationType;
import novaeng.hypernet.ComputationCenterCache;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineUpgradeHelper;
RecipeBuilder.newBuilder("helios_controller_MAKE","atomicprocessequipx",1800)
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <modularmachinery:data_processor_t4_factory_controller>,
    <contenttweaker:infinity_processor>*4,
    <contenttweaker:industrial_circuit_v3>*8,
    <contenttweaker:sensor_v4>*2,
    <contenttweaker:hypernet_ram_t4>*16,
 ])
 .addOutput(<modularmachinery:helios_factory_controller>)
 .build();
 RecipeBuilder.newBuilder("helios_computer_make","atomicprocessequipx",600)
  .addEnergyPerTickInput(1000000)
  .addInputs([
    <liquid:plasma>*10000,
    <appliedenergistics2:material:22>*16,
    <appliedenergistics2:material:23>*16,
    <appliedenergistics2:material:24>*16,
    <contenttweaker:sensor_v4>*4,
    <mets:advanced_heat_vent>*8,
    <appliedenergistics2:material:47>
  ])
  .addOutput(<contenttweaker:helioscomputer>)
  .build();

 RecipeBuilder.newBuilder("helios_memory_make","atomicprocessequipx",600)
  .addEnergyPerTickInput(1000000)
  .addInputs([
    <liquid:plasma>*10000,
    <appliedenergistics2:material:22>*16,
    <appliedenergistics2:material:23>*16,
    <appliedenergistics2:material:24>*16,
    <contenttweaker:sensor_v4>*4,
    <appliedenergistics2:material:47>
  ])
  .addOutput(<contenttweaker:heliosmemory>)
  .build();
//函数注释详见_registry.zs
MachineModifier.setMaxThreads("starcomputer",0);
MachineModifier.setMaxThreads("acdcenter",0);
MachineModifier.setMaxThreads("mega_researchstationt4",0);
RegistryHyperNet.addComputationCenter("acdcenter");
//星河天穹
RegistryHyperNet.addDataProcessorType(DataProcessorType.create("starcomputer", 100 * 1000 * 10000,1000000,2147483647)
    .addRadiatorIngredient(80000000, [<liquid:bec> * 10], [<liquid:higgsfluid> * 1])
);
//HELIOS
RegistryHyperNet.addDataProcessorType(DataProcessorType.create("helios", 200 * 2000 * 18750,10000000,2147483647)
    .addRadiatorIngredient(80000000, [<liquid:cryotheum>* 10], [<liquid:water> * 1])
);

//BEC计算机
MachineUpgradeHelper.registerSupportedItem(<contenttweaker:beccomputer>);
ProcessorModuleGPUType.createGPUType(40000,200000,10*1000*100,4000000.0F)
    .register("bec_super_computer","§e可控§9超冷量子逻辑演算原型",12.0F);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:beccomputer>, "bec_super_computer");
//BEC内存
MachineUpgradeHelper.registerSupportedItem(<contenttweaker:becmemory>);
ProcessorModuleRAMType.create(400000,200000,10*1000*10,16000000.0F)
    .register("bec_super_ram","§9大规模§e光-§a物质波§9转换阵列",12.0F);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:becmemory>, "bec_super_ram");
//HELIOS计算机
MachineUpgradeHelper.registerSupportedItem(<contenttweaker:helioscomputer>);
ProcessorModuleGPUType.createGPUType(40000,200000,10*1000*100,1000000.0F)
    .register("helioscomputer","§e搭载全互连架构与量子电荷耦合器件QCCD",10.0F);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:helioscomputer>, "helioscomputer");
//HELIOS内存
MachineUpgradeHelper.registerSupportedItem(<contenttweaker:heliosmemory>);
ProcessorModuleRAMType.create(400000,200000,10*1000*10,4000000.0F)
    .register("heliosmemory","§e吸收型量子存储器",10.0F);
MachineUpgradeHelper.addFixedUpgrade(<contenttweaker:heliosmemory>, "heliosmemory");

RegistryHyperNet.addComputationCenterType(ComputationCenterType.create("acdcenter",1500 * 1000000,1000,80000000,4000000,200,800,0.02F)
        .addFixIngredient(1000, <contenttweaker:industrial_circuit_v1>)
        .addFixIngredient(4000, <contenttweaker:industrial_circuit_v2>)
        .addFixIngredient(150000, <contenttweaker:industrial_circuit_v3>)
        .addFixIngredient(3700000,<contenttweaker:industrial_circuit_v4>)
);
RegistryHyperNet.addResearchStationType(ResearchStationType.create("mega_researchstationt4",25 * 1000000000,19.1));
<modularmachinery:starcomputer_factory_controller>.addTooltip("§9基础能量消耗：§416G RF/t§f");
<modularmachinery:starcomputer_factory_controller>.addTooltip("§9热容量：§42G HU§f");
<modularmachinery:starcomputer_factory_controller>.addTooltip("§9最大被动散热量：§41M HU/t§f");
<modularmachinery:starcomputer_factory_controller>.addTooltip("§9最大主动散热量：§480M HU/t§f");
//
<modularmachinery:helios_factory_controller>.addTooltip("§9基础能量消耗：§41G RF/t§f");
<modularmachinery:helios_factory_controller>.addTooltip("§9热容量：§42G HU§f");
<modularmachinery:helios_factory_controller>.addTooltip("§9最大被动散热量：§410M HU/t§f");
<modularmachinery:helios_factory_controller>.addTooltip("§9最大主动散热量：§475M HU/t§f");
//
<modularmachinery:acdcenter_factory_controller>.addTooltip("§9基础能量消耗：§41.5G RF/t§f");
<modularmachinery:acdcenter_factory_controller>.addTooltip("§9最大连接数：§e1000§f");
<modularmachinery:acdcenter_factory_controller>.addTooltip("§9最大算力支持：§b80E FloPS§f");
<modularmachinery:acdcenter_factory_controller>.addTooltip("§9主电路板最大耐久：§a4000000§f");
<modularmachinery:mega_researchstationt4_factory_controller>.addTooltip("§9基础能量消耗：§425G RF/t§f");
<modularmachinery:mega_researchstationt4_factory_controller>.addTooltip("§9研究站认知极限：难度:§4§k1#050505-4D4D4D-FFFFFFNEGATIVE_PRIME§4§k1§f");
<modularmachinery:mega_researchstationt4_factory_controller>.addTooltip("§9如果网络中存在算力盈余,则会自动进行最高 §a设置数量 §9倍速的研究超频。§f");
MMEvents.onControllerGUIRender("acdcenter", function(event as ControllerGUIRenderEvent) {
    onGUIRenderCenter(event);
});
MMEvents.onControllerGUIRender("starcomputer", function(event as ControllerGUIRenderEvent) {
    onGUIRenderComputer(event);
});
MMEvents.onControllerGUIRender("mega_researchstationt4", function(event as ControllerGUIRenderEvent) {
    onGUIRenderResearchStation(event);
});
function onGUIRenderCenter(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val processor = ComputationCenter.from(ctrl);
    val type = processor.type;

    if (ctrl.ticksExisted % 20 == 0) {
        processor.readNBT();
    }

    var info as string[] = [
        "§9///////////// #002080-8AD8FF-3754A9协议核心矩阵§9 /////////////"
    ];

    if (ctrl.isWorking) {
        info += "§9状态：§a在线";
        info += "§9已连接 §a" + ComputationCenterCache.getTotalConnected() + " §9/ §e" + type.maxConnections + " §9台机械";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9状态：§c离线";
    }

    info += "§9电路板耐久剩余：§a" + processor.circuitDurability + "（" + formatPercent(processor.circuitDurability, type.circuitDurability) + "）";

    info += "§7HyperNet #002080-8AD8FF-3754A9协议核心矩阵§7 v1.0";
    info += "§9//////////////////////////////////";

    event.extraInfo = info;
}

function onGUIRenderComputer(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val processor = NetNodeCache.getDataProcessor(ctrl);
    val type = processor.type;

    if (ctrl.ticksExisted % 20 == 0) {
        processor.readNBT();
    }

    var info as string[] = [
        "§9////////// #570FFF-42F2FF星河天穹§9 //////////"
    ];

    if (ctrl.isWorking) {
        val maxProvision = processor.maxGeneration;
        val provision = min(processor.computationalLoad, maxProvision);
        info += "§9算力：§b" + formatFLOPS(provision) + " / " + formatFLOPS(maxProvision) + "（负载：§e" + formatPercent(provision / maxProvision, 1.0F) + "§b）";
    }

    val overHeatPercent = processor.storedHU as float / type.overheatThreshold;
    if (overHeatPercent >= 0.85F) {
        info += "§9内部热量：§c" + processor.storedHU + " HU" + "（" + formatPercent(overHeatPercent, 1.0F) + "，触发温控）";
    } else {
        info += "§9内部热量：§c" + processor.storedHU + " HU" + "（" + formatPercent(overHeatPercent, 1.0F) + "）";
    }

    if (processor.connected) {
        info += "§9网络状态：§a已连接";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9网络状态：§c断开连接";
    }

    info += "§7HyperNet #570FFF-42F2FF星河天穹§7 v1.0";
    info += "§9//////////////////////////////";

    event.extraInfo = info;
}
function onGUIRenderResearchStation(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val researchStation = NetNodeCache.getResearchStation(ctrl);

    if (ctrl.ticksExisted % 20 == 0) {
        researchStation.readNBT();
    }

    var info as string[] = [
        "§9//////////// #FE0101-FF9742'临界点'§9 ////////////"
    ];

    if (ctrl.isWorking) {
        info += "§9算力消耗：§b" + formatFLOPS(researchStation.computationPointConsumption);
    }

    if (researchStation.connected) {
        info += "§9网络状态：§a已连接";
        info += "§9总算力消耗 / 产出：§b" +
            formatFLOPS(ComputationCenterCache.getComputationPointConsumption()) +
            " / " +
            formatFLOPS(ComputationCenterCache.getComputationPointGeneration());
    } else {
        info += "§9网络状态：§c断开连接";
    }

    info += "§7HyperNet #FE0101-FF9742'临界点'§f v1.0";
    info += "§9//////////////////////////////";

    event.extraInfo = info;
}

function formatPercent(num1 as int, num2 as int) {
    return NovaEngUtils.formatFloat((num1 * 100) as float / num2 as float, 2) + "%";
}

function formatFLOPS(tflops as float) as string {
    if (tflops < 1000.0F) {
        return NovaEngUtils.formatFloat(tflops, 1) + "T FloPS";
    }
    if (tflops < 1000000.0F) {
        return NovaEngUtils.formatFloat(tflops / 1000.0F, 1) + "P FloPS";
    }
    if (tflops > 1000000.0F) {
        return NovaEngUtils.formatFloat(tflops / 1000000.0F, 1) + "E FloPS";
    }
}
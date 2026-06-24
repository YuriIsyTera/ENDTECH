import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineStructureUpdateEvent;
import crafttweaker.block.IBlock;
import novaeng.hypernet.HyperNetHelper;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.event.BlockBreakEvent;
import crafttweaker.liquid.ILiquidStack;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;
import mods.modularmachinery.MachineController;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
MachineModifier.setMaxThreads("high_density_energy_focus_core",1);
RecipeBuilder.newBuilder("energy_change_controller_make","atomicprocessequipx",1800)
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <modularmachinery:energy_conversion_station_controller>*4,
    <contenttweaker:energycube_mk1>*16,
    <contenttweaker:sensor_v3>*8,
    <contenttweaker:industrial_circuit_v2>*6,
    <contenttweaker:engineering_battery_v4>*18
 ])
 .addOutput(<modularmachinery:high_density_energy_focus_core_factory_controller>)
 .build();
MachineModifier.addSmartInterfaceType("high_density_energy_focus_core",
    SmartInterfaceType.create("speed", 1)
        .setHeaderInfo("转换速度设置")
        .setValueInfo("速度：§a%.0f ")
        .setFooterInfo("§a每1单位代表5GRF/t的转换速度,最大25600")
        .setJeiTooltip("速度范围：最低 §a%.0f 倍§f，最高 §a%.0f 倍", 2)
);
MMEvents.onMachinePostTick("high_density_energy_focus_core", function(event as MachineTickEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("speed");
    var speed = isNull(nullable) ? 1.0f : nullable.value;
    if (speed < 1 || speed > 25600) {
        nullable.value = 1;
    }
    map["speed"] = speed;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("energy_change_mode_1","high_density_energy_focus_core",1)
    .addFluidOutput(<liquid:liquid_energy>)
    .addEnergyPerTickInput(5000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val speed = data.getFloat("speed",1) as int;
        event.activeRecipe.maxParallelism = speed;
    })
    .addRecipeTooltip("在智能数据接口处调整并行")
    .addRecipeTooltip("该配方最高拥有25600并行")
    .build();
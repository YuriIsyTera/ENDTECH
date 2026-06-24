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
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;
import mods.modularmachinery.MachineController;
import crafttweaker.liquid.ILiquidStack;

import crafttweaker.data.IData;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
MachineModifier.setMaxThreads("orionengine",0);
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("固态燃料端口#1"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("固态燃料端口#2"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("固态燃料端口#3"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("液态燃料端口#1"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("液态燃料端口#2"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("液态燃料端口#3"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("高密度燃料端口#1"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("高密度燃料端口#2"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("高密度燃料端口#3"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("高密度燃料端口#4"));
MachineModifier.addCoreThread("orionengine", FactoryRecipeThread.createCoreThread("高密度燃料端口#5"));
RecipeBuilder.newBuilder("orionengine_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(20000000)
    .addFluidInputs([
       <liquid:plasma>*100000,
       <liquid:unsteady_plasma>*100000
    ])
    .addItemInputs([
      <modularmachinery:energy_converter_controller>,
      <modularmachinery:energy_crystal_controller>,
      <modularmachinery:tiny_energy_converter_controller>,
      <modularmachinery:energy_conversion_station_controller>,
      <modularmachinery:energy_crystal_2_controller>,
      <contenttweaker:world_energy_core>*4,
      <mekanism:antimatterpellet>*16,
      <contenttweaker:energized_fuel_container_v1>*128,
      <contenttweaker:energized_fuel_container_v2>*64,
      <contenttweaker:energized_fuel_container_v3>*16,
      <contenttweaker:energized_fuel_container_v4>*8,
    ])
    .addOutputs([
        <modularmachinery:orionengine_factory_controller>
    ])
    .requireResearch("theory_transfer_fuel")
    .requireComputationPoint(100000.0)
    .build();
RecipeBuilder.newBuilder("orion_fuel_v2","orionengine",400,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=32;
    event.activeRecipe.parallelism=32;
 })
 .addInputs(<contenttweaker:energized_fuel_v2>)
 .addEnergyPerTickOutput(600000000)
 .addOutputs(<contenttweaker:energized_fuel_depleted_v2>)
 .addFluidOutputs(<liquid:base_fuel>*75000)
 .setThreadName("固态燃料端口#1")
 .addRecipeTooltip("快速充分燃烧燃料单元")
 .addRecipeTooltip("该配方并行上限为32")
 .build();
RecipeBuilder.newBuilder("orion_fuel_v3","orionengine",800,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=16;
    event.activeRecipe.parallelism=16;
 })
 .addInputs(<contenttweaker:energized_fuel_v3>)
 .addOutputs(<contenttweaker:energized_fuel_depleted_v3>)
 .addEnergyPerTickOutput(4000000000)
 .addFluidOutputs(<liquid:base_fuel>*136232)
 .setThreadName("固态燃料端口#2")
 .addRecipeTooltip("快速充分燃烧燃料单元")
  .addRecipeTooltip("该配方并行上限为16")
 .build();
RecipeBuilder.newBuilder("orion_fuel_v4","orionengine",1200,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=8;
    event.activeRecipe.parallelism=8;
 })
 .addInputs(<contenttweaker:energized_fuel_v4>)
 .addOutputs(<contenttweaker:energized_fuel_depleted_v4>)
 .addEnergyPerTickOutput(60000000000)
 .addFluidOutputs(<liquid:base_fuel>*207232)
 .setThreadName("固态燃料端口#3")
 .addRecipeTooltip("快速充分燃烧燃料单元")
  .addRecipeTooltip("该配方并行上限为8")
 .build();

RecipeBuilder.newBuilder("orion_plasma","orionengine",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=32;
    event.activeRecipe.parallelism=32;
 })
 .addInputs(<liquid:plasma>*10000)
 .addOutputs(<liquid:unsteady_plasma>*5000)
 .addEnergyPerTickOutput(2000000000)
 .addFluidOutputs(<liquid:base_fuel>*50000)
 .setThreadName("液态燃料端口#1")
 .addRecipeTooltip("不经由任何加工直接利用等离子体进行发电")
  .addRecipeTooltip("该配方并行上限为32")
 .build();

RecipeBuilder.newBuilder("orion_dt","orionengine",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=32;
    event.activeRecipe.parallelism=32;
 })
 .addInputs(<liquid:liquidfusionfuel>*10000)
 .addEnergyPerTickOutput(1000000000)
 .addFluidOutputs(<liquid:base_fuel>*50000)
 .setThreadName("液态燃料端口#2")
 .addRecipeTooltip("充分燃烧液态燃料")
  .addRecipeTooltip("该配方并行上限为32")
 .build();

 RecipeBuilder.newBuilder("orion_cv1","orionengine",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=64;
    event.activeRecipe.parallelism=64;
 })
 .addInputs(<contenttweaker:charged_fuel_v1>)
 .addEnergyPerTickOutput(1200000000)
 .addFluidOutputs(<liquid:base_fuel>*100000)
 .addOutput(<liquid:unsteady_plasma>*10000)
 .setThreadName("高密度燃料端口#1")
 .addRecipeTooltip("在短时间内充分燃烧高能物质")
  .addRecipeTooltip("该配方并行上限为64")
 .build();

  RecipeBuilder.newBuilder("orion_cv2","orionengine",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=64;
    event.activeRecipe.parallelism=64;
 })
 .addInputs(<contenttweaker:charged_fuel_v2>)
 .addEnergyPerTickOutput(2400000000)
 .addFluidOutputs(<liquid:base_fuel>*200000)
 .addOutput(<liquid:unsteady_plasma>*40000)
 .setThreadName("高密度燃料端口#2")
 .addRecipeTooltip("在短时间内充分燃烧高能物质")
  .addRecipeTooltip("该配方并行上限为64")
 .build();

  RecipeBuilder.newBuilder("orion_cv3","orionengine",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=64;
    event.activeRecipe.parallelism=64;
 })
 .addInputs(<contenttweaker:charged_fuel_v3>)
 .addEnergyPerTickOutput(16000000000)
 .addFluidOutputs(<liquid:base_fuel>*544928)
 .addOutput(<liquid:unsteady_plasma>*100000)
 .setThreadName("高密度燃料端口#3")
 .addRecipeTooltip("在短时间内充分燃烧高能物质")
  .addRecipeTooltip("该配方并行上限为64")
 .build();

   RecipeBuilder.newBuilder("orion_cv4","orionengine",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=64;
    event.activeRecipe.parallelism=64;
 })
 .addInputs(<contenttweaker:charged_fuel_v4>)
 .addEnergyPerTickOutput(240000000000)
 .addFluidOutputs(<liquid:base_fuel>*828928)
 .addOutput(<liquid:unsteady_plasma>*500000)
 .setThreadName("高密度燃料端口#4")
 .addRecipeTooltip("在短时间内充分燃烧高能物质")
  .addRecipeTooltip("该配方并行上限为64")
 .build();

    RecipeBuilder.newBuilder("orion_cv5","orionengine",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=64;
    event.activeRecipe.parallelism=64;
 })
 .addInputs(<contenttweaker:charged_fuel_v5>)
 .addEnergyPerTickOutput(480000000000)
 .addFluidOutputs(<liquid:base_fuel>*1000000)
 .setThreadName("高密度燃料端口#5")
 .addRecipeTooltip("在短时间内充分燃烧高能物质")
  .addRecipeTooltip("该配方并行上限为64")
 .build();

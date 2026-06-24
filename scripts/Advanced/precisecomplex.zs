import mods.extendedcrafting.TableCrafting;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeFinishEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.MachineUpgradeHelper;

import crafttweaker.util.IRandom;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;

import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;
HyperNetHelper.proxyMachineForHyperNet("precisecomplex");
MachineModifier.setMaxThreads("precisecomplex", 10);
MachineModifier.setInternalParallelism("precisecomplex",4096);
RecipeBuilder.newBuilder("precisecomplex_factory_controllerMAKE","machine_arm",1200)
    .addEnergyPerTickInput(200000)
    .addFluidInputs([
       <liquid:redstone>*100000
    ])
    .addItemInputs([
      <modularmachinery:board_assembly_room_controller>*5,
      <modularmachinery:precision_assembler_factory_controller>*5,
      <mekanism:controlcircuit>*256,
      <mekanism:controlcircuit:1>*256,
      <mekanism:controlcircuit:2>*256,
      <mekanism:controlcircuit:3>*256,
      <modularmachinery:blockparallelcontroller:1>*10,

    ])
    .addOutputs([
        <modularmachinery:precisecomplex_factory_controller>
    ])
    .requireResearch("theory_precisecomplex")
    .build();
//元件装配室
RecipeAdapterBuilder.create("precisecomplex", "modularmachinery:board_assembly_room")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1.0F, 1, false).build())
    .build();
//机械核心
RecipeAdapterBuilder.create("precisecomplex", "modularmachinery:mach_crafter")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1.0F, 1, false).build())
    .build();
//精密装配机
RecipeAdapterBuilder.create("precisecomplex","modularmachinery:precision_assembler")
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.2,1,false).build());
  })
  .build();

RecipeBuilder.newBuilder("syschip","precisecomplex",40)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(50000)
  .addFluidInputs([
    <liquid:redstone>*10000,
  ])
  .addInputs([
    <contenttweaker:industrial_circuit_v1>*16,
    <contenttweaker:sensor_v1>*4,
    <deepmoblearning:glitch_infused_ingot>*18,
    <enderio:item_material:41>*4
  ])
  .addOutputs([
    <contenttweaker:synthesischip>
  ])
  .requireComputationPoint(100.0)
  .build();

RecipeBuilder.newBuilder("solarwindcollector_make","precisecomplex",800)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(50000)
  .addFluidInputs([
    <liquid:cryotheum>*100000,
  ])
  .addInputs([
    <contenttweaker:industrial_circuit_v2>*32,
    <contenttweaker:sensor_v2>*16,
    <appliedenergistics2:spatial_pylon>*8,
    <minecraft:ender_pearl>*192,
    <contenttweaker:electric_motor_v2>*14,
  ])
  .addOutputs([
    <modularmachinery:solarwindcollector_factory_controller>
  ])
 .requireComputationPoint(500.0)
 .build();

 RecipeBuilder.newBuilder("zchip_make","precisecomplex",40)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(20000)
  .addInputs([
    <minecraft:diamond_axe>,
  ]).setChance(0)
  .addInputs([
    <minecraft:shears>
  ]).setChance(0)
  .addInputs([
    <enderio:item_alloy_ingot:7>*2,
    <appliedenergistics2:material:5>*2,
    <minecraft:redstone>,
    <minecraft:skull:2>
  ])
  .addOutputs([
    <enderio:item_material:42>
  ])
  .build();

 RecipeBuilder.newBuilder("coil_make_prc","precisecomplex",40)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addInput(<contenttweaker:synthesischip>).setChance(0)
  .addEnergyPerTickInput(100)
  .addInputs([
    <thermalfoundation:material:128>*8,
    <thermalfoundation:material:32>*1,
  ])
  .addOutputs([
    <ic2:crafting:5>
  ])
 .build();

  RecipeBuilder.newBuilder("framework_1","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <minecraft:iron_bars>*192,
    <minecraft:iron_ingot>*192,
    <enderio:item_material:20>*32
  ])
  .addOutputs([
    <enderio:item_material>*64
  ])
 .build();

   RecipeBuilder.newBuilder("framework_2","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <enderio:item_material>*64,
    <enderio:item_material:52>*64,
  ])
  .addOutputs([
    <enderio:item_material:53>*64
  ])
 .build();

    RecipeBuilder.newBuilder("framework_3","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <enderio:item_material>*64,
    <enderio:item_material:51>*64,
  ])
  .addOutputs([
    <enderio:item_material:1>*64
  ])
 .build();
 
     RecipeBuilder.newBuilder("framework_4","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <enderio:item_material>*64,
    <enderio:item_material:51>*64,
  ])
  .addOutputs([
    <enderio:item_material:1>*64
  ])
 .build();

      RecipeBuilder.newBuilder("framework_5","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <thermalfoundation:material:65>*6,
    <enderio:item_material:32>*6,
    <minecraft:wool>*6,
    <enderio:item_alloy_ingot:1>*4,
    <enderio:item_basic_capacitor>*2,
    <minecraft:prismarine_shard>*2,
    <minecraft:prismarine_crystals>*4,
    <enderio:item_material:53>
  ])
  .addOutputs([
    <enderio:item_material:55>
  ])
 .build();

      RecipeBuilder.newBuilder("framework_6","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <enderio:item_alloy_ingot:8>*192,
    <enderio:block_end_iron_bars>*192,
    <enderio:item_material:20>*32
  ])
  .addOutputs([
    <enderio:item_material:66>*64
  ])
 .build();

       RecipeBuilder.newBuilder("framework_7","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <enderio:item_material:66>*64,
    <enderio:item_material:52>*64
  ])
  .addOutputs([
    <enderio:item_material:54>*64
  ])
 .build();

        RecipeBuilder.newBuilder("z_control_make","precisecomplex",40)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
 })
  .addEnergyPerTickInput(100)
  .addInputs([
    <minecraft:skull:2>,
    <minecraft:iron_block>,
    <contenttweaker:industrial_circuit_v1>*4
  ])
  .addOutputs([
    <enderio:item_material:41>*8
  ])
 .build();
 MMEvents.onControllerGUIRender("precisecomplex", function(event as ControllerGUIRenderEvent) {
                val ctrl = event.controller;
                val data = ctrl.customData;
                val lslx = data.getInt("lslx",0);
                var info as string[] = [];
                if (lslx == 1){
                    info += "§b额外设备等级：§6神龙";
                } else if (lslx == 2){
                    info += "§b额外设备等级：§8混沌";
                }
                event.extraInfo = info;
            });
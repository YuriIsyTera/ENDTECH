import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
import crafttweaker.data.IData;
import crafttweaker.world.IWorld;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.MachineModifier;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import crafttweaker.util.Math;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.MachineTickEvent;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;
HyperNetHelper.proxyMachineForHyperNet("aerospacefactory");
MachineModifier.setMaxThreads("aerospacefactory",0);
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("工程蓝图结构"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("航天器平台#1"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("航天器平台#2"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("航天器平台#3"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("航天器平台#4"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("自组装单元装配平台"));
MachineModifier.addCoreThread("aerospacefactory", FactoryRecipeThread.createCoreThread("航天工业集成处理"));

RecipeBuilder.newBuilder("aerospacefactory_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(500000000)
    .addItemInputs([
      <modularmachinery:workshop_factory_controller>*4,
      <advancedrocketry:warpcore>*128,
      <advancedrocketry:warpmonitor>*128,
      <advancedrocketry:deployablerocketbuilder>*64,
      <advancedrocketry:fuelingstation>*32,
      <contenttweaker:robot_arm_v4>*16,
      <contenttweaker:exponential_level_processor>*128,
    ])
    .addOutputs([
        <modularmachinery:aerospacefactory_factory_controller>
    ])
    .requireResearch("site")
    .requireComputationPoint(5000.0)
    .build();

//MK1卫星
RecipeBuilder.newBuilder("mk1satellite","aerospacefactory",100,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism=128;
  })
  .addInputs([
    <contenttweaker:industrial_circuit_v3>,
    <actuallyadditions:block_furnace_solar>*8,
    <immersiveposts:metal_rods:4>*16,
    <advancedrocketry:itemcircuitplate:1>*4,
    <advancedrocketry:satelliteprimaryfunction>*16
  ])
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:mk1satellite>*5)
  .addRecipeTooltip("§a该配方最大有128并行")
  .setThreadName("航天器平台#1")
  .requireResearch("site")
  .requireComputationPoint(100.0)
  .build();

//MK2卫星
RecipeBuilder.newBuilder("mk2satellite","aerospacefactory",200,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism=64;
  })
  .addInputs([
    <contenttweaker:mk1satellite>*5,
    <contenttweaker:gama_tialcoil>*16,
    <contenttweaker:universalalloychip>*3,
    <moreplates:neutronium_plate>*32,
  ])
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:mk2satellite>*5)
  .requireComputationPoint(2000.0)
  .addRecipeTooltip("§a该配方最大有64并行")
  .setThreadName("航天器平台#1")
  .requireResearch("site")
  .build();


//MK1无人机
RecipeBuilder.newBuilder("mk1drone","aerospacefactory",100,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism=128;
  })
  .addInputs([
    <contenttweaker:industrial_circuit_v3>,
    <super_solar_panels:machines:2>,
    <advancedrocketry:satelliteprimaryfunction:4>*4,
    <mets:titanium_plate>*16,
    <contenttweaker:sensor_v3>*5,
    <advancedrocketry:atmanalyser>*5
  ])
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:oredrone1>*5)
  .addRecipeTooltip("§a该配方最大有128并行")
  .setThreadName("航天器平台#2")
  .requireComputationPoint(100.0)
  .requireResearch("site")
  .build();

//MK2无人机
RecipeBuilder.newBuilder("mk2drone","aerospacefactory",200,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism=64;
  })
  .addInputs([
    <contenttweaker:oredrone1>*5,
    <contenttweaker:gama_tialcoil>*16,
    <contenttweaker:universalalloychip>*3,
    <moreplates:neutronium_plate>*32,
  ])
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:mk2oredrone>*5)
  .addRecipeTooltip("§a该配方最大有64并行")
  .setThreadName("航天器平台#2")
  .requireComputationPoint(2000.0)
  .requireResearch("site")
  .build();
//Mk1火箭
RecipeBuilder.newBuilder("mk1rocket","aerospacefactory",100,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism=128;
  })
  .addInputs([
    <contenttweaker:industrial_circuit_v3>,
    <contenttweaker:sensor_v3>,
    <advancedrocketry:ic:2>,
    <mets:titanium_plate>*16,
    <jaopca:item_platedensetitanium>*8,
    <advancedrocketry:misc>,
    <contenttweaker:stellar_alloy_wire>*12,
  ])
  .addFluidInput(<liquid:liquidfusionfuel>*5000)
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:mk1rocket>*5)
  .addRecipeTooltip("§a该配方最大有128并行")
  .setThreadName("航天器平台#3")
  .requireComputationPoint(100.0)
  .requireResearch("site")
  .build();
//MK2火箭
RecipeBuilder.newBuilder("mk2rocket","aerospacefactory",200,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism=64;
  })
  .addInputs([
    <contenttweaker:mk1rocket>*5,
    <contenttweaker:gama_tialcoil>*16,
    <contenttweaker:universalalloychip>*3,
    <moreplates:neutronium_plate>*32,
  ])
  .addFluidInput(<liquid:liquidfusionfuel>*5000)
  .addEnergyPerTickInput(1000000)
  .addOutput(<contenttweaker:mk2rocket>*5)
  .addRecipeTooltip("§a该配方最大有64并行")
  .setThreadName("航天器平台#3")
  .requireResearch("site")
  .requireComputationPoint(2000.0)
  .build();

//MK1镜组
RecipeBuilder.newBuilder("mk1observer","aerospacefactory",100,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism =128;
    event.activeRecipe.maxParallelism=128;
  })
  .addInputs([
    <actuallyadditions:item_misc:18>,
    <contenttweaker:sensor_v3>*5,
    <moreplates:neutronium_plate>*12,
    <contenttweaker:industrial_circuit_v3>*2,
    <advancedrocketry:satelliteprimaryfunction>*16,
  ])
  .addEnergyPerTickInput(1000000)
  .addFluidInput(<liquid:crystalloidneutron>*5000)
  .addOutput(<contenttweaker:mk1observer>*5)
  .addRecipeTooltip("§a该配方最大有128并行")
  .setThreadName("航天器平台#4")
  .requireComputationPoint(100.0)
  .requireResearch("site")
  .build();

//MK2镜组
RecipeBuilder.newBuilder("mk2observer","aerospacefactory",200,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    event.activeRecipe.parallelism =64;
    event.activeRecipe.maxParallelism=64;
  })
  .addInputs([
        <contenttweaker:mk1observer>*5,
    <contenttweaker:gama_tialcoil>*16,
    <contenttweaker:universalalloychip>*3,
    <moreplates:neutronium_plate>*32,
  ])
  .addEnergyPerTickInput(1000000)
  .addFluidInput(<liquid:crystalloidneutron>*5000)
  .addOutput(<contenttweaker:mk2observer>*5)
  .addRecipeTooltip("§a该配方最大有64并行")
  .setThreadName("航天器平台#4")
  .requireResearch("site")
  .requireComputationPoint(2000.0)
  .build();

RecipeBuilder.newBuilder("advanced_circuit","aerospacefactory",100,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
    <minecraft:gold_ingot>,
    <minecraft:redstone_block>,
    <advancedrocketry:itemcircuitplate>*1
 ])
 .addEnergyPerTickInput(7200)
 .addOutputs(<advancedrocketry:itemcircuitplate:1>)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();

RecipeBuilder.newBuilder("normal_circuit","aerospacefactory",100,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
    <thermalfoundation:material:33>,
    <minecraft:redstone>,
    <advancedrocketry:wafer>*1
 ])
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:itemcircuitplate>*1)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();
 
RecipeBuilder.newBuilder("ic_1","aerospacefactory",100,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
    <minecraft:redstone>,
    <minecraft:ender_eye>,
    <advancedrocketry:itemcircuitplate>,
 ])
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:ic:1>)
 .addRecipeTooltip("§a该配方最大有64并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();

 RecipeBuilder.newBuilder("analyse","aerospacefactory",100,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
    <libvulpes:battery>,
    <advancedrocketry:ic:2>,
    <advancedrocketry:misc>,
    <advancedrocketry:lens>,
    <thermalfoundation:material:321>
 ])
 .addEnergyPerTickInput(1000)
 .addOutputs(<advancedrocketry:atmanalyser>)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();

 RecipeBuilder.newBuilder("constructunit_1","aerospacefactory",100,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16; 
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:tyf1>*8,
    <contenttweaker:kjcl>*4,
    <contenttweaker:kjzj>,
    <contenttweaker:energized_fuel_v2>*16,
    <contenttweaker:synthesischip>
  ])
  .addOutputs([
    <contenttweaker:constructunit>,
    <contenttweaker:energized_fuel_depleted_v2>*16
  ])
  .addRecipeTooltip("制造一级§9自组装单元")
  .addRecipeTooltip("§a该配方最大有16并行")
  .setThreadName("自组装单元装配平台")
  .requireComputationPoint(1000.0)
  .build();
 RecipeBuilder.newBuilder("constructunit_3","aerospacefactory",100,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16; 
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:tyf1>*8,
    <contenttweaker:kjcl>*4,
    <contenttweaker:kjzj>,
    <contenttweaker:energized_fuel_v3>*16,
    <contenttweaker:crystalchip>
  ])
  .addOutputs([
    <contenttweaker:constructunit> *4,
    <contenttweaker:energized_fuel_depleted_v3>*16
  ])
  .addRecipeTooltip("制造一级§9自组装单元")
  .addRecipeTooltip("§a该配方最大有16并行")
  .setThreadName("自组装单元装配平台")
  .requireComputationPoint(4000.0)
  .build();
 RecipeBuilder.newBuilder("constructunit_4","aerospacefactory",100,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16; 
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:tyf2>*8,
    <contenttweaker:kjcl>*8,
    <contenttweaker:kjzj> *4,
    <contenttweaker:energized_fuel_v3>*32,
    <contenttweaker:universalalloychip>
  ])
  .addOutputs([
    <contenttweaker:constructunit> *32,
    <contenttweaker:energized_fuel_depleted_v3>*32
  ])
  .addRecipeTooltip("制造一级§9自组装单元")
  .addRecipeTooltip("§a该配方最大有16并行")
  .setThreadName("自组装单元装配平台")
  .requireComputationPoint(8000.0)
  .build();
   RecipeBuilder.newBuilder("constructunit_5","aerospacefactory",100,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16; 
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:tyf2>*8,
    <contenttweaker:kjcl>*8,
    <contenttweaker:kjzj> *4,
    <contenttweaker:energized_fuel_v4>*4,
    <contenttweaker:universalalloychip> *4
  ])
  .addOutputs([
    <contenttweaker:constructunit> *64,
    <contenttweaker:energized_fuel_depleted_v4>*4
  ])
  .addRecipeTooltip("制造一级§9自组装单元")
  .addRecipeTooltip("§a该配方最大有16并行")
  .requireComputationPoint(16000.0)
  .setThreadName("自组装单元装配平台")
  .build();

  RecipeBuilder.newBuilder("coil_gama_water", "aerospacefactory", 10, 10, false)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=4096;
    event.activeRecipe.maxParallelism=4096;
  })
    .addEnergyPerTickInput(128000)
    .addInput(<contenttweaker:gama_tialalloy> * 1)
    .addOutput(<contenttweaker:gama_tialcoil> * 3)
    .requireComputationPoint(0.25F)
    .setMultipleParallelized(4)
    .setThreadName("航天工业集成处理")
    .build();

  RecipeBuilder.newBuilder("advanced_circuit_MAKE_aero","aerospacefactory",200,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
  <advancedrocketry:itemcircuitplate:1>,
    <appliedenergistics2:material:16>,
  <appliedenergistics2:material:17>,
  <appliedenergistics2:material:18>,
 ])
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:ic:2>*4)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();

   RecipeBuilder.newBuilder("tiepian_ar_water", "numerical_control_machine", 60, 10, false)
    .addEnergyPerTickInput(128000)
    .addInput(<thermalfoundation:material:32> * 1)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addOutput(<libvulpes:productsheet:1> *1 )
    .addFluidPerTickInput(<liquid:water> * 300)
    .addFluidPerTickOutput(<liquid:steam> * 300)
    .requireComputationPoint(0.25F)
    .setMultipleParallelized(4)
    .build();

  RecipeBuilder.newBuilder("base_circuit_MAKE_aero","aerospacefactory",200,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
  <advancedrocketry:itemcircuitplate>,
  <appliedenergistics2:material:16>,
  <appliedenergistics2:material:17>,
  <appliedenergistics2:material:18>,
 ])
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:ic>*4)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();

   RecipeBuilder.newBuilder("interger_stoarge_MAKE","aerospacefactory",200,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
 .addInputs([
  <minecraft:redstone>,
  <minecraft:emerald>,
  <advancedrocketry:ic>,

 ])
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:dataunit>)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();


    RecipeBuilder.newBuilder("siliconcircle_MAKE","aerospacefactory",20,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=256;
    event.activeRecipe.maxParallelism=256;
 })
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:itemSilicon>,
                <ore:ingotSilicon>
            ])
    )
    .addInput(<thermalfoundation:material:128>)
 .addEnergyPerTickInput(4800)
 .addOutputs(<advancedrocketry:wafer>*32)
 .addRecipeTooltip("§a该配方最大有256并行")
 .setThreadName("航天工业集成处理")
 .requireComputationPoint(50.0)
 .build();
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
HyperNetHelper.proxyMachineForHyperNet("basic_zeropressure");
MachineModifier.setMaxThreads("basic_zeropressure", 0);
for i in 1 to 15{
        MachineModifier.addCoreThread("basic_zeropressure", FactoryRecipeThread.createCoreThread("静滞点" + i));
}
        RecipeAdapterBuilder.create("basic_zeropressure","modularmachinery:atomic_reconstructor")
        .addModifier(RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 128;
    })
    .build();
RecipeBuilder.newBuilder("fuel_v1","basic_zeropressure",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
    <liquid:pyrotheum>*1000,
    <liquid:base_fuel>*9000,
 ])
 .addEnergyPerTickInput(25600)
 .addInputs([
    <contenttweaker:dust>*16,
 ])
 .addOutput(<contenttweaker:energized_fuel_v1>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为128")
 .build();


RecipeBuilder.newBuilder("fuel_v2","basic_zeropressure",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
    <liquid:plasma>*1000,
    <liquid:base_fuel>*900,
 ])
 .addEnergyPerTickInput(102400)
 .addInputs([
    <contenttweaker:dust>*24,
 ])
 .addOutput(<contenttweaker:energized_fuel_v2>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为128")
 .build();

 RecipeBuilder.newBuilder("fuel_v3","basic_zeropressure",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
    <liquid:draconic_metal>*1000,
    <liquid:base_fuel>*9000,
 ])
 .addEnergyPerTickInput(409600)
 .addInputs([
    <contenttweaker:dust>*32,
    <draconicevolution:chaos_shard>*4,
 ])
 .addOutput(<contenttweaker:energized_fuel_v3>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为128")
 .build();

  RecipeBuilder.newBuilder("fuel_v4","basic_zeropressure",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
   <liquid:crystalloid>*1000,
    <liquid:base_fuel>*90000,
 ])
 .addEnergyPerTickInput(1638400)
 .addInputs([
    <contenttweaker:dust>*32,
    <avaritia:resource:5>,
 ])
 .addOutput(<contenttweaker:energized_fuel_v4>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为128")
 .build();

RecipeBuilder.newBuilder("antimatter","basic_zeropressure",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 16;
 })
 .addFluidInputs([
   <liquid:ancient_debris>*1000,
    <liquid:base_fuel>*100000,
 ])
 .addEnergyPerTickInput(32768000)
 .addInputs([
    <mekanism:antimatterpellet>*16,
    <contenttweaker:dust>*128,
    <contenttweaker:ymysq>,
 ])
 .addOutput(<contenttweaker:fwzrlb>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为32")
 .build();

RecipeBuilder.newBuilder("hxs","basic_zeropressure",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 8;
 })
 .addFluidInputs([
   <liquid:infinity_metal>*100,
    <liquid:base_fuel>*1000000,
 ])
 .addEnergyPerTickInput(65536000)
 .addInputs([
    <contenttweaker:dust>*256,
    <contenttweaker:ymysq>,
    <contenttweaker:hxs>*16,
    <additions:novaextended-crystal4>
 ])
 .addOutput(<contenttweaker:hxsrlb>)
 .addRecipeTooltip("解放高温行星残骸中的热量,快速制作燃料")
 .addRecipeTooltip("该配方的并行上限为8")
 .build();

RecipeBuilder.newBuilder("caozongmoxing","basic_zeropressure",100,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 128;
  })
  .addEnergyPerTickInput(1000000000)
  .addInputs([
   <contenttweaker:forcemanucontainer>,
   <contenttweaker:micro_mmf_accelerator>*8,
   <contenttweaker:nanites>*32
  ])
  .addFluidInputs([
   <liquid:higgsfluid>*10000
  ])
  .addOutputs([
   <contenttweaker:forcecontainer>
  ])
  .addRecipeTooltip("更快速的制造操纵模型")
  .addRecipeTooltip("该配方的并行上限为128")
  .build();

RecipeBuilder.newBuilder("similar_darkmatter","basic_zeropressure",200,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 16;
  })
  .addEnergyPerTickInput(1000000000)
  .addInputs([
   <contenttweaker:darkmatters>
  ]).setChance(0.01)
  .addFluidInputs([
   <liquid:dimensionbeam>*100000
  ])
  .addOutputs([
   <contenttweaker:similardarkmatter>
  ])
  .addRecipeTooltip("仿制暗物质的结构")
  .addRecipeTooltip("该配方的并行上限为4")
  .build();

RecipeBuilder.newBuilder("ctc_computer_make","basic_zeropressure",100,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 16;
  })
  .addEnergyPerTickInput(100000000)
  .addInputs([
   <liquid:tachyonfluid>*8888,
   <liquid:spaceframefluid>*8888,
   <liquid:bec>*10000,
      <contenttweaker:atomicclock>*8,
   <contenttweaker:nanoswarm>*32,
   <contenttweaker:infinitychip>*1,
   <contenttweaker:mripcb>*128
  ])
  .addOutputs([
   <contenttweaker:ctc_computer>
  ])
  .requireComputationPoint(100000.0)
  .addRecipeTooltip("制造一种极特殊的计算系统")
  .addRecipeTooltip("该配方的并行上限为16")
  .build();

  RecipeBuilder.newBuilder("dragon_heart_make_basic","basic_zeropressure",20,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 1024;
  })
  .addEnergyPerTickInput(8000000)
  .addInputs([
   <draconicevolution:chaos_shard>*10
  ])
  .addOutputs([
   <draconicevolution:dragon_heart>
  ])
  .addRecipeTooltip("快速制造龙之心")
  .addRecipeTooltip("该配方的并行上限为1024")
  .build();

  RecipeBuilder.newBuilder("ultimate_ingot_bzps","basic_zeropressure",20,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(800000)
  .addInputs([
   <avaritia:resource:6>*4,
   <additions:novaextended-terraalloy>,
   <tconevo:metal:10>,
   <additions:novaextended-fallen_star_alloy>,
   <additions:novaextended-blue_alloy_ingot>
  ])
  .addOutputs([
   <extendedcrafting:material:32>*60
  ])
  .addRecipeTooltip("领会终极的奥义")
  .addRecipeTooltip("该配方的并行上限为4096")
  .build();

    RecipeBuilder.newBuilder("shroud_needle","basic_zeropressure",1200)
  .addEnergyPerTickInput(80000000000)
  .addInputs([
<advancedrocketry:misc>,
<contenttweaker:beccomputer> * 4,
<contenttweaker:arkchip> * 4,
<novaeng_core:extendable_calculator_subsystem_l9> * 32,
<contenttweaker:spacetimeframework> * 128,
<contenttweaker:recoilengine>,
<contenttweaker:lightplatform> * 64,
<contenttweaker:mk2observer> * 64
  ])
  .addOutputs([
   <contenttweaker:shroud_needle>
  ])
  .requireResearch("Mega-ShroudNeedle")
  .requireComputationPoint(800000.0)
  .build();

    RecipeBuilder.newBuilder("shroud_needle_array","basic_zeropressure",1200)
  .addEnergyPerTickInput(80000000000)
  .addInputs([
<contenttweaker:beccomputer> * 16,
<contenttweaker:arkchip> * 16,
<novaeng_core:extendable_calculator_subsystem_l9> * 64,
<contenttweaker:spacetimeframework> * 256,
<contenttweaker:lightplatform> * 256,
<contenttweaker:shroudchunk> * 16
  ])
  .addOutputs([
   <contenttweaker:phantom_calculation_array>
  ])
  .requireResearch("Mega-ShroudNeedle")
  .requireComputationPoint(800000.0)
  .build();

      RecipeBuilder.newBuilder("crystal_otherworld","basic_zeropressure",40)
  .addEnergyPerTickInput(160000000)
  .addInputs([
   <liquid:crystalloidneutron>*288000,
   <liquid:fluidedmana>*1000,
   <contenttweaker:crystalred>*6,
   <contenttweaker:crystalgreen>*6,
   <contenttweaker:crystalpurple>*6
  ])
  .addOutputs([
   <additions:novaextended-crystal4>
  ])
  .build();

      RecipeBuilder.newBuilder("zp_upgrade_make","basic_zeropressure",40)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 1024;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <liquid:tachyonfluid>*1600,
   <liquid:spaceframefluid>*1600,
   <contenttweaker:darkmatters>*8,
   <contenttweaker:fieldofgravitycore>*32,
   <contenttweaker:voidmatter>*64,
   <contenttweaker:arkchip>
  ])
  .addOutputs([
   <contenttweaker:zp_upgrade>*16
  ])
    .addRecipeTooltip("在低能区域制造一种特殊的时空操纵装置")
  .addRecipeTooltip("该配方的并行上限为1024")
  .build();

        RecipeBuilder.newBuilder("charged_fuel_v1_zp_make","basic_zeropressure",100)
                .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 1024;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <liquid:pyrotheum>*25600,
   <liquid:liquid_energy>*4000,
   <contenttweaker:fieldofgravitycore>,
   <contenttweaker:gama_tialcoil>*8,
   <contenttweaker:energized_fuel_v1>
  ])
  .addOutputs([
   <contenttweaker:charged_fuel_v1>
  ])
    .addRecipeTooltip("革新的升级版燃料")
    .addRecipeTooltip("该配方的并行上限为1024")
  .build();

          RecipeBuilder.newBuilder("charged_fuel_v2_zp_make","basic_zeropressure",100)
                          .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 1024;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <liquid:plasma>*25600,
   <liquid:liquid_energy>*5000,
   <contenttweaker:fieldofgravitycore>*2,
   <contenttweaker:gama_tialcoil>*16,
   <contenttweaker:energized_fuel_v2>
  ])
  .addOutputs([
   <contenttweaker:charged_fuel_v2>
  ])
      .addRecipeTooltip("革新的升级版燃料")
    .addRecipeTooltip("该配方的并行上限为1024")
  .build();

            RecipeBuilder.newBuilder("charged_fuel_v3_zp_make","basic_zeropressure",100)
                            .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 1024;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <liquid:chaotic_metal>*1000,
   <liquid:liquid_energy>*6000,
   <contenttweaker:fieldofgravitycore>*4,
   <contenttweaker:gama_tialcoil>*32,
   <contenttweaker:energized_fuel_v3>
  ])
  .addOutputs([
   <contenttweaker:charged_fuel_v3>
  ])
      .addRecipeTooltip("革新的升级版燃料")
    .addRecipeTooltip("该配方的并行上限为1024")
  .build();

            RecipeBuilder.newBuilder("charged_fuel_v4_zp_make","basic_zeropressure",100)
                            .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <liquid:crystalloid>*10000,
   <liquid:liquid_energy>*10000,
   <contenttweaker:fieldofgravitycore>*8,
   <contenttweaker:gama_tialcoil>*16,
   <contenttweaker:energized_fuel_v4>
  ])
  .addOutputs([
   <contenttweaker:charged_fuel_v4>
  ])
      .addRecipeTooltip("革新的升级版燃料")
    .addRecipeTooltip("该配方的并行上限为1024")
  .build();

              RecipeBuilder.newBuilder("charged_fuel_v5_zp_make","basic_zeropressure",100)
                              .addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(16000000)
  .addInputs([
   <contenttweaker:gama_tialcoil>*64,
   <contenttweaker:neutrondustingot>*32,
   <contenttweaker:planetoflight>*8,
   <contenttweaker:voidmatter>*16
  ])
  .addOutputs([
   <contenttweaker:charged_fuel_v5>
  ])
      .addRecipeTooltip("革新的升级版燃料")
    .addRecipeTooltip("该配方的并行上限为1024")
  .build();
  //强化通用合金
RecipeBuilder.newBuilder("universalalloy_zeropressure", "atomic_reconstructor", 1200)
    .addEnergyPerTickInput(400000000)
    .addFluidInputs(<liquid:crystalloid> * 2000) 
    .addInputs(<contenttweaker:universalalloyt1> * 16)
    .addInputs(<thermalfoundation:material:165> * 4)  
    .addInputs(<thermalfoundation:material:166> * 4) 
    .addInputs(<thermalfoundation:material:167> * 4) 
    .addInputs(<additions:novaextended-ingot8> * 4) 
    .addInputs(<additions:novaextended-psi_alloy> * 4)
    .addInputs(<futuremc:netherite_ingot> * 4)
    .addInputs(<enderio:item_alloy_endergy_ingot:3> * 4)
    .addInputs(<tconevo:metal:40> * 4)
    .addInputs(<tconevo:metal:35> * 4) 
    .addOutputs(<contenttweaker:universalalloyt2> * 16)
    .build();

RecipeBuilder.newBuilder("antimattercore_zeropressure", "atomic_reconstructor", 1200)
    .addEnergyPerTickInput(400000000)
    .addInputs([<mekanism:antimatterpellet>*16,
    <liquid:dimensionbeam>*1000,
    <contenttweaker:voidmatter>*4,
    ])
    .addOutput(<contenttweaker:antimatter_core>)
    .addRecipeTooltip("制造反物质核心")
    .build();
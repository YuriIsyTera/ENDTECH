import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.hypernet.HyperNetHelper;
MachineModifier.setMaxThreads("spacetime_gestalt",0);
MachineModifier.addCoreThread("spacetime_gestalt",FactoryRecipeThread.createCoreThread("蜂群组装阵列"));
MachineModifier.addCoreThread("spacetime_gestalt",FactoryRecipeThread.createCoreThread("催化反应容器"));
MachineModifier.addCoreThread("spacetime_gestalt",FactoryRecipeThread.createCoreThread("精细制程阵列"));
RecipeBuilder.newBuilder("gestalt_controllerMAKE","atomicprocessequipx",3600,4)
    .addEnergyPerTickInput(500000000)
    .addInputs([
      <modularmachinery:life_extracts_altar_controller>,
      <modularmachinery:workshop_factory_controller>*4,
      <modularmachinery:spirit_forge_factory_controller>*4,
      <modularmachinery:soul_fabrication_ritual_builder_controller>*4,
      <contenttweaker:cfcm>*256,
      <contenttweaker:nanoglassmetal>*8,
      <contenttweaker:carbon_nanotube>*128,
      <contenttweaker:infinity_processor>*32,
      <contenttweaker:soul_core>,
      <contenttweaker:life_regeneration_core>*4
    ])
    .addFluidInputs([
      <liquid:lifeessence>*1000000,
    ])
    .addOutputs([
      <modularmachinery:spacetime_gestalt_factory_controller>
    ])
    .requireResearch("theory_nano_swarm")
    .requireComputationPoint(200000.0)
    .build();

RecipeBuilder.newBuilder("nano_swarm_create","spacetime_gestalt",100,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 64;
   })
   .addEnergyPerTickInput(100000000)
   .addInput(<contenttweaker:nanoswarm>).setChance(0)
   .addFluidInput(<liquid:t1000>*1000)
   .addInputs([
    <contenttweaker:nanites>*64,
    <contenttweaker:gama_tialcoil>*256,
   ])
   .addInputs([<contenttweaker:wisecore>]).setChance(0)
   .addOutputs(<contenttweaker:nanoswarm>*1)
   .addRecipeTooltip("通过原有的蜂群结构")
   .addRecipeTooltip("快速制造§7恒星级§c纳米蜂群")
   .addRecipeTooltip("该配方最高有64的并行")
   .setThreadName("蜂群组装阵列")
   .build();

RecipeBuilder.newBuilder("t1000_rapid_create","spacetime_gestalt",100,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 64;
   })
   .addEnergyPerTickInput(100000000)
   .addInput(<contenttweaker:nanoswarm>*128).setChance(0).setParallelizeUnaffected(true)
   .addFluidInputs([
    <liquid:crystalloid>*1280,
    <liquid:higgsfluid>*1280,
    <liquid:ic2uu_matter>*10000,
   ])
   .addInputs([
    <contenttweaker:exponential_level_processor>*1,
    <contenttweaker:lifesense_processor>*1,
    <threng:material:6>*16,
    <threng:material:14>*16,
   ])
   .addFluidOutput(<liquid:t1000>*10000)
   .addRecipeTooltip("让增殖介质与蜂群元件充分接触")
   .addRecipeTooltip("快速制造§7多边矩阵液态金属阵列")
   .addRecipeTooltip("该配方最高有64的并行")
   .setThreadName("催化反应容器")
   .build();

RecipeBuilder.newBuilder("mripcb_create","spacetime_gestalt",100,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
   })
   .addEnergyPerTickInput(100000000)
   .addFluidInputs([
    <liquid:bec>*1000
   ])
   .addInputs([
    <contenttweaker:weakmag>*4,
    <contenttweaker:nanoswarm>*1,
    <contenttweaker:nanites>*8,
    <additions:novaextended-ark_circuit>,
   ])
   .addOutput(<contenttweaker:mripcb>*64)
   .addRecipeTooltip("制造相对廉价粗糙的磁共振电路")
   .addRecipeTooltip("该配方最高有128的并行")
   .setThreadName("精细制程阵列")
   .build();
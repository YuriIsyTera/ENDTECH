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
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;
MachineModifier.setMaxThreads("prometheus",16);
MachineModifier.addCoreThread("prometheus",FactoryRecipeThread.createCoreThread("量子衰退"));
RecipeBuilder.newBuilder("quantum_recession","prometheus",1,1)
 .addEnergyPerTickInput(1000000)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
    <liquid:higgsfluid>*1
 ])
 .addFluidOutputs([
    <liquid:crystalloid>*100
 ])
 .addRecipeTooltip("该配方的并行上限为128")
 .setThreadName("量子衰退")
 .build();
RecipeBuilder.newBuilder("bec_recession","prometheus",10,1)
 .addEnergyPerTickInput(10000000)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 128;
 })
 .addFluidInputs([
    <liquid:bec>*1
 ])
 .addOutputs([
    <liquid:steady_ultra_dense_atomic_matter>*100,
    <liquid:neutronium>*100,
    <liquid:crystalloidneutron>*1000
 ])
 .addRecipeTooltip("该配方的并行上限为128")
  .setThreadName("量子衰退")
 .build();
 RecipeBuilder.newBuilder("energy_input_crystal1","prometheus",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=2048;
    event.activeRecipe.parallelism=2048;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000
 ])
 .addInputs([
    <contenttweaker:geocentric_crystal>
 ])
 .addOutputs([
    <contenttweaker:geocentric_quartz_crystal_charged>
 ])
 .addRecipeTooltip("该配方拥有2048并行")
 .build();
 RecipeBuilder.newBuilder("energy_input_crystal2","prometheus",50,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=2048;
    event.activeRecipe.parallelism=2048;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000
 ])
 .addInputs([
    <minecraft:emerald>*64
 ])
 .addOutputs([
    <contenttweaker:charging_crystal_block>
 ])
 .addRecipeTooltip("该配方拥有2048并行")

 .build();

  RecipeBuilder.newBuilder("energy_input_crystal","prometheus",50,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=2048;
    event.activeRecipe.parallelism=2048;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000
 ])
 .addInputs([
    <ebwizardry:magic_crystal>*3,
    <botania:manaresource:5>*8,
    <botania:manaresource:9>*8
 ])
 .addOutputs([
   <contenttweaker:mana_crystal_1>,
   <contenttweaker:mana_crystal_2>,
    <contenttweaker:mana_crystal_3>
 ])
 .addRecipeTooltip("该配方拥有2048并行")

 .build();

   RecipeBuilder.newBuilder("energy_input_cycrystal","prometheus",50,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=2048;
    event.activeRecipe.parallelism=2048;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000,
    <liquid:crystalloid>*800,
 ])
 .addInputs([
   <contenttweaker:mana_crystal_1>*3,
 ])
 .addOutputs([
   <contenttweaker:uu_crystal_1>,
   <contenttweaker:uu_crystal_2>,
    <contenttweaker:uu_crystal_3>
 ])
 .addRecipeTooltip("该配方拥有2048并行")

 .build();
 RecipeBuilder.newBuilder("energy_input_crystal3","prometheus",50,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=100;
    event.activeRecipe.parallelism=100;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000,
    <liquid:crystalloid>*2000,
 ])
 .addInputs([
    <ebwizardry:magic_crystal>,
    <botania:manaresource:5>,
    <botania:manaresource:9>
 ])
 .addOutputs([
    <contenttweaker:uu_crystal_3>
 ])
 .addRecipeTooltip("该配方拥有100并行")

 .build();

 RecipeBuilder.newBuilder("natites_activate","atomicprocessequipx",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=4096;
    event.activeRecipe.parallelism=4096;
 })
 .addEnergyPerTickInput(8000000)
 .addFluidInputs([
    <liquid:liquid_energy>*1000,
    <liquid:lifeessence>*10000,
 ])
 .addInputs([
   <contenttweaker:inactivenanites>,
   <deepmoblearning:living_matter_overworldian>*256,
   <deepmoblearning:living_matter_hellish>*256,
   <deepmoblearning:living_matter_extraterrestrial>*256,
   <deepmoblearning:living_matter_legend>*16,
 ])
 .addOutputs([
   <contenttweaker:nanites>
 ])
 .addRecipeTooltip("启动失活的纳米致动器")
 .addRecipeTooltip("该配方拥有4096并行")
 .build();

 
 RecipeBuilder.newBuilder("energy_input_crystalX","prometheus",50,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism=2048;
    event.activeRecipe.parallelism=2048;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000
 ])
 .addInputs([
    <minecraft:emerald_block>*7
 ])
 .addOutputs([
    <contenttweaker:charging_crystal>*63
 ])
 .addRecipeTooltip("该配方拥有2048并行")
  .build();
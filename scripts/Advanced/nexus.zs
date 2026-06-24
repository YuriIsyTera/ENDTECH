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
RecipeBuilder.newBuilder("nexus_ich_controllerMAKE","atomicprocessequipx",1800)
 .addEnergyPerTickInput(1000000)
 .addInputs([
    <modularmachinery:asteroidlockdevice_factory_controller>*4,
    <contenttweaker:mk2satellite>*256,
    <contenttweaker:mk2rocket>*256,
    <contenttweaker:mk2observer>*256,
    <contenttweaker:mk2oredrone>*256,
    <contenttweaker:charged_fuel_v5>*64,
    <contenttweaker:arkchip>
 ])
 .addOutput(<modularmachinery:nexus_ich_factory_controller>)
 .build();
RecipeBuilder.newBuilder("locked_planet_1_nexus","nexus_ich",200,1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16;
})
 .addEnergyPerTickInput(10000000000)
 .addInputs([
    <contenttweaker:normalplanet>*4,
    <contenttweaker:mripcb>*32,
    <contenttweaker:wisecore>,
    <contenttweaker:constructunit>*128,
    <contenttweaker:spacetime_lens>
 ])
 .addOutput(<contenttweaker:lockednormalplanet>*4)
 .addRecipeTooltip("成熟的深空工业体系让我们更轻易的掌握这些小型天体")
 .addRecipeTooltip("该配方拥有16并行")
 .build();

 RecipeBuilder.newBuilder("locked_planet_2_nexus","nexus_ich",200,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16;
})
 .addEnergyPerTickInput(10000000000)
 .addInputs([
    <contenttweaker:hellplanet>*4,
    <contenttweaker:mripcb>*32,
    <contenttweaker:wisecore>,
    <contenttweaker:constructunit>*128,
    <contenttweaker:spacetime_lens>
 ])
 .addOutput(<contenttweaker:lockedhellplanet>*4)
  .addRecipeTooltip("成熟的深空工业体系让我们更轻易的掌握这些小型天体")
 .addRecipeTooltip("该配方拥有16并行")
 .build();

  RecipeBuilder.newBuilder("locked_planet_3_nexus","nexus_ich",200,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism=16;
    event.activeRecipe.maxParallelism=16;
})
 .addEnergyPerTickInput(10000000000)
 .addInputs([
    <contenttweaker:enderplanet>*4,
    <contenttweaker:mripcb>*32,
    <contenttweaker:wisecore>,
    <contenttweaker:constructunit>*128,
    <contenttweaker:spacetime_lens>
 ])
 .addOutput(<contenttweaker:lockedenderplanet>*4)
  .addRecipeTooltip("成熟的深空工业体系让我们更轻易的掌握这些小型天体")
 .addRecipeTooltip("该配方拥有16并行")
 .build();
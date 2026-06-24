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
MachineModifier.setMaxThreads("east_tokamak",16);
RecipeBuilder.newBuilder("east_controller_MAKE","atomicprocessequipx",1800)
 .addEnergyPerTickInput(10000000)
 .addInputs([
    <mekanismgenerators:reactor>*4,
    <mekanismgenerators:reactor:1>*64,
    <modularmachinery:tokmak_reactor_controller>,
    <contenttweaker:superconidiosome>*16,
    <contenttweaker:field_generator_v2>*8,
    <contenttweaker:industrial_circuit_v3>*8
 ])
 .addOutput(<modularmachinery:east_tokamak_factory_controller>)
 .build();
RecipeBuilder.newBuilder("normal_plasma","east_tokamak",20,1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 32;
    event.activeRecipe.parallelism = 32;
})
 .addEnergyPerTickInput(1000000)
 .addInput(<minecraft:cobblestone>)
 .addOutput(<liquid:plasma>*1000)
 .addEnergyPerTickOutput(400000000)
 .addRecipeTooltip("该配方的并行上限为16")
 .build();

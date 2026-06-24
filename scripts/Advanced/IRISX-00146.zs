#loader crafttweaker reloadable
import crafttweaker.data.IData;
import crafttweaker.enchantments.IEnchantment;
import crafttweaker.item.IItemStack;
import mods.nuclearcraft.AlloyFurnace;
import moretweaker.draconicevolution.FusionCrafting;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import crafttweaker.item.IIngredient;
import crafttweaker.liquid.ILiquidStack;
import mod.mekanism.gas.IGasStack;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import crafttweaker.item.IItemDefinition;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.events.IEventManager;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import crafttweaker.event.EntityLivingDeathEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import crafttweaker.event.ItemTossEvent;
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.entity.IEntityItem;
import crafttweaker.world.IBlockPos;
import crafttweaker.util.Math;
import mods.thermalexpansion.InductionSmelter;
import mods.modularmachinery.Sync;
import crafttweaker.world.IWorld;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import novaeng.NovaEngUtils;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.RecipeTickEvent;

MachineModifier.setMaxThreads("test_irisx",10);

RecipeBuilder.newBuilder("mana_ingot_make","test_irisx",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*1)
 .addEnergyPerTickInput(1000)
 .addInput(<minecraft:iron_ingot>)
 .addOutput(<botania:manaresource>)
 .addRecipeTooltip("进行高效的魔力注入")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();

 RecipeBuilder.newBuilder("mana_pearl_make","test_irisx",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*1)
 .addEnergyPerTickInput(1000)
 .addInput(<minecraft:ender_pearl>)
 .addOutput(<botania:manaresource:1>)
 .addRecipeTooltip("进行高效的魔力注入")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();

 RecipeBuilder.newBuilder("mana_diamond_make","test_irisx",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*1)
 .addEnergyPerTickInput(1000)
 .addInput(<minecraft:diamond>)
 .addOutput(<botania:manaresource:2>)
 .addRecipeTooltip("进行高效的魔力注入")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();

 RecipeBuilder.newBuilder("mana_psi_make","test_irisx",20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*1)
 .addEnergyPerTickInput(1000)
 .addInput(<minecraft:gold_ingot>)
 .addOutput(<psi:material:1>)
 .addRecipeTooltip("进行高效的魔力注入")
 .addRecipeTooltip("什么?你说此魔力非彼魔力?")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();

 RecipeBuilder.newBuilder("mana_terra_make","test_irisx",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 2048;
 })
 .addFluidInput(<liquid:fluidedmana>*500)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <botania:manaresource>,
   <botania:manaresource:1>,
   <botania:manaresource:2>
 ])
 .addOutput(<botania:manaresource:4>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为2048")
 .build();

 RecipeBuilder.newBuilder("mana_orihax_make","test_irisx",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 2048;
 })
 .addFluidInput(<liquid:fluidedmana>*150)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <botania:manaresource:14>*2,
   <botania:manaresource:5>*4,
   <extrabotany:material:3>
 ])
 .addOutput(<extrabotany:material:1>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为2048")
 .build();

 
 RecipeBuilder.newBuilder("mana_shadow_make","test_irisx",10,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 2048;
 })
 .addFluidInput(<liquid:fluidedmana>*5)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <extrabotany:nightmarefuel>*3,
   <extrabotany:gildedmashedpotato>,
   <botania:livingrock>,
   <botania:manaresource:7>
 ])
 .addOutput(<extrabotany:material:5>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为4096")
 .build();

  RecipeBuilder.newBuilder("mana_light_make","test_irisx",10,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 2048;
 })
 .addFluidInput(<liquid:fluidedmana>*5)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <extrabotany:material>*3,
   <extrabotany:gildedmashedpotato>,
   <botania:livingrock>,
   <botania:manaresource:7>
 ])
 .addOutput(<extrabotany:material:8>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为4096")
 .build();

 RecipeBuilder.newBuilder("mana_potato_make","test_irisx",10,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*5)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <minecraft:potato>,
   <botania:livingrock>,
 ])
 .addOutput(<extrabotany:gildedmashedpotato>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();

  RecipeBuilder.newBuilder("mana_potato_spirit_fractures","test_irisx",10,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 65536;
 })
 .addFluidInput(<liquid:fluidedmana>*5)
 .addEnergyPerTickInput(1000)
 .addInputs([
   <minecraft:coal>
 ])
 .addOutput(<extrabotany:material>)
 .addRecipeTooltip("更高效的魔力聚合")
 .addRecipeTooltip("该配方的并行上限为65536")
 .build();
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
MachineModifier.setMaxThreads("tss_site",0);
for i in 1 to 15{
        MachineModifier.addCoreThread("tss_site", FactoryRecipeThread.createCoreThread("轨道磁场传导" + i));
}
 //ControllerMAKE
recipes.addShaped(<modularmachinery:tss_site_factory_controller>, [
    [<appliedenergistics2:material:41>, <appliedenergistics2:material:41>, <appliedenergistics2:material:41>],
    [<appliedenergistics2:material:47>, <appliedenergistics2:controller>, <appliedenergistics2:material:47>],
    [<mekanism:controlcircuit>, <appliedenergistics2:material:42>, <mekanism:controlcircuit>]
]);
RecipeBuilder.newBuilder("tss_level_1","tss_site",400)
 .addInput(<contenttweaker:mk1satellite_generator>).setChance(0.5)
 .addEnergyPerTickOutput(80000)
 .build();
 RecipeBuilder.newBuilder("tss_level_2","tss_site",400)
 .addInput(<contenttweaker:mk2satellite_generator>).setChance(0.5)
 .addEnergyPerTickOutput(400000)
 .build();
 RecipeBuilder.newBuilder("tss_level_3","tss_site",400)
 .addInput(<contenttweaker:mk3satellite_generator>).setChance(0.5)
 .addEnergyPerTickOutput(1000000)
 .build();
 RecipeBuilder.newBuilder("tss_level_4","tss_site",400)
 .addInput(<contenttweaker:mk4satellite_generator>).setChance(0.5)
 .addEnergyPerTickOutput(8000000)
 .build();
  RecipeBuilder.newBuilder("tss_level_5","tss_site",400)
 .addInput(<contenttweaker:mk5satellite_generator>).setChance(0.3)
 .addEnergyPerTickOutput(100000000)
 .build();
   RecipeBuilder.newBuilder("tss_level_6","tss_site",400)
 .addInput(<contenttweaker:mk6satellite_generator>).setChance(0.2)
 .addEnergyPerTickOutput(400000000)
 .build();
    RecipeBuilder.newBuilder("tss_level_7","tss_site",800)
 .addInput(<contenttweaker:mk7satellite_generator>).setChance(0.1)
 .addEnergyPerTickOutput(100000000000)
 .build();

     RecipeBuilder.newBuilder("tss_level_8","tss_site",800)
 .addInput(<contenttweaker:mk8satellite_generator>).setChance(0.1)
 .addEnergyPerTickOutput(100000000000)
 .build();

 //level1
recipes.addShaped(<contenttweaker:mk1satellite_generator>, [
    [<minecraft:leaves>, <minecraft:log>, <minecraft:leaves>],
    [<minecraft:leaves>, <mekanism:controlcircuit>, <minecraft:leaves>],
    [<minecraft:leaves>, <minecraft:log>, <minecraft:leaves>]
]);
//level2
recipes.addShaped(<contenttweaker:mk2satellite_generator>, [
    [<thermalfoundation:material:33>, <minecraft:stone>, <thermalfoundation:material:33>],
    [<appliedenergistics2:material:22>, <mekanism:controlcircuit:1>, <appliedenergistics2:material:22>],
    [<ic2:plate:11>, <minecraft:stone>, <ic2:plate:11>]
]);
//level3
recipes.addShaped(<contenttweaker:mk3satellite_generator>, [
    [<mets:niobium_titanium_plate>, <super_solar_panels:crafting:9>, <mets:niobium_titanium_plate>],
    [<moreplates:empowered_emeradic_plate>, <contenttweaker:industrial_circuit_v1>, <moreplates:empowered_emeradic_plate>],
    [<mets:niobium_titanium_plate>, <super_solar_panels:crafting:9>, <mets:niobium_titanium_plate>]
]);
//level4
recipes.addShaped(<contenttweaker:mk4satellite_generator>, [
    [<avaritia:resource:1>, <moreplates:refined_obsidian_plate>, <avaritia:resource:1>],
    [<threng:material:14>, <mekanism:controlcircuit:3>,<threng:material:14>],
    [<avaritia:resource:1>, <moreplates:refined_obsidian_plate>, <avaritia:resource:1>]
]);
//level5
RecipeBuilder.newBuilder("mk5satellite_generator_MAKE","precisecomplex",400)
 .addEnergyPerTickInput(10000000)
 .addInputs([
    <contenttweaker:industrial_circuit_v2>*4,
    <moreplates:neutronium_plate>*16,
    <contenttweaker:robot_arm_v3>*4,
    <contenttweaker:charging_crystal>,
    <contenttweaker:degenerationmatter>*128,
    <contenttweaker:synthesischip>
 ])
 .addOutputs(<contenttweaker:mk5satellite_generator>*4)
 .build();

 //level6
RecipeBuilder.newBuilder("mk6satellite_generator_MAKE","precisecomplex",400)
 .addEnergyPerTickInput(80000000)
 .addInputs([
    <eternalsingularity:eternal_singularity>,
    <contenttweaker:charging_crystal_block>*4,
    <contenttweaker:field_generator_v1>*32,
    <liquid:crystalloid>*1000
 ])
 .addOutputs(<contenttweaker:mk6satellite_generator>*4)
 .build();

 //level7
RecipeBuilder.newBuilder("mk7satellite_generator_MAKE","atomicprocessequipx",400)
 .addEnergyPerTickInput(200000000)
 .addInputs([
    <avaritiatweaks:enhancement_crystal>*4,
    <contenttweaker:crystalchip>,
    <avaritia:resource:6>*4,
    <contenttweaker:industrial_circuit_v3>,
    <contenttweaker:field_generator_v3>*2
 ])
 .addOutputs(<contenttweaker:mk7satellite_generator>*4)
 .build();

  //level8
RecipeBuilder.newBuilder("mk8satellite_generator_MAKE","atomicprocessequipx",400)
 .addEnergyPerTickInput(10000000000)
 .addInputs([
    <additions:novaextended-ark_circuit>*4,
    <contenttweaker:neutronchip>,
    <contenttweaker:tyf3>*8,
    <additions:novaextended-star_ingot>*16,
    <contenttweaker:industrial_circuit_v4>,
    <contenttweaker:robot_arm_v5>*4,
    <contenttweaker:antimatter_core>
 ])
 .addOutputs(<contenttweaker:mk8satellite_generator>*4)
 .build();
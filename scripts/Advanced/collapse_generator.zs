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
MachineModifier.setMaxThreads("collapse_generator",0);
MachineModifier.addCoreThread("collapse_generator",FactoryRecipeThread.createCoreThread("奇点生成装置").addRecipe("darkmatter_output"));
MachineModifier.addCoreThread("collapse_generator",FactoryRecipeThread.createCoreThread("稳态撕裂装置").addRecipe("break_space"));
MachineModifier.addCoreThread("collapse_generator",FactoryRecipeThread.createCoreThread("异界操纵装置").addRecipe("other_world_cgne"));
RecipeBuilder.newBuilder("darkmatter_output","collapse_generator",400,1)
.addEnergyPerTickInput(10000000)
 .addInputs([
    <eternalsingularity:eternal_singularity>*512,
    <avaritia:resource:4>*186,
    <enderio:item_material:20>*628,
    <contenttweaker:degenerationmatter>*178,
    <contenttweaker:fieldofgravitycore>*8,
    <contenttweaker:spacetimeframework>*8
 ])
 .addOutput(<contenttweaker:darkmatters>)
 .addOutput(<avaritia:singularity>*256).setChance(0.1)
 .addOutput(<avaritia:singularity:2>*256).setChance(0.1)
  .addOutput(<avaritia:singularity:3>*256).setChance(0.1)
 .addOutput(<avaritia:singularity:4>*256).setChance(0.1)
  .addOutput(<avaritia:singularity:5>*256).setChance(0.1)
.addOutput(<avaritia:singularity:6>*256).setChance(0.1)
.addOutput(<avaritia:singularity:7>*256).setChance(0.1)
.addOutput(<avaritia:singularity:8>*256).setChance(0.1)
.addOutput(<avaritia:singularity:9>*256).setChance(0.1)
.addOutput(<avaritia:singularity:10>*256).setChance(0.1)
.addOutput(<avaritia:singularity:11>*256).setChance(0.1)
.addOutput(<avaritia:singularity:12>*256).setChance(0.1)
.addOutput(<avaritia:singularity:13>*256).setChance(0.1)
.addOutput(<avaritia:singularity:14>*256).setChance(0.1)
.setThreadName("奇点生成装置")
.addRecipeTooltip("放弃了天幕引擎那充满风险的运行方式")
.addRecipeTooltip("我们选择了一种更为保守的方式来产出暗物质")
.build();

RecipeBuilder.newBuilder("break_space","collapse_generator",200,2)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 64;
   event.activeRecipe.parallelism = 64;
})
 .addEnergyPerTickInput(100000000)
 .addInput(<contenttweaker:darkmatters>).setChance(0.1).setParallelizeUnaffected(true)
 .addInput(<contenttweaker:degenerationmatter>*124)
 .addInput(<contenttweaker:voidmatter>).setChance(0.1).setParallelizeUnaffected(true)
 .addOutputs([
   <liquid:tachyonfluid>*500,
   <liquid:spaceframefluid>*500,
 ])
 .setThreadName("稳态撕裂装置")
 .addRecipeTooltip("使用低功率的天幕引擎量产机产出流体")
 .addRecipeTooltip("该配方的并行上限为64")
 .build();

 RecipeBuilder.newBuilder("other_world_cgne","collapse_generator",200,2)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 64;
   event.activeRecipe.parallelism = 64;
})
 .addEnergyPerTickInput(10000000)
 .addInputs([
   <liquid:dimensionbeam>*1000,
   <mekanism:antimatterpellet>*2
 ])
 .addInputs([
   <additions:novaextended-crystal4>
 ]).setChance(0.1).setParallelizeUnaffected(true)
 .addOutputs([
   <contenttweaker:crystalred>*64,
   <contenttweaker:crystalpurple>*64,
   <contenttweaker:crystalgreen>*64
 ])
 .setThreadName("异界操纵装置")
 .addRecipeTooltip("更温和的引导时空束流与异世界水晶反应")
 .addRecipeTooltip("该配方的并行上限为64")
 .build();
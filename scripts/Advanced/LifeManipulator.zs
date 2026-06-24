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
MachineModifier.setMaxThreads("lifemanipulator",0);
MachineModifier.addCoreThread("lifemanipulator",FactoryRecipeThread.createCoreThread("生命链接维系单元"));
MachineModifier.addCoreThread("lifemanipulator",FactoryRecipeThread.createCoreThread("源质转移"));
RecipeBuilder.newBuilder("lifemanipulator_controller_MAKE","atomicprocessequipx",3600)
  .addEnergyPerTickInput(36000000)
  .addInputs([
    <modularmachinery:mm_altar_factory_controller>*8,
    <deepmoblearningbm:digital_agonizer>*64,
    <bloodmagic:slate:4>*128,
    <bloodmagic:altar>*16,
    <bloodmagic:blood_rune>*256,
    <contenttweaker:crystalmatrixforcefieldcontrolblock>*4,
    <contenttweaker:fallenstarforcefieldcontrolblock>*4,
    <contenttweaker:universalforcefieldcontrolblock>*4,
    <liquid:lifeessence>*36888,
  ])
  .requireComputationPoint(2000.0)
  .addOutput(<modularmachinery:lifemanipulator_factory_controller>)
  .build();
RecipeBuilder.newBuilder("connect_maintain_LM","lifemanipulator",3600)
   .addInputs(<bloodmagic:sacrificial_dagger:1>).setChance(0)
   .setThreadName("生命链接维系单元")
   .addRecipeTooltip("维系创造匕首与设备的生命链接")
   .build();
function registerLM(input as IItemStack,output as IItemStack,index as int,time as int,inputcount as int,outputcount as int){
    MachineModifier.addCoreThread("lifemanipulator",FactoryRecipeThread.createCoreThread("生灵操纵结构"+index));
    RecipeBuilder.newBuilder("lifemanipulator_recipe"+index,"lifemanipulator",time)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("链接单元未在线");
        }else{
            event.activeRecipe.maxParallelism = 4096;
        }
    })
    .addInput(input*inputcount)
    .addOutput(output*outputcount)
    .setThreadName("生灵操纵结构"+index)
    .addRecipeTooltip("利用创造匕首的庞大生命能量进行快速合成")
    .addRecipeTooltip("当生命链接维系单元在线时可以执行")
    .addRecipeTooltip("该配方最高拥有4096并行")
    .build();
}
RecipeBuilder.newBuilder("lifessence_output_LM","lifemanipulator",100)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        event.setFailed("链接单元未在线");
    }
 })
 .addOutputs(<liquid:lifeessence>*65536)
 .addOutput(<draconicevolution:mob_soul>*16)
 .addRecipeTooltip("持续转移创造匕首中的生命源质")
 .setThreadName("源质转移")
 .build();

registerLM(<contenttweaker:yunshi>,<contenttweaker:cxyunshi>,1,500,1,1);
registerLM(<mets:nano_living_metal>,<botania:manaresource:7>,2,20,1,1);
registerLM(<extrabotany:material:1>,<extrabotany:material:3>,3,10,1,1);
registerLM(<botania:manaresource:1>,<appliedenergistics2:material:9>,4,20,1,1);
registerLM(<bloodmagic:decorative_brick>,<bloodmagic:blood_shard>,5,20,1,4);
registerLM(<bloodmagic:decorative_brick:2>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:transcendent"}),6,200,1,1);
registerLM(<minecraft:diamond>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:weak"}),7,200,1,1);
registerLM(<minecraft:nether_star>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:archmage"}),8,200,1,1);
registerLM(<minecraft:stone>,<bloodmagic:slate>,9,20,1,1);
registerLM(<bloodmagic:slate>,<bloodmagic:slate:1>,10,40,1,1);
registerLM(<bloodmagic:slate:1>,<bloodmagic:slate:2>,11,60,1,1);
registerLM(<minecraft:gold_block>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:magician"}),12,200,1,1);
registerLM(<bloodmagic:slate:2>,<bloodmagic:slate:3>,13,80,1,1);
registerLM(<bloodmagic:blood_shard>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:master"}),14,200,1,1);
registerLM(<bloodmagic:lava_crystal>,<bloodmagic:activation_crystal>,15,200,1,1);
registerLM(<minecraft:redstone_block>,<bloodmagic:blood_orb>.withTag({orb: "bloodmagic:apprentice"}),16,200,1,1);
registerLM(<deepmoblearning:glitch_infused_ingot>,<deepmoblearningbm:blood_infused_glitch_ingot>,17,40,1,1);
registerLM(<bloodmagic:slate:3>,<bloodmagic:slate:4>,18,100,1,1);
registerLM(<tconevo:material>,<tconevo:metal:25>,19,20,1,1);
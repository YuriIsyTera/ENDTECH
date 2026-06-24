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
RecipeBuilder.newBuilder("bio_cube_MAKE","mach_crafter",1200,1)
 .addEnergyPerTickInput(4000)
 .addInputs([
    <enderio:block_killer_joe>*4,
    <modularmachinery:blockcasing>*8,
    <contenttweaker:industrial_circuit_v1>*16,
    <contenttweaker:robot_arm_v1>*32,
    <minecraft:glass_bottle>*64
 ])
 .addOutput(<modularmachinery:bio_cube_factory_controller>)
 .build();
 
MachineModifier.setMaxThreads("bio_cube",0);
MMEvents.onStructureFormed("bio_cube" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var para1 = ctrl.getBlocksInPattern(<modularmachinery:blockparallelcontroller>);
    var para2 = ctrl.getBlocksInPattern(<modularmachinery:blockparallelcontroller:1>);
    var para3 = ctrl.getBlocksInPattern(<modularmachinery:blockparallelcontroller:2>);
    var para4 = ctrl.getBlocksInPattern(<modularmachinery:blockparallelcontroller:3>);
    var para5 = ctrl.getBlocksInPattern(<modularmachinery:blockparallelcontroller:4>);
    if(para1 == 1){
        map["para"]=4;
        ctrl.customData = data;
    }
    if(para2 == 1){
        map["para"]=16;
        ctrl.customData = data;
    }
    if(para3 == 1){
        map["para"]=64;
        ctrl.customData = data;
    }
    if(para4 == 1){
        map["para"]=256;
        ctrl.customData = data;
    }
    if(para5 == 1){
        map["para"]=512;
        ctrl.customData = data;
    }
    ctrl.customData = data;
});
function bio(input as IIngredient[], output as IIngredient[],id as string,counter as int){
    MachineModifier.addCoreThread("bio_cube", FactoryRecipeThread.createCoreThread("生命拟造"+counter));
    RecipeBuilder.newBuilder("bio"+id,"bio_cube",40,counter)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val para = data.getInt("para",4);
        event.activeRecipe.maxParallelism = para;
        event.activeRecipe.parallelism = para;
    })
     .addEnergyPerTickInput(10000)
     .addFluidInput(<liquid:water>*100)
     .addInputs(input).setChance(0).setParallelizeUnaffected(true)
     .addOutputs(output)
     .addRecipeTooltip("该配方并行上限由并行仓决定")
     .addRecipeTooltip("使用前请先在工作台清除灵魂瓶多余NBT")
     .setThreadName("生命拟造"+counter)
     .build();
}
var counter = 1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:zombie"})],[<minecraft:rotten_flesh>*8,<minecraft:carrot>*4,<minecraft:skull:2>,<minecraft:iron_ingot>,<minecraft:potato>*4,<tconstruct:edible:10>*8],"zombie",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:skeleton"})],[<minecraft:bone>*8,<minecraft:skull>,<minecraft:arrow>*16],"skeleton",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:blaze"})],[<minecraft:blaze_rod>*8,<thermalfoundation:material:771>*8],"blaze",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:enderman"})],[<minecraft:ender_pearl>*16,<enderio:item_material:16>*8,<enderio:block_enderman_skull>],"enderman",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:ghast"})],[<minecraft:ghast_tear>*4],"ghast",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:guardian"})],[<minecraft:prismarine_shard>*16,<minecraft:prismarine_crystals>*16,<minecraft:fish>*8],"guardian",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:shulker"})],[<minecraft:shulker_shell>*8,<minecraft:diamond>*16],"shulker",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:slime"})],[<minecraft:slime_ball>*16,<tconstruct:edible:1>*16,<tconstruct:edible:2>*16,<tconstruct:edible:4>*16],"slime",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:spider"})],[<minecraft:spider_eye>*8,<minecraft:web>*4,<minecraft:string>*16],"spider",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:witch"})],[<minecraft:redstone>*16,<minecraft:glowstone_dust>*16,<minecraft:sugar>*16],"witch",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:pig"})],[<minecraft:porkchop>*8],"pig",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:sheep"})],[<minecraft:chicken>*8,<minecraft:feather>*8],"chicken",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "thermalfoundation:blizz"})],[<thermalfoundation:material:2048>*16],"blizz",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:cow"})],[<minecraft:beef>*16,<minecraft:leather>*8],"cow",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:villager"})],[<minecraft:emerald>*16],"villager",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:magma_cube"})],[<minecraft:magma_cream>*16],"magma_cube",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:wither_skeleton"})],[<minecraft:nether_star>*16,<minecraft:coal>*16,<minecraft:skull:1>],"wither_skeleton",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "ancientspellcraft:void_creeper"})],[<ebwizardry:crystal_shard>*16,<ebwizardry:magic_crystal>*8,<ebwizardry:grand_crystal>],"void_creeper",counter);counter+=1;
bio([<additions:novaextended-novaextended_medal4>],[<harvestcraft:venisonrawitem>*8,<harvestcraft:duckrawitem>*8,<harvestcraft:turkeyrawitem>*8,<minecraft:rabbit>*8],"meat",counter);counter+=1;
bio([<enderio:item_soul_vial:1>.withTag({entityId: "minecraft:creeper"})],[<minecraft:gunpowder>*8],"creeper",counter);counter+=1;








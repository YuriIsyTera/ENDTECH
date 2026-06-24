//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;
import crafttweaker.event.BlockBreakEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.block.IBlock;
import crafttweaker.player.IPlayer;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerInteractBlockEvent;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;


var recipeCounter = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//阿努比斯
RecipeBuilder.newBuilder("wallcrea-13", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val anb = data.getInt("anb",0);
        if(anb == 0){
            event.setFailed("未找到阿努比斯");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_f>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "environmentalmaterials:basalt", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "environmentaltech:aethium", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:mob_soul", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:rotten_flesh", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:spider_eye", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:string", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:gunpowder", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:bone", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:egg", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leather", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:feather", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:chicken", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:porkchop", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:beef", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:mutton", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:rabbit", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:rabbit_foot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:fish", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:rabbit_hide", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:fish", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:fish", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:fish", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:treasurebox", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:material", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:failnaught", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:camera", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:excaliber", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:achilleshield", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:spearsubspace", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:silenteternity", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:buddhistrelics", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:firstfractal", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extrabotany:judahoath", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonearsenal:storage", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:level_infinity_orb", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§6阿努比斯之力")
    .addRecipeTooltip("§6死神之力。")
    .addRecipeTooltip("§6死亡本是宿命的唯一终点，可先贤的意志始终不灭。")
    .addRecipeTooltip("§6意志超越了死亡，超越早已注定的未来走向，将这份力量交付于你手中。")
    .setThreadName("阿努比斯创生")
    .build();
recipeCounter += 1;

//马赫斯
RecipeBuilder.newBuilder("wallcrea-14", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mhb = data.getInt("mhb",0);
        if(mhb == 0){
            event.setFailed("未找到马赫斯");
        }
    })
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_a>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:yellow_flower", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 2, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 4, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 5, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 7, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_flower", Damage: 8, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:double_plant", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:double_plant", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:double_plant", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:double_plant", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:lily_of_the_valley", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:cornflower", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:brown_mushroom", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_mushroom", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "botania:specialflower", Count: 1, tag: {type: "asgardandelion"}, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:redstone_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:lapis_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§3马赫斯之力")
    .addRecipeTooltip("§3美妙之色彩")
    .addRecipeTooltip("§3已死的色彩，我刚刚已重新造就。")
    .setThreadName("马赫斯创生")
    .build();
recipeCounter += 1;

//荷鲁斯
RecipeBuilder.newBuilder("wallcrea-15", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val hob = data.getInt("hob",0);
        if(hob == 0){
            event.setFailed("未找到荷鲁斯");
        }
    })
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_b>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritia:block_resource", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritia:resource", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritia:resource", Damage: 3, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritia:resource", Damage: 2, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritiaio:grindingballneutronium", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 4, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 5, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 164, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 165 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 166 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 160 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 3, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 13 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:atomicalloy", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 27 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 29 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 26 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "super_solar_panels:crafting", Damage: 28 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "crystalloid", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "ic2uu_matter", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "universal_metal", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconevo:metal", Damage: 40 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconevo:metal", Damage: 41 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconevo:metal_block", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:universalalloyt2", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:material", Damage: 32 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:universalalloyt3", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:creative_energy_cell", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:uu_crystal_1", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:uu_crystal_2", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:uu_crystal_3", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:charging_crystal", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:charging_crystal_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§5荷鲁斯之力")
    .addRecipeTooltip("§5无穷无尽之重量，无限奇异之世界。")
    .addRecipeTooltip("§5不可变更之美丽，极致精彩之星际。")
    .setThreadName("荷鲁斯创生")
    .build();
recipeCounter += 1;

//赛特
RecipeBuilder.newBuilder("wallcrea-16", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val seb = data.getInt("seb",0);
        if(seb == 0){
            event.setFailed("未找到赛特");
        }
    })
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_c>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:snow", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:blue_ice", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:supercold_ice", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:storage", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:material", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:storage", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "thermalfoundation:storage", Count: 1, Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 1025 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "cryotheum", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:mana_crystal_1", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:mana_crystal_2", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:mana_crystal_3", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:quartz_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:quartz_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 10 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:fluix_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 12 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 9 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:controller", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:drive", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:interface", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:fluid_interface", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ae2fc:dual_interface", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:quantum_ring", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:quantum_link", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ae2fc:ultimate_encoder", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:quartz_glass", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 39 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 47 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:part", Damage: 16 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:part", Damage: 36 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:part", Damage: 516 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:part", Damage: 76 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:part", Damage: 140 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:interface", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§b赛特之力")
    .addRecipeTooltip("§b寒霜之涸，风暴权柄")
    .addRecipeTooltip("§b如若世间争乱不休，我会带来寂静。")
    .setThreadName("赛特创生")
    .build();
recipeCounter += 1;

//漆黑世界
RecipeBuilder.newBuilder("wallcrea-18", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val ddb = data.getInt("ddb",0);
        if(ddb == 0){
            event.setFailed("未找到漆黑世界");
        }
    })
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_d>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0, Cnt: 1, id: "astralsorcery:itemperkgem", tag: {astralsorcery: {modifiers: [{mode: 1, baseValue: 0.0 as float, mId: 5742 as long, type: "astralsorcery.liferecovery", idMost: -8753875956501492003 as long, idLeast: -6945354675646213299 as long}]}, HideFlags: 63, display: {Lore: ["§6与任意工具或武器合成以获取无法破坏词条", "§6不会被消耗"], Name: "§6亘古不灭星魂"}}, Count: 1, Damage: 1, Req: 0}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:eclipse_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:storage", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "thermalfoundation:storage", Count: 1, Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 1025 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "cryotheum", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:crystalpurple", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:crystalgreen", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:crystalred", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:gama_tialalloy", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("Surmount-UTS-004")
    .addRecipeTooltip("§0所有漆黑的世界")
    .addRecipeTooltip("§0否定意义，超脱一切。")
    .addRecipeTooltip("§0黑暗无边无际，灭绝如诗婉转。")
    .addRecipeTooltip("§0我走在战胜的路上，一次又一次，于毁灭中燃烧。")
    .addRecipeTooltip("§6这一次也请点燃吧...点燃我的身躯，让这光芒为你而闪耀")
    .setThreadName("漆黑世界创生")
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("wallcrea-oct", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val oct = data.getInt("oct",0);
        if(oct == 0){
            event.setFailed("未找到十月喵");
        }
    })
    .addInput(<contenttweaker:advanced_programming_circuit_f>)
    .addInput(<contenttweaker:programming_circuit_f>)
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "avaritia:resource", Count: 1 as byte, Damage: 5 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "avaritia:resource", Count: 1 as byte, Damage: 6 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "avaritia:block_resource", Count: 1 as byte, Damage: 1 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "avaritiaio:infinitecapacitor", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "avaritiatweaks:enhancement_crystal", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:infinity_processor", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "additions:novaextended-star_ingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "tconevo:metal", Count: 1 as byte, Damage: 5 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:energized_fuel_v4", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "ic2:crafting", Count: 1 as byte, Damage: 3 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:superluminal_core", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:gama_tialalloy", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:spacematrix_ingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:neutrondustingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:superconidiosome", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:planetoflight", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:octingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:nova_ingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:universalalloyt1", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:universalalloyt2", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:universalalloyt3", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "additions:novaextended-blue_alloy_ingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "additions:novaextended-fallen_star_alloy", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "additions:novaextended-psi_alloy", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "additions:novaextended-terraalloy", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "taiga:adamant_ingot", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:hypernet_ram_t5", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:hypernet_ram_max", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:hypernet_cpu_t4", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:hypernet_gpu_t3", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:hypernet_gpu_max", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:planet_ff", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "eternalsingularity:eternal_singularity", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:ljgz", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:industrial_circuit_v3", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:industrial_circuit_v4", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:industrial_circuit_v5", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:robot_arm_v4", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:sensor_v4", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:robot_arm_v5", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "contenttweaker:sensor_v5", Count: 1 as byte, Damage: 0 as short, Req: 0 as long}, t: "i"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "plasma", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "unsteady_plasma", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "steady_ultra_dense_atomic_matter", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "crystalloidneutron", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "anti_neutron", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "neutronium", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "infinity_metal", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "ark", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "draconic_metal", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
.addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "chaotic_metal", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
    .requireResearch("Surmount-UTS-004")
    .addRecipeTooltip("#fffc00-abfd00-48ff00宇宙无序，不能公正。")
    .addRecipeTooltip("#fffc00-abfd00-48ff00任由光明漂泊，苦难变成大多数...")
    .addRecipeTooltip("#fffc00-abfd00-48ff00§7...没错，§4举 目 绝 望")
    .addRecipeTooltip("#fffc00-abfd00-48ff00可尽管希望已死，我也终会找出答案。")
    .addRecipeTooltip("#fffc00-abfd00-48ff00一切苦难，一切悲苦，一切苍凉，一切哀伤...我必将战胜。")
    .addRecipeTooltip("§8......我知道了，你所留下的话...你的样子，我会尽数记下的。")
    .setThreadName("十月之创生")
    .build();
recipeCounter += 1;
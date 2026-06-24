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

//水星
RecipeBuilder.newBuilder("wallcrea-5", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val meb = data.getInt("meb",0);
        if(meb == 0){
            event.setFailed("未找到水星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_e>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:ice", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:packed_ice", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "biomesoplenty:hard_ice", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:iron_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "iron", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "ice", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§9水星之力")
    .addRecipeTooltip("§9诶？你不知道吗？")
    .addRecipeTooltip("§9虽然名为水星，但它的表层可都是冰山哦！")
    .addRecipeTooltip("§9小小的体积，却是最接近太阳的行星，真是英勇而可爱！")
    .addRecipeTooltip("§9顺便一提，它真是解决了一些当下必要的问题啊！")
    .setThreadName("水星创生")
    .build();
recipeCounter += 1;

//火星
RecipeBuilder.newBuilder("wallcrea-6", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mab = data.getInt("mab",0);
        if(mab == 0){
            event.setFailed("未找到火星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_f>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:hotturf", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot", Damage: 15 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:dust", Damage: 15 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot_block", Damage: 15 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:dust", Damage: 13 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:alloy", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "carbon_dioxide", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "manganese_dioxide", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 1, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§c火星之力")
    .addRecipeTooltip("§c变晨搅宙，凡惑唯此！")
    .addRecipeTooltip("§c吞渺还星，行寂空孤。")
    .addRecipeTooltip("§c变化吧，变化吧！于夜空之中闪耀吧！")
    .setThreadName("火星创生")
    .build();
recipeCounter += 1;

//金星
RecipeBuilder.newBuilder("wallcrea-7", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val veb = data.getInt("veb",0);
        if(veb == 0){
            event.setFailed("未找到金星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_a>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:basalt_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:basalt_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:basalt_block", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:oreblock", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:ingot", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:dust", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:basicblock2", Damage: 10 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:depleted_fuel_ic2", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:plutonium", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:nuclear", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mets:uranium_rich_seed", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:uranium_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:dual_uranium_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:quad_uranium_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:mox_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:dual_mox_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:quad_mox_fuel_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 5, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§e金星之力")
    .addRecipeTooltip("§e虚假的金光熠熠")
    .addRecipeTooltip("§e可它是金星，她是Venus(维纳斯)！")
    .addRecipeTooltip("§e她并未向外造就，但它就是爱与美，纵使“双膀”残缺，她也已独身屹立于星辰之海。")
    .setThreadName("金星创生")
    .build();
recipeCounter += 1;

//冥王星
RecipeBuilder.newBuilder("wallcrea-8", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val plb = data.getInt("plb",0);
        if(plb == 0){
            event.setFailed("未找到冥王星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_b>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:diamond_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:diamond", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:otherdust", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:diamond_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "avaritia:resource", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "ic2:dust", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "nitrogen", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 14, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "psi:material", Damage: 2, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:item_crystal", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:item_crystal_empowered", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_crystal", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_crystal_empowered", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:compresseddiamond", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:reinforcedalloy", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:material", Damage: 24 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§7冥王星之力")
    .addRecipeTooltip("§7冥世之神。")
    .addRecipeTooltip("§7生命过往不迭，生命稍纵即走。")
    .addRecipeTooltip("§7焦土之上，也有故人的想念和祈愿。")
    .addRecipeTooltip("§7我们受困于死亡的终末，它却告诉你，世间总在延续。")
    .addRecipeTooltip("§7“你我”终将再一次遇见。")
    .setThreadName("冥王星创生")
    .build();
recipeCounter += 1;
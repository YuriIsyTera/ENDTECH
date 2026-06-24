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

//谷神星
RecipeBuilder.newBuilder("wallcrea-9", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val ceb = data.getInt("ceb",0);
        if(ceb == 0){
            event.setFailed("未找到谷神星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_c>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:saltblock", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:salt", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "brine", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "liquidlithium", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot", Damage: 6, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:otherdust", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot_block", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:biofuel", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "nak", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "sodium", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "potassium", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "naoh", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "koh", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "ethene", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "ethanol", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mekanism:biofuel", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:golden_apple", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:gold_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§9谷神星之力")
    .addRecipeTooltip("§9天象蓬勃，也请佑我万福无伤，吉行于天下。")
    .addRecipeTooltip("§9你我正领受祝福于大千世界。")
    .setThreadName("谷神星创生")
    .build();
recipeCounter += 1;

//鸟神星
RecipeBuilder.newBuilder("wallcrea-10", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mmb = data.getInt("mmb",0);
        if(mmb == 0){
            event.setFailed("未找到鸟神星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_d>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:rockwool", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 864 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "hydrofluoric_acid", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "fluoromethane", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:clay_ball", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:clay", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:brick", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:hardened_clay", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:brick_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:soil", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:ingots", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "immersiveengineering:stone_decoration", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "immersiveengineering:stone_decoration", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "immersiveengineering:stone_decoration", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "clay", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "pigiron", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:materials", Damage: 2, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:dried_clay", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:materials", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:seared", Damage: 3, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§6鸟神星之力")
    .addRecipeTooltip("§6天道不仁，以万物为刍狗。")
    .addRecipeTooltip("§6可鸟道不同喔！我只要叼叼石头，孵孵蛋，就好了哦！")
    .setThreadName("鸟神星创生")
    .build();
recipeCounter += 1;

//妊神星
RecipeBuilder.newBuilder("wallcrea-11", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val hab = data.getInt("hab",0);
        if(hab == 0){
            event.setFailed("未找到妊神星");
        }
    })
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_e>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 161 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 97 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:gem", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 20 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:alloy", Damage: 13 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_alloy_ingot", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_alloy_ingot", Damage: 3, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "electrum", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§5妊神星之力")
    .addRecipeTooltip("§5它要孕育一场变革。")
    .addRecipeTooltip("§5却被琥珀禁锢了生机，连时间都不能逃逸。")
    .addRecipeTooltip("§5所以，那尚未发生的事，要到未来才能得以脱身了。")
    .addRecipeTooltip("未找到妊神星")
    .build();
recipeCounter += 1;

//奈佩里
RecipeBuilder.newBuilder("wallcrea-12", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val npb = data.getInt("npb",0);
        if(npb == 0){
            event.setFailed("未找到奈佩里");
        }
    })
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_e>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:dilithium_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "libvulpes:productgem", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:dilithium_ingot", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:dilithium_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:slime_grass", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:slime_ball", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:slime", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:emerald", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:emerald_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:emerald_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:item_crystal", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:item_crystal_empowered", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_crystal", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_crystal_empowered", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "moreplates:emeradic_plate", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "moreplates:empowered_emeradic_plate", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:edible", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:edible", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:edible", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconstruct:throwball", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves2", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:leaves2", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "moreplates:empowered_emeradic_plate", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "moreplates:empowered_emeradic_plate", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§2奈佩里之力")
    .addRecipeTooltip("§2在这郁郁葱葱的世界里，我们找到了不少好东西。")
    .addRecipeTooltip("§2至少，看看这个伟大的JEI合成表！")
    .addRecipeTooltip("§2虽然你并不喜欢它的气候，但这里真的藏着不少绿宝石！")
    .addRecipeTooltip("奈佩里创生")
    .build();
recipeCounter += 1;
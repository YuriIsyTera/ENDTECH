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

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

MachineModifier.setMaxParallelism("superelect", 1200);
MachineModifier.setMaxThreads("superelect",10);

MachineModifier.setInternalParallelism("superelect", 1200);
MachineModifier.addCoreThread("superelect", FactoryRecipeThread.createCoreThread("有厘头之线程"));

var recipeCount = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//==================================厘头电解机控制器==============================
//电解机_集成控制器
//工作台合成
recipes.addShaped( 
    <modularmachinery:superelect_factory_controller>, // 输出物品
    [[<modularmachinery:blockcasing>, <modularmachinery:blockcasing>, <modularmachinery:blockcasing>],
    [<mekanism:machineblock2:4>, <mekanism:electrolyticcore>, <mekanism:machineblock2:4>],
    [<modularmachinery:blockcasing>, <appliedenergistics2:controller>, <modularmachinery:blockcasing>]]
);

// ———— 电解器 —————————————

RecipeBuilder.newBuilder("oh11111", "superelect",20)  // 氢 氧
    .addEnergyPerTickInput(900)
    .addFluidInput(<liquid:water> * 1000)
    .addOutputs(<gas:hydrogen> * 1000)
    .addOutputs(<gas:oxygen> * 500)
    .addRecipeTooltip("§3YES！水中氢氧比例为2:1")
    .build();

RecipeBuilder.newBuilder("oh22222", "superelect",20)  // 煤炭
    .addEnergyPerTickInput(900)
    .addInput(<gas:oxygen> * 1)
    .addOutputs(<minecraft:coal> * 4)
    .addRecipeTooltip("§3O2=4C！")
    .build();
 
RecipeBuilder.newBuilder("oh33333", "superelect",20)  // 钻石
    .addEnergyPerTickInput(1200)
    .addInput(<minecraft:coal> * 100)
    .addOutput(<minecraft:diamond> * 90)
    .addOutput(<thermalfoundation:material:771> * 3)
    .addOutput(<thermalfoundation:material:864> * 5)
    .addOutput(<gas:hydrogen> * 1000)
    .addOutput(<gas:oxygen> * 1000)
    .addRecipeTooltip("合理的煤炭内部物质含量剖析（）")
    .addRecipeTooltip("也许吧。")
    .build();
 
RecipeBuilder.newBuilder("oh44444", "superelect",20)  //液体DT
    .addEnergyPerTickInput(3000)
    .addInput(<liquid:heavywater> * 10000)
    .addOutput(<liquid:jfh> * 200)
    .addOutput(<liquid:helium_3> * 5000)
    .addOutputs(<liquid:liquidfusionfuel> * 6250)
    .addRecipeTooltip("§c是啊，绽放属于TOKMAK的荣光吧...")
    .addRecipeTooltip("§c我们...我们一起去。")
    .build();
 
RecipeBuilder.newBuilder("oh55555", "superelect",20)  //氢氧无限元件
    .addInput(<extendedae:infinity_cell>.withTag({r: {FluidName: "water", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "oxygen", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "hydrogen", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"}) * 2)
    .build();
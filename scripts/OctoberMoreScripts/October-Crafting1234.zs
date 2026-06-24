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


var recipeCounter = 0;

MachineModifier.setInternalParallelism("crafting_adv1", 520);

MachineModifier.setMaxThreads("crafting_adv1",12);

MachineModifier.addCoreThread("crafting_adv1", FactoryRecipeThread.createCoreThread("高级扩展加速"));

MachineModifier.setInternalParallelism("crafting_eli2", 1314);

MachineModifier.setMaxThreads("crafting_eli2",24);

MachineModifier.addCoreThread("crafting_eli2", FactoryRecipeThread.createCoreThread("精英扩展加速"));

MachineModifier.setInternalParallelism("crafting_ult3", 1919);

MachineModifier.setMaxThreads("crafting_ult3",48);

MachineModifier.addCoreThread("crafting_ult3", FactoryRecipeThread.createCoreThread("终极扩展加速"));
//§6高级模式 控制器配方
mods.extendedcrafting.TableCrafting.addShaped(<modularmachinery:crafting_adv1_factory_controller>, [
	[<extendedcrafting:material:9>, <modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>, <extendedcrafting:material:9>], 
	[<modularmachinery:blockcasing:4>, <ore:blockGold>, null, <ore:blockGold>, <modularmachinery:blockcasing:4>], 
	[<novaeng_core:estorage_casing>, null, <extendedcrafting:table_advanced>, null, <novaeng_core:estorage_casing>], 
	[<modularmachinery:blockcasing:4>, <ore:blockGold>, null, <ore:blockGold>, <modularmachinery:blockcasing:4>], 
	[<extendedcrafting:material:9>, <modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>, <extendedcrafting:material:9>]
]);

//§6精英模式 控制器配方
mods.extendedcrafting.TableCrafting.addShaped(<modularmachinery:crafting_eli2_factory_controller>, [
	[null, <ore:blockDiamond>, <extendedcrafting:material:16>, <ore:ingotBlueAlloy>, <extendedcrafting:material:16>, <ore:blockDiamond>, null], 
	[<ore:blockDiamond>, <ore:blockDiamond>, <novaeng_core:estorage_casing>, null, <novaeng_core:estorage_casing>, <ore:blockDiamond>, <ore:blockDiamond>], 
	[<extendedcrafting:material:16>, <novaeng_core:estorage_casing>, null, <extendedcrafting:material:10>, null, <novaeng_core:estorage_casing>, <extendedcrafting:material:16>], 
	[<ore:ingotBlueAlloy>, null, <extendedcrafting:material:10>, <modularmachinery:crafting_adv1_factory_controller>, <extendedcrafting:material:10>, null, <ore:ingotBlueAlloy>], 
	[<extendedcrafting:material:16>, <novaeng_core:estorage_casing>, null, <extendedcrafting:material:10>, null, <novaeng_core:estorage_casing>, <extendedcrafting:material:16>], 
	[<ore:blockDiamond>, <ore:blockDiamond>, <novaeng_core:estorage_casing>, null, <novaeng_core:estorage_casing>, <ore:blockDiamond>, <ore:blockDiamond>], 
	[null, <ore:blockDiamond>, <extendedcrafting:material:16>, <ore:ingotBlueAlloy>, <extendedcrafting:material:16>, <ore:blockDiamond>, null]
]);

//§6终极模式 控制器配方
mods.extendedcrafting.TableCrafting.addShaped(<modularmachinery:crafting_ult3_factory_controller>, [
	[<novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>, <ore:blockEmerald>, <ore:blockEmerald>, null, <ore:blockEmerald>, <ore:blockEmerald>, <modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>], 
	[<modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>, <novaeng_core:estorage_casing>, <ore:blockEmerald>, null, <ore:blockEmerald>, <novaeng_core:estorage_casing>, <novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>], 
	[<ore:blockEmerald>, <novaeng_core:estorage_casing>, <extendedcrafting:material:11>, <extendedcrafting:material:17>, <extendedcrafting:material:17>, <ore:ingotVibrantAlloy>, <extendedcrafting:material:11>, <novaeng_core:estorage_casing>, <ore:blockEmerald>], 
	[<ore:blockEmerald>, <ore:blockEmerald>, <ore:ingotVibrantAlloy>, null, null, null, <extendedcrafting:material:17>, <ore:blockEmerald>, <ore:blockEmerald>], 
	[null, null, <extendedcrafting:material:17>, null, <modularmachinery:crafting_eli2_factory_controller>, null, <extendedcrafting:material:17>, null, null], 
	[<ore:blockEmerald>, <ore:blockEmerald>, <extendedcrafting:material:17>, null, null, null, <ore:ingotVibrantAlloy>, <ore:blockEmerald>, <ore:blockEmerald>], 
	[<ore:blockEmerald>, <novaeng_core:estorage_casing>, <extendedcrafting:material:11>, <ore:ingotVibrantAlloy>, <extendedcrafting:material:17>, <extendedcrafting:material:17>, <extendedcrafting:material:11>, <novaeng_core:estorage_casing>, <ore:blockEmerald>], 
	[<modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>, <novaeng_core:estorage_casing>, <ore:blockEmerald>, null, <ore:blockEmerald>, <novaeng_core:estorage_casing>, <novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>], 
	[<novaeng_core:estorage_casing>, <modularmachinery:blockcasing:4>, <ore:blockEmerald>, <ore:blockEmerald>, null, <ore:blockEmerald>, <ore:blockEmerald>, <modularmachinery:blockcasing:4>, <novaeng_core:estorage_casing>]
]);

//§6高级模式-配方
RecipeBuilder.newBuilder("adv1", "crafting_adv1",20)  // 地磁发电机x4
        .addInputs([
        <mets:titanium_plate> * 6,
        <ore:circuitElite> * 6,
        <mets:nano_living_metal> * 4,
        <ic2:te:5> * 4,
        <mets:te:3> * 2,
        <mets:te:2> * 1,
        <mets:geomagnetic_antenna> * 1,
    ])
    .addOutputs(<mets:te:21> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv2", "crafting_adv1",100)  // 地磁发电机天线x6
        .addInputs([
        <mets:superconducting_cable> * 8,
        <mets:nano_living_metal> * 5,
        <ic2:te:41> * 4,
    ])
    .addOutputs(<mets:geomagnetic_antenna> * 6)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv3", "crafting_adv1",100)  // 电磁发电机基座x10
        .addInputs([
        <ic2:te:4> * 8,
        <mets:titanium_block> * 5,
        <mets:nano_living_metal> * 2,
        <ore:circuitElite> * 1,
        <ore:circuitUltimate> * 1,
    ])
    .addOutputs(<mets:geomagnetic_pedestal> * 10)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv4", "crafting_adv1",20)  //模块总线x3
        .addInputs([
        <tconevo:metal:33> * 8,
        <modularmachinery:blockcasing> * 6,
        <botania:manaresource:7> * 4,
        <moreplates:empowered_emeradic_plate> * 6,
        <appliedenergistics2:part:180> * 6,
    ])
    .addOutputs(<modularmachinery:blockupgradebus> * 3)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv5", "crafting_adv1",20)  //强化模块总线x3
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <appliedenergistics2:part:180> * 6,
        <taiga:valyrium_ingot> * 6,
        <contenttweaker:lifesense_processor> * 6,
        <contenttweaker:industrial_circuit_v2> * 1,
    ])
    .addOutputs(<modularmachinery:blockupgradebus:1> * 3)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv6", "crafting_adv1",20)  //并行控制器x3
        .addInputs([
        <modularmachinery:blockcasing> * 6,
        <appliedenergistics2:part:180> * 6,
        <botania:manaresource:4> * 6,
        <ore:circuitUltimate> * 6,
    ])
    .addOutputs(<modularmachinery:blockparallelcontroller> * 3)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv7", "crafting_adv1",20)  //强化并行控制器x3
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <appliedenergistics2:part:180> * 6,
        <taiga:valyrium_ingot> * 6,
        <tconevo:metal:38> * 6,
        <contenttweaker:industrial_circuit_v2> * 3,
    ])
    .addOutputs(<modularmachinery:blockparallelcontroller:1> * 3)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv8", "crafting_adv1",20)  //智能数据接口x10
        .addInputs([
        <modularmachinery:blockcasing> * 5,
        <appliedenergistics2:part:180> * 5,
        <enderio:item_alloy_ingot:3> * 5,
        <ore:circuitBasic> * 4,
    ])
    .addOutputs(<modularmachinery:blocksmartinterface> * 10)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv9", "crafting_adv1",20)  //强化机械外壳x64
        .addInputs([
        <modularmachinery:blockcasing> * 20,
        <additions:novaextended-ingot8> * 12,
        <mekanism:ingot> * 12,
        <ic2:resource:13> * 8,
    ])
    .addOutputs(<modularmachinery:blockcasing:4> * 64)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv10", "crafting_adv1",20)  //机械电路板x8
        .addInputs([
        <modularmachinery:blockcasing> * 4,
        <enderio:item_alloy_ingot:3> * 4,
        <enderio:item_alloy_ingot:2> * 8,
        <ore:circuitAdvanced> * 4,
        <ore:programmingCircuit> * 1,
    ])
    .addOutputs(<modularmachinery:blockcasing:5> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv11", "crafting_adv1",20)  //机械齿轮箱x8
        .addInputs([
        <modularmachinery:blockcasing> * 4,
        <mets:niobium_titanium_ingot> * 4,
        <enderio:item_alloy_endergy_ingot:2> * 8,
        <enderio:item_material:13> * 4,
        <enderio:item_material:73> * 1,
    ])
    .addOutputs(<modularmachinery:blockcasing:3> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv12", "crafting_adv1",20)  //巨型流体输出仓x4
        .addInputs([
        <extendedcrafting:material:16> * 12,
        <enderio:item_alloy_endergy_ingot:3> * 8,
        <modularmachinery:blockcasing:4> * 2,
        <modularmachinery:blockfluidoutputhatch:4> * 2,
    ])
    .addOutputs(<modularmachinery:blockfluidoutputhatch:5> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv13", "crafting_adv1",20)  //巨型流体输入仓x4
        .addInputs([
        <extendedcrafting:material:16> * 16,
        <enderio:item_alloy_endergy_ingot:3> * 8,
        <modularmachinery:blockcasing:4> * 2,
        <modularmachinery:blockfluidinputhatch:4> * 2,
    ])
    .addOutputs(<modularmachinery:blockfluidinputhatch:5> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv14", "crafting_adv1",20)  //巨型能源输出仓x4
        .addInputs([
        <extendedcrafting:material:16> * 16,
        <enderio:item_alloy_endergy_ingot:3> * 12,
        <modularmachinery:blockcasing:4> * 4,
        <modularmachinery:blockenergyoutputhatch:4> * 2,
    ])
    .addOutputs(<modularmachinery:blockenergyoutputhatch:5> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv15", "crafting_adv1",20)  //巨型能源输入仓x4
        .addInputs([
        <extendedcrafting:material:16> * 16,
        <enderio:item_alloy_endergy_ingot:3> * 12,
        <modularmachinery:blockcasing:4> * 4,
        <modularmachinery:blockenergyinputhatch:4> * 2,
    ])
    .addOutputs(<modularmachinery:blockenergyinputhatch:5> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv16", "crafting_adv1",20)  //巨型物品输出仓x8
        .addInputs([
        <extendedcrafting:material:16> * 12,
        <enderio:item_alloy_endergy_ingot:3> * 12,
        <modularmachinery:blockcasing:4> * 6,
        <modularmachinery:blockoutputbus:4> * 6,
    ])
    .addOutputs(<modularmachinery:blockoutputbus:5> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv17", "crafting_adv1",20)  //巨型物品输入仓x8
        .addInputs([
        <extendedcrafting:material:16> * 12,
        <enderio:item_alloy_endergy_ingot:3> * 12,
        <modularmachinery:blockcasing:4> * 6,
        <modularmachinery:blockinputbus:4> * 6,
    ])
    .addOutputs(<modularmachinery:blockinputbus:5> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv18", "crafting_adv1",20)  //精英合成催化剂x12
        .addInputs([
        <extendedcrafting:material:16> * 4,
        <additions:novaextended-blue_alloy_ingot> * 8,
        <botania:manaresource:4> * 3,
    ])
    .addOutputs(<extendedcrafting:material:10> * 12)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv19", "crafting_adv1",20)  //精英合成组件x24
        .addInputs([
        <thermalfoundation:material:134> * 12,
        <extendedcrafting:material:2> * 12,
        <extendedcrafting:material:15> * 8,
    ])
    .addOutputs(<extendedcrafting:material:16> * 24)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("adv20", "crafting_adv1",20)  //基础通用合金x16
        .addInputs([
        <enderio:item_alloy_endergy_ingot:1> * 16,
        <botania:manaresource> * 12,
        <draconicevolution:draconium_ingot> * 6,
    ])
    .addOutputs(<contenttweaker:universalalloyt1> * 16)
    .build();
recipeCounter += 1;


//§6精英模式-配方
RecipeAdapterBuilder.create("crafting_eli2", "modularmachinery:crafting_adv1")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.8, 1, false).build())
    .build();

RecipeBuilder.newBuilder("eli1", "crafting_eli2",20)  //晶素锭x64
        .addInputs([
        <ore:gemDiamond> * 32,
        <minecraft:dye:4> * 24,
        <extendedcrafting:material:140> * 16,
    ])
    .addOutputs(<extendedcrafting:material:24> * 64)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli2", "crafting_eli2",40)  //精英模块总线x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 12,
        <appliedenergistics2:part:180> * 12,
        <contenttweaker:exponential_level_processor> * 10,
        <redstonerepository:material:4> * 4,
        <extendedcrafting:material:10> * 4,
        <modularmachinery:blockupgradebus:1> * 2,
        <contenttweaker:industrial_circuit_v3> * 3,
    ])
    .addOutputs(<modularmachinery:blockupgradebus:2> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli3", "crafting_eli2",40)  //精英并行控制器x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 12,
        <appliedenergistics2:part:180> * 4,
        <additions:novaextended-extremecircuit> * 8,
        <extendedcrafting:material:17> * 4,
        <extendedcrafting:material:11> * 4,
        <modularmachinery:blockparallelcontroller:1> * 2,
    ])
    .addOutputs(<modularmachinery:blockparallelcontroller:2> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli4", "crafting_eli2",20)  //手提包
        .addInputs([
        <enderutilities:enderpart:50> * 4,
        <astralsorcery:itemcraftingcomponent:4> * 4,
        <enderutilities:enderpart:1> * 4,
        <additions:novaextended-blue_alloy_ingot> * 2,
        <mets:nano_living_metal> * 4,
        <thermalexpansion:satchel:4> * 1,
    ])
    .addOutputs(<enderutilities:handybag> * 1)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli5", "crafting_eli2",40)  //超级流体输出仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 8,
        <draconicevolution:draconic_ingot> * 8,
        <contenttweaker:universalalloyt2> * 2,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 4,
        <modularmachinery:blockfluidoutputhatch:5> * 2,
    ])
    .addOutputs(<modularmachinery:blockfluidoutputhatch:6> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli6", "crafting_eli2",40)  //超级流体输入仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 8,
        <draconicevolution:draconic_ingot> * 8,
        <contenttweaker:universalalloyt2> * 2,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 4,
        <modularmachinery:blockfluidinputhatch:5> * 2,
    ])
    .addOutputs(<modularmachinery:blockfluidinputhatch:6> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli7", "crafting_eli2",40)  //超级能源输出仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 8,
        <mekanism:basicblock2:3>.withTag({tier: 0}) * 4,
        <draconicevolution:draconic_ingot> * 8,
        <contenttweaker:universalalloyt2> * 2,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 4,
        <modularmachinery:blockenergyoutputhatch:5> * 2,
    ])
    .addOutputs(<modularmachinery:blockenergyoutputhatch:6> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli8", "crafting_eli2",40)  //超级能源输入仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 8,
        <mekanism:basicblock2:3>.withTag({tier: 0}) * 4,
        <draconicevolution:draconic_ingot> * 8,
        <contenttweaker:universalalloyt2> * 2,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 4,
        <modularmachinery:blockenergyinputhatch:5> * 2,
    ])
    .addOutputs(<modularmachinery:blockenergyinputhatch:6> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli9", "crafting_eli2",40)  //超级物品输出仓x12
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <draconicevolution:draconic_ingot> * 8,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 3,
        <modularmachinery:blockoutputbus:5> * 3,
    ])
    .addOutputs(<modularmachinery:blockoutputbus:6> * 12)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli10", "crafting_eli2",40)  //超级物品输出仓x12
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <draconicevolution:draconic_ingot> * 8,
        <extendedcrafting:material:17> * 8,
        <extendedcrafting:material:11> * 3,
        <modularmachinery:blockinputbus:5> * 3,
    ])
    .addOutputs(<modularmachinery:blockinputbus:6> * 12)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli11", "crafting_eli2",20)  //聚变堆控制器
        .addInputs([
        <mekanismgenerators:reactor:1> * 4,
        <appliedenergistics2:part:180> * 4,
        <mekanism:atomicalloy> * 4,
        <mekanismgenerators:reactorglass> * 4,
        <contenttweaker:field_generator_v1> * 4,
        <ore:circuitUltimate> * 2,
    ])
    .addOutputs(<mekanismgenerators:reactor> * 1)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli12", "crafting_eli2",120)  //管理员太阳能板x4
        .addInputs([
        <contenttweaker:universalalloyt2> * 6,
        <extendedcrafting:material:11> * 6,
        <redstonerepository:material:4> * 6,
        <draconicevolution:awakened_core> * 4,
        <super_solar_panels:crafting:44> * 4,
        <draconicevolution:draconic_energy_core> * 4,
        <super_solar_panels:crafting:35>,
    ])
    .addOutputs(<super_solar_panels:machines:7> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli13", "crafting_eli2",40)  //晶素合成催化剂x16
        .addInputs([
        <extendedcrafting:material:18> * 8,
        <avaritia:resource:1> * 8,
        <botania:manaresource:4> * 4,
        <tconevo:metal:5> * 4,
        <additions:novaextended-terraalloy> * 4,
    ])
    .addOutputs(<extendedcrafting:material:12> * 16)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli14", "crafting_eli2",40)  //终极合成催化剂x16
        .addInputs([
        <avaritia:resource:3> * 16,
        <extendedcrafting:material:17> * 8,
        <avaritia:resource:1> * 4,
        <additions:novaextended-terraalloy> * 4,
    ])
    .addOutputs(<extendedcrafting:material:11> * 16)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli15", "crafting_eli2",40)  //晶素合成组件x16
        .addInputs([
        <extendedcrafting:material:24> * 12,
        <extendedcrafting:material:17> * 8,
    ])
    .addOutputs(<extendedcrafting:material:18> * 16)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli16", "crafting_eli2",40)  //终极合成组件x16
        .addInputs([
        <enderio:item_alloy_ingot:2> * 12,
        <enderio:item_alloy_ingot:6> * 8,
        <extendedcrafting:material:16> * 4,
    ])
    .addOutputs(<extendedcrafting:material:17> * 16)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli17", "crafting_eli2",20)  //落星核箭
        .addInputs([
        <additions:novaextended-fallen_star_alloy> * 1,
        <additions:novaextended-terraalloy> * 2,
        <enderio:item_material:71> * 3,
        <extrabotany:jingweifeather> * 2,
    ])
    .addOutputs(<additions:novaextended-fallen_star_arrow> * 128)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli18", "crafting_eli2",120)  //绿宝石生物农场
        .addInputs([
        <ore:holyFusedQuartz> * 17,
        <ore:blockEmerald> * 4,
        <jaopca:block_blockwillowalloy> * 3,
        <additions:novaextended-blue_alloy_ingot> * 2,
        <tinymobfarm:diamond_farm> * 1,
    ])
    .addOutputs(<tinymobfarm:emerald_farm> * 1)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("eli19", "crafting_eli2",150)  //灵魂核心x4
    .addInputs([
	<modularmachinery:data_processor_t3_factory_controller> * 4,
    <eternalsingularity:eternal_singularity> * 4,
    <contenttweaker:field_generator_v1> * 4,
    <avaritia:block_resource:1> * 1,
])
    .addOutputs(<contenttweaker:soul_core> * 4)
    .build();
recipeCounter += 1;

//§6终极模式-配方
RecipeAdapterBuilder.create("crafting_ult3", "modularmachinery:crafting_adv1")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.8, 1, false).build())
    .build();

RecipeAdapterBuilder.create("crafting_ult3", "modularmachinery:crafting_eli2")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.8, 1, false).build())
    .build();

RecipeBuilder.newBuilder("ult1", "crafting_ult3",40)  //超级模块总线x6
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <contenttweaker:extrememachineblock> * 6,
        <appliedenergistics2:part:180> * 6,
        <extendedcrafting:material:12> * 6,
        <tconevo:metal:10> * 8,
        <taiga:astrium_ingot> * 8,
        <contenttweaker:infinity_processor> * 3,
        <modularmachinery:blockupgradebus:2> * 3,
    ])
    .addOutputs(<modularmachinery:blockupgradebus:3> * 6)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult2", "crafting_ult3",40)  //终极模块总线x6
        .addInputs([
        <contenttweaker:extrememachineblock> * 6,
        <contenttweaker:arkmachineblock> * 6,
        <appliedenergistics2:part:180> * 6,
        <contenttweaker:industrial_circuit_v4> * 6,
        <extendedcrafting:material:13> * 6,
        <additions:novaextended-star_ingot> * 8,
        <additions:novaextended-extremecircuit> * 6,
        <modularmachinery:blockupgradebus:3> * 3,
    ])
    .addOutputs(<modularmachinery:blockupgradebus:4> * 6)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult3", "crafting_ult3",40)  //超级并行控制器x6
        .addInputs([
        <modularmachinery:blockcasing:4> * 6,
        <contenttweaker:extrememachineblock> * 6,
        <appliedenergistics2:part:180> * 6,
        <contenttweaker:infinity_processor> * 6,
        <extendedcrafting:material:12> * 2,
        <tconevo:metal:10> * 8,
        <taiga:nihilite_ingot> * 8,
        <modularmachinery:blockparallelcontroller:2> * 2,
        <avaritiatweaks:enhancement_crystal> * 1,
    ])
    .addOutputs(<modularmachinery:blockparallelcontroller:3> * 6)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult4", "crafting_ult3",40)  //终极并行控制器x6
        .addInputs([
        <contenttweaker:extrememachineblock> * 6,
        <contenttweaker:arkmachineblock> * 6,
        <appliedenergistics2:part:180> * 6,
        <additions:novaextended-ark_circuit> * 6,
        <extendedcrafting:material:13> * 6,
        <additions:novaextended-star_ingot> * 8,
        <contenttweaker:charging_crystal_block> * 8,
        <modularmachinery:blockparallelcontroller:3> * 2,
        <additions:novaextended-crystal4> * 1,
    ])
    .addOutputs(<modularmachinery:blockparallelcontroller:4> * 6)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult5", "crafting_ult3",50)  //终极锭
    .addInputs([
	<extendedcrafting:material:48>, <ore:ingotCrystaltine>, <ore:ingotIron>, <ore:ingotGold>, <ore:ingotElvenElementium>, <ore:ingotManasteel>, <ore:ingotDarkSteel>, <ore:ingotPulsatingIron>, <ore:ingotConductiveIron>, <ore:ingotRedstoneAlloy>, <ore:ingotVibrantAlloy>, <ore:ingotEnergeticAlloy>, <ore:ingotElectricalSteel>, <ore:ingotDraconium>, <ore:ingotSoularium>, <ore:ingotEndSteel>, <ore:ingotMelodicAlloy>, <ore:ingotCrystallineAlloy>, <ore:ingotEnergeticSilver>, <ore:ingotVividAlloy>, <ore:ingotBlackIron>, <super_solar_panels:crafting:4>, <mets:niobium_titanium_ingot>, <modularmachinery:itemmodularium>, <ore:ingotRefinedGlowstone>, <ore:ingotOsmium>, <ore:ingotPhotonium>, <ore:ingotShadowium>, <ore:ingotFluixSteel>, <ore:ingotSignalum>, <ore:ingotLumium>, <ore:ingotAlloyT1>, <ore:ingotAlloyT2>, <ore:ingotPsiAlloy>, <ore:ingotBlueAlloy>, <ore:ingotEnderium>, <ore:ingotWillowalloy>, <ore:ingotNetherite>, <ore:ingotDraconiumAwakened>, <ore:ingotStellarAlloy>, <ore:ingotManyullyn>, <ore:ingotEnergium>, <ore:ingotUUMatter>, <ore:ingotSolarium>, <ore:ingotBoundMetal>, <ore:ingotSentientMetal>, <ore:ingotCosmicNeutronium>, <deepmoblearning:glitch_infused_ingot>, <ore:ingotCrystalMatrix>, <ore:ingotTerrasteel>, <ore:gaiaIngot>, <ore:ingotOrichalcos>, <ore:ingotTerraAlloy>, <ore:ingotFallenStarAlloy>, <ore:ingotWyvernMetal>, <ore:ingotDraconicMetal>, <ore:ingotChaoticMetal>,
])
    .addOutputs(<extendedcrafting:material:32> * 240)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult6", "crafting_ult3",50)  //真空流体输出仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 4,
        <contenttweaker:extrememachineblock> * 4,
        <avaritia:block_resource:2> * 4,
        <avaritia:block_resource> * 4,
        <extendedcrafting:material:18> * 2,
        <extendedcrafting:material:12> * 6,
        <additions:novaextended-terraalloy> * 4,
        <additions:novaextended-fallen_star_alloy> * 4,
        <tconevo:metal:10> * 8,
        <avaritia:resource:4> * 8,
        <modularmachinery:blockfluidoutputhatch:6> * 1,
    ])
    .addOutputs(<modularmachinery:blockfluidoutputhatch:7> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult7", "crafting_ult3",50)  //真空流体输入仓x4
        .addInputs([
        <modularmachinery:blockcasing:4> * 4,
        <contenttweaker:extrememachineblock> * 4,
        <avaritia:block_resource:2> * 4,
        <avaritia:block_resource> * 4,
        <extendedcrafting:material:18> * 2,
        <extendedcrafting:material:12> * 6,
        <additions:novaextended-terraalloy> * 4,
        <additions:novaextended-fallen_star_alloy> * 4,
        <tconevo:metal:10> * 8,
        <avaritia:resource:4> * 8,
        <modularmachinery:blockfluidinputhatch:6> * 1,
    ])
    .addOutputs(<modularmachinery:blockfluidinputhatch:7> * 4)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult8", "crafting_ult3",50)  //终极能源输出仓x8
        .addInputs([
        <contenttweaker:arkmachineblock> * 8,
        <contenttweaker:extrememachineblock> * 8,
        <contenttweaker:charging_crystal_block> * 12,
        <extendedcrafting:material:12> * 4,
        <additions:novaextended-terraalloy> * 4,
        <additions:novaextended-fallen_star_alloy> * 4,
        <contenttweaker:universalalloyt2> * 8,
        <additions:novaextended-star_ingot> * 8,
        <modularmachinery:blockenergyoutputhatch:6> * 1,
    ])
    .addOutputs(<modularmachinery:blockenergyoutputhatch:7> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult9", "crafting_ult3",50)  //终极能源输入仓x8
        .addInputs([
        <contenttweaker:arkmachineblock> * 8,
        <contenttweaker:extrememachineblock> * 8,
        <contenttweaker:charging_crystal_block> * 12,
        <extendedcrafting:material:12> * 4,
        <additions:novaextended-terraalloy> * 4,
        <additions:novaextended-fallen_star_alloy> * 4,
        <contenttweaker:universalalloyt2> * 8,
        <additions:novaextended-star_ingot> * 8,
        <modularmachinery:blockenergyinputhatch:6> * 1,
    ])
    .addOutputs(<modularmachinery:blockenergyinputhatch:7> * 8)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult10", "crafting_ult3",120)  //光子太阳能板x3
        .addInputs([
        <extrabotany:blockorichalcos> * 6,
        <avaritia:block_resource:2> * 6,
        <mets:superconducting_cable> * 6,
        <gravisuite:crafting:2> * 3,
        <gravisuite:crafting:1> * 3,
        <mets:super_iridium_compress_plate> * 3,
        <contenttweaker:field_generator_v1> * 3,
        <draconicevolution:chaotic_core> * 3,
        <draconicadditions:chaotic_energy_core> * 3,
        <super_solar_panels:machines:7> * 3,
        <avaritiatweaks:enhancement_crystal> * 1,
    ])
    .addOutputs(<super_solar_panels:machines:8> * 3)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult11", "crafting_ult3",60)  //终极催化剂x12
    .addInputs([
        <extendedcrafting:material:19> * 12,
        <contenttweaker:universalalloyt1> * 8,
        <avaritia:resource:4> * 4,
        <mets:neutron_plate> * 4,
        <additions:novaextended-terraalloy> * 2,
        <additions:novaextended-fallen_star_alloy> * 2,
        <contenttweaker:universalalloyt2> * 1,
    ])
    .addOutputs(<extendedcrafting:material:13> * 12)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult12", "crafting_ult3",60)  //终极组件x32
    .addInputs([
        <extendedcrafting:material:18> * 16,
        <extendedcrafting:material:32> * 16,
    ])
    .addOutputs(<extendedcrafting:material:19> * 32)
    .build();
recipeCounter += 1;

RecipeBuilder.newBuilder("ult13", "crafting_ult3",120)  //下界生物农场
        .addInputs([
        <ore:holyFusedQuartz> * 23,
        <avaritia:block_resource:2> * 5,
        <jaopca:block_blockwillowalloy> * 4,
        <additions:novaextended-extremecircuit> * 4,
        <ore:circuitUltimate> * 4,
        <additions:novaextended-terraalloy> * 2,
        <additions:novaextended-fallen_star_alloy> * 2,
        <tinymobfarm:emerald_farm> * 1,
    ])
    .addOutputs(<tinymobfarm:inferno_farm> * 1)
    .build();
recipeCounter += 1;
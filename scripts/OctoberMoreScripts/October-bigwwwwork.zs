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

MachineModifier.setMaxParallelism("newengineerworkshop1", 520);
MachineModifier.setMaxThreads("newengineerworkshop1",12);

MachineModifier.setInternalParallelism("newengineerworkshop1", 520);
MachineModifier.addCoreThread("newengineerworkshop1", FactoryRecipeThread.createCoreThread("高级线程加强"));

var recipeCount = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//==================================工坊控制器==============================
//工坊_控制器
//工作台合成
recipes.addShaped( 
    <modularmachinery:newengineerworkshop1_controller>, // 输出物品
    [[<modularmachinery:blockcasing>, <modularmachinery:blockcasing>, <modularmachinery:blockcasing>],
    [<modularmachinery:blockcasing>, <artisanworktables:workshop:6>, <modularmachinery:blockcasing>],
    [<modularmachinery:blockcasing>, <appliedenergistics2:controller>, <modularmachinery:blockcasing>]]
);

//集成工坊_集成控制器
//工作台合成
recipes.addShaped( 
    <modularmachinery:newengineerworkshop1_factory_controller>, // 输出物品
    [[<modularmachinery:blockcasing>, <artisanworktables:workstation:6>, <modularmachinery:blockcasing>],
    [<artisanworktables:workstation:6>, <artisanworktables:workshop:6>, <artisanworktables:workstation:6>],
    [<modularmachinery:blockcasing>, <appliedenergistics2:controller>, <modularmachinery:blockcasing>]]
);

// ———— 工程师作坊 —————————————
RecipeBuilder.newBuilder("ic2_te_63", "newengineerworkshop1",20)  // 复制机
    .addInputs([
        <ic2:resource:11> * 4,
        <ore:plateDenseSteel> * 4,
        <enderio:item_alloy_endergy_ingot:3> * 2,
        <ic2:resource:13> * 2,
        <mets:niobium_titanium_plate> * 2,
        <enderio:item_capacitor_stellar> * 1,
        <extrabotany:material:1> * 1,
        <contenttweaker:engineering_battery_v3> * 1,
        <ic2:iridium_reflector> * 1,
    ])
    .addOutputs(<ic2:te:63> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_22", "newengineerworkshop1",20)  // 粒子聚合发生器
    .addInputs([
        <ic2:resource:13> * 2,
        <ic2:crafting:4> * 4,
        <extrabotany:material:1> * 2,
        <contenttweaker:field_generator_v1> * 1,
        <mets:living_circuit> * 2,
        <mets:super_iridium_compress_plate> * 2,
        <super_solar_panels:crafting:44> * 1,
    ])
    .addOutputs(<mets:te:22> * 2)
    .build();
 

RecipeBuilder.newBuilder("mekanismgenerators_generator_6", "newengineerworkshop1",20)  // 风力发电机
    .addInputs([
        <ore:ingotOsmium> * 2,
        <ic2:crafting:32> * 1,
        <ore:circuitBasic> * 1,
        <mekanism:enrichedalloy> * 1,
        <mekanism:energytablet> * 1,
    ])
    .addOutputs(<mekanismgenerators:generator:6> * 2)
    .build();
 

RecipeBuilder.newBuilder("ic2_upgrade_x6", "newengineerworkshop1",20)  // 超频升级x6
    .addInputs([
        <ic2:fluid_cell> * 2,
        <ore:circuitBasic> * 2,
        <ore:plateSteel> * 1,
    ])
    .addFluidInput(<liquid:ic2coolant> * 600)
    .addOutputs(<ic2:upgrade> * 6)
    .build();
 

RecipeBuilder.newBuilder("ic2_upgrade_x16", "newengineerworkshop1",20)  // 超频升级x16
    .addInputs([
        <ic2:fluid_cell> * 4,
        <ore:circuitBasic> * 2,
        <ore:circuitAdvanced> * 2,
        <ore:plateSteel> * 3,
    ])
    .addFluidInput(<liquid:cryotheum> * 2000)
    .addOutputs(<ic2:upgrade> * 16)
    .build();
 

RecipeBuilder.newBuilder("mekanismgenerators_solarpanel_x3", "newengineerworkshop1",20)  // 太阳能板x3
    .addInputs([
        <ore:blockGlass> * 3,
        <enderio:item_material:38> * 3,
        <ore:circuitBasic> * 2,
        <mekanism:enrichedalloy> * 1,
    ])
    .addOutputs(<mekanismgenerators:solarpanel> * 3)
    .build();
 

RecipeBuilder.newBuilder("yjss_enderio_block_solar_panel_4", "newengineerworkshop1",20)  // 晶化光伏电池
    .addInputs([
        <ore:ingotCrystallineAlloy> * 3,
        <enderio:item_material:3> * 1,
        <enderio:item_capacitor_crystalline> * 1,
        <ore:enlightenedFusedQuartz> * 3,
        <enderio:block_solar_panel:3> * 1,
    ])
    .addOutputs(<enderio:block_solar_panel:4> * 3)
    .build();
 

RecipeBuilder.newBuilder("yjss_enderio_block_solar_panel_5", "newengineerworkshop1",20)  // 旋律光伏电池
    .addInputs([
        <ore:ingotMelodicAlloy> * 3,
        <ore:enlightenedFusedQuartz> * 3,
        <enderio:item_capacitor_melodic> * 1,
        <enderio:block_solar_panel:3> * 1,
        <enderio:item_material:3> * 1,
        <enderio:block_solar_panel:4> * 1,
    ])
    .addOutputs(<enderio:block_solar_panel:5> * 3)
    .build();
 

RecipeBuilder.newBuilder("yjss_enderio_block_solar_panel_6", "newengineerworkshop1",20)  // 恒星光伏电池
    .addInputs([
        <ore:ingotStellarAlloy> * 3,
        <enderio:item_capacitor_stellar> * 1,
        <enderio:block_solar_panel:4> * 1,
        <enderio:block_solar_panel:3> * 1,
        <ore:ingotMelodicAlloy> * 1,
        <enderio:block_solar_panel:5> * 1,
    ])
    .addOutputs(<enderio:block_solar_panel:6> * 3)
    .build();
 

RecipeBuilder.newBuilder("mets_te_17", "newengineerworkshop1",20)  // 高级太阳能板
    .addInputs([
        <ic2:te:8> * 2,
        <ore:plateCarbon> * 2,
        <ore:circuitElite> * 2,
        <enderio:item_material:3> * 1,
        <mets:advanced_lithium_battery> * 1,
    ])
    .addOutputs(<mets:te:17> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_18", "newengineerworkshop1",20)  // 光子振谐太阳能板
    .addInputs([
        <ic2:crafting:4> * 4,
        <ore:circuitElite> * 4,
        <ore:circuitUltimate> * 3,
        <enderio:item_material:3> * 3,
        <ic2:neutron_reflector> * 2,
        <contenttweaker:engineering_battery_v2> * 1,
        <mets:super_iridium_compress_plate> * 1,
    ])
    .addOutputs(<mets:te:18> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_20", "newengineerworkshop1",20)  // 终极光子振谐太阳能板
    .addInputs([
        <mets:living_circuit> * 3,
        <ore:circuitUltimate> * 3,
        <ic2:crafting:4> * 3,
        <enderio:block_solar_panel:3> * 3,
        <contenttweaker:engineering_battery_v2> * 2,
        <mets:super_iridium_compress_plate> * 2,
        <ic2:thick_neutron_reflector> * 2,
    ])
    .addOutputs(<mets:te:20> * 2)
    .build();
 

RecipeBuilder.newBuilder("mekanismgenerators_generator_1_x2", "newengineerworkshop1",20)  // 太阳能发电机x2
    .addInputs([
        <ore:dustOsmium> * 4,
        <mekanismgenerators:solarpanel> * 3,
        <ore:circuitBasic> * 3,
        <mekanism:enrichedalloy> * 2,
        <enderio:item_material:38> * 2,
        <mekanism:energytablet> * 1,
    ])
    .addOutputs(<mekanismgenerators:generator:1> * 2)
    .build();
 

RecipeBuilder.newBuilder("ic2_te_61_x4", "newengineerworkshop1",20)  // 物质生成机x4
    .addInputs([
        <ic2:plate:16> * 4,
        <ic2:resource:13> * 4,
        <ore:circuitUltimate> * 4,
        <ic2:thick_neutron_reflector> * 4,
        <thermalfoundation:material:262> * 4,
        <thermalfoundation:material:263> * 4,
    ])
    .addOutputs(<ic2:te:61> * 4)
    .build();
 

RecipeBuilder.newBuilder("mets_te_21_x2", "newengineerworkshop1",20)  // 地磁发电机x2
    .addInputs([
        <mets:titanium_plate> * 6,
        <ore:circuitElite> * 6,
        <mets:nano_living_metal> * 4,
        <ic2:te:5> * 4,
        <mets:te:3> * 2,
        <mets:te:2> * 1,
        <avaritia:resource> * 1,
        <mets:geomagnetic_antenna> * 1,
    ])
    .addOutputs(<mets:te:21> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_geomagnetic_pedestal_x5", "newengineerworkshop1",20)  // 电磁发电机基座x5
    .addInputs([
        <ic2:te:4> * 8,
        <mets:titanium_block> * 5,
        <mets:nano_living_metal> * 2,
        <ore:circuitElite> * 1,
        <ore:circuitUltimate> * 1,
    ])
    .addOutputs(<mets:geomagnetic_pedestal> * 5)
    .build();
 

RecipeBuilder.newBuilder("mets_geomagnetic_antenna_x3", "newengineerworkshop1",20)  // 地磁发电机天线x3
    .addInputs([
        <mets:superconducting_cable> * 8,
        <mets:nano_living_metal> * 5,
        <ic2:te:41> * 4,
    ])
    .addOutputs(<mets:geomagnetic_antenna> * 3)
    .build();
 

RecipeBuilder.newBuilder("mets_te_7", "newengineerworkshop1",20)  // 进阶高压压缩机
    .addInputs([
        <ore:plateTitanium> * 6,
        <ore:plateSteel> * 4,
        <minecraft:piston> * 2,
        <ore:circuitElite> * 2,
        <ic2:te:43> * 1,
    ])
    .addOutputs(<mets:te:7> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_6", "newengineerworkshop1",20)  // 进阶旋风打粉机
    .addInputs([
        <ore:plateTitanium> * 6,
        <ore:gemDiamond> * 4,
        <minecraft:flint> * 2,
        <ore:circuitElite> * 2,
        <ic2:te:47> * 1,
    ])
    .addOutputs(<mets:te:6> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_23", "newengineerworkshop1",20)  // 电力纳米高炉
    .addInputs([
        <mets:neutron_plate> * 8,
        <ic2:crafting:4> * 4,
        <ore:plateDenseSteel> * 4,
        <contenttweaker:field_generator_v1> * 2,
        <ic2:advanced_heat_exchanger> * 2,
        <ore:circuitUltimate> * 2,
        <ic2:te:12> * 2,
        <mets:te:5> * 1,
    ])
    .addOutputs(<mets:te:23> * 2)
    .build();
 

RecipeBuilder.newBuilder("world_energy_core", "newengineerworkshop1",20)  // 寰宇能源核心
    .addInputs([
        <contenttweaker:field_generator_v1> * 6,
        <draconicevolution:chaotic_core> * 1,
        <contenttweaker:crystalpurple> * 1,
        <contenttweaker:crystalred> * 1,
        <gravisuite:crafting:2> * 15,
        <avaritiaio:infinitecapacitor> * 1,
    ])
    .addOutputs(<contenttweaker:world_energy_core> * 3)
    .build();
 

RecipeBuilder.newBuilder("chaos_radiation_core", "newengineerworkshop1",20)  // 混沌超辐射核心
    .addInputs([
        <draconicadditions:chaotic_energy_core> * 2,
        <draconicevolution:chaotic_core> * 1,
    ])
    .addOutputs(<contenttweaker:chaos_radiation_core> * 2)
    .build();
 

RecipeBuilder.newBuilder("pure_crystal_synthesis_instrument_controller", "newengineerworkshop1",20)  // 纯晶合成仪控制器
    .addInputs([
        <contenttweaker:industrial_circuit_v1> * 8,
        <contenttweaker:industrial_circuit_v2> * 4,
        <appliedenergistics2:smooth_sky_stone_block> * 4,
        <contenttweaker:field_generator_v1> * 1,
        <modularmachinery:blockcasing> * 1,
    ])
    .addOutputs(<modularmachinery:pure_crystal_synthesis_instrument_controller> * 2)
    .build();
 

RecipeBuilder.newBuilder("purpur_furance_factory_controller", "newengineerworkshop1",20)  // 紫珀炉集成控制器
    .addInputs([
        <minecraft:end_bricks> * 8,
        <minecraft:purpur_block> * 6,
        <minecraft:furnace> * 3,
        <minecraft:iron_ingot> * 2,
        <modularmachinery:blockcasing> * 1,
    ])
    .addOutputs(<modularmachinery:purpur_furance_factory_controller> * 2)
    .build();
 

RecipeBuilder.newBuilder("tinymobfarm_gold_farm", "newengineerworkshop1",20)  // 金制生物农场
    .addInputs([
        <ore:holyFusedQuartz> * 11,
        <ore:blockGold> * 5,
        <ore:circuitElite> * 2,
        <tinymobfarm:iron_farm> * 1,
    ])
    .addOutputs(<tinymobfarm:gold_farm> * 2)
    .build();
 

RecipeBuilder.newBuilder("tinymobfarm_diamond_farm", "newengineerworkshop1",20)  // 钻石生物农场
    .addInputs([
        <ore:holyFusedQuartz> * 11,
        <ore:blockDiamond> * 4,
        <mekanism:controlcircuit:3> * 2,
        <ore:blockWillowalloy> * 1,
        <tinymobfarm:gold_farm> * 1,
    ])
    .addOutputs(<tinymobfarm:diamond_farm> * 2)
    .build();
 

RecipeBuilder.newBuilder("draconicevolution_crafting_injector", "newengineerworkshop1",20)  // 基础注入合成装置
    .addInputs([
        <appliedenergistics2:smooth_sky_stone_block> * 6,
        <ore:gearWillowalloy> * 2,
        <enderio:item_alloy_ingot:2> * 2,
        <redstonerepository:material:1> * 2,
        <draconicevolution:draconium_ingot> * 2,
        <draconicevolution:draconic_core> * 1,
        <botania:manaresource:7> * 1,
        <ore:ingotPsiAlloy> * 1,
        <ore:blockDiamond> * 1,
    ])
    .addOutputs(<draconicevolution:crafting_injector> * 3)
    .build();
 

RecipeBuilder.newBuilder("super_solar_panels_machines_25", "newengineerworkshop1",20)  // 分子重组仪
    .addInputs([
        <ic2:resource:11> * 8,
        <ic2:resource:13> * 8,
        <super_solar_panels:crafting:9> * 4,
        <enderio:item_capacitor_melodic> * 1,
        <ore:circuitElite> * 1,
        <mets:te:33> * 1,
    ])
    .addOutputs(<super_solar_panels:machines:25> * 3)
    .build();
 

RecipeBuilder.newBuilder("deepmoblearning_trial_keystone", "newengineerworkshop1",20)  // 测试楔石
    .addInputs([
        <super_solar_panels:crafting:44> * 2,
        <ore:circuitUltimate> * 2,
        <ic2:crafting:4> * 2,
        <mets:nano_living_metal> * 2,
        <ore:gearDimensionalShard> * 2,
        <deepmoblearning:trial_key> * 1,
        <contenttweaker:field_generator_v1> * 1,
        <deepmoblearning:machine_casing> * 1,
        <mets:living_circuit> * 1,
        <ic2:resource:13> * 1,
    ])
    .addOutputs(<deepmoblearning:trial_keystone> * 1)
    .build();
 

RecipeBuilder.newBuilder("deepmoblearning_simulation_chamber", "newengineerworkshop1",20)  // 模拟室
    .addInputs([
        <ore:plateEmerald> * 8,
        <ore:plateDimensionalShard> * 8,
        <ore:circuitElite> * 4,
        <mets:living_circuit> * 2,
        <deepmoblearning:machine_casing> * 2,
        <tinymobfarm:diamond_farm> * 1,
    ])
    .addOutputs(<deepmoblearning:simulation_chamber> * 2)
    .build();
 

RecipeBuilder.newBuilder("contenttweaker_hypernet_cpu_t1", "newengineerworkshop1",20)  // HyperNet CPU模块(等级1)
    .addInputs([
        <moreplates:empowered_palis_plate> * 6,
        <mekanism:controlcircuit:1> * 6,
        <appliedenergistics2:material:16> * 6,
        <appliedenergistics2:material:20> * 6,
    ])
    .addOutputs(<contenttweaker:hypernet_cpu_t1> * 3)
    .build();
 

RecipeBuilder.newBuilder("contenttweaker_hypernet_ram_t1", "newengineerworkshop1",20)  // HyperNet 内存模块(等级1)
    .addInputs([
        <moreplates:empowered_palis_plate> * 6,
        <appliedenergistics2:material:18> * 6,
        <appliedenergistics2:material:20> * 6,
        <mekanism:controlcircuit:1> * 3,
        <ore:dustGold> * 8,
    ])
    .addOutputs(<contenttweaker:hypernet_ram_t1> * 3)
    .build();
 

RecipeBuilder.newBuilder("ic2_te_77", "newengineerworkshop1",20)  // 低压变压器
    .addInputs([
        <ore:plankWood> * 6,
        <enderio:item_power_conduit> * 1,
        <enderio:item_endergy_conduit:3> * 1,
        <ic2:crafting:5> * 1,
    ])
    .addOutputs(<ic2:te:77> * 2)
    .build();
 

RecipeBuilder.newBuilder("ic2_te_78", "newengineerworkshop1",20)  // 中压变压器
    .addInputs([
        <enderio:item_power_conduit> * 1,
        <enderio:item_endergy_conduit:6> * 1,
        <ic2:resource:12> * 1,
    ])
    .addOutputs(<ic2:te:78> * 2)
    .build();
 

RecipeBuilder.newBuilder("ic2_te_79", "newengineerworkshop1",20)  // 高压变压器
    .addInputs([
        <ore:circuitBasic> * 2,
        <mekanism:energytablet> * 2,
        <enderio:item_endergy_conduit:7> * 2,
        <enderio:item_endergy_conduit:6> * 2,
        <ic2:resource:12> * 1,
    ])
    .addOutputs(<ic2:te:79> * 2)
    .build();
 

RecipeBuilder.newBuilder("ic2_te_80", "newengineerworkshop1",20)  // 超高压变压器
    .addInputs([
        <enderio:item_endergy_conduit:8> * 4,
        <ore:circuitAdvanced> * 2,
        <enderio:item_basic_capacitor:2> * 1,
        <enderio:item_capacitor_crystalline> * 1,
        <ic2:resource:13> * 1,
    ])
    .addOutputs(<ic2:te:80> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_33", "newengineerworkshop1",20)  // 特高压变压器
    .addInputs([
        <ore:circuitElite> * 2,
        <enderio:item_endergy_conduit:8> * 2,
        <enderio:item_endergy_conduit:10> * 2,
        <ic2:resource:13> * 2,
        <enderio:item_capacitor_melodic> * 1,
    ])
    .addOutputs(<mets:te:33> * 2)
    .build();
 

RecipeBuilder.newBuilder("mets_te_34", "newengineerworkshop1",20)  // 剧差压变压器
    .addInputs([
        <mets:nano_living_metal> * 4,
        <ic2:resource:13> * 4,
        <enderio:item_endergy_conduit:10> * 2,
        <enderio:item_endergy_conduit:11> * 2,
        <ore:circuitUltimate> * 2,
        <enderio:item_capacitor_melodic> * 1,
        <enderio:item_capacitor_stellar> * 1,
    ])
    .addOutputs(<mets:te:34> * 2)
    .build();
 


// ———— 设计师作坊 ————
RecipeBuilder.newBuilder("mach_crafter_controller", "newengineerworkshop1",20)  // 机械核心装配机控制器
    .addInputs([
        <minecraft:quartz_block:2> * 6,
        <ore:circuitBasic> * 4,
        <ore:ingotSteel> * 4,
        <minecraft:iron_block> * 3,
        <ore:workbench> * 2,
        <ore:circuitAdvanced> * 1,
    ])
    .addOutputs(<modularmachinery:mach_crafter_controller> * 2)
    .build();
 

RecipeBuilder.newBuilder("cosmic_ray_receiver_controller", "newengineerworkshop1",20)  // 宇宙射线接收器控制器
    .addInputs([
        <psi:psi_decorative:4> * 4,
        <ore:blockConstructionAlloy> * 4,
        <ore:blockPsiMetal> * 4,
        <contenttweaker:industrial_circuit_v1> * 2,
        <contenttweaker:sensor_v1> * 1,
        <ore:circuitElite> * 1,
        <ore:blockOsmium> * 1,
    ])
    .addOutputs(<modularmachinery:cosmic_ray_receiver_controller> * 2)
    .build();
 

RecipeBuilder.newBuilder("energy_releaser_controller", "newengineerworkshop1",20)  // 释能器控制器
    .addInputs([
        <ore:dustCryotheum> * 4,
        <contenttweaker:field_generator_v1> * 2,
        <mets:te:33> * 2,
        <ore:blockSignalum> * 2,
        <ore:blockLumium> * 2,
        <ore:blockEnderium> * 1,
        <contenttweaker:energized_fuel_v1> * 1,
    ])
    .addOutputs(<modularmachinery:energy_releaser_controller> * 2)
    .build();
 

RecipeBuilder.newBuilder("advanced_energy_releaser_controller", "newengineerworkshop1",20)  // 高级释能器控制器
    .addInputs([
        <contenttweaker:industrial_circuit_v2> * 6,
        <ore:blockCosmicNeutronium> * 2,
        <contenttweaker:energized_fuel_v1> * 2,
        <super_solar_panels:crafting:10> * 1,
        <ore:blockCrystalMatrix> * 1,
        <ore:ingotOrichalcos> * 1,
        <modularmachinery:energy_releaser_controller> * 1,
    ])
    .addOutputs(<modularmachinery:advanced_energy_releaser_controller> * 2)
    .build();
 


// ———— 法师作坊 ————
RecipeBuilder.newBuilder("bot_crafter_factory_controller", "newengineerworkshop1",20)  // 魔力聚合机集成控制器
    .addInputs([
        <contenttweaker:industrial_circuit_v1> * 8,
        <botania:livingrock> * 8,
        <ic2:resource:12> * 2,
        <ore:circuitElite> * 2,
        <ore:ingotCrystalMatrix> * 2,
        <contenttweaker:field_generator_v1> * 2,
        <botania:livingwood> * 2,
        <super_solar_panels:crafting:15> * 2,
        <extrabotany:ultimatehammer> * 2,
        <modularmachinery:blockcasing> * 1,
        <botania:pool> * 1,
        <ore:ingotOrichalcos> * 1,
    ])
    .addOutputs(<modularmachinery:bot_crafter_factory_controller> * 2)
    .build();
 


// ———— 基础作坊 ————
RecipeBuilder.newBuilder("ic2_crafting_5", "newengineerworkshop1",20)  // 线圈
    .addInputs([
        <ic2:casing:1> * 8,
        <minecraft:iron_ingot> * 1
    ])
    .addOutputs(<ic2:crafting:5> * 1)
    .build();
 


// ———— 石匠作坊 ————
RecipeBuilder.newBuilder("ic2_resource_11_x4", "newengineerworkshop1",20)  // 防爆石x4
    .addInputs([
        <ic2:scaffold:2> * 4,
        <minecraft:sand> * 4,
        <ic2:crafting:25> * 1
    ])
    .addFluidInput(<liquid:water> * 1000)
    .addOutputs(<ic2:resource:11> * 4)
    .build();

RecipeBuilder.newBuilder("bedrock1", "newengineerworkshop1",20)  // 基岩x4
    .addFluidInput(<liquid:cryotheum> * 1000)
    .addFluidInput(<liquid:pyrotheum> * 1000)
    .addOutputs(<minecraft:bedrock> * 1)
    .build();
 

// ———— 铁匠作坊 ————
RecipeBuilder.newBuilder("ic2_plate_9", "newengineerworkshop1",20)  // 致密青铜板
    .addInputs([
        <ore:ingotBronze> * 9,
    ])
    .addOutputs(<ic2:plate:9> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_10", "newengineerworkshop1",20)  // 致密铜板
    .addInputs([
        <ore:ingotCopper> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:10> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_11", "newengineerworkshop1",20)  // 致密金板
    .addInputs([
        <ore:ingotGold> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:11> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_12", "newengineerworkshop1",20)  // 致密铁板
    .addInputs([
        <ore:ingotIron> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:12> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_13", "newengineerworkshop1",20)  // 致密青金石板
    .addInputs([
        <minecraft:dye:4> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:13> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_14", "newengineerworkshop1",20)  // 致密铅板
    .addInputs([
        <ore:ingotLead> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:14> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_15", "newengineerworkshop1",20)  // 致密黑曜石板
     .addInputs([
        <minecraft:obsidian> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:15> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_16", "newengineerworkshop1",20)  // 致密钢板
    .addInputs([
        <ore:ingotSteel> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:16> * 1)
    .build();
 

RecipeBuilder.newBuilder("ic2_plate_17", "newengineerworkshop1",20)  // 致密锡板
    .addInputs([
        <ore:ingotTin> * 9,
    ])
    .addInput(<ore:artisansHammer>).setChance(0)
    .addOutputs(<ic2:plate:17> * 1)
    .build();
 

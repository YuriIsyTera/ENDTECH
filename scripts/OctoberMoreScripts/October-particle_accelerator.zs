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

MachineModifier.setInternalParallelism("particle_accelerator", 120000);

MachineModifier.setMaxThreads("particle_accelerator",120);

MachineModifier.addCoreThread("particle_accelerator", FactoryRecipeThread.createCoreThread("多重粒子迸变加速"));

var recipeCounter = 0;


// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//==================================粒子加速器控制器==============================
//粒子加速器_控制器
RecipeBuilder.newBuilder("marbleslab_controller", "workshop", 200)
    .addEnergyPerTickInput(300000)
    .addInput(<mekanism:module_energy_unit> * 128)
    .addInput(<mekanism:module_magnetic_unit> * 128)
    .addInput(<taiga:proxii_block> * 128)
    .addInput(<enderio:block_alloy:6> * 64)
    .addInput(<moreplates:neutronium_plate> * 128)
    .addInput(<contenttweaker:coil_v5> * 6)
    .addInput(<avaritia:neutronium_compressor> * 3)
    .addInput(<mets:neutron_plate> * 256)
    .addOutput(<modularmachinery:particle_accelerator_controller>)
    .requireComputationPoint(4000.0F)
    .requireResearch("Surmount-AE")
    .build();

//粒子加速器_集成控制器
RecipeBuilder.newBuilder("marbleslab_factory_controller", "workshop", 400)
    .addEnergyPerTickInput(300000)
    .addInput(<mekanism:module_energy_unit> * 256)
    .addInput(<mekanism:module_magnetic_unit> * 256)
    .addInput(<taiga:proxii_block> * 64)
    .addInput(<enderio:block_alloy:6> * 128)
    .addInput(<moreplates:neutronium_plate> * 128)
    .addInput(<contenttweaker:coil_v5> * 12)
    .addInput(<avaritia:neutronium_compressor> * 6)
    .addInput(<mets:neutron_plate> * 512)
    .addOutput(<modularmachinery:particle_accelerator_factory_controller>)
    .requireComputationPoint(10000.0F)
    .requireResearch("Surmount-AE")
    .build();




//异变光子核心
RecipeBuilder.newBuilder("accelerator-3", "particle_accelerator", 60)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:34> * 1)
    .addOutput(<additions:novaextended-phocore_2> * 1)
    .build();
recipeCounter += 1;

//中子核心
RecipeBuilder.newBuilder("accelerator-4", "particle_accelerator", 60)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:29> * 1)
    .addOutput(<super_solar_panels:crafting:30> * 5)
    .build();
recipeCounter += 1;

//质子核心
RecipeBuilder.newBuilder("accelerator-5", "particle_accelerator", 60)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:27> * 1)
    .addOutput(<super_solar_panels:crafting:25> * 5)
    .build();
recipeCounter += 1;

//光子核心
RecipeBuilder.newBuilder("accelerator-6", "particle_accelerator", 30)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:35> * 1)
    .addOutput(<super_solar_panels:crafting:34> * 1)
    .build();
recipeCounter += 1;

//管理员核心
RecipeBuilder.newBuilder("accelerator-7", "particle_accelerator", 30)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:21> * 1)
    .addOutput(<super_solar_panels:crafting:35> * 1)
    .build();
recipeCounter += 1;

//奇异核心
RecipeBuilder.newBuilder("accelerator-8", "particle_accelerator", 30)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:22> * 1)
    .addOutput(<super_solar_panels:crafting:21> * 1)
    .build();
recipeCounter += 1;

//光谱核心
RecipeBuilder.newBuilder("accelerator-9", "particle_accelerator", 30)
    .addEnergyPerTickInput(3000)
    .addInput(<super_solar_panels:crafting:13> * 1)
    .addOutput(<super_solar_panels:crafting:22> * 1)
    .build();
recipeCounter += 1;

//力场发生器（1级）
RecipeBuilder.newBuilder("accelerator-10", "particle_accelerator", 20)
    .addEnergyPerTickInput(3000)
    .addInput(<minecraft:nether_star> * 1)
    .addOutput(<contenttweaker:field_generator_v1> * 1)
    .build();
recipeCounter += 1;

//力场发生器（2级）
RecipeBuilder.newBuilder("accelerator-11", "particle_accelerator", 20)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:field_generator_v1> * 1)
    .addOutput(<contenttweaker:field_generator_v2> * 1)
    .build();
recipeCounter += 1;

//力场发生器（3级）
RecipeBuilder.newBuilder("accelerator-12", "particle_accelerator", 20)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:field_generator_v2> * 1)
    .addOutput(<contenttweaker:field_generator_v3> * 1)
    .build();
recipeCounter += 1;


//究极控制电路
RecipeBuilder.newBuilder("accelerator-14", "particle_accelerator", 30)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:exponential_level_processor> * 1)
    .addOutput(<additions:novaextended-extremecircuit> * 1)
    .build();
recipeCounter += 1;


//工程电池（4级）
RecipeBuilder.newBuilder("accelerator-16", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:engineering_battery_v3> * 1)
    .addOutput(<contenttweaker:engineering_battery_v4> * 1)
    .build();
recipeCounter += 1;

//工程电池（3级）
RecipeBuilder.newBuilder("accelerator-17", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:engineering_battery_v2> * 1)
    .addOutput(<contenttweaker:engineering_battery_v3> * 1)
    .build();
recipeCounter += 1;

//工程电池（2级）
RecipeBuilder.newBuilder("accelerator-18", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:engineering_battery_v1> * 1)
    .addOutput(<contenttweaker:engineering_battery_v2> * 1)
    .build();
recipeCounter += 1;


//工程电路（3级）
RecipeBuilder.newBuilder("accelerator-20", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:industrial_circuit_v2> * 1)
    .addOutput(<contenttweaker:industrial_circuit_v3> * 1)
    .build();
recipeCounter += 1;

//工程电路（2级）
RecipeBuilder.newBuilder("accelerator-21", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:industrial_circuit_v1> * 1)
    .addOutput(<contenttweaker:industrial_circuit_v2> * 1)
    .build();
recipeCounter += 1;



//充能燃料单元（3级）
RecipeBuilder.newBuilder("accelerator-23", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:energized_fuel_v2> * 1)
    .addOutput(<contenttweaker:energized_fuel_v3> * 1)
    .build();
recipeCounter += 1;

//充能燃料单元（2级）
RecipeBuilder.newBuilder("accelerator-24", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:energized_fuel_v1> * 1)
    .addOutput(<contenttweaker:energized_fuel_v2> * 1)
    .build();
recipeCounter += 1;

//充能燃料单元（1级）
RecipeBuilder.newBuilder("accelerator-25", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<botania:manaresource:23> * 8)
    .addOutput(<contenttweaker:energized_fuel_v1> * 1)
    .build();
recipeCounter += 1;



//合金线圈（4级）
RecipeBuilder.newBuilder("accelerator-27", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:coil_v3> * 1)
    .addOutput(<contenttweaker:coil_v4> * 1)
    .build();
recipeCounter += 1;

//合金线圈（3级）
RecipeBuilder.newBuilder("accelerator-28", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:coil_v2> * 1)
    .addOutput(<contenttweaker:coil_v3> * 1)
    .build();
recipeCounter += 1;





//机械臂（3级）
RecipeBuilder.newBuilder("accelerator-31", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:robot_arm_v2> * 1)
    .addOutput(<contenttweaker:robot_arm_v3> * 1)
    .build();
recipeCounter += 1;

//机械臂（2级）
RecipeBuilder.newBuilder("accelerator-32", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:robot_arm_v1> * 1)
    .addOutput(<contenttweaker:robot_arm_v2> * 1)
    .build();
recipeCounter += 1;

//机械臂（1级）
RecipeBuilder.newBuilder("accelerator-33", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<libvulpes:productrod:1> * 2)
    .addOutput(<contenttweaker:robot_arm_v1> * 1)
    .build();
recipeCounter += 1;

//传感器（4级）
RecipeBuilder.newBuilder("accelerator-34", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:sensor_v3> * 1)
    .addOutput(<contenttweaker:sensor_v4> * 1)
    .build();
recipeCounter += 1;



//传感器（3级）
RecipeBuilder.newBuilder("accelerator-36", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:sensor_v2> * 1)
    .addOutput(<contenttweaker:sensor_v3> * 1)
    .build();
recipeCounter += 1;

//传感器（2级）
RecipeBuilder.newBuilder("accelerator-37", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:sensor_v1> * 1)
    .addOutput(<contenttweaker:sensor_v2> * 1)
    .build();
recipeCounter += 1;

//传感器（1级）
RecipeBuilder.newBuilder("accelerator-38", "particle_accelerator", 40)
    .addEnergyPerTickInput(3000)
    .addInput(<moreplates:tin_stick> * 2)
    .addOutput(<contenttweaker:sensor_v1> * 1)
    .build();
recipeCounter += 1;
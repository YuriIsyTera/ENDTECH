#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import mods.modularmachinery.Sync;
import mods.modularmachinery.GeoMachineModel;
import mods.modularmachinery.ControllerModelAnimationEvent;
import mods.contenttweaker.Commands;

import crafttweaker.world.IBlockPos;
import crafttweaker.util.Math;
import crafttweaker.event.PlayerInteractBlockEvent;
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
import crafttweaker.block.IBlockState;
import crafttweaker.block.IBlock;
import crafttweaker.player.IPlayer;
import mods.jei.JEI;
import mods.randomtweaker.jei.IJeiUtils;
import crafttweaker.item.IItemDefinition;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

GeoMachineModel.registerGeoMachineModel("blackhole_core",
    "modularmachinery:geo/blackhole_core.geo.json",
    "modularmachinery:textures/blackhole_core.png",
    "modularmachinery:animations/blackhole_core.animation.json"
);
GeoMachineModel.registerGeoMachineModel("singularity_core_sp",
    "modularmachinery:geo/singularity_core_sp.geo.json",
    "modularmachinery:textures/singularity_core_sp.png",
    "modularmachinery:animations/singularity_core_sp.animation.json"
);
GeoMachineModel.registerGeoMachineModel("research_station_sp",
    "modularmachinery:geo/giga_researchstation.geo.json",
    "modularmachinery:textures/giga_researchstation.png",
    "modularmachinery:animations/giga_researchstation.animation.json"
);
GeoMachineModel.registerGeoMachineModel("research_station_t4",
    "modularmachinery:geo/research_station_t4.geo.json",
    "modularmachinery:textures/research_station_t4.png",
    "modularmachinery:animations/research_station_t4.animation.json"
);
GeoMachineModel.registerGeoMachineModel("giga_godforge",
    "modularmachinery:geo/giga_godforge.geo.json",
    "modularmachinery:textures/giga_godforge.png",
    "modularmachinery:animations/giga_godforge.animation.json"
);
GeoMachineModel.registerGeoMachineModel("giga_darkmatterfussion",
    "modularmachinery:geo/darkmatter_fussion.geo.geo.json",
    "modularmachinery:textures/darkmatter_fussion.geo.png",
    "modularmachinery:animations/darkmatter_fussion.geo.animation.json"
);
HyperNetHelper.proxyMachineForHyperNet("giga_arcanceassemblyline");
MachineModifier.setMaxThreads("giga_dimensionallytranscendentplasmaforge", 0);
MachineModifier.setMaxThreads("giga_cosmiccasket", 0);
MachineModifier.setMaxThreads("giga_timespacesingularity", 0);
MachineModifier.setMaxThreads("giga_arcanceassemblyline", 0);
MachineModifier.setMaxThreads("giga_dimensionallyfocusengravingarray", 0);
MachineModifier.setMaxThreads("giga_hyperlimitresearchstation", 0);
MachineModifier.setMaxThreads("giga_godforge", 0);
MachineModifier.addCoreThread("giga_arcanceassemblyline", FactoryRecipeThread.createCoreThread("§d灵能§e转化单元§f"));
MachineModifier.addCoreThread("giga_arcanceassemblyline", FactoryRecipeThread.createCoreThread("§d灵能§e合成单元§f"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e矩阵中枢§f"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#1"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#2"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#3"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#4"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#5"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#6"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#7"));
MachineModifier.addCoreThread("giga_dimensionallyfocusengravingarray", FactoryRecipeThread.createCoreThread("§1超维度§9激光蚀刻§e单元§f#8"));
MachineModifier.addCoreThread("giga_godforge", FactoryRecipeThread.createCoreThread("§z诸神之锻炉中枢控制器§f"));
MachineModifier.setMachineGeoModel("giga_timespacesingularity", "miniature_cosmic_resource_collector");
MachineModifier.setMachineGeoModel("giga_blackholecore", "blackhole_core");
MachineModifier.setMachineGeoModel("giga_singularitycore", "singularity_core_sp");
MachineModifier.setMachineGeoModel("giga_hyperlimitresearchstation", "research_station_sp");
MachineModifier.setMachineGeoModel("mega_researchstationt4", "research_station_t4");
MachineModifier.setMachineGeoModel("giga_godforge", "giga_godforge");
MachineModifier.setMachineGeoModel("giga_masscore", "blackhole_core");
# MachineModifier.setMachineGeoModel("giga_darkmatterfussion_renderer", "giga_darkmatterfussion");
//§f编程电路
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_0>,[<contenttweaker:programming_circuit_0>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_a>,[<contenttweaker:programming_circuit_a>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_b>,[<contenttweaker:programming_circuit_b>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_c>,[<contenttweaker:programming_circuit_c>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_d>,[<contenttweaker:programming_circuit_d>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_e>,[<contenttweaker:programming_circuit_e>,<contenttweaker:degenerationmatter>]);
recipes.addShapeless(<contenttweaker:advanced_programming_circuit_f>,[<contenttweaker:programming_circuit_f>,<contenttweaker:degenerationmatter>]);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_0>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_a>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_b>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_c>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_d>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_e>);
<ore:programmingCircuit>.add(<contenttweaker:advanced_programming_circuit_f>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_0>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_a>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_b>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_c>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_d>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_e>);
<ore:AdvancedProgrammingCircuit>.add(<contenttweaker:advanced_programming_circuit_f>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_0>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_a>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_b>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_c>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_d>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_e>);
<ore:BasicProgrammingCircuit>.add(<contenttweaker:programming_circuit_f>);

MMEvents.onControllerModelAnimation("giga_timespacesingularity", function(event as ControllerModelAnimationEvent) {
    // 为"安装"状态设置动画 "installation"单次
    event.addAnimation("installation_off");
    event.addAnimation("installation_load_00");
    event.addAnimation("installation_load_01");
    event.addAnimation("installation_load_02");
    event.addAnimation("installation_load_03");
    event.addAnimation("installation_load_04");
    event.addAnimation("installation_load_00");
    event.addAnimation("run_04", true);
});
MMEvents.onControllerModelAnimation("giga_blackholecore", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("scalechange_01", true);
});
MMEvents.onControllerModelAnimation("giga_singularitycore", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("run_all_01", true);
});
MMEvents.onControllerModelAnimation("giga_hyperlimitresearchstation", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("run_01", true);
});
MMEvents.onControllerModelAnimation("giga_godforge", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("rotation_01");
});#
MMEvents.onControllerModelAnimation("giga_masscore", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("scalechange_01", true);
});
# MMEvents.onControllerModelAnimation("giga_darkmatterfussion_renderer", function(event as ControllerModelAnimationEvent) {
#     event.addAnimation("run_01");
# });
MMEvents.onControllerGUIRender("giga_dimensionallyfocusengravingarray",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val DFEA_lens_durability = data.getInt("DFEA_lens_durability",0);
    var info as string[]=[];
    info += "§a////////////§1超维度§9激光蚀刻§e矩阵§f控制台§a////////////";
    if(DFEA_lens_durability < 1){
        info += "§4尚未输入透镜或耐久值小于等于零§f";
    }
    if(DFEA_lens_durability > 0){
        info += "当前§3透镜§f剩余耐久值 : " + DFEA_lens_durability;
    }
    event.extraInfo = info;
});
RecipeBuilder.newBuilder("giga_aal_upkeep", "giga_arcanceassemblyline", 12000)
    .addInput(<contenttweaker:shroudchunk> * 1).setChance(0.01)
    .addInput(<contenttweaker:shroudplanet> * 1)
    .addInput(<contenttweaker:voidmatter> * 160)
    .setThreadName("§d灵能§e转化单元§f")
    .addRecipeTooltip("使用§8虚空能§f为巨型装配矩阵提供基础功能。")
    .addRecipeTooltip("通过§5虚境§e观测站§f的数据确定一颗§5虚境星球§f的位置。")
    .addRecipeTooltip("将§5虚境星球§f转化§d灵能§f为我们所用。")
    .setParallelized(false)
    .requireResearch("Mega-ShroudConsciousness")
    .requireComputationPoint(80000.0F)
    .build();
RecipeBuilder.newBuilder("arcance_soc","giga_arcanceassemblyline",400)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000,
        <liquid:spaceframefluid> * 10000,
        <liquid:tachyonfluid> * 10000,
    ])
    .addInputs([
        <contenttweaker:arkchip> * 8,
        <contenttweaker:nanites> * 256,
        <contenttweaker:arcance_ingot> * 16,
        <contenttweaker:nova_ingot> * 24,
        <contenttweaker:antimatter_core> * 32,
        <contenttweaker:world_energy_core> * 64,
        <contenttweaker:spacetimeframework> * 64,
        <contenttweaker:darkmatters> * 64,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-DimensionFocusEngraving")
    .addOutput(<contenttweaker:arcance_soc>)
    .requireComputationPoint(8000000.0)
    .build();
RecipeBuilder.newBuilder("arcance_lens","giga_arcanceassemblyline",120)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000
    ])
    .addInputs([
        <contenttweaker:nanites> * 256,
        <contenttweaker:constructunit> * 256,
        <contenttweaker:phantom_calculation_array>,
        <contenttweaker:opticsunit> * 64,
        <contenttweaker:arcance_ingot> * 16,
        <contenttweaker:spacetime_lens> * 32
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-DimensionFocusEngraving")
    .addOutput(<contenttweaker:arcance_lens>)
    .requireComputationPoint(8000000.0)
    .build();
RecipeBuilder.newBuilder("hyperdimensional_lens","giga_arcanceassemblyline",120)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000
    ])
    .addInputs([
        <contenttweaker:nanoswarm> * 64,
        <contenttweaker:nanites> * 512,
        <contenttweaker:constructunit> * 512,
        <contenttweaker:arcance_soc>,
        <contenttweaker:opticsunit> * 256,
        <contenttweaker:arcance_ingot> * 16,
        <contenttweaker:arcance_lens>
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-DimensionFocusEngraving")
    .addOutput(<contenttweaker:hyperdimensional_lens>)
    .requireComputationPoint(8000000.0)
    .build();
RecipeBuilder.newBuilder("hyperdimensional_computer","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(100000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:xprotonfluid> * 100000000,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:nanites> * 512,
        <contenttweaker:hyperdimensional_soc> * 1,
        <contenttweaker:phantom_calculation_array> * 4,
        <contenttweaker:arkchip> * 16,
        <contenttweaker:spacetimeframework> * 256,
        <contenttweaker:wisecore> * 64,
        <contenttweaker:becmemory> * 256,
        <contenttweaker:beccomputer> * 256,
        <contenttweaker:infinitychip> * 64,
        <contenttweaker:neutronchip> * 128,
        <contenttweaker:universalalloychip> * 256,
        <contenttweaker:crystalchip> * 512,
        <contenttweaker:synthesischip> * 1024,
        <contenttweaker:similardarkmatter> * 64,
        <contenttweaker:infinity_frame> * 64,
        <contenttweaker:arcancemachineblock> * 64
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addRecipeTooltip("§1无§3限§9神§b机§f")
    .requireResearch("Giga-DimensionFocusEngraving")
    .addOutput(<contenttweaker:hyperdimensional_computer> * 16)
    .requireComputationPoint(40000000.0)
    .build();
RecipeBuilder.newBuilder("overreachedspace_blueprint","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(100000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:xprotonfluid> * 100000000,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:nanites> * 512,
        <contenttweaker:hyperdimensional_computer>,
        <contenttweaker:nanoglassmetal> * 2048,
        <contenttweaker:cfcm> * 2048,
        <contenttweaker:arcance_ingot> * 32,
        <contenttweaker:dust> * 16384,
        <contenttweaker:similardarkmatter> * 64,
        <contenttweaker:axis_blueprint>,
        <contenttweaker:mineral> * 16384
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-DimensionFocusEngraving")
    .addOutput(<contenttweaker:overreachedspace_blueprint> * 512)
    .requireComputationPoint(40000000.0)
    .build();
RecipeBuilder.newBuilder("cosmiccasket_core","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:fluid_nova_alloy> * 14400,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:nanites> * 512,
        <contenttweaker:hyperdimensional_computer>,
        <contenttweaker:negativephase_matter> * 512,
        <contenttweaker:psm_core>,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-CosmicCasket")
    .addOutput(<contenttweaker:cosmiccasket_core>)
    .requireComputationPoint(10000000.0)
    .build();
RecipeBuilder.newBuilder("singularity_core","giga_arcanceassemblyline",720)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 100000,
        <liquid:fluid_nova_alloy> * 14400,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:nanoswarm> * 64,
        <contenttweaker:constructunit> * 1280,
        <contenttweaker:alloy> * 1048576,
        <contenttweaker:darkmatters> * 32768,
        <contenttweaker:arcance_ingot> * 64,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-Doomsday")
    .addOutput(<modularmachinery:giga_singularitycore_controller>)
    .requireComputationPoint(10000000.0)
    .build();
RecipeBuilder.newBuilder("singularity_core_ctrl","giga_arcanceassemblyline",720)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 100000,
        <liquid:fluid_nova_alloy> * 14400,
        <liquid:spaceframefluid> * 1000000,
        <liquid:tachyonfluid> * 1000000
    ])
    .addInputs([
        <contenttweaker:hyperdimensional_blueprint>,
        <contenttweaker:nanites> * 512,
        <contenttweaker:constructunit> * 512,
        <advancedrocketry:misc> * 16,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-Doomsday")
    .addOutput(<modularmachinery:giga_negativephasecollector_factory_controller>)
    .requireComputationPoint(10000000.0)
    .build();
RecipeBuilder.newBuilder("timespace_coil_block","giga_arcanceassemblyline",900)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:xprotonfluid> * 100000000,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:hyperdimensional_soc>,
        <contenttweaker:neutron_coil_discs> * 64,
        <contenttweaker:novamatrix>,
        <contenttweaker:starvoidstructure> * 8,
        <contenttweaker:superspace_star_controlmatrix> * 8,
        <contenttweaker:entropy_singularity>,
        <contenttweaker:timespace_ingot> * 8,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-TimeSpaceCoil")
    .addOutput(<contenttweaker:timespace_coil_block>)
    .requireComputationPoint(1000000.0)
    .build();
RecipeBuilder.newBuilder("superspacestructure","giga_arcanceassemblyline",900)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:fluid_nova_alloy> * 1440,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:hyperdimensional_lens>,
        <contenttweaker:arkchip> * 8,
        <contenttweaker:stablestructure> * 256,
        <contenttweaker:space_engblock> * 256,
        <contenttweaker:darkmatterblock> * 64,
        <contenttweaker:novamatrix>,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<contenttweaker:superspacestructure> * 16)
    .requireComputationPoint(100000.0)
    .build();
RecipeBuilder.newBuilder("se_core_aal","giga_arcanceassemblyline",900)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addInput(<contenttweaker:hyperdimensional_blueprint>).setChance(0)
    .addInputs(<contenttweaker:alloy> * 8192)
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<contenttweaker:se_core>)
    .requireComputationPoint(100000.0)
    .build();
RecipeBuilder.newBuilder("arcane_spacetime_expansion_generator","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000,
        <liquid:fluid_nova_alloy> * 1440,
        <liquid:anti_quarkgluon> * 20000,
        <liquid:quarkgluon> * 40000
    ])
    .addInputs([
        <contenttweaker:arkchip> * 4,
        <contenttweaker:novamatrix> * 1,
        <contenttweaker:arcance_ingot> * 16,
        <contenttweaker:fragments_of_the_space_time_continuum> * 1024
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .requireResearch("Giga-ASEG")
    .addOutput(<contenttweaker:arcane_spacetime_expansion_generator> * 4)
    .requireComputationPoint(1000000.0)
    .build();
RecipeBuilder.newBuilder("giga_condenseddarkplasmaturbine_ctrl","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000,
        <liquid:fluid_nova_alloy> * 1440,
        <liquid:anti_quarkgluon> * 100000,
        <liquid:quarkgluon> * 200000
    ])
    .addInputs([
        <contenttweaker:arcane_spacetime_expansion_generator> * 64,
        <contenttweaker:hyperdimensional_blueprint>,
        <contenttweaker:hyperdimensional_computer>,
        <modularmachinery:giga_singularitycore_controller>,
        <contenttweaker:etherengine_upgrade> * 64,
        <contenttweaker:fragments_of_the_space_time_continuum> * 51200,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .requireResearch("Giga-Doomsday")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<modularmachinery:giga_condenseddarkplasmaturbine_factory_controller>)
    .requireComputationPoint(1000000.0)
    .build();
RecipeBuilder.newBuilder("rtg3521fumo","giga_arcanceassemblyline",28800)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000000,
        <liquid:fluid_nova_alloy> * 1440000,
        <liquid:anti_quarkgluon> * 10000000,
        <liquid:quarkgluon> * 20000000
    ])
    .addInputs([
        <contenttweaker:arcane_spacetime_expansion_generator> * 256,
        <contenttweaker:entropy_singularity> * 256,
        <contenttweaker:space_array> * 256,
        <contenttweaker:arcancemachineblock> * 256,
        <contenttweaker:novamatrix> * 64,
        <contenttweaker:hyperdimensional_blueprint> * 64,
        <contenttweaker:hyperdimensional_computer> * 64,
        <contenttweaker:alloy> * 16777216,
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<contenttweaker:rtg3521fumo>)
    .requireComputationPoint(64000000.0)
    .build();
RecipeBuilder.newBuilder("rtg3521fumo_plus","giga_arcanceassemblyline",2000)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 100000,
        <liquid:fluid_nova_alloy> * 144000,
        <liquid:anti_quarkgluon> * 1000000,
        <liquid:quarkgluon> * 2000000
    ])
    .addInput(<contenttweaker:rtg3521fumo>).setChance(0)
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<contenttweaker:rtg3521fumo>)
    .requireComputationPoint(64000000.0)
    .build();
RecipeBuilder.newBuilder("hyper_stablestructure","giga_arcanceassemblyline",1440)
    .addEnergyPerTickInput(1600000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定§5虚境星球§f位置");
            return;
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addFluidInputs([
        <liquid:aefe> * 1000,
        <liquid:fluid_nova_alloy> * 1440,
        <liquid:anti_quarkgluon> * 20000,
        <liquid:quarkgluon> * 40000
    ])
    .addInputs([
        <contenttweaker:hyper_strenth_machine_block> * 8,
        <contenttweaker:stablestructure> * 64,
        <contenttweaker:arcance_ingot> * 16,
        <contenttweaker:dimensionally_transcendent_casing> * 16
    ])
    .setThreadName("§d灵能§e合成单元§f")
    .addRecipeTooltip("需要确定§5虚境星球§f位置。")
    .addOutput(<contenttweaker:hyper_stablestructure> * 64)
    .requireComputationPoint(1000000.0)
    .build();
RecipeBuilder.newBuilder("giga_dfea_upkeep","giga_dimensionallyfocusengravingarray",3600)
    .addEnergyPerTickInput(51200000000)
    .addInput(<contenttweaker:hyperdimensional_lens>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val DFEA_lens_durability = data.getInt("DFEA_lens_durability",1);
        map["DFEA_lens_durability"] = DFEA_lens_durability + 1024;
        ctrl.customData = data;
    })
    .setThreadName("§1超维度§9激光蚀刻§e矩阵中枢§f")
    .addRecipeTooltip("§a增加§3透镜§f剩余耐久值 : 1024")
    .build();
RecipeBuilder.newBuilder("giga_dfea_recipe01","giga_dimensionallyfocusengravingarray",1)
    .addEnergyPerTickInput(16000000000000)
    .addInput(<contenttweaker:arcance_soc>)
    .addOutput(<contenttweaker:hyperdimensional_soc>)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0001,1,false).build());
    })
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val DFEA_lens_durability = data.getInt("DFEA_lens_durability",1);
        if(DFEA_lens_durability == 0){
            event.setFailed("§3透镜§4耐久值不足§f");
        }
        })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("decrease_time");
        val DFEA_lens_durability = data.getInt("DFEA_lens_durability",1);
        map["DFEA_lens_durability"] = DFEA_lens_durability - 16;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§c消耗§3透镜§f剩余耐久值 : 16")
    .build();
RecipeBuilder.newBuilder("giga_dfea_recipe02","giga_dimensionallyfocusengravingarray",1)
    .addEnergyPerTickInput(16000000000000)
    .addInput(<contenttweaker:overreachedspace_blueprint> * 4)
    .addOutput(<contenttweaker:hyperdimensional_blueprint>)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0001,1,false).build());
    })
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val DFEA_lens_durability = data.getInt("DFEA_lens_durability",1);
        if(DFEA_lens_durability == 0){
            event.setFailed("§3透镜§4耐久值不足§f");
        }
        })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("decrease_time");
        val DFEA_lens_durability = data.getInt("DFEA_lens_durability",1);
        map["DFEA_lens_durability"] = DFEA_lens_durability - 128;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§c消耗§3透镜§f剩余耐久值 : 128")
    .build();

HyperNetHelper.proxyMachineForHyperNet("giga_negativephasecollector");
MachineModifier.setMaxThreads("giga_negativephasecollector", 0);
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§0负相§e收集者中枢§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§e物质解压单元§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§8暗物质§e收集单元§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§e冷却单元§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§0负相物质§e采集单元§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§e物质输入单元#1§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§e物质输入单元#2§f"));
MachineModifier.addCoreThread("giga_negativephasecollector", FactoryRecipeThread.createCoreThread("§1维度通道§f"));
MMEvents.onControllerGUIRender("giga_negativephasecollector",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val NPMC_level = data.getInt("NPMC_level",0);
    val NPMC_timex = data.getDouble("NPMC_timex",1.0);
    val is_step_finished = data.getInt("is_step_finished",0);
    val nova_alloy = data.getInt("nova_alloy",0);
    val aefe = data.getInt("aefe",0);
    val darkmatter_count = data.getInt("darkmatter_count",0);
    val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",0);
    val no_block = data.getInt("no_block",0);
    val NPMC_initialisation = data.getInt("NPMC_initialisation",0);
    var info as string[]=[];
    info += "§a////////////§0负相§e收集者§b控制台§a////////////";
    info += "当前§1超维计算单元§f等级 : " + NPMC_level;
    info += "当前抗§8熵增§f流质数量 : " + aefe + "mB";
    info += "当前§5液态稀有金属§f数量 : " + nova_alloy + "mB";
    if(event.controller.recipeThreadList[2].activeRecipe){
        info += "";
        info += "§8暗物质§e收集单元§f : §e工作中§f";
    }
    if(event.controller.recipeThreadList[3].activeRecipe){
        info += "";
        info += "§8暗物质§e收集单元§f : §e冷却中§f";
    }
    info += "";
    if(is_step_finished == 0){
        info += "§b当前超维化进度§f : §8任重道远§f";
    }
    if(is_step_finished == 1){
        info += "§b当前超维化进度§f : 突入维度§f";
    }
    if(is_step_finished == 2){
        info += "§b当前超维化进度§f : 逆转维度§f";
    }
    if(is_step_finished == 3){
        info += "§b当前超维化进度§f : §4Completed§f";
    }
    event.extraInfo = info;
});
MMEvents.onStructureFormed("giga_negativephasecollector" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val NPMC_level = data.getInt("NPMC_level",0);
    val NPMC_timex = data.getDouble("NPMC_timex",1.0);
    val is_step_finished = data.getInt("is_step_finished",0);
    val nova_alloy = data.getInt("nova_alloy",0);
    val aefe = data.getInt("aefe",0);
    val darkmatter_count = data.getInt("darkmatter_count",0);
    val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",0);
    val no_block = data.getInt("no_block",0);
    val NPMC_initialisation = data.getInt("NPMC_initialisation",0);
    if (NPMC_initialisation != 1){
        map["NPMC_level"] = 0;
        map["NPMC_timex"] = 1;
        map["is_step_finished"] = 0;
        map["nova_alloy"] = 0;
        map["aefe"] = 0;
        map["darkmatter_count"] = 0;
        map["darkmatter_producer_cooldown"] = 1;
        map["no_block"] = 0;
        map["NPMC_initialisation"] = 1;
    }
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("NPMC_upgrade_level","giga_negativephasecollector",3600)
    .addInput(<contenttweaker:hyperdimensional_computer>)
    .addInput(<contenttweaker:alloy> * 1048576)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_level = data.getInt("NPMC_level",1);
        val NPMC_timex = data.getDouble("NPMC_timex",1.0);
        map["NPMC_level"] = NPMC_level + 1;
        map["NPMC_timex"] = NPMC_timex * 0.8;
        ctrl.customData = data;
    })
    .addRecipeTooltip("建造一所§1超维计算单元§f")
    .addRecipeTooltip("每所§1超维计算单元§f将提供 0.8x 的时间乘数与 16 并行数")
    .setThreadName("§0负相§e收集者中枢§f")
    .build();
RecipeBuilder.newBuilder("NPMC_mining_station","giga_negativephasecollector",40)
    .addOutput(<contenttweaker:mineral> * 64)
    .addOutput(<contenttweaker:exoticgases> * 64)
    .addOutput(<contenttweaker:nova_ingot>)
    .addOutput(<avaritia:resource:5> * 1280)
    .addOutput(<avaritia:block_resource> * 5120)
    .addOutput(<mekanism:antimatterpellet> * 10240)
    .addOutput(<avaritia:block_resource:2> * 2560)
    .addOutput(<eternalsingularity:eternal_singularity> * 2560)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        event.activeRecipe.maxParallelism = NPMC_level * 1024;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_level = data.getInt("NPMC_level",1);
        val NPMC_timex = data.getDouble("NPMC_timex",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",NPMC_timex,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("decrease_time");
    })
    .addRecipeTooltip("根据§1超维计算单元§f等级决定配方时间")
    .setThreadName("§e物质解压单元§f")
    .build();
RecipeBuilder.newBuilder("NPMC_darkmatters","giga_negativephasecollector",12000)
    .addInput(<contenttweaker:programming_circuit_0>)
    .addOutput(<contenttweaker:darkmatters>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",1);
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        if(darkmatter_producer_cooldown == 0){
            event.setFailed("§8暗物质§e收集单元§f冷却中!");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val darkmatter_count_ram = ctrl.world.random.nextInt(1,10000);
        val darkmatter_count = data.getInt("darkmatter_count",1);
        map["darkmatter_count"] = darkmatter_count_ram;
        ctrl.customData = data;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_timex = data.getDouble("NPMC_timex",1.0);
        val darkmatter_count = data.getInt("darkmatter_count",1);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",NPMC_timex,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",darkmatter_count,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",1);
        val darkmatter_count = data.getInt("darkmatter_count",1);
        map["darkmatter_producer_cooldown"] = 0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("根据§1超维计算单元§f等级决定配方时间")
    .addRecipeTooltip("此配方产出仅作标记，与实际产出无关。")
    .addRecipeTooltip("此配方将随机产出 1 - 10000 个暗物质")
    .addRecipeTooltip("此配方不会获得并行")
    .setThreadName("§8暗物质§e收集单元§f")
    .build();
RecipeBuilder.newBuilder("NPMC_darkmatters_cooldown","giga_negativephasecollector",12000)
    .addFluidInputs([
        <liquid:spaceframefluid> * 10000,
        <liquid:tachyonfluid> * 10000,
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",1);
        if(darkmatter_producer_cooldown == 1){
            event.setFailed("§8暗物质§e收集单元§f无需冷却!");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",1);
        map["darkmatter_producer_cooldown"] = 1;
    })
    .addRecipeTooltip("冷却§8暗物质§e收集单元§f")
    .addRecipeTooltip("此配方不会获得并行与时间乘数")
    .setThreadName("§e冷却单元§f")
    .build();
RecipeBuilder.newBuilder("NPMC_step_1_1","giga_negativephasecollector",2000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_step_finished = data.getInt("is_step_finished",1);
        val darkmatter_producer_cooldown = data.getInt("darkmatter_producer_cooldown",0);
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        if(darkmatter_producer_cooldown == 1){
            event.setFailed("尚未收集完成§8暗物质§f!");
        }
        if(is_step_finished == 1){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 2){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 3){
            event.setFailed("缺少物品输入!");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val aefe = data.getInt("aefe",1);
        val NPMC_level = data.getInt("NPMC_level",1);
        val darkmatter_count = data.getInt("darkmatter_count",1);
        if( NPMC_level * darkmatter_count >= aefe * 0.95 && aefe * 1.05 <= NPMC_level * darkmatter_count ){
            val is_step_finished = data.getInt("is_step_finished",1);
            map["is_step_finished"] = 0;
            map["aefe"] = 0;
            ctrl.customData = data;
        }
        if( NPMC_level * darkmatter_count <= aefe * 0.95 || aefe * 1.05 >= NPMC_level * darkmatter_count ){
            val is_step_finished = data.getInt("is_step_finished",1);
            map["is_step_finished"] = 1;
            map["aefe"] = 0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("根据§8暗物质§f产量与§1超维计算单元§f等级决定需求流体数")
    .addRecipeTooltip("此配方不会获得并行")
    .addRecipeTooltip("")
    .addRecipeTooltip("抑制§8熵增§f。。。")
    .setThreadName("§1维度通道§f")
    .build();
RecipeBuilder.newBuilder("NPMC_step_2_1","giga_negativephasecollector",2000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_step_finished = data.getInt("is_step_finished",1);
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level < 1){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        if(is_step_finished == 0){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 2){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 3){
            event.setFailed("缺少物品输入!");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val no_block_ram = ctrl.world.random.nextInt(1,4);
        val no_block = data.getInt("no_block",1);
        map["no_block"] = no_block_ram;
        val block_pos = pos.up(1);
        Sync.addSyncTask(function(){
            val redstone = ctrl.world.getBlock(block_pos);
            if (redstone.definition.id == "novaeng_core:redstone_logical_port"){
                if (no_block != redstone.meta){
                    ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${no_block}>,block_pos);
                }
            }
        });
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val nova_alloy = data.getInt("nova_alloy",1);
        val no_block = data.getInt("no_block",1);
        val darkmatter_count = data.getInt("darkmatter_count",1);
        if( no_block * darkmatter_count >= nova_alloy * 0.95 && nova_alloy * 1.05 >= no_block * darkmatter_count ){
            val is_step_finished = data.getInt("is_step_finished",1);
            map["is_step_finished"] = 2;
            map["no_block"] = 0;
            map["nova_alloy"] = 0;
            ctrl.customData = data;
        }
        if( no_block * darkmatter_count <= nova_alloy * 0.95 || nova_alloy * 1.05 <= no_block * darkmatter_count ){
            val is_step_finished = data.getInt("is_step_finished",1);
            map["is_step_finished"] = 0;
            map["no_block"] = 0;
            map["nova_alloy"] = 0;
            ctrl.customData = data;
        }
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val block_pos = pos.up(1);
    })
    .addRecipeTooltip("根据生成的方块种类与§1超维计算单元§f等级决定需求流体数")
    .addRecipeTooltip("§4执行此配方前，请勿在控制器正上方一格放置方块 / 实体§f")
    .addRecipeTooltip("此配方不会获得并行")
    .addRecipeTooltip("")
    .addRecipeTooltip("逆转§1维度§f。。。")
    .setThreadName("§1维度通道§f")
    .build();
RecipeBuilder.newBuilder("NPMC_step_3_1","giga_negativephasecollector",72000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_step_finished = data.getInt("is_step_finished",1);
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        if(is_step_finished == 0){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 1){
            event.setFailed("缺少物品输入!");
        }
        if(is_step_finished == 3){
            event.setFailed("缺少物品输入!");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_step_finished = data.getInt("is_step_finished",1);
        map["is_step_finished"] = 3;
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_step_finished = data.getInt("is_step_finished",1);
        map["is_step_finished"] = 0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("通过突入§1高维空间§f的§3附属空间(次元)§f并§c逆转§f其§1维度§f属性，我们成功创造了微型的§0负相宇宙§f")
    .addRecipeTooltip("此配方不会获得并行")
    .addRecipeTooltip("")
    .addRecipeTooltip("§4It's time§f。。。")
    .setThreadName("§1维度通道§f")
    .build();
RecipeBuilder.newBuilder("NPMC_input_01","giga_negativephasecollector",1)
    .addInput(<liquid:fluid_nova_alloy> * 1440)
    .addInput(<contenttweaker:arcance_ingot>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        event.activeRecipe.maxParallelism = 2000000000;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val nova_alloy = data.getInt("nova_alloy",1);
        val thread = event.factoryRecipeThread;
        val parallelism_num = thread.activeRecipe.parallelism;
        map["nova_alloy"] = nova_alloy + parallelism_num * 1440;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入 1440mB §5液态稀有金属§f")
    .addRecipeTooltip("该配方具有§e近乎无穷§f的并行数")
    .setThreadName("§e物质输入单元#1§f")
    .build();
RecipeBuilder.newBuilder("NPMC_input_01_2","giga_negativephasecollector",1)
    .addInput(<liquid:fluid_nova_alloy> * 1)
    .addInput(<contenttweaker:gama_tialalloy>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        event.activeRecipe.maxParallelism = 2000000000;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val nova_alloy = data.getInt("nova_alloy",1);
        val thread = event.factoryRecipeThread;
        val parallelism_num = thread.activeRecipe.parallelism;
        map["nova_alloy"] = nova_alloy + parallelism_num * 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入 1mB §5液态稀有金属§f")
    .addRecipeTooltip("该配方具有§e近乎无穷§f的并行数")
    .setThreadName("§e物质输入单元#1§f")
    .build();
RecipeBuilder.newBuilder("NPMC_input_02","giga_negativephasecollector",1)
    .addInput(<liquid:aefe> * 1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val NPMC_level = data.getInt("NPMC_level",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        event.activeRecipe.maxParallelism = 2000000000;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val aefe = data.getInt("aefe",1);
        val thread = event.factoryRecipeThread;
        val parallelism_num = thread.activeRecipe.parallelism;
        map["aefe"] = aefe + parallelism_num;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入 1mB 抗§8熵增§f流质")
    .addRecipeTooltip("该配方具有§e近乎无穷§f的并行数")
    .setThreadName("§e物质输入单元#2§f")
    .build();
RecipeBuilder.newBuilder("NPMC_negativephasematter","giga_negativephasecollector",2000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_timex = data.getDouble("NPMC_timex",1.0);
        val NPMC_level = data.getInt("NPMC_level",1);
        val is_step_finished = data.getInt("is_step_finished",1);
        if(NPMC_level == 0){
            event.setFailed("尚未建造§1超维度计算机§f!");
        }
        if(is_step_finished != 3){
            event.setFailed("尚未§c创造§0负相宇宙§f");
        }
        event.activeRecipe.maxParallelism = NPMC_timex * 16;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val NPMC_level = data.getInt("NPMC_level",1);
        val NPMC_timex = data.getDouble("NPMC_timex",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",NPMC_timex,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("decrease_time");
    })
    .addInputs([
        <contenttweaker:nanites> * 4,
        <contenttweaker:darkmatters> * 16,
        <contenttweaker:voidmatter> * 16,
    ])
    .addOutput(<contenttweaker:negativephase_matter>)
    .setThreadName("§0负相物质§e采集单元§f")
    .addRecipeTooltip("根据§1超维计算单元§f等级决定配方时间")
    .requireResearch("Giga-NegativePhase")
    .build();

HyperNetHelper.proxyMachineForHyperNet("giga_cosmiccasket");
MachineModifier.addCoreThread("giga_cosmiccasket", FactoryRecipeThread.createCoreThread("§7熵能§5奇点§e稳定器§f"));
MachineModifier.addCoreThread("giga_cosmiccasket", FactoryRecipeThread.createCoreThread("§7熵能§5奇点§e提取器§f"));
MachineModifier.addCoreThread("giga_cosmiccasket", FactoryRecipeThread.createCoreThread("§e物质解压单元§f"));
RecipeBuilder.newBuilder("giga_cosmiccasket_upkeep", "giga_cosmiccasket", 72000)
    .addInput(<contenttweaker:hyperdimensional_computer>).setChance(0.2)
    .addInput(<contenttweaker:cosmic_data> * 4)
    .addInput(<contenttweaker:voidmatter> * 160)
    .setThreadName("§7熵能§5奇点§e稳定器§f")
    .addRecipeTooltip("使用§8虚空能§f驱动§1超维度计算机§f以稳定§7熵能§5奇点§f。")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("giga_cosmiccasket_singularity","giga_cosmiccasket",3600)
    .addEnergyPerTickInput(160000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定稳定§5奇点§f!");
            return;
        }
    })
    .addFluidInputs([
        <liquid:aefe> * 10000,
        <liquid:fluid_nova_alloy> * 144000,
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:negativephase_matter> * 64,
    ])
    .setThreadName("§7熵能§5奇点§e提取器§f")
    .addRecipeTooltip("需要稳定§7熵能§5奇点§f。")
    .requireResearch("Giga-CosmicCasket")
    .addOutput(<contenttweaker:entropy_singularity>)
    .requireComputationPoint(10000000.0)
    .build();
RecipeBuilder.newBuilder("giga_cosmiccasket_output_01","giga_cosmiccasket",1)
    .addEnergyPerTickInput(16000000000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未确定稳定§5奇点§f!");
            return;
        }
        event.activeRecipe.maxParallelism = 1024;
    })
    .addFluidInputs([
        <liquid:aefe> * 1,
    ])
    .addInputs([
        <contenttweaker:voidmatter> * 1,
    ])
    .addOutput(<contenttweaker:mineral> * 4)
    .addOutput(<contenttweaker:exoticgases> * 4)
    .addOutput(<avaritia:resource:5> * 1280)
    .addOutput(<avaritia:block_resource> * 5120)
    .addOutput(<mekanism:antimatterpellet> * 10240)
    .addOutput(<avaritia:block_resource:2> * 2560)
    .addOutput(<eternalsingularity:eternal_singularity> * 2560)
    .addOutput(<liquid:aefe> * 100)
    .setThreadName("§e物质解压单元§f")
    .addRecipeTooltip("需要稳定§7熵能§5奇点§f。")
    .addRecipeTooltip("该配方最高拥有1024并行。")
    .requireComputationPoint(10000.0)
    .build();
MachineModifier.addCoreThread("giga_timespacesingularity", FactoryRecipeThread.createCoreThread("§8时空§1奇点§e稳定器§f"));
MachineModifier.addCoreThread("giga_timespacesingularity", FactoryRecipeThread.createCoreThread("§8时空§1奇点§e激发器§f"));
MachineModifier.addCoreThread("giga_timespacesingularity", FactoryRecipeThread.createCoreThread("§8时空§1奇点§e提取器§f"));
MachineModifier.addCoreThread("giga_timespacesingularity", FactoryRecipeThread.createCoreThread("§e物质解压单元§f"));
MMEvents.onControllerGUIRender("giga_timespacesingularity",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val TSS_durability = data.getInt("TSS_durability",0);
    var info as string[]=[];
    info += "§a////////////§8时空§1奇点§e稳定器§a////////////";
    if(TSS_durability < 1){
        info += "§4尚未稳定§8时空§1奇点§f";
        info += "§e物质解压单元§f : §a可用§f";
        info += "§8时空§1奇点§e提取器§f : §c不可用§f";
    }
    if(TSS_durability > 0){
        info += "当前§8时空§1奇点§f剩余§8时空§f : §a" + TSS_durability + "§f/§c1048576§f";
        info += "§e物质解压单元§f : §c不可用§f";
        info += "§8时空§1奇点§e提取器§f : §a可用§f";
    }
    event.extraInfo = info;
});
RecipeBuilder.newBuilder("giga_timespacesingularity_upkeep", "giga_timespacesingularity", 72000)
    .addInput(<contenttweaker:hyperdimensional_computer>).setChance(0.5)
    .addInput(<contenttweaker:cosmic_data> * 64)
    .addInput(<contenttweaker:negativephase_matter> * 64)
    .addInput(<contenttweaker:voidmatter> * 1600)
    .setThreadName("§8时空§1奇点§e稳定器§f")
    .addRecipeTooltip("使用§8虚空能§f创造一个§8时空§1奇点§f。")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("giga_timespacesingularity_input_01","giga_timespacesingularity",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val TSS_durability = data.getInt("TSS_durability",1);
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未创造§8时空§1奇点§f!");
            return;
        }
        if(TSS_durability > 1048576){
            event.setFailed("§8时空§f含量过高!");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val TSS_durability = data.getInt("TSS_durability",1);
        map["TSS_durability"] = TSS_durability + 1024;
        ctrl.customData = data;
    })
    .addFluidInputs([
        <liquid:spaceframefluid> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:negativephase_matter> * 16,
    ])
    .setThreadName("§8时空§1奇点§e激发器§f")
    .addRecipeTooltip("需要创造§8时空§1奇点§f。")
    .addRecipeTooltip("激发§8时空§1奇点§f使其中的§8时空§f稳定，或引发物质§7熵增§f。")
    .addRecipeTooltip("§a为§8时空§1奇点§a添加 1024单位 时空。§f")
    .addRecipeTooltip("§4此配方将导致§e物质解压单元§4不可用。§f")
    .build();
RecipeBuilder.newBuilder("giga_timespacesingularity_input_02","giga_timespacesingularity",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val TSS_durability = data.getInt("TSS_durability",1);
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未创造§8时空§1奇点§f!");
            return;
        }
        if(TSS_durability > 2000000000){
            event.setFailed("§z§k1§k2§k1§k2§k1§k2§k1§f");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val TSS_durability = data.getInt("TSS_durability",1);
        map["TSS_durability"] = TSS_durability + 1048576;
        ctrl.customData = data;
    })
    .addInputs([
        <contenttweaker:timespace_ingot>,
        <contenttweaker:etherengine_upgrade>
    ])
    .setThreadName("§8时空§1奇点§e激发器§f")
    .addRecipeTooltip("需要创造§8时空§1奇点§f。")
    .addRecipeTooltip("使用§8时空锭§f与§5时空破碎§1发生器§f破碎其他次元的时空，或引发因果崩溃。")
    .addRecipeTooltip("§a为§8时空§1奇点§a添加 1048576单位 时空。§f")
    .addRecipeTooltip("§4此配方将导致§e物质解压单元§4不可用。§f")
    .build();
RecipeBuilder.newBuilder("giga_timespacesingularity_input_02","giga_timespacesingularity",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未创造§8时空§1奇点§f!");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val TSS_durability = data.getInt("TSS_durability",1);
        map["TSS_durability"] = 0;
        ctrl.customData = data;
    })
    .addFluidInputs([
        <liquid:aefe> * 100000,
        <liquid:tachyonfluid> * 100000
    ])
    .addInputs([
        <contenttweaker:voidmatter> * 64,
    ])
    .setThreadName("§8时空§1奇点§e激发器§f")
    .addRecipeTooltip("需要创造§8时空§1奇点§f。")
    .addRecipeTooltip("稳定§8时空§1奇点§f中的§8熵§f，或引发§8时空§4湮灭§f。")
    .addRecipeTooltip("§c清除§8时空§1奇点§c中所有时空。§f")
    .addRecipeTooltip("§4此配方将导致§8时空§1奇点§e提取器§4不可用。§f")
    .build();
RecipeBuilder.newBuilder("giga_timespacesingularity_output_01","giga_timespacesingularity",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val TSS_durability = data.getInt("TSS_durability",1);
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未创造§8时空§1奇点§f!");
            return;
        }
        if(TSS_durability < 1){
            event.setFailed("§8时空§1奇点§e提取器§f当前§c不可用§f");
        }
        if(TSS_durability < 64){
            event.activeRecipe.maxParallelism = TSS_durability;
        }
        if(TSS_durability > 64){
            event.activeRecipe.maxParallelism = 64;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val thread = event.factoryRecipeThread;
        val parallelism_num = thread.activeRecipe.parallelism;
        val TSS_durability = data.getInt("TSS_durability",1);
        map["TSS_durability"] = TSS_durability - parallelism_num;
        ctrl.customData = data;
    })
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 640)
    .addOutput(<contenttweaker:space_time_condensation_block> * 640)
    .addOutput(<contenttweaker:voidmatter> * 640)
    .addOutput(<contenttweaker:darkmatters> * 640)
    .addOutput(<contenttweaker:cosmic_data> * 64)
    .addOutput(<contenttweaker:dust> * 32768)
    .addFluidOutputs([
        <liquid:dimensionbeam> * 1000,
        <liquid:space_time_fluids> * 1000,
        <liquid:aefe> * 1000,
        <liquid:spaceframefluid> * 1000,
        <liquid:tachyonfluid> * 1000,
        <liquid:bec> * 10000,
        <liquid:zerotempaturefluid> * 10000,
        <liquid:higgsfluid> * 10000,
    ])
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0)
    .addEnergyPerTickOutput(1000000000000)
    .setThreadName("§8时空§1奇点§e提取器§f")
    .addRecipeTooltip("需要创造§8时空§1奇点§f。")
    .addRecipeTooltip("§a此配方将消耗 1单位 §8时空§a。§f")
    .addRecipeTooltip("§a需要启用§8时空§1奇点§e提取器§f")
    .addRecipeTooltip("该配方最高拥有64并行。")
    .build();
RecipeBuilder.newBuilder("giga_timespacesingularity_output_02","giga_timespacesingularity",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val TSS_durability = data.getInt("TSS_durability",1);
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未创造§8时空§1奇点§f!");
            return;
        }
        if(TSS_durability > 0){
            event.setFailed("§e物质解压单元§f当前§c不可用§f");
        }
        event.activeRecipe.maxParallelism = 64;
    })
    .addOutput(<contenttweaker:mineral> * 64)
    .addOutput(<contenttweaker:exoticgases> * 64)
    .addOutput(<contenttweaker:nova_ingot>)
    .addOutput(<avaritia:resource:5> * 1280)
    .addOutput(<avaritia:block_resource> * 5120)
    .addOutput(<mekanism:antimatterpellet> * 10240)
    .addOutput(<avaritia:block_resource:2> * 2560)
    .addOutput(<eternalsingularity:eternal_singularity> * 2560)
    .addOutput(<contenttweaker:weakmag> * 4)
    .addFluidOutputs([
        <liquid:anti_quarkgluon> * 1000,
        <liquid:quarkgluon> * 2000
    ])
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0)
    .addEnergyPerTickOutput(1000000000000)
    .setThreadName("§e物质解压单元§f")
    .addRecipeTooltip("需要创造§8时空§1奇点§f。")
    .addRecipeTooltip("§a需要启用§e物质解压单元§f")
    .addRecipeTooltip("该配方最高拥有64并行。")
    .build();
MMEvents.onControllerGUIRender("giga_dimensionallytranscendentplasmaforge",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val fuel_count = data.getInt("fuel_count",0);
    val DTPF_timex = data.getDouble("DTPF_timex",1.0);
    val power = data.getInt("power",0);
    val DTPF_initialisation = data.getInt("DTPF_initialisation",0);
    var info as string[]=[
        "§a////////////§1超维度等离子锻炉§a////////////",
        "剩余§3激发态§1维度§c熔浆§f : " + fuel_count + "mB",
        "当前§1超维化§f进程 : " + power/86400 + "%",
        "时间乘数 : " + DTPF_timex + "x"
    ];
    event.extraInfo = info;
});
MMEvents.onStructureFormed("giga_dimensionallytranscendentplasmaforge" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val fuel_count = data.getInt("fuel_count",0);
    val DTPF_timex = data.getDouble("DTPF_timex",1.0);
    val power = data.getInt("power",0);
    val DTPF_initialisation = data.getInt("DTPF_initialisation",0);
    if (DTPF_initialisation != 1){
        map["fuel_count"] = 0;
        map["DTPF_timex"] = 1;
        map["power"] = 0;
        map["DTPF_initialisation"] = 1;
    }
    ctrl.customData = data;
});
MachineModifier.addCoreThread("giga_dimensionallytranscendentplasmaforge", FactoryRecipeThread.createCoreThread("§1超维度等离子锻炉§e中枢§f"));
MachineModifier.addCoreThread("giga_dimensionallytranscendentplasmaforge", FactoryRecipeThread.createCoreThread("§e熵增抑制单元§f"));
MachineModifier.addCoreThread("giga_dimensionallytranscendentplasmaforge", FactoryRecipeThread.createCoreThread("§e燃料输入单元§f"));
MachineModifier.addCoreThread("giga_dimensionallytranscendentplasmaforge", FactoryRecipeThread.createCoreThread("§e燃料燃烧单元§f"));
MachineModifier.addCoreThread("giga_dimensionallytranscendentplasmaforge", FactoryRecipeThread.createCoreThread("§1超维度等离子锻炉§f"));
RecipeBuilder.newBuilder("giga_dimensionallytranscendentplasmaforge_upkeep", "giga_dimensionallytranscendentplasmaforge", 72000)
    .addInput(<liquid:aefe> * 16000)
    .setThreadName("§e熵增抑制单元§f")
    .addRecipeTooltip("抑制§8s熵增§f")
    .setParallelized(false)
    .build();
RecipeBuilder.newBuilder("giga_dimensionallytranscendentplasmaforge_input_01","giga_dimensionallytranscendentplasmaforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        if(isNull(event.controller.recipeThreadList[1].activeRecipe)){
            event.setFailed("尚未抑制§8熵增§f!");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val fuel_count = data.getInt("fuel_count",1);
        map["fuel_count"] = fuel_count + 1000;
        ctrl.customData = data;
    })
    .addFluidInput(<liquid:hyperdimensionalfuel> * 1000)
    .setThreadName("§e燃料输入单元§f")
    .addRecipeTooltip("需要抑制§8熵增§f。")
    .addRecipeTooltip("§a为§1超维度等离子锻炉§a添加 1000mB §3激发态§1维度§c熔浆§a。§f")
    .build();
MachineModifier.setMaxThreads("giga_iridiosamariumchipforge", 0);
MachineModifier.addCoreThread("giga_iridiosamariumchipforge", FactoryRecipeThread.createCoreThread("§3超限§e装配集群#1"));
MachineModifier.addCoreThread("giga_iridiosamariumchipforge", FactoryRecipeThread.createCoreThread("§3超限§e装配集群#2"));
MachineModifier.addCoreThread("giga_iridiosamariumchipforge", FactoryRecipeThread.createCoreThread("§3超限§e装配集群#3"));
MachineModifier.addCoreThread("giga_iridiosamariumchipforge", FactoryRecipeThread.createCoreThread("§3超限§e装配集群#4"));
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_01","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 1,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<enderio:item_material:41> * 4)
    .addOutput(<contenttweaker:synthesischip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_02","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 2,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:synthesischip> * 2)
    .addInput(<avaritia:resource:1> * 64)
    .addOutput(<contenttweaker:crystalchip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_03","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 4,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:crystalchip> * 2)
    .addInput(<additions:novaextended-fallen_star_alloy> * 64)
    .addOutput(<contenttweaker:universalalloychip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_04","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 8,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:universalalloychip> * 2)
    .addInput(<avaritia:resource:4> * 64)
    .addOutput(<contenttweaker:neutronchip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_05","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 16,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:neutronchip> * 2)
    .addInput(<avaritia:resource:6> * 64)
    .addOutput(<contenttweaker:infinitychip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_06","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 32,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:infinitychip> * 2)
    .addInput(<additions:novaextended-star_ingot> * 64)
    .addOutput(<contenttweaker:arkchip>)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_recipe_07","giga_iridiosamariumchipforge",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addCatalystInput(<contenttweaker:weakmag> * 64,
        ["使用磁物质快速蚀刻继承系统芯片。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ])
    .addCatalystInput(<contenttweaker:etherengine_upgrade> * 1024,
        ["破碎奇点另一端的时空以打破因果。", "使芯片的产出§ax4§f。"],
        [
        RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
    ]).setChance(0).setParallelizeUnaffected(true)
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:arkchip> * 2)
    .addInput(<contenttweaker:arcance_ingot> * 64)
    .addOutput(<contenttweaker:arcance_soc>)
    .build();
RecipeBuilder.newBuilder("giga_godforge_star_generating", "giga_godforge", 72000)
    .addFactoryStartHandler(function (event as FactoryRecipeStartEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val starpos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,123);
        Sync.addSyncTask(function(){
            if (!world.remote) {
                world.setBlockState(<blockstate:draconicevolution:reactor_core>,{BCManagedData: {reactorState: 2 as byte, reactableFuel: 1000000.0,temperature:100000.0,shieldCharge: 2000000000,maxShieldCharge: 2000000000}},starpos1);
            }
        });
    }) 
    .build();
MachineModifier.setMaxThreads("giga_condenseddarkplasmaturbine", 0);
MachineModifier.addCoreThread("giga_condenseddarkplasmaturbine", FactoryRecipeThread.createCoreThread("§9暗物质相变单元§f"));
MachineModifier.addCoreThread("giga_condenseddarkplasmaturbine", FactoryRecipeThread.createCoreThread("§9暗物质反应检测单元§f"));
MMEvents.onControllerGUIRender("giga_condenseddarkplasmaturbine",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val explosionCountdown = data.getInt("explosionCountdown",0);
    var info as string[]=[];
    info += "§a////////////§9冷暗物质相变阵列§a////////////";
    info += "核心反应失控倒计时 : " + explosionCountdown / 20 + "s";
    event.extraInfo = info;
});
MMEvents.onStructureFormed("giga_dimensionallytranscendentplasmaforge" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val explosionCountdown = data.getInt("explosionCountdown",0);
    map["explosionCountdown"] = 0;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("giga_condenseddarkplasmaturbine","giga_condenseddarkplasmaturbine",1200)
    .addEnergyPerTickOutput(8000000000000000)
    .addFluidPerTickInput(<liquid:aefe> * 8)
    .addInput(<contenttweaker:darkmatters> * 4096)
    .addOutput(<contenttweaker:negativephase_matter> * 64)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(event.controller.recipeThreadList[1].activeRecipe){
            event.setFailed("暗物质反应仍在进行!");
            return;
        }
    })
    .addFactoryStartHandler(function (event as FactoryRecipeStartEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val explosionCountdown = data.getInt("explosionCountdown",1);  
        val pos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,16);
        map["explosionCountdown"] =  1440;
        ctrl.customData = data;
        Sync.addSyncTask(function(){
            if (!world.remote) {
                world.setBlockState(<blockstate:draconicevolution:reactor_core>,{BCManagedData: {reactorState: 2 as byte, reactableFuel: 10000.0,temperature:100000.0,shieldCharge: 100000000,maxShieldCharge: 100000000}},pos1);
            }
        });
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val pos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,16);
        Sync.addSyncTask(function(){
            if (!world.remote) {
                world.setBlockState(<blockstate:minecraft:air>,{},pos1);
            }
        });
    })
    .setThreadName("§9暗物质相变单元§f")
    .addRecipeTooltip("将暗物质凝聚为超流体在时空场中相变。")
    .addRecipeTooltip("停止输入流体或能源无法输出时将使得反应§4失控§f。")
    .build();
RecipeBuilder.newBuilder("giga_condenseddarkplasmaturbine_check","giga_condenseddarkplasmaturbine",1440)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        if(isNull(event.controller.recipeThreadList[0].activeRecipe)){
            event.setFailed("尚未进行暗物质反应!");
            return;
        }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val explosionCountdown = data.getInt("explosionCountdown",1); 
        val pos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,16);
        val martrix1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,13,0,16);
        val martrix2 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-13,0,16);
        val martrix3 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,3);
        val martrix4 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,28);
        map["explosionCountdown"] = explosionCountdown - 1;
        if (explosionCountdown < 80){
            if(event.controller.recipeThreadList[0].activeRecipe){
                Sync.addSyncTask(function(){
                    if (!world.remote) {
                        world.setBlockState(<blockstate:minecraft:air>,{},martrix1);
                        world.setBlockState(<blockstate:minecraft:air>,{},martrix2);
                        world.setBlockState(<blockstate:minecraft:air>,{},martrix3);
                        world.setBlockState(<blockstate:minecraft:air>,{},martrix4);
                        world.setBlockState(<blockstate:draconicevolution:reactor_core>,{BCManagedData: {reactorState: 6 as byte, reactableFuel: 100000.0,explosionCountdown:160,temperature:100000.0,ShieldCharge: 8000000,MaxShieldCharge: 8000000}},pos1);
                    }
                });
            }else {
                world.setBlockState(<blockstate:minecraft:air>,{},pos1);
            }
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("监测§9暗物质核心反应堆§f。")
    .addRecipeTooltip("在核心反应失控倒计时小于 4s 时反应堆将完全失控。")
    .setThreadName("§9暗物质反应检测单元§f")
    .build();
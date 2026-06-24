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
import mods.avaritia.ExtremeCrafting;
import crafttweaker.recipes.ICraftingInfo;
import mods.avaritia.Compressor;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

MachineModifier.setInternalParallelism("mega_compressor", 16777216);
MachineModifier.setInternalParallelism("mega_industrialcrusher", 16777216);
MachineModifier.setInternalParallelism("mega_injectiondevice", 16777216);
MachineModifier.setInternalParallelism("mega_magicalcrafttable", 131072);

HyperNetHelper.proxyMachineForHyperNet("mega_psionicsiphonmatrix");
HyperNetHelper.proxyMachineForHyperNet("mega_compressor");
HyperNetHelper.proxyMachineForHyperNet("mega_industrialcrusher");
HyperNetHelper.proxyMachineForHyperNet("mega_injectiondevice");
HyperNetHelper.proxyMachineForHyperNet("mega_magicalcrafttable");
MachineModifier.setMaxThreads("mega_psionicsiphonmatrix", 0);
MachineModifier.setMaxThreads("mega_compressor", 0);
MachineModifier.setMaxThreads("mega_industrialcrusher", 0);
MachineModifier.setMaxThreads("mega_injectiondevice", 0);
MachineModifier.setMaxThreads("mega_magicalcrafttable", 0);
MachineModifier.setMaxThreads("giga_massunpacker", 0);
MachineModifier.addCoreThread("mega_psionicsiphonmatrix", FactoryRecipeThread.createCoreThread("§d灵能§e虹吸单元§f"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#1"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#2"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#3"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#4"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#5"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#6"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#7"));
MachineModifier.addCoreThread("mega_compressor", FactoryRecipeThread.createCoreThread("高效压缩单元#8"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#1"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#2"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#3"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#4"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#5"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#6"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#7"));
MachineModifier.addCoreThread("mega_industrialcrusher", FactoryRecipeThread.createCoreThread("高效粉碎单元#8"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#1"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#2"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#3"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#4"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#5"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#6"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#7"));
MachineModifier.addCoreThread("mega_injectiondevice", FactoryRecipeThread.createCoreThread("高效注液单元#8"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#1"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#2"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#3"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#4"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#5"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#6"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#7"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#8"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#9"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#10"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#11"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#12"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#13"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#14"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#15"));
MachineModifier.addCoreThread("mega_magicalcrafttable", FactoryRecipeThread.createCoreThread("高效聚合单元#16"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#1"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#2"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#3"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#4"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#5"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#6"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#7"));
MachineModifier.addCoreThread("giga_massunpacker", FactoryRecipeThread.createCoreThread("高效解包单元#8"));
//function lib
//oredrone 消耗无人机点数,rocket 消耗运载火箭点数, satellite 消耗遥感卫星点数, purpose 目标控制器,consume 自组装单元消耗数量,input 输入材料组,collectrank 采集阵列等级, carryrank 运载阵列等级 , maintainrank 维护阵列等级
//elevator 是否需要太空电梯参与 energy消耗能量/tick research_name需求的研究名称 require_cp需求算力 time配方时间 require_spacestation_level 空间站等级
function megabuild(oredrone as int,rocket as int,satellite as int,purpose as IIngredient[],consume as int,input as IIngredient[],collectrank as int,carryrank as int,maintainrank as int,elevator as bool,counter as int,energy as long,research_name as string,require_cp as long,time as long,require_spacestation_level as int){
RecipeBuilder.newBuilder("M"+counter+"create_fork01","communication_center",time,counter)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
     val ctrl = event.controller;
     val data = ctrl.customData;
     val collectMatrix = data.getInt("collectMatrix",0);
     val carryMatrix = data.getInt("carryMatrix",0);
     val maintainMatrix = data.getInt("maintainMatrix",0);
     val spacestation_level = data.getInt("spacestation_level",0);
     if(elevator == 1){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val enable_elevator = data.getInt("enable_elevator",0);
        if(enable_elevator == 0){
            event.setFailed("未连接太空电梯模块");
        }
     }
     if(collectMatrix < collectrank){
        event.setFailed("采集阵列等级不足");
     }
     if(carryMatrix < carryrank){
        event.setFailed("运载阵列等级不足");
     }
     if(maintainMatrix < maintainrank){
        event.setFailed("维护阵列等级不足");
     }
     if(spacestation_level < require_spacestation_level){
        event.setFailed("空间站等级不足");
     }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val enable_elevator = data.getInt("enable_elevator",0);
    if(enable_elevator == 1){
        val efficiency = data.getFloat("efficiency",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",1/efficiency,0,false).build());
    }
   })
   .addInputs(input)
   .addEnergyPerTickInput(energy)
   .addInputs(<contenttweaker:constructunit>*consume)
   .addOutputs(purpose)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
     val ctrl = event.controller;
     val data = ctrl.customData;
     val lx = data.getInt("lx",0);
     val ly = data.getInt("ly",0);
     val lz = data.getInt("lz",0);
     val ldim = data.getInt("ldim",0);
     val world = IWorld.getFromID(ldim);
     val loftstormsite = MachineController.getControllerAt(world,lx,ly,lz);
     val loftdata = loftstormsite.customData;
     var oredrone_count = loftdata.getInt("oredrone_count",0);
     var rocket_count = loftdata.getInt("rocket_count",0);
     var satellite_count = loftdata.getInt("satellite_count",0);
     val enable_elevator = data.getInt("enable_elevator",0);
     if(enable_elevator == 0){
       oredrone_count -= oredrone;
       rocket_count -= rocket;
       satellite_count -= satellite;
     }
     loftdata.asMap()["oredrone_count"]=oredrone_count;
     loftdata.asMap()["rocket_count"]=rocket_count;
     loftdata.asMap()["satellite_count"]=satellite_count;
     loftstormsite.customData = loftdata;
     val thread = event.factoryRecipeThread;
     thread.removePermanentModifier("decrease_time");
   })
   .requireResearch(research_name)
   .requireComputationPoint(require_cp)
   .addRecipeTooltip("协调在轨航天器,组建深空巨构")
   .addRecipeTooltip("需要§6T"+collectrank+"采集阵列,§aT"+carryrank+"运载阵列,§bT"+maintainrank+"维护阵列")
   .addRecipeTooltip("需要§7T" + require_spacestation_level + "空间站")
   .addRecipeTooltip("将消耗§c"+oredrone+"§f点§6采集无人机点数")
   .addRecipeTooltip("将消耗§c"+rocket+"§f点§a运载火箭点数")
   .addRecipeTooltip("将消耗§c"+satellite+"§f点§b遥感卫星点数")
   .addRecipeTooltip("当连接§9太空电梯§f时将不会消耗点数")
   .setThreadName("深空巨构装配")
   .build();
}
/*
global unique_recipe_with_research as function(IIngredient[],IIngredient,int,int,string,int)void = function (input as IIngredient[],output as IIngredient,time as int,newcounter as int,research_name as string,require_cp as int) as void{
   RecipeBuilder.newBuilder("unique_recipe_with_research"+newcounter,"irisx_00147",time,newcounter)
      .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         val bx = data.getLong("bx",8);
         event.activeRecipe.maxParallelism = bx;
      })
      .addEnergyPerTickInput(10000)
      .addInputs(input)
      .addOutputs(output)
      .addRecipeTooltip("合成特殊合金")
      .addRecipeTooltip("初始为8并行")
      .requireResearch(research_name)
      .requireComputationPoint(require_cp)
      .setThreadName("III-熔炼环带")
      .build();
};
*/
function unique_recipe_with_research(input as IIngredient[],output as IIngredient,time as int,UCWR_counter as int,research_name as string,require_cp as int,energy as int){
    RecipeBuilder.newBuilder("unique_recipe"+UCWR_counter,"irisx_00147",time)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
      val mode2_controller = event.controller;
      val mode2ifacing = mode2_controller.facing;
      val world = mode2_controller.world;
      val mainpos = mode2_controller.pos.createPosByFacing(mode2ifacing,-7,0,7);
      val main_controller = MachineController.getControllerAt(world,mainpos);
      val main_data = main_controller.customData;
      val bx = main_data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
   .addEnergyPerTickInput(energy)
   .addInputs(input)
   .addOutputs(output)
   .addRecipeTooltip("合成特殊合金")
   .addRecipeTooltip("初始为8并行")
   .requireResearch(research_name)
   .requireComputationPoint(require_cp)
   .build();
}
//深度元件配方
//有小猪不写配方
//别骂了，我不会用zs的for循环
val redstone = <ore:dustRedstone>;
val glass = <appliedenergistics2:quartz_glass>;
val netherite = <ore:ingotNetherite>;
val crystal = <ore:itemPulsatingCrystal>;
recipes.addShaped(<infinitycell:item_cell_1k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:35>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_4k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:36>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_16k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:37>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_64k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:38>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_256k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:1>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_1024k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:2>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_4096k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:3>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:item_cell_16384k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:4>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_1k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:54>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_4k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:55>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_16k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:56>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_64k>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:57>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_256k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:5>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_1024k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:6>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_4096k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:7>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:fluid_cell_16384k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:8>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_1k>, [
    [glass,redstone,glass],
    [redstone,<mekeng:gas_core_1k>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_4k>, [
    [glass,redstone,glass],
    [redstone,<mekeng:gas_core_4k>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_16k>, [
    [glass,redstone,glass],
    [redstone,<mekeng:gas_core_16k>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_64k>, [
    [glass,redstone,glass],
    [redstone,<mekeng:gas_core_64k>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_256k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:9>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_1024k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:10>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_4096k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:11>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:gas_cell_16384k>, [
    [glass,redstone,glass],
    [redstone,<nae2:material:12>,redstone],
    [netherite,crystal,netherite]
]);
recipes.addShaped(<infinitycell:advanced_cell_housing>, [
    [glass,redstone,glass],
    [redstone,<appliedenergistics2:material:39>,redstone],
    [netherite,crystal,netherite]
]);
recipes.remove(<infinitycell:item_cell_inf>);
recipes.remove(<infinitycell:fluid_cell_inf>);
recipes.remove(<infinitycell:gas_cell_inf>);
recipes.addShaped(<infinitycell:item_cell_inf>, [
    [<contenttweaker:dimensiontwistblock>,<contenttweaker:milkmachineblock>,<contenttweaker:dimensiontwistblock>],
    [<contenttweaker:arkforcefieldcontrolblock>,<infinitycell:infinite_component_item>,<contenttweaker:arkforcefieldcontrolblock>],
    [<contenttweaker:octingot>,<contenttweaker:planetoflight>,<contenttweaker:octingot>]
]);
recipes.addShaped(<infinitycell:fluid_cell_inf>, [
    [<contenttweaker:dimensiontwistblock>,<contenttweaker:milkmachineblock>,<contenttweaker:dimensiontwistblock>],
    [<contenttweaker:arkforcefieldcontrolblock>,<infinitycell:infinite_component_fluid>,<contenttweaker:arkforcefieldcontrolblock>],
    [<contenttweaker:octingot>,<contenttweaker:planetoflight>,<contenttweaker:octingot>]
]);
recipes.addShaped(<infinitycell:gas_cell_inf>, [
    [<contenttweaker:dimensiontwistblock>,<contenttweaker:milkmachineblock>,<contenttweaker:dimensiontwistblock>],
    [<contenttweaker:arkforcefieldcontrolblock>,<infinitycell:infinite_component_gas>,<contenttweaker:arkforcefieldcontrolblock>],
    [<contenttweaker:octingot>,<contenttweaker:planetoflight>,<contenttweaker:octingot>]
]);
recipes.addShaped(<infinitycell:infinite_component_item>, [
    [<contenttweaker:becmemory>,<novaeng_core:estorage_cell_item_256m>,<contenttweaker:becmemory>],
    [<novaeng_core:estorage_cell_item_256m>,<contenttweaker:assemblycore>,<novaeng_core:estorage_cell_item_256m>],
    [<contenttweaker:tearenginee>,<contenttweaker:infinitychip>,<contenttweaker:tearenginee>]
]);
recipes.addShaped(<infinitycell:infinite_component_fluid>, [
    [<contenttweaker:becmemory>,<novaeng_core:estorage_cell_fluid_256m>,<contenttweaker:becmemory>],
    [<novaeng_core:estorage_cell_fluid_256m>,<contenttweaker:assemblycore>,<novaeng_core:estorage_cell_fluid_256m>],
    [<contenttweaker:tearenginee>,<contenttweaker:infinitychip>,<contenttweaker:tearenginee>]
]);
recipes.addShaped(<infinitycell:infinite_component_gas>, [
    [<contenttweaker:becmemory>,<novaeng_core:estorage_cell_gas_256m>,<contenttweaker:becmemory>],
    [<novaeng_core:estorage_cell_gas_256m>,<contenttweaker:assemblycore>,<novaeng_core:estorage_cell_gas_256m>],
    [<contenttweaker:tearenginee>,<contenttweaker:infinitychip>,<contenttweaker:tearenginee>]
]);
//256k-16384k气体存储组件配方
recipes.addShaped(<nae2:material:9>,[
    [<appliedenergistics2:material:8>,<appliedenergistics2:material:23>,<appliedenergistics2:material:8>],
    [<mekeng:gas_core_64k>,<appliedenergistics2:quartz_glass>,<mekeng:gas_core_64k>],
    [<appliedenergistics2:material:8>,<mekeng:gas_core_64k>,<appliedenergistics2:material:8>]
]);
recipes.addShaped(<nae2:material:10>,[
    [<appliedenergistics2:material:8>,<appliedenergistics2:material:23>,<appliedenergistics2:material:8>],
    [<nae2:material:9>,<appliedenergistics2:quartz_glass>,<nae2:material:9>],
    [<appliedenergistics2:material:8>,<nae2:material:9>,<appliedenergistics2:material:8>]
]);
recipes.addShaped(<nae2:material:11>,[
    [<appliedenergistics2:material:8>,<appliedenergistics2:material:23>,<appliedenergistics2:material:8>],
    [<nae2:material:10>,<appliedenergistics2:quartz_glass>,<nae2:material:10>],
    [<appliedenergistics2:material:8>,<nae2:material:10>,<appliedenergistics2:material:8>]
]);
recipes.addShaped(<nae2:material:12>,[
    [<appliedenergistics2:material:8>,<appliedenergistics2:material:23>,<appliedenergistics2:material:8>],
    [<nae2:material:11>,<appliedenergistics2:quartz_glass>,<nae2:material:11>],
    [<appliedenergistics2:material:8>,<nae2:material:11>,<appliedenergistics2:material:8>]
]);
recipes.addShapeless(<nae2:storage_cell_gas_256k>,[<appliedenergistics2:material:39>,<nae2:material:9>]);
recipes.addShapeless(<nae2:storage_cell_gas_1024k>,[<appliedenergistics2:material:39>,<nae2:material:10>]);
recipes.addShapeless(<nae2:storage_cell_gas_4096k>,[<appliedenergistics2:material:39>,<nae2:material:11>]);
recipes.addShapeless(<nae2:storage_cell_gas_16384k>,[<appliedenergistics2:material:39>,<nae2:material:12>]);
//奇点核心配方
recipes.addShapeless(<modularmachinery:giga_blackholecore_controller>,[<modularmachinery:giga_singularitycore_controller>]);
//添加动画
MMEvents.onControllerModelAnimation("mega_researchstationt4", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("run_01", true);
});
//§9光速超频矩阵§f
recipes.addShaped(<contenttweaker:lightspeed_overclock_array>,[
    [<contenttweaker:spacexmachineblock>,<contenttweaker:superluminal_core>,<contenttweaker:spacexmachineblock>],
    [<contenttweaker:superluminal_core>,<contenttweaker:novamatrix>,<contenttweaker:superluminal_core>],
    [<contenttweaker:spacexmachineblock>,<contenttweaker:superluminal_core>,<contenttweaker:spacexmachineblock>]
]);
//§7奇点核心§f
recipes.addShaped(<modularmachinery:giga_masscore_controller>,[
    [<contenttweaker:lightspeed_overclock_array>,<contenttweaker:etherengine_upgrade>,<contenttweaker:lightspeed_overclock_array>],
    [<contenttweaker:etherengine_upgrade>,<contenttweaker:planet_ff>,<contenttweaker:etherengine_upgrade>],
    [<contenttweaker:lightspeed_overclock_array>,<contenttweaker:etherengine_upgrade>,<contenttweaker:lightspeed_overclock_array>]
]);
//玩偶配方
mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:yunyouairfumo>, [
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>,<contenttweaker:rtg3521fumo>, <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>]
]);
mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:baitang233fumo>, [
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>,<contenttweaker:rtg3521fumo>, <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>]
]);
mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:mcdycfumo>, [
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <contenttweaker:rtg3521fumo>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>]
]);
mods.extendedcrafting.TableCrafting.addShaped(0, <contenttweaker:newmaafumo>, [
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <contenttweaker:rtg3521fumo>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>]
]);
ExtremeCrafting.addShaped("yunyouairfumo", <contenttweaker:yunyouairfumo>, [
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>,<contenttweaker:rtg3521fumo>, <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>]
]);
ExtremeCrafting.addShaped("baitang233fumo", <contenttweaker:baitang233fumo>, [
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>,<contenttweaker:rtg3521fumo>, <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:novamatrix>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "aefe", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <contenttweaker:space_array>, <forge:bucketfilled>.withTag({FluidName: "fluid_nova_alloy", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <forge:bucketfilled>.withTag({FluidName: "anti_quarkgluon", Amount: 1000}), <contenttweaker:arcancemachineblock>], 
	[<contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>, <contenttweaker:arcancemachineblock>]
]);
ExtremeCrafting.addShaped("mcdycfumo", <contenttweaker:mcdycfumo>, [
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <contenttweaker:rtg3521fumo>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_gas>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_fluid>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>], 
	[<infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>, <infinitycell:infinite_component_item>]
]);
ExtremeCrafting.addShaped("newmaafumo", <contenttweaker:newmaafumo>, [
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <contenttweaker:rtg3521fumo>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_circuitforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_iridiosamariumchipforge_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>], 
	[<modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>, <modularmachinery:giga_qft_factory_controller>]
]);
//风电_控制器
RecipeBuilder.newBuilder("mega_windturbine_controller", "workshop", 3600)
    .addEnergyPerTickInput(300000)
    .addInput(<contenttweaker:industrial_circuit_v3> * 8)
    .addInput(<contenttweaker:field_generator_v3> * 4)
    .addInput(<contenttweaker:charging_crystal_block> * 16)
    .addInput(<super_solar_panels:rotor_carbon3> *8)
    .addOutput(<modularmachinery:mega_windturbine_controller>)
    .requireComputationPoint(4000.0F)
    .requireResearch("Mega-WindTurbineTech")
    .build();
//风电_集成控制器
RecipeBuilder.newBuilder("mega_windturbine_factory_conwtroller", "workshop", 7200)
    .addEnergyPerTickInput(300000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 8)
    .addInput(<contenttweaker:field_generator_v4> * 4)
    .addInput(<contenttweaker:antimatter_core>)
    .addInput(<modularmachinery:mega_windturbine_controller> * 8)
    .addInput(<contenttweaker:charging_crystal_block> * 256)
    .addInput(<moreplates:infinity_gear> * 8)
    .addInput(<contenttweaker:coil_v5> * 64)
    .addInput(<additions:novaextended-phocore_2>)
    .addOutput(<modularmachinery:mega_windturbine_factory_controller>)
    .requireComputationPoint(10000.0F)
    .requireResearch("Mega-WindTurbineTech")
    .build();
//风力发电配方
RecipeBuilder.newBuilder("mega_windturbine-LowAltitude", "mega_windturbine", 1200, 0, true)
    .setAltitude(0, 139)
    .addEnergyPerTickOutput(400000000)
    .build();
RecipeBuilder.newBuilder("mega_windturbine-HighAltitude", "mega_windturbine", 1200, 0, true)
    .setAltitude(140, 256)
    .addEnergyPerTickOutput(1000000000)
    .build();
MachineModifier.setMaxThreads("mega_windturbine", 32);
//基础加工继承配方
//压缩机
RecipeAdapterBuilder.create("mega_compressor", "nuclearcraft:pressurizer")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 50000,    1, false).build())
    .build();
// 合金线圈（等级 3）
RecipeBuilder.newBuilder("mega_compressor_coil_v3", "mega_compressor", 10)
    .addEnergyPerTickInput(64000)
    .addInput(<ore:plateDraconicMetal> * 1)
    .addOutput(<contenttweaker:coil_v3> * 3)
    .build();
// 合金线圈（等级 4）
RecipeBuilder.newBuilder("mega_compressor_coil_v4", "mega_compressor", 10)
    .addEnergyPerTickInput(512000)
    .addInputs(<ore:ingotFallenStarAlloy> * 1)
    .addOutputs(<contenttweaker:coil_v4> * 3)
    .build();
// 合金线圈（等级 5）
RecipeBuilder.newBuilder("mega_compressor_coil_v5", "mega_compressor", 10)
    .addEnergyPerTickInput(8192000)
    .addInputs(<ore:ingotArk> * 1)
    .addOutputs(<contenttweaker:coil_v5> * 3)
    .build();
// 合金线圈（GammaTial）
RecipeBuilder.newBuilder("mega_compressor_coil_gama", "mega_compressor", 10)
    .addEnergyPerTickInput(8192000)
    .addInputs(<contenttweaker:gama_tialalloy> * 1)
    .addOutputs(<contenttweaker:gama_tialcoil> * 3)
    .build();
//粉碎机
RecipeAdapterBuilder.create("mega_industrialcrusher", "novaeng_core:shredder")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025,  1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
    .build();
# 粉碎 - 圆石
RecipeBuilder.newBuilder("mega_industrialcrusher_cobblestone", "mega_industrialcrusher", 10,0)
    .addEnergyPerTickInput(12800)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInputs([
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
        <minecraft:cobblestone> * 6,
    ])
    .addOutput(<ic2:crafting:23> * 64)
    .build();
# 粉碎 - 沙子 + 海蓝宝石
RecipeBuilder.newBuilder("mega_industrialcrusher_aquamarine_sandhuh", "mega_industrialcrusher", 10,0)
    .addEnergyPerTickInput(25600)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<minecraft:sand> * 64)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 32)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
    ])
    .build();
# 粉碎 - 海蓝宝石
RecipeBuilder.newBuilder("mega_industrialcrusher_aquamarine_nosand", "mega_industrialcrusher", 10,0)
    .addEnergyPerTickInput(51200)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 16000).setChance(0)
    .addInput(<liquid:lava> * 16000).setChance(0)
    .addOutput(<astralsorcery:itemcraftingcomponent> * 64)
    .addRecipeTooltip([
        "星能液数量和熔岩数量§c受并行影响§f，但是§a不消耗§f。",
    ])
    .build();
# 粉碎 - 基岩粉
RecipeBuilder.newBuilder("enderio:block_infinity", "mega_industrialcrusher", 10)
    .addEnergyPerTickInput(51200)
    .addInput(<enderio:block_infinity>).setChance(0)
    .addInput(<avaritiaio:grindingballneutronium> * 32).setChance(0.001)
    .addOutput(<enderio:block_infinity>).setChance(0.9)
    .addOutput(<enderio:block_infinity>).setChance(0.75)
    .addOutput(<enderio:block_infinity>).setChance(0.5)
    .addOutput(<enderio:block_infinity>).setChance(0.25)
    .build();
# 粉碎 - 铀
RecipeBuilder.newBuilder("mega_industrialcrusher_separator_uranium", "mega_industrialcrusher", 10)
    .addInput(<ore:stoneAndesite>*10)
    .addOutput(<nuclearcraft:dust:9>* 10)
    .addOutput(<nuclearcraft:compound:11> * 6)
    .addOutput(<nuclearcraft:gem_dust:10> * 3)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("mega_industrialcrusher_stoneDiorite_is", "mega_industrialcrusher", 10)
    .addInput(<ore:stoneDiorite>*10)
    .addOutput(<nuclearcraft:dust:10>* 10)
    .addOutput(<mekanism:otherdust:7> * 9)
    .addOutput(<nuclearcraft:gem_dust:9> * 7)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("mega_industrialcrusher_stoneGranite_is", "mega_industrialcrusher", 10)
    .addInput(<ore:stoneGranite>*10)
    .addOutput(<nuclearcraft:gem_dust:1>* 8)
    .addOutput(<thermalfoundation:material:771>* 6)
    .addOutput(<nuclearcraft:gem_dust:8>* 4)
    .addEnergyPerTickInput(51200)
    .build();  
RecipeBuilder.newBuilder("mega_industrialcrusher_separator_uranium", "mega_industrialcrusher", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([<ore:dustUranium>*10]))
    .addOutput(<nuclearcraft:uranium:10>* 9)
    .addOutput(<nuclearcraft:uranium:5> * 1)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("mega_industrialcrusher_separator_boron", "mega_industrialcrusher", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([<ore:dustBoron>*12]))
    .addOutput(<nuclearcraft:boron:1>* 9)
    .addOutput(<nuclearcraft:boron>* 3)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("mega_industrialcrusher_separator_lithium", "mega_industrialcrusher", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([<ore:dustLithium>*10]))
    .addOutput(<nuclearcraft:lithium:1> * 9)
    .addOutput(<nuclearcraft:lithium> * 1)
    .addEnergyPerTickInput(51200)
    .build();
//注入机
RecipeAdapterBuilder.create("mega_injectiondevice", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.1, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 25000,    1, false).build())
    .build();
RecipeAdapterBuilder.create("mega_injectiondevice", "tconstruct:smeltery_alloy")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "input", 100, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 100, 1, false).build())
    .build();
RecipeAdapterBuilder.create("mega_injectiondevice", "modularmachinery:large_metallurgical_complex")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "input", 10, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:fluid", "output", 10, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1, 1, false).build())
    .build();
RecipeBuilder.newBuilder("redstonerepository_socool_aaf", "mega_injectiondevice", 10)
    .addInputs(
        <thermalfoundation:material:1025>,
        <thermalfoundation:material:167>
        )  
    .addOutput(<redstonerepository:material:1>) 
    .addEnergyPerTickInput(51200)  // 设置每 tick 的能量需求
    .build();  
//科技枪里面的黑曜石钢锭
RecipeBuilder.newBuilder("itemshared_aaf", "mega_injectiondevice", 10)
    .addInputs(
        <ore:dustObsidian>,
        <ore:ingotSteel>
        )  
    .addOutput(<techguns:itemshared:84>) 
    .addEnergyPerTickInput(51200)  // 设置每 tick 的能量需求
    .build();  
// Titanium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedtitanium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)  // 添加基础玻璃作为输入
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotTitanium>,  // 可以使用钛锭
                <ore:dustTitanium>    // 或者钛粉尘
            ])
    )
    .addOutput(<jaopca:block_glasshardenedtitanium>*2)  // 输出为钛硬化玻璃块
    .addEnergyPerTickInput(51200)  // 设置每 tick 的能量需求
    .build();  
// Uranium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneduranium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotUranium>,
                <ore:dustUranium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneduranium>*2)
    .addEnergyPerTickInput(51200)
    .build();
// WillowAlloy 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedwillowalloy", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotWillowalloy>,
                <ore:dustWillowalloy>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedwillowalloy>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Dilithium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneddilithium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDilithium>,
                <ore:dustDilithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddilithium>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Cobalt 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedcobalt", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotCobalt>,
                <ore:dustCobalt>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedcobalt>*2)
    .addEnergyPerTickInput(51200)
    .build();
// AstralStarmetal 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedastralstarmetal", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotAstralStarmetal>,
                <ore:dustAstralStarmetal>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedastralstarmetal>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Boron 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedboron", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotBoron>,
                <ore:dustBoron>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedboron>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Gold 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedgold", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotGold>,
                <ore:dustGold>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedgold>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Thorium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedthorium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotThorium>,
                <ore:dustThorium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedthorium>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Draconium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardeneddraconium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDraconium>,
                <ore:dustDraconium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddraconium>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Iron 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenediron", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotIron>,
                <ore:dustIron>
            ])
    )
    .addOutput(<jaopca:block_glasshardenediron>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Osmium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedosmium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotOsmium>,
                <ore:dustOsmium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedosmium>*2)
    .addEnergyPerTickInput(51200)
    .build();
// Magnesium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedmagnesium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotMagnesium>,
                <ore:dustMagnesium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedmagnesium>    *2)
    .addEnergyPerTickInput(51200)
    .build();
// Lithium 硬化玻璃块配方
RecipeBuilder.newBuilder("block_glasshardenedlithium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotLithium>,
                <ore:dustLithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedlithium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_glasshardenediron", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)  // 添加基础玻璃输入
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotIron>,   // 可使用铁锭
                <ore:dustIron>     // 或者铁粉
            ])
    )
    .addOutput(<jaopca:block_glasshardenediron>)  // 输出铁制硬化玻璃块
    .addEnergyPerTickInput(51200)  // 设置每 tick 所需能量
    .build();  
RecipeBuilder.newBuilder("block_glasshardeneddraconium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotDraconium>,
                <ore:dustDraconium>
            ])
    )
    .addOutput(<jaopca:block_glasshardeneddraconium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_glasshardenedthorium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotThorium>,
                <ore:dustThorium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedthorium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_glasshardenedmagnesium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotMagnesium>,
                <ore:dustMagnesium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedmagnesium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_glasshardenedlithium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotLithium>,
                <ore:dustLithium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedlithium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_glasshardenedosmium", "mega_injectiondevice", 10)
    .addInput(<ore:dustObsidian>)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotOsmium>,
                <ore:dustOsmium>
            ])
    )
    .addOutput(<jaopca:block_glasshardenedosmium>*2)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("ingots_lvhuangt", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:dustCopper>,
                <ore:ingotCopper>
            ]))
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:ingotAluminium>*3,
                <ore:dustAluminium>*3
            ]))
    .addOutput(<tconstruct:ingots:5>*4)
    .addEnergyPerTickInput(51200)
    .build();
 RecipeBuilder.newBuilder("glitch_infused_ingot", "mega_injectiondevice", 10)
    .addInputs(
         <minecraft:dye:4>,
         <minecraft:gold_ingot>,
         <deepmoblearning:glitch_fragment>
    )
    .addOutput(<deepmoblearning:glitch_infused_ingot>)
    .addEnergyPerTickInput(51200)
    .build();
// 创建 Glazed Nether Brick 配方
RecipeBuilder.newBuilder("glazed_nether_brick_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <minecraft:netherbrick>,
        <minecraft:nether_wart> * 4,
        <minecraft:clay_ball> * 6
    )
    .addOutput(<ore:ingotBrickNetherGlazed>)
    .addEnergyPerTickInput(51200)
    .build();
// 创建硅晶片配方（Silicon Wafer）
RecipeBuilder.newBuilder("silicon_wafer_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <ore:ingotLead> * 3,
        <minecraft:ender_pearl> * 4,
        <thermalfoundation:material:134>
    )
    .addOutput(<enderio:item_material:39>)
    .addEnergyPerTickInput(51200)
    .build();
//红色染料配方
RecipeBuilder.newBuilder("hongseranliao", "mega_injectiondevice", 10)
    .addInputs(
        <minecraft:beetroot>,
        <ore:egg>*6,
        <minecraft:clay_ball>*3
    )
    .addOutput(<minecraft:dye:1>*12)
    .addEnergyPerTickInput(51200)
    .build();
//吃的!
RecipeBuilder.newBuilder("xiaobinggan", "mega_injectiondevice", 10)
    .addInputs(
        <ore:dustWheat>,
        <minecraft:dye:3>
    )
    .addOutput(<minecraft:cookie>*12)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("mianbaobian", "mega_injectiondevice", 10)
    .addInputs(
        <ore:dustWheat>*3,
        <ore:egg>
    )
    .addOutput(<enderio:item_material:70>*12)
    .addEnergyPerTickInput(51200)
    .build();
//炉渣
RecipeBuilder.newBuilder("isoverMEATERIAL864", "mega_injectiondevice", 10)
    .addInputs(
        <ore:sand>,
        <ore:dustRedstone>
    )
    .addOutput(<thermalfoundation:material:864>)
    .addOutput(<thermalfoundation:material:865>).setChance(0.5)
    .addEnergyPerTickInput(51200)
    .build();
//富炉渣
RecipeBuilder.newBuilder("isoverMEATERIAL865", "mega_injectiondevice", 10)
    .addInputs(
        <ore:sand>,
        <thermalfoundation:material:865>
    )
    .addOutput(<thermalfoundation:material:865>)
    .addEnergyPerTickInput(51200)
    .build();
//三个有机染料
RecipeBuilder.newBuilder("item_material75", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:dustCoal>,
                <ore:dustCharcoal>
            ]))
    .addInput(<enderio:item_material:20>)
    .addOutput(<enderio:item_material:75>*4)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("item_material49", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dyeBrown>
    )
    .addOutput(<enderio:item_material:49>*4)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("item_material48", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dyeGreen>
    )
    .addOutput(<enderio:item_material:48>*4)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("item_material50", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:slimeball>,
                <ore:egg>
            ]))
    .addInputs(
        <ore:dustCoal>,
        <ore:dustCharcoal>
    )
    .addOutput(<enderio:item_material:50>*4)
    .addEnergyPerTickInput(51200)
    .build();
//神秘的花
// 创建死亡袋子配方（Death Pouch Recipe）
RecipeBuilder.newBuilder("death_pouch_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <minecraft:dye:15> * 7,           // 黑色染料 x7
        <enderio:item_material:81>        // Ender IO 特殊材料
    )
    .addOutput(<enderio:block_death_pouch>)  // 输出死亡袋子
    .addEnergyPerTickInput(51200)              // 每 tick 所需能量
    .build();
// 创建暗钢升级模块配方（Dark Steel Upgrade Recipe）
RecipeBuilder.newBuilder("dark_steel_upgrade_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <minecraft:string> * 4,           // 线 x4
        <enderio:block_dark_iron_bars>,   // 暗铁栅栏
        <minecraft:clay_ball>             // 粘土球
    )
    .addOutput(<enderio:item_dark_steel_upgrade>)  // 输出暗钢升级模块
    .addEnergyPerTickInput(51200)                   // 每 tick 所需能量
    .build();    
// 创建铁粉配方（Iron Dust Recipe）
RecipeBuilder.newBuilder("iron_dust_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <enderio:item_material:51>,       // 第一个输入材料
        <enderio:item_material>         // 第二个输入材料，需确认具体的子ID
    )
    .addOutput(<enderio:item_material:1>) // 输出铁粉
    .addEnergyPerTickInput(51200)           // 每 tick 所需能量
    .build();                               // 注册该配方
// 创建基础电容配方（Basic Capacitor Recipe）
RecipeBuilder.newBuilder("basic_capacitor_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <enderio:item_material:52>,       // 输入材料1（例如：基板）
        <enderio:item_material:66>        // 输入材料2（例如：硅芯片）
    )
    .addOutput(<enderio:item_material:54>)  // 输出基础电容
    .addEnergyPerTickInput(51200)             // 每 tick 所需能量
    .build();                                 // 注册该配方
// 创建银粉配方（Silver Dust Recipe）
RecipeBuilder.newBuilder("silver_dust_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <enderio:item_material:0>,         // 第一个输入材料，需确认具体的子ID
        <enderio:item_material:52>         // 第二个输入材料
    )
    .addOutput(<enderio:item_material:53>) // 输出银粉
    .addEnergyPerTickInput(51200)           // 每 tick 所需能量
    .build();                               // 注册该配方//石英玻璃
RecipeBuilder.newBuilder("block_dark_fused_quartz", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addInputs(
        <ore:dyeBlack>
    )
    .addOutput(<enderio:block_dark_fused_quartz>)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_enlightened_fused_quartz", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <chisel:glowstone:5>,
        <minecraft:glowstone_dust>*4
    ]))
    .addOutput(<enderio:block_enlightened_fused_quartz>)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_fused_quartz", "mega_injectiondevice", 10)
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
                <ore:blockQuartz>,
                <ore:gemQuartz>*4
            ]))
    .addOutput(<enderio:block_fused_quartz>)
    .addEnergyPerTickInput(51200)
    .build();
//纯净玻璃
RecipeBuilder.newBuilder("block_dark_fused_glass", "mega_injectiondevice", 10)
    .addInputs(
        <ore:dyeBlack>,
        <ore:blockGlass>
    )
    .addOutput(<enderio:block_dark_fused_glass>)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_enlightened_fused_glass", "mega_injectiondevice", 10)
    .addInputs(
        <ore:blockGlass>
    )
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <chisel:glowstone:5>,
        <minecraft:glowstone_dust>*4
    ]))
    .addOutput(<enderio:block_enlightened_fused_glass>)
    .addEnergyPerTickInput(51200)
    .build();
RecipeBuilder.newBuilder("block_fused_glass", "mega_injectiondevice", 10)
    .addInputs(
        <ore:blockGlass>
    )
    .addOutput(<enderio:block_fused_glass>)
    .addEnergyPerTickInput(51200)
    .build();
// 创建工业绝缘块配方（Industrial Insulation Recipe）
RecipeBuilder.newBuilder("industrial_insulation_recipe", "mega_injectiondevice", 10)
    .addInputs(
        <ore:dustTin>,              // 锡粉
        <ore:dustLapis>,            // 青金石粉
        <minecraft:wool>            // 羊毛
    )
    .addOutput(<enderio:block_industrial_insulation>)  // 输出工业绝缘块
    .addEnergyPerTickInput(51200)    // 每 tick 所需能量
    .build();                      // 注册该配方
// 创建 Endergy 合金锭配方
RecipeBuilder.newBuilder("endergy_alloy_ingot_recipe","mega_injectiondevice", 10)
    .addInputs(
        <minecraft:clay_ball>,
        <minecraft:gravel>,
        <ore:cobblestone>  //原石
    )
    .addOutput(<enderio:item_alloy_endergy_ingot>)
    .addEnergyPerTickInput(51200)
    .build();
//感知锭
RecipeBuilder.newBuilder("konwyouding","mega_injectiondevice", 10)
    .addInputs(
        <tconevo:material>,
        <bloodmagic:monster_soul>  //灵魂
    )
    .addOutput(<tconevo:metal:30>)
    .addEnergyPerTickInput(51200)
    .build();
//铌钛合金
RecipeBuilder.newBuilder("youaresomeili","mega_injectiondevice", 10)
    .addInputs(
        <mets:niobium_titanium_dust>*4
    )
    .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([
        <ore:charcoal>,
        <ore:coal>
    ]))
    .addOutput(<mets:niobium_titanium_ingot>* 4)
    .addEnergyPerTickInput(51200)
    .build();

//魔力聚合机配方
//五彩观象台
RecipeAdapterBuilder.create("mega_magicalcrafttable", "modularmachinery:iridescentobservatory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.001F, 1, false).build())
    .build();
function registerRecipe(machine as string,name as string,inputs as IIngredient[],Weightedinputs as IWeightedIngredient[],outputs as IIngredient[],Weightedoutputs as IWeightedIngredient[],time as int,energy as long){
    val recipe = RecipeBuilder.newBuilder(machine,name,time);
        if (energy > 0){
            recipe.addEnergyPerTickInput(energy);
        }
        for input in inputs{
            recipe.addInput(input);
        }
        for input in Weightedinputs{
            recipe.addInput(input.ingredient).setChance(input.percent);
        }
        for output in outputs{
            recipe.addOutput(output);
        }
        for output in Weightedoutputs{
            recipe.addOutput(output.ingredient).setChance(output.percent);
        }
        recipe.build();
}
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe1",[<extrabotany:nightmarefuel>*3,<extrabotany:gildedmashedpotato>,<botania:manaresource:7>,<botania:livingrock:0>],[],[<extrabotany:material:5>],[],2,2560);
//奥利哈钢
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe2",[<botania:manaresource:14>*2,<botania:manaresource:5>*4,<extrabotany:material:3>],[],[<extrabotany:material:1>],[],20,12800);
//镀金土豆泥
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe3",[<minecraft:potato>,<botania:livingrock:0>],[],[<extrabotany:gildedmashedpotato>],[],5,2560);
//光子锭
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe4",[<extrabotany:material:0>*3,<extrabotany:gildedmashedpotato>,<botania:manaresource:7>,<botania:livingrock:0>],[],[<extrabotany:material:8>],[],20,2560);
//精神碎片
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe5",[<minecraft:coal>],[],[<extrabotany:material:0>],[],5,2560);
//泰拉钢
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe6",[<botania:manaresource:0>,<botania:manaresource:1>,<botania:manaresource:2>],[],[<botania:manaresource:4>],[],20,2560);
//异世界水晶_3
registerRecipe("mega_magicalcrafttable","mega_magicalcrafttable_recipe7",[<ore:gemCrystalPurple>],[],[],[<contenttweaker:crystalgreen>],12,0);
//符文配方
// 水之符文 (botania:rune:0)
RecipeBuilder.newBuilder("Mega_water_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <minecraft:reeds>,
        <minecraft:dye:15>,
        <minecraft:fishing_rod>, // 任意耐久钓鱼竿
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addEnergyPerTickInput(5200) // 电力消耗
    .addOutput(<botania:rune:0> * 2)
    .build();
// 火之符文 (botania:rune:1)
RecipeBuilder.newBuilder("Mega_fire_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <minecraft:nether_brick>,
        <minecraft:gunpowder>,
        <minecraft:nether_wart>,
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addEnergyPerTickInput(5200) // 电力消耗
    .addOutput(<botania:rune:1> * 2)
    .build();
// 地之符文 (botania:rune:2)
RecipeBuilder.newBuilder("Mega_earth_rune", "mega_magicalcrafttable", 20) // 时间设置为1秒
    .addInputs([
        <minecraft:stone>,
        <minecraft:coal_block>,
        <ore:mushroom>, // 任意颜色蘑菇
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addEnergyPerTickInput(5200) // 电力消耗
    .addOutput(<botania:rune:2> * 2)
    .build();
// 风之符文 (botania:rune:3)
RecipeBuilder.newBuilder("Mega_wind_rune", "mega_magicalcrafttable", 20)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:carpet:0>, // 白色地毯
                <minecraft:carpet:1>, // 橙色地毯
                <minecraft:carpet:2>, // 品红色地毯
                <minecraft:carpet:3>, // 浅蓝色地毯
                <minecraft:carpet:4>, // 黄色地毯
                <minecraft:carpet:5>, // 绿色地毯
                <minecraft:carpet:6>, // 粉红色地毯
                <minecraft:carpet:7>, // 灰色地毯
                <minecraft:carpet:8>, // 浅灰色地毯
                <minecraft:carpet:9>, // 青色地毯
                <minecraft:carpet:10>, // 紫色地毯
                <minecraft:carpet:11>, // 蓝色地毯
                <minecraft:carpet:12>, // 棕色地毯
                <minecraft:carpet:13>, // 绿色地毯
                <minecraft:carpet:14>, // 红色地毯
                <minecraft:carpet:15>  // 黑色地毯
            ])
        )
    .addInputs([
        <minecraft:feather>,
        <minecraft:string>,
        <botania:manaresource:23>, // 魔力尘
        <botania:manaresource:0> // 魔力钢锭
    ])
    .addEnergyPerTickInput(5200) // 电力消耗
    .addOutput(<botania:rune:3> * 2)
    .build();
// 春之符文 (botania:rune:4)
RecipeBuilder.newBuilder("Mega_spring_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:grassseeds:0> * 3, // 草地之种
        <minecraft:wheat>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addEnergyPerTickInput(8000) // 电力消耗
    .addOutput(<botania:rune:4>)
    .build();
// 夏之符文 (botania:rune:5)
RecipeBuilder.newBuilder("Mega_summer_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:sand> * 2, // 任意沙子
        <ore:slimeball>, // 任意粘液球
        <minecraft:melon>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addEnergyPerTickInput(8000) // 电力消耗
    .addOutput(<botania:rune:5>)
    .build();
// 秋之符文 (botania:rune:6)
RecipeBuilder.newBuilder("Mega_autumn_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:treeLeaves> * 3, // 任意树叶
        <minecraft:spider_eye>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addEnergyPerTickInput(8000) // 电力消耗
    .addOutput(<botania:rune:6>)
    .build();
// 冬之符文 (botania:rune:7)
RecipeBuilder.newBuilder("Mega_winter_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <minecraft:snow> * 2,
        <ore:wool>, // 任意颜色羊毛
        <minecraft:cake>,
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addEnergyPerTickInput(8000) // 电力消耗
    .addOutput(<botania:rune:7>)
    .build();
//魔力符文 (botania:rune:8)
RecipeBuilder.newBuilder("Mega_mana_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2>, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addEnergyPerTickInput(16000) // 电力消耗
    .addOutput(<botania:rune:8>)
    .build();
// 傲慢符文 (botania:rune:15)
RecipeBuilder.newBuilder("Mega_pride_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:5>).setChance(0) // 夏之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:15>)
    .build();
// 嫉妒符文 (botania:rune:14)
RecipeBuilder.newBuilder("Mega_envy_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:14>)
    .build();
// 暴怒符文 (botania:rune:13)
RecipeBuilder.newBuilder("Mega_wrath_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:2>).setChance(0) // 地之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:13>)
    .build();
//懒惰符文 (botania:rune:12)
RecipeBuilder.newBuilder("Mega_sloth_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:6>).setChance(0) // 秋之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:12>)
    .build();
// 贪婪符文 (botania:rune:11)
RecipeBuilder.newBuilder("Mega_greed_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:4>).setChance(0) // 春之符文（不消耗）
    .addInputs(<botania:rune:0>).setChance(0) // 水之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:11>)
    .build();
// 暴食符文 (botania:rune:10)
RecipeBuilder.newBuilder("Mega_gluttony_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:7>).setChance(0) // 冬之符文（不消耗）
    .addInputs(<botania:rune:1>).setChance(0) // 火之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:10>)
    .build();
// 欲望符文 (botania:rune:9)
RecipeBuilder.newBuilder("Mega_lust_rune", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:manaresource:2> * 2, // 魔力钻石
        <botania:livingrock> // 活石
    ])
    .addInputs(<botania:rune:5>).setChance(0) // 夏之符文（不消耗）
    .addInputs(<botania:rune:3>).setChance(0) // 风之符文（不消耗）
    .addEnergyPerTickInput(12000) // 电力消耗
    .addOutput(<botania:rune:9>)
    .build();
// 特殊物品 - 玩家的头
RecipeBuilder.newBuilder("player_head", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:itemSkull>,
        <minecraft:golden_apple>,
        <minecraft:name_tag>,
        <minecraft:sea_lantern>, // 海晶沙砾
        <botania:manaresource:8>  // 精灵尘
    ])
    .addInput(<botania:livingrock>) // 活石
    .addEnergyPerTickInput(22500) // 电力消耗
    .addOutput(<minecraft:skull:3>) // 注意：这里的输出可能需要根据实际需求调整
    .build();
// Soarleander 花合成
RecipeBuilder.newBuilder("Mega_soarleander_flower", "mega_magicalcrafttable", 20)
    .addInputs([
        <botania:specialflower>.withTag({type: "gourmaryllis"}),
        <minecraft:chicken>*8
    ])
    .addInput(<botania:livingrock>) // 活石
    .addEnergyPerTickInput(8000) // 电力消耗
    .addOutput(<botania:specialflower>.withTag({type: "soarleander"})) // 输出：Soarleander 花
    .build();
// 强化材质合成
RecipeBuilder.newBuilder("Mega_enchanted_material", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotManasteel>,
        <ore:ingotTerrasteel>,
        <ore:gaiaIngot>,
        <ore:ingotElvenElementium>,
        <ore:manaDiamond>,
        <ore:elvenDragonstone>
    ])
    .addInput(<botania:livingrock>) // 活石
    .addEnergyPerTickInput(100000) // 电力消耗
    .addOutput(<extrabotany:material:2>.withTag({
        ench: [
            {lvl: 5 as short, id: 1},
            {lvl: 5 as short, id: 4},
            {lvl: 5 as short, id: 3},
            {lvl: 5 as short, id: 0}
        ]
    })) // 输出：附魔强化材质
    .build();
// Material:2 合成
RecipeBuilder.newBuilder("Mega_material_2", "mega_magicalcrafttable", 20)
    .addInputs([
        <minecraft:potato>,
        <minecraft:gold_nugget>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(800) // 电力消耗
    .addOutput(<extrabotany:material:2>) // 输出：Material:2
    .build();
// Froststar 合成
RecipeBuilder.newBuilder("Mega_froststar", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:ice>*2,
        <botania:rune:0> // 魔力符文
    ])
    .addInputs(<botania:livingrock>) // 活石
    .addEnergyPerTickInput(2000) // 电力消耗
    .addOutput(<extrabotany:froststar>) // 输出：Froststar
    .build();
// Death Ring 合成
RecipeBuilder.newBuilder("Mega_death_ring", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <ore:manaDiamond>,
        <minecraft:skull:1>,
        <botania:rune:7>, // Envy 符文
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(2000) // 电力消耗
    .addOutput(<extrabotany:deathring>) // 输出：Death Ring
    .build();
// Combat Maid Chest Darkened 合成
RecipeBuilder.newBuilder("Mega_combatmaidchestdarkened", "mega_magicalcrafttable", 20)
    .addInputs([
        <extrabotany:combatmaidchest>,
        <extrabotany:shadowwarriorhelm>,
        <extrabotany:shadowwarriorchest>,
        <extrabotany:shadowwarriorlegs>,
        <extrabotany:shadowwarriorboots>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(50000) // 电力消耗
    .addOutput(<extrabotany:combatmaidchestdarkened>) // 输出：Combat Maid Chest Darkened
    .build();
// Walljumping 合成
RecipeBuilder.newBuilder("Mega_walljumping", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:wheat_seeds>,
        <botania:rune:4>, // Earth 符文
        <minecraft:sticky_piston>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(2000) // 电力消耗
    .addOutput(<extrabotany:walljumping>) // 输出：Walljumping
    .build();
// Wallrunning 合成
RecipeBuilder.newBuilder("Mega_wallrunning", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotManasteel>*2,
        <minecraft:wheat_seeds>,
        <botania:rune:4>, // Earth 符文
        <ore:stone>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(2000) // 电力消耗
    .addOutput(<extrabotany:wallrunning>) // 输出：Wallrunning
    .build();
// Elvenking 合成
RecipeBuilder.newBuilder("Mega_elvenking", "mega_magicalcrafttable", 20)
    .addInputs([
        <ore:ingotElvenElementium>*2,
        <ore:quartzElven>*2,
        <botania:rune:8>, // Spring 符文
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(4000) // 电力消耗
    .addOutput(<extrabotany:elvenking>) // 输出：Elvenking
    .build();
// Ultimate Hammer 合成
RecipeBuilder.newBuilder("Mega_ultimatehammer", "mega_magicalcrafttable", 20)
    .addInputs([
        <extrabotany:terrasteelhammer>,
        <extrabotany:gildedmashedpotato>*3,
        <minecraft:gold_block>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(100000) // 电力消耗
    .addOutput(<extrabotany:ultimatehammer>) // 输出：Ultimate Hammer
    .build();
// Allforone 合成
RecipeBuilder.newBuilder("Mega_allforone", "mega_magicalcrafttable", 20)
    .addInputs([
        <extrabotany:elvenking>,
        <extrabotany:material:3>,
        <botania:rune:6>, // Lust 符文
        <botania:rune:7>, // Gluttony 符文
        <botania:rune:8>, // Greed 符文
        <botania:rune:9>, // Sloth 符文
        <botania:rune:10>, // Wrath 符文
        <botania:rune:11>, // Envy 符文
        <botania:rune:12>, // Pride 符文
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(50000) // 电力消耗
    .addOutput(<extrabotany:allforone>) // 输出：Allforone
    .build();
// Firstfractal 合成
RecipeBuilder.newBuilder("Mega_firstfractal", "mega_magicalcrafttable", 20)
    .addInputs([
        <extrabotany:gildedmashedpotato>,
        <extrabotany:excaliber>,
        <extrabotany:buddhistrelics>.withTag({}),
        <extrabotany:shadowkatana>.withTag({}),
        <minecraft:wooden_sword>,
        <botania:terrasword>,
        <botania:starsword>,
        <botania:elementiumsword>,
        <botania:thundersword>,
        <botania:manasteelsword>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(1000000) // 电力消耗
    .addOutput(<extrabotany:firstfractal>) // 输出：Firstfractal
    .build();
// Advancedrocketry Crystal 合成
RecipeBuilder.newBuilder("Mega_advancedrocketry_crystal", "mega_magicalcrafttable", 20)
    .addInputs([
        <ancientspellcraft:astral_diamond_shard>.withTag({"display": {"Lore": ["和除去魔力符文的15种符文一同接受一池魔力，它会焕发新生"], "Name": "某种事物的...基质？"}}),
        <botania:rune>,
        <botania:rune:1>,
        <botania:rune:2>,
        <botania:rune:3>,
        <botania:rune:4>,
        <botania:rune:5>,
        <botania:rune:6>,
        <botania:rune:7>,
        <botania:rune:9>,
        <botania:rune:10>,
        <botania:rune:11>,
        <botania:rune:12>,
        <botania:rune:13>,
        <botania:rune:14>,
        <botania:rune:15>,
        <botania:livingrock> // 活石
    ])
    .addEnergyPerTickInput(1000000) // 电力消耗
    .addOutput(<advancedrocketry:crystal>.withTag({"display": {"Lore": ["想想怎么利用它，不如试试用铿金与它熔炼出新物质？"], "Name": "重聚而出的晶块"}})) // 输出：Advanced Rocketry Crystal
    .build();
//产五颜六色的花瓣
RecipeBuilder.newBuilder("Mega-PetalProduction","mega_magicalcrafttable", 20)
    .addItemInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addItemOutput(<botania:petal>*5).setChance(0.15)
    .addItemOutput(<botania:petal:1>*5).setChance(0.15)
    .addItemOutput(<botania:petal:2>*5).setChance(0.15)
    .addItemOutput(<botania:petal:3>*5).setChance(0.15)
    .addItemOutput(<botania:petal:4>*5).setChance(0.15)
    .addItemOutput(<botania:petal:5>*5).setChance(0.15)
    .addItemOutput(<botania:petal:6>*5).setChance(0.15)
    .addItemOutput(<botania:petal:7>*5).setChance(0.15)
    .addItemOutput(<botania:petal:8>*5).setChance(0.15)
    .addItemOutput(<botania:petal:9>*5).setChance(0.15)
    .addItemOutput(<botania:petal:10>*5).setChance(0.15)
    .addItemOutput(<botania:petal:11>*5).setChance(0.15)
    .addItemOutput(<botania:petal:12>*5).setChance(0.15)
    .addItemOutput(<botania:petal:13>*5).setChance(0.15)
    .addItemOutput(<botania:petal:14>*5).setChance(0.15)
    .addItemOutput(<botania:petal:15>*5).setChance(0.15)
    .addItemOutput(<contenttweaker:iridescence>).setChance(0.01)
    .build();
//产五颜六色的燃料
RecipeBuilder.newBuilder("Mega-FuelProduction","mega_magicalcrafttable", 20)
    .addItemInput(<contenttweaker:programming_circuit_a>).setChance(0)
    .addItemOutput(<minecraft:dye:1>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:2>*5).setChance(0.15)
    .addItemOutput(<futuremc:dye>*5).setChance(0.15)
    .addItemOutput(<futuremc:dye:1>*5).setChance(0.15)
    .addItemOutput(<futuremc:dye:2>*5).setChance(0.15)
    .addItemOutput(<futuremc:dye:3>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:5>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:6>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:7>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:8>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:9>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:10>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:11>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:12>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:13>*5).setChance(0.15)
    .addItemOutput(<minecraft:dye:14>*5).setChance(0.15)
    .build();
//产有机燃料
RecipeBuilder.newBuilder("Mega-AnotherFuelProduction","mega_magicalcrafttable", 20)
    .addItemInput(<contenttweaker:programming_circuit_b>).setChance(0)
    .addItemOutput(<enderio:item_material:48>*10).setChance(0.333)
    .addItemOutput(<enderio:item_material:49>*10).setChance(0.333)
    .addItemOutput(<enderio:item_material:50>*10).setChance(0.333)
    .build();
//产活石活木 活体金属(???) 好吧其实是活体木头
RecipeBuilder.newBuilder("Mega-LivingMaterialProduction","mega_magicalcrafttable", 20)
    .addItemInput(<contenttweaker:programming_circuit_c>).setChance(0)
    .addItemOutput(<botania:livingrock>*32)
    .addItemOutput(<botania:livingwood>*32)
    .build();
//星辉配方
RecipeBuilder.newBuilder("hs_xingnengyechanchu", "mega_magicalcrafttable", 600)
    .addInput(<extrabotany:material:3>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<contenttweaker:programming_circuit_d>).setChance(0)
    .addFluidPerTickOutput(<liquid:astralsorcery.liquidstarlight> * 1000)
    .addCatalystInput(<astralsorcery:itemcoloredlens:6>,
        ["注入了星能的彩色透镜拥有将星能汇聚的能力。", "使星能液的产量翻倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addCatalystInput(<ancientspellcraft:astral_diamond_charged>,
        ["充能后的星芒宝钻蕴含着众多遗灵强大的能量。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addCatalystInput(<avaritia:resource:5>,
        ["一即全，全即一。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addCatalystInput(<additions:novaextended-novaextended_medal2>,
        ["美丽的时钟座。", "使星能液的生产速率 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addCatalystInput(<ebwizardry:astral_diamond>,
        ["事情的一部分当然是不可缺少的。", "使星能液的产量 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addRecipeTooltip("§a英雄徽章§f数量影响并行数")
    .setMaxThreads(1)
    .build();
// 新配方：飞龙剑
RecipeBuilder.newBuilder("xhzz_wyvern_sword", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<redstonerepository:tool.sword_gelid>) // 凝胶斧头
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_sword>) // 输出：飞龙剑
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙剑！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙镐
RecipeBuilder.newBuilder("xhzz_wyvern_pick", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<redstonerepository:tool.pickaxe_gelid>) // 凝胶镐头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_pick>) // 输出：飞龙镐
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙镐！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙斧
RecipeBuilder.newBuilder("xhzz_wyvern_axe", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:tool.axe_gelid>) // 凝胶斧头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>) // 旋律合金 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_axe>) // 输出：飞龙斧
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙斧！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙铲
RecipeBuilder.newBuilder("xhzz_wyvern_shovel", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonearsenal:tool.excavator_flux>) // 红石铲
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_shovel>) // 输出：飞龙铲
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙铲！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙弓
RecipeBuilder.newBuilder("xhzz_wyvern_bow", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_end_steel_bow>) // 末影钢弓
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<botania:manaresource:16>*2) // 魔法绳索 x2
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_bow>) // 输出：飞龙弓
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出强大的飞龙弓！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙头盔
RecipeBuilder.newBuilder("xhzz_wyvern_helm", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.helmet_gelid>) // 凝胶头盔
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*2) // 旋律合金 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_helm>) // 输出：飞龙头盔
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙头盔！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙胸甲
RecipeBuilder.newBuilder("xhzz_wyvern_chest", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.chestplategelid>) // 凝胶胸甲
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_chest>) // 输出：飞龙胸甲
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙胸甲！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙护腿
RecipeBuilder.newBuilder("xhzz_wyvern_legs", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.leggings_gelid>) // 凝胶护腿
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_legs>) // 输出：飞龙护腿
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙护腿！") // 提示信息：描述配方功能
    .build();
// 新配方：飞龙靴子
RecipeBuilder.newBuilder("xhzz_wyvern_boots", "Mega_MagicalCraftTabl", 100)
    .addEnergyPerTickInput(640000)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:armor.boots_gelid>) // 凝胶靴子
    .addItemInput(<enderio:item_material:71>*3) // 无尽之杆 x3
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_boots>) // 输出：飞龙靴子
    .addRecipeTooltip("星辉铸造：\n凝聚星能与龙之力，锻造出坚固的飞龙靴子！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章
RecipeBuilder.newBuilder("xhzz_medal", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 8) // 共振宝石 x8
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<additions:novaextended-terraalloy> * 1) // 泰拉合金 x1
    .addItemInput(<additions:novaextended-ingot8>* 2) // 柳木合金 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 8000) // 星能液桶 1000 MB * 8
    .addItemOutput(<additions:novaextended-novaextended_medal>) // 输出：星耀勋章
    .addRecipeTooltip("星耀共鸣：\n汇聚星光之力，铸就荣耀勋章！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章1
RecipeBuilder.newBuilder("xhzz_medal1", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:gold_ore> * 1) // 金矿石 x1
    .addItemInput(<minecraft:iron_ore> * 1) // 铁矿石 x1
    .addItemInput(<minecraft:diamond_ore> * 1) // 钻石矿石 x1
    .addItemInput(<minecraft:emerald_ore> * 1) // 绿宝石矿石 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal1>) // 输出：星耀勋章1
    .addRecipeTooltip("晶金共鸣：\n结合矿物的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章2
RecipeBuilder.newBuilder("xhzz_medal2", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:clock> * 1) // 时钟 x1
    .addItemInput(<minecraft:redstone> * 1) // 红石粉 x1
    .addItemInput(<minecraft:glowstone_dust> * 1) // 萤石粉 x1
    .addItemInput(<rftools:timer_block> * 1) // RFTools 定时器 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal2>) // 输出：星耀勋章2
    .addRecipeTooltip("时钟共鸣：\n融合时间的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章3
RecipeBuilder.newBuilder("xhzz_medal3", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<avaritia:resource:5> * 2) // 极限资源 x2
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:diamond_block> * 1) // 钻石块 x1
    .addItemInput(<minecraft:lapis_block> * 1) // 青金石块 x1
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<jaopca:block_blockwillowalloy> * 1) // 柳木合金块 x1
    .addItemInput(<avaritia:resource:6>* 1) // 无尽锭 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal3>) // 输出：星耀勋章3
    .addRecipeTooltip("避役共鸣：\n融合无尽的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章4
RecipeBuilder.newBuilder("xhzz_medal4", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:pumpkin> * 1) // 南瓜 x1
    .addItemInput(<minecraft:melon> * 1) // 西瓜 x1
    .addItemInput(<minecraft:hay_block> * 1) // 干草块 x1
    .addItemInput(<minecraft:wool> * 1) // 羊毛块 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal4>) // 输出：星耀勋章4
    .addRecipeTooltip("牧夫共鸣：\n融合丰收的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();
// 新配方：星耀勋章5
RecipeBuilder.newBuilder("xhzz_medal5", "Mega_MagicalCraftTabl", 40)
    .addEnergyPerTickInput(640000)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:bone> * 1) // 骨头 x1
    .addItemInput(<minecraft:nether_star> * 1) // 下界之星 x1
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    .addItemInput(<deepmoblearning:glitch_heart> * 1) // 故障核心 x1
    .addInput(<liquid:astralsorcery.liquidstarlight>* 4000) // 星能液桶 1000 MB * 4
    .addItemOutput(<additions:novaextended-novaextended_medal5>) // 输出：星耀勋章5
    .addRecipeTooltip("唤生共鸣：\n融合星辰的力量，提升勋章等级！") // 提示信息：描述配方功能
    .build();
// 新配方：玻璃板转化为玻璃透镜
RecipeBuilder.newBuilder("glass_to_lens", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:glass_pane> * 1) // 玻璃板 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:3> * 1) // 输出：玻璃透镜 x1
    .addRecipeTooltip("星能矩阵转化：\n通过精确的电力输入，将普通的玻璃板转化为神秘的玻璃透镜！") // 提示信息：描述配方功能
    .build();
// 新配方：海蓝宝石 + 萤石粉 制作 辉光粉
RecipeBuilder.newBuilder("hs_glow_dust", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<minecraft:glowstone_dust> * 4) // 萤石粉 x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemusabledust> * 16) // 输出：辉光粉 x16
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将海蓝宝石与萤石粉转化为大量辉光粉！") // 提示信息：描述配方功能
    .build();
// 新配方：海蓝宝石 + 煤炭变种 制作 暗夜粉
RecipeBuilder.newBuilder("hs_dark_dust", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>* 4,               // 普通煤炭
                <minecraft:coal:1>* 4,             // 木炭
            ]) // 每种煤炭变种的数量为 4
    )
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemusabledust:1> * 16) // 输出：暗夜粉 x16
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将海蓝宝石与煤炭转化为大量暗夜粉！") // 提示信息：描述配方功能
    .build();
// 新配方：金粒 + 木板 + 大理石块 + 玻璃透镜 制作 光波增幅器
RecipeBuilder.newBuilder("hs_lightwave_amplifier", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:gold_nugget> * 2) // 金粒 x2
    .addInput(<ore:plankWood>*2)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble> * 1,    // 大理石块 元数据 1 x1   
                <astralsorcery:blockmarble:1> * 1,    // 大理石块 元数据 1 x1
                <astralsorcery:blockmarble:2> * 1,    // 大理石块 元数据 2 x1
                <astralsorcery:blockmarble:3> * 1,    // 大理石块 元数据 3 x1
                <astralsorcery:blockmarble:4> * 1,    // 大理石块 元数据 4 x1
                <astralsorcery:blockmarble:5> * 1,    // 大理石块 元数据 5 x1
                <astralsorcery:blockmarble:6> * 1,    // 大理石块 元数据 6 x1
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockattunementrelay> * 1) // 输出：光波增幅器 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将材料转化为一个光波增幅器！") // 提示信息：描述配方功能及产物名称
    .build();
// 新配方：辉光粉 + 玻璃透镜 + 光波增幅器 制作 标记光波增幅器
RecipeBuilder.newBuilder("hs_marked_relay", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemusabledust> * 3) // 辉光粉 x3
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockattunementrelay> * 1) // 光波增幅器 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<packagedastral:marked_relay> * 1) // 输出：标记光波增幅器 x1
    .addRecipeTooltip("星能转化：\n将材料转化为标记光波增幅器！") // 提示信息：描述配方功能
    .build();
// 新配方：羽毛 + 辉光粉 + 星尘 + 羊皮纸 + 煤炭变种 制作 知识共享卷轴
RecipeBuilder.newBuilder("hs_knowledge_share", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:feather> * 1) // 羽毛 x1
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:5> * 1) // 羊皮纸 x1
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>,               // 普通煤炭
                <minecraft:coal:1>,             // 木炭
            ]) // 煤炭变种 x1
    )
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemknowledgeshare> * 1) // 输出：知识共享卷轴 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，将材料转化为知识共享卷轴！") // 提示信息：描述配方功能
    .build();
// 新配方：水晶石 + 星辉锭 + 星尘 + 辉光粉 + 玻璃透镜 + 大理石块 制作 天体星门
RecipeBuilder.newBuilder("hs_celestial_gateway", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 星尘 x4
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockcelestialgateway> * 1) // 输出：天体星门 x1
    .addRecipeTooltip("星能转化：\n通过星光矩阵的力量，制造出天体星门！") // 提示信息：仅描述产物名称
    .build();
// 新配方：海蓝宝石 + 玻璃透镜 + 水晶石 + 金锭 + 大理石块 + 聚星木 制作 透镜
RecipeBuilder.newBuilder("hs_lens", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 3) // 玻璃透镜 x3
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    .addItemInput(<astralsorcery:blockinfusedwood:4> * 2) // 聚星木（元数据4）x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blocklens> * 1) // 输出：透镜 x1
    .addRecipeTooltip("星能转化：\n制造出透镜！") // 提示信息：仅描述产物名称
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_burning", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_powder> * 6) // 烈焰粉 x6
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:0>) // 输出：燃烧透镜 x1
    .addRecipeTooltip("星能转化：\n制造出燃烧透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_destruction", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_pickaxe> * 1) // 铁镐 x1
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:1>) // 输出：破坏透镜 x1
    .addRecipeTooltip("星能转化：\n制造出破坏透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_growth", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:wheat_seeds> * 6) // 小麦种子 x6
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:2>) // 输出：生长透镜 x1
    .addRecipeTooltip("星能转化：\n制造出生长透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_damage", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_sword> * 2) // 铁剑 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:3>) // 输出：伤害透镜 x1
    .addRecipeTooltip("星能转化：\n制造出伤害透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_regeneration", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:apple> * 1) // 苹果 x1
    .addItemInput(<minecraft:diamond> * 1) // 钻石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:4>) // 输出：再生透镜 x1
    .addRecipeTooltip("星能转化：\n制造出再生透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_repulsion", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:piston> * 2) // 活塞 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:5>) // 输出：抗拒透镜 x1
    .addRecipeTooltip("星能转化：\n制造出抗拒透镜！") // 提示信息
    .build();
RecipeBuilder.newBuilder("hs_colored_lens_convergence", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemcoloredlens:6>) // 输出：汇聚透镜 x1
    .addRecipeTooltip("星能转化：\n制造出汇聚透镜！") // 提示信息
    .build();
// 新配方：树叶（可替代）+ 树苗（可替代）+ 星能液桶 + 大理石块（元数据6）+ 海蓝宝石 制作 烽火树
RecipeBuilder.newBuilder("hs_tree_beacon", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)
    .addInput(<ore:treeLeaves>*6)
    .addInput(<ore:treeSapling>)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blocktreebeacon> * 1) // 输出：烽火树 x1
    .addRecipeTooltip("星能转化：\n制造出烽火树！") // 提示信息：仅描述产物名称
    .build();
// 新配方：金粒 + 金锭 + 玻璃板 + 玻璃透镜 + 星尘 + 海蓝宝石 制作 效应链接通道 x2
RecipeBuilder.newBuilder("hs_ritual_link", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:gold_nugget> * 4) // 金粒 x4
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 2) // 玻璃透镜 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:blockrituallink> * 2) // 输出：效应链接通道 x2
    .addRecipeTooltip("星能转化：\n制造出效应链接通道！") // 提示信息：仅描述产物名称
    .build();
// 新配方：星尘 + 海蓝宝石 + 大理石柱（元数据6）+ 星能液桶 + 辉光粉 制作 更替之星
RecipeBuilder.newBuilder("hs_shifting_star", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石柱（元数据6）x4
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemshiftingstar>* 1) // 输出：更替之星 x1
    .addRecipeTooltip("星能转化：\n制造出更替之星！") // 提示信息：仅描述产物名称
    .build();
// 新配方：更替之星 + 原石 + 星尘 + 辉光粉 制作 辐射之星（解离座）
RecipeBuilder.newBuilder("hs_radiation_star_evorsio", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 原石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.evorsio"}}) * 1) // 输出：辐射之星（解离座）x1
    .addRecipeTooltip("星能转化：\n制造出解离座（Evorsio）！") // 提示信息：描述产物名称
    .build();
// 新配方：更替之星 + 树苗 + 星尘 + 辉光粉 制作 生息座（Aevitas）
RecipeBuilder.newBuilder("hs_life_star_aevitas", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addInput(<ore:treeSapling>*4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.aevitas"}}) * 1) // 输出：生息座（Aevitas）x1
    .addRecipeTooltip("星能转化：\n制造出生息座（Aevitas）！") // 提示信息：描述产物名称
    .build();
// 新配方：更替之星 + 羽毛 + 星尘 + 辉光粉 制作 虚御座（Vicio）
RecipeBuilder.newBuilder("hs_vicio_star", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:feather> * 4) // 羽毛 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.vicio"}}) * 1) // 输出：虚御座（Vicio）x1
    .addRecipeTooltip("星能转化：\n制造出虚御座（Vicio）！") // 提示信息：描述产物名称
    .build();
// 新配方：更替之星 + 铁锭 + 星尘 + 辉光粉 制作 遁甲座（Armara）
RecipeBuilder.newBuilder("hs_armara_star", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.armara"}}) * 1) // 输出：遁甲座（Armara）x1
    .addRecipeTooltip("星能转化：\n制造出遁甲座（Armara）！") // 提示信息：描述产物名称
    .build();
// 新配方：更替之星 + 燧石 + 星尘 + 辉光粉 制作 非攻座（Discidia）
RecipeBuilder.newBuilder("hs_discidia_star", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.discidia"}}) * 1) // 输出：非攻座（Discidia）x1
    .addRecipeTooltip("星能转化：\n制造出非攻座（Discidia）！") // 提示信息：描述产物名称
    .build();
// 新配方：木棍 + 原木（可替代）+ 海蓝宝石 制作 链接工具
RecipeBuilder.newBuilder("hs_linking_tool", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<minecraft:stick> * 2) // 木棍 x2
    .addInput(<ore:logWood>*2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemlinkingtool> * 1) // 输出：链接工具 x1
    .addRecipeTooltip("星能转化：\n制造出链接工具！") // 提示信息：描述产物名称
    .build();
// 新配方：水晶石 + 玻璃板 + 玻璃透镜 + 辉光粉 + 更替之星 制作 星座核心
RecipeBuilder.newBuilder("hs_constellation_focus", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 12) // 水晶石 x12
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:itemshiftingstar> * 1) // 更替之星 x1
    .addEnergyPerTickInput(750) // 每 tick 输入 750 单位电力 (总电力消耗 = 750 * 40 = 30000)
    .addItemOutput(<packagedastral:constellation_focus> * 1) // 输出：星座核心 x1
    .addRecipeTooltip("星能转化：\n制造出星座核心！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 金锭 + 星能液桶 + 水晶石 制作 仪式基座
RecipeBuilder.newBuilder("hs_ritual_pedestal", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石（元数据2）x4
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockritualpedestal> * 1) // 输出：仪式基座 x1
    .addRecipeTooltip("星能转化：\n制造出仪式基座！") // 提示信息：描述产物名称
    .build();
// 新配方：金锭 + 海蓝宝石 + 星能液桶 + 星尘 + 大理石 制作 星能聚合器
RecipeBuilder.newBuilder("hs_starlight_infuser", "mega_magicalcrafttable", 20) // 时间1秒，
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:blockmarble:5> * 2) // 大理石（元数据5）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 6) // 大理石（元数据2）x6
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockstarlightinfuser> * 1) // 输出：星能聚合器 x1
    .addRecipeTooltip("星能转化：\n制造出星能聚合器！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 辉光粉 + 水晶石 + 海蓝宝石 + 星尘 制作 照明星杖
RecipeBuilder.newBuilder("hs_illumination_wand", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 2) // 大理石（元数据6）x2
    .addItemInput(<astralsorcery:itemusabledust> * 1) // 辉光粉 x1
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 2) // 水晶石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemilluminationwand>) // 输出：照明星杖 x1
    .addRecipeTooltip("星能转化：\n制造出照明星杖！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 钻石 + 星尘 制作 转位星杖
RecipeBuilder.newBuilder("hs_exchange_wand", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:diamond> * 2) // 钻石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:itemexchangewand> * 1) // 输出：转位星杖 x1
    .addRecipeTooltip("星能转化：\n制造出转位星杖！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 末影珍珠 + 紫色燃料（可替代） 制作 冲击星杖
RecipeBuilder.newBuilder("hs_grapple_wand", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 1,         // Botania 紫色染料 x1
                <minecraft:dye:5> * 1,        // Minecraft 紫色染料 x1
                <thermalfoundation:dye:5> * 1 // Thermal Foundation 紫色染料 x1
            ])
    ) // 紫色染料（任意种类）x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemgrapplewand> * 1) // 输出：冲击星杖 x1
    .addRecipeTooltip("星能转化：\n制造出冲击星杖！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 紫色染料（可替代）+ 星尘 制作 秩序星杖
RecipeBuilder.newBuilder("hs_architect_wand", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 2,         // Botania 紫色染料 x2
                <minecraft:dye:5> * 2,        // Minecraft 紫色染料 x2
                <thermalfoundation:dye:5> * 2 // Thermal Foundation 紫色染料 x2
            ])
    ) // 紫色染料（任意种类）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemarchitectwand> * 1) // 输出：秩序星杖 x1
    .addRecipeTooltip("星能转化：\n制造出秩序星杖！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石块（可替代）+ 海蓝宝石 + 末影珍珠 制作 共振星杖
RecipeBuilder.newBuilder("hs_resonance_wand", "mega_magicalcrafttable", 20) // 时间调整为20 ticks (1秒)，
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble:0> * 2, // 大理石块（元数据0）x2
                <astralsorcery:blockmarble:1> * 2, // 大理石块（元数据1）x2
                <astralsorcery:blockmarble:2> * 2, // 大理石块（元数据2）x2
                <astralsorcery:blockmarble:3> * 2, // 大理石块（元数据3）x2
                <astralsorcery:blockmarble:4> * 2, // 大理石块（元数据4）x2
                <astralsorcery:blockmarble:5> * 2, // 大理石块（元数据5）x2
                <astralsorcery:blockmarble:6> * 2  // 大理石块（元数据6）x2
            ])
    ) // 大理石块（任意元数据）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 20 = 10000)
    .addItemOutput(<astralsorcery:itemwand> * 1) // 输出：共鸣星杖 x1
    .addRecipeTooltip("星能转化：\n制造出共鸣星杖！") // 提示信息：描述产物名称
    .build();
RecipeBuilder.newBuilder("hs_resonance_wand_vicio", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<minecraft:feather> * 6) // 羽毛 x6
    .addItemInput(<minecraft:reeds> * 2) // 甘蔗 x2
    .addItemInput(<minecraft:arrow> * 2) // 箭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.vicio"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出共鸣星杖虚御座！")
    .build();
RecipeBuilder.newBuilder("hs_resonance_wand_evorsio", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:gunpowder> * 4) // 火药 x4
    .addItemInput(<minecraft:cobblestone> * 4) // 原石 x4
    .addItemInput(<minecraft:quartz> * 2) // 石英 x2
    .addItemInput(<minecraft:blaze_powder> * 2) // 烈焰粉 x2
    .addItemInput(<minecraft:flint> * 2) // 燧石 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.evorsio"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出解离座！")
    .build();
RecipeBuilder.newBuilder("hs_resonance_wand_discidia", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_rod> * 2) // 烈焰棒 x2
    .addItemInput(<minecraft:glowstone_dust> * 2) // 萤石粉 x2
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.discidia"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出非攻座！")
    .build();
RecipeBuilder.newBuilder("hs_resonance_wand_armara", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<minecraft:nether_brick> * 2) // 地狱砖 x2
    .addItemInput(<minecraft:leather> * 2) // 皮革 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1>* 2) // 星辉锭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.armara"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出遁甲座！")
    .build();
RecipeBuilder.newBuilder("hs_resonance_wand_aevitas", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:reeds> * 4) // 甘蔗 x4
    .addInput(<ore:treeSapling>*6)
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<minecraft:prismarine_shard> * 2) // 海晶砂砾 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.aevitas"}}) * 1)
    .addRecipeTooltip("星能转化：\n制造出生息座！")
    .build();
// 新配方：星辉合成台 + 聚星木 + ME 封包组件 + 共鸣星杖 + 大理石块 制作 星辉封包合成器
RecipeBuilder.newBuilder("hs_discovery_crafter", "mega_magicalcrafttable", 20) // 时间1秒
    .addItemInput(<astralsorcery:blockaltar> * 1) // 星辉合成台 x1
    .addItemInput(<astralsorcery:blockinfusedwood> * 2) // 聚星木 x2
    .addItemInput(<packagedauto:me_package_component> * 1) // ME 封包组件 x1
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块 x4
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<packagedastral:discovery_crafter> * 1) // 输出：星辉封包合成器 x1
    .addRecipeTooltip("星能转化：\n制造出星辉封包合成器！") // 提示信息：描述产物名称
    .build();
// 新配方：海蓝宝石 + 星辉锭 + 水晶石 + 光波增幅器 + 大理石块 制作 共鸣祭坛
RecipeBuilder.newBuilder("hs_attunement_altar", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 2) // 星辉锭 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockattunementrelay>* 1) // 光波增幅器 x1
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:blockattunementaltar> * 1) // 输出：共鸣祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出共鸣祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 星能液桶 + 大理石 制作 星辉祭坛
RecipeBuilder.newBuilder("hs_starlight_altar", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据2）x4
    .addEnergyPerTickInput(600) // 每 tick 输入 600 单位电力 (总电力消耗 = 600 * 30 = 18000)
    .addItemOutput(<astralsorcery:blockaltar:1> * 1) // 输出：星辉祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出星辉祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：星尘 + 星辉锭 + 海蓝宝石 + 水晶石 + 大理石 制作 天辉祭坛
RecipeBuilder.newBuilder("hs_celestial_altar", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2>* 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    .addEnergyPerTickInput(700) // 每 tick 输入 700 单位电力 (总电力消耗 = 700 * 40 = 28000)
    .addItemOutput(<astralsorcery:blockaltar:2> * 1) // 输出：天辉祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出天辉祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：大理石 + 玻璃透镜 + 海蓝宝石 + 水晶石 + 熏黑大理石 制作 五彩祭坛
RecipeBuilder.newBuilder("hs_prismatic_altar", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockblackmarble> * 4) // 熏黑大理石 x4
    .addEnergyPerTickInput(800) // 每 tick 输入 800 单位电力 (总电力消耗 = 800 * 50 = 40000)
    .addItemOutput(<astralsorcery:blockaltar:3> * 1) // 输出：五彩祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出五彩祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：星辉封包合成器 + 熏黑大理石 + 星能液桶 + 星尘 + 水晶石 + 大理石 制作 星辉封包合成祭坛
RecipeBuilder.newBuilder("hs_attunement_crafter", "mega_magicalcrafttable", 20)
    .addItemInput(<packagedastral:discovery_crafter> * 1) // 星辉封包合成器 x1
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000) // 星能液桶 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据5）x4
    .addEnergyPerTickInput(900) // 每 tick 输入 900 单位电力 (总电力消耗 = 900 * 60 = 54000)
    .addItemOutput(<packagedastral:attunement_crafter> * 1) // 输出：星辉封包合成祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出星辉封包合成祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：星尘 + 水晶石 + 海蓝宝石 + 共振宝石 + 熏黑大理石 + 大理石 + 红石 + 星辉锭 制作 天辉封包祭坛
RecipeBuilder.newBuilder("hs_constellation_crafter", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 2) // 共振宝石 x2
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<minecraft:redstone> * 2) // 红石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addEnergyPerTickInput(800) // 每 tick 输入 800 单位电力 (总电力消耗 = 800 * 50 = 40000)
    .addItemOutput(<packagedastral:constellation_crafter> * 1) // 输出：天辉封包祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出天辉封包祭坛！") // 提示信息：描述产物名称
    .build();
// 新配方：多种材料 制作 五彩封包祭坛
RecipeBuilder.newBuilder("hs_trait_crafter", "mega_magicalcrafttable", 20)
    .addItemInput(<minecraft:redstone> * 4) // 红石粉 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:blockblackmarble:4> * 4) // 熏黑大理石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<minecraft:ender_eye> * 2) // 末影之眼 x2
    .addItemInput(<packagedastral:constellation_focus> * 1) // 星座核心 x1
    .addItemInput(<packagedastral:constellation_crafter> * 1) // 天辉封包祭坛 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1) // 水晶石 x1
    .addEnergyPerTickInput(1000) // 每 tick 输入 1000 单位电力 (总电力消耗 = 1000 * 70 = 70000)
    .addItemOutput(<packagedastral:trait_crafter> * 1) // 输出：五彩封包祭坛 x1
    .addRecipeTooltip("星能转化：\n制造出五彩封包祭坛！") // 提示信息：描述产物名称
    .build();
// 封闭印章
RecipeBuilder.newBuilder("itemperkseal", "mega_magicalcrafttable", 20)
    .addItemInput(<astralsorcery:itemusabledust:1> * 192)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 64)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 64)
    .addEnergyPerTickInput(10000)
    .addItemOutput(<astralsorcery:itemperkseal> * 64)
    .build();

// 家用机器控制器配方
// 巨型压缩机
RecipeBuilder.newBuilder("mega_compressor_factory_controller", "atomicprocessequipx", 7200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_a> * 1)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 128)
    .addInput(<modularmachinery:numerical_control_machine_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 1024)
    .addInput(<contenttweaker:coil_v5> * 4096)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:dust> * 8192)
    .addInput(<contenttweaker:arkchip>)
    .addOutput(<modularmachinery:mega_compressor_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("Mega-AdvancedBaseMachineTech")
    .build();
// 巨型粉碎机
RecipeBuilder.newBuilder("mega_industrialcrusher_factory_controller", "atomicprocessequipx", 7200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_b> * 1)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 128)
    .addInput(<modularmachinery:item_shredder_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 1024)
    .addInput(<contenttweaker:coil_v5> * 4096)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:dust> * 8192)
    .addInput(<contenttweaker:arkchip>)
    .addOutput(<modularmachinery:mega_industrialcrusher_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("Mega-AdvancedBaseMachineTech")
    .build();
// 巨型共价超载器
RecipeBuilder.newBuilder("mega_injectiondevice_factory_controller", "atomicprocessequipx", 7200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_c> * 1)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 128)
    .addInput(<modularmachinery:covalent_overloader_controller> * 64)
    .addInput(<moreplates:infinity_gear> * 1024)
    .addInput(<contenttweaker:coil_v5> * 4096)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:dust> * 8192)
    .addInput(<contenttweaker:arkchip>)
    .addOutput(<modularmachinery:mega_injectiondevice_factory_controller>)
    .requireComputationPoint(400000.0F)
    .requireResearch("Mega-AdvancedBaseMachineTech")
    .build();
// 巨型魔力聚合机
RecipeBuilder.newBuilder("mega_magicalcrafttable_factory_controller", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_d> * 1)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 128)
    .addInput(<modularmachinery:bot_crafter_factory_controller> * 1)
    .addInput(<moreplates:infinity_gear> * 1024)
    .addInput(<contenttweaker:coil_v5> * 4096)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:dust> * 8192)
    .addInput(<contenttweaker:arkchip>)
    .addOutput(<modularmachinery:mega_magicalcrafttable_factory_controller>)
    .requireResearch("Mega-AdvancedBaseMachineTech")
    .requireComputationPoint(400000.0F)
    .build();
// 巨型战争矩阵
RecipeBuilder.newBuilder("mega_advancedwarmatrix_factory_controller", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:programming_circuit_e> * 1)
    .addInput(<contenttweaker:industrial_circuit_v4> * 256)
    .addInput(<contenttweaker:field_generator_v4> * 128)
    .addInput(<modularmachinery:warmatrix_factory_controller> * 16)
    .addInput(<moreplates:infinity_gear> * 1024)
    .addInput(<contenttweaker:coil_v5> * 4096)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<contenttweaker:dust> * 8192)
    .addInput(<contenttweaker:arkchip>)
    .addOutput(<modularmachinery:mega_advancedwarmatrix_factory_controller>)
    .requireResearch("Mega-AdvancedWarMatrix")
    .requireComputationPoint(400000.0F)
    .build();
// 临界点
RecipeBuilder.newBuilder("mega_researchstationt4_factory_controller", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:infinitychip> * 1)
    .addInput(<contenttweaker:field_generator_v4> * 16)
    .addInput(<contenttweaker:beccomputer> * 8)
    .addInput(<contenttweaker:becmemory> * 8)
    .addInput(<contenttweaker:coil_v5> * 512)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addInput(<contenttweaker:dust> * 2048)
    .addInput(<modularmachinery:research_station_t3_factory_controller> * 8)
    .addOutput(<modularmachinery:mega_researchstationt4_factory_controller>)
    .requireResearch("theory_computer_milkway")
    .requireComputationPoint(500000.0F)
    .build();
//量子操纵者
RecipeBuilder.newBuilder("giga_qft", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:infinitychip> * 4)
    .addInput(<contenttweaker:field_generator_v4> * 16)
    .addInput(<contenttweaker:coil_v5> * 512)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addInput(<contenttweaker:dust> * 2048)
    .addInput(<contenttweaker:novamatrix> * 4)
    .addInput(<contenttweaker:exoticgases> * 8192)
    .addInput(<contenttweaker:alloy> * 16384)
    .addInput(<modularmachinery:atomicprocessequipx_factory_controller> * 64)
    .addInput(<contenttweaker:atomicclock> * 4)
    .addOutput(<modularmachinery:giga_qft_factory_controller> * 4)
    .requireResearch("Mega-QFT")
    .requireComputationPoint(500000.0F)
    .build();
//家用解包机
RecipeBuilder.newBuilder("giga_massunpacker", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:infinitychip> * 4)
    .addInput(<contenttweaker:field_generator_v4> * 16)
    .addInput(<contenttweaker:coil_v5> * 512)
    .addInput(<contenttweaker:antimatter_core> * 4)
    .addInput(<contenttweaker:dust> * 2048)
    .addInput(<contenttweaker:world_energy_core> * 4)
    .addInput(<contenttweaker:nanoswarm> * 128)
    .addInput(<modularmachinery:massanomaldevice_factory_controller> * 64)
    .addOutput(<modularmachinery:giga_massunpacker_factory_controller>)
    .requireComputationPoint(500000.0F)
    .build();
//gama-tial线圈
RecipeBuilder.newBuilder("gama_tial_coil_block", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:field_generator_v4> * 1)
    .addInput(<contenttweaker:infinite_coil> * 64)
    .addInput(<contenttweaker:gama_tialcoil> * 64)
    .addOutput(<contenttweaker:gama_tial_coil_block>)
    .addInput(<liquid:tachyonfluid> * 100)
    .addInput(<liquid:spaceframefluid> * 100)
    .requireComputationPoint(50000.0F)
    .build();
//框架
RecipeBuilder.newBuilder("infinity_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:neutron_fiber_housing>)
    .addInput(<moreplates:infinity_plate> * 16)
    .addInput(<avaritia:block_resource:1> * 4)
    .addOutput(<contenttweaker:infinity_frame> * 4)
    .addInput(<liquid:tachyonfluid> * 200)
    .addInput(<liquid:spaceframefluid> * 200)
    .requireComputationPoint(50000.0F)
    .build();
RecipeBuilder.newBuilder("infinity_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:neutron_fiber_housing>)
    .addInput(<moreplates:infinity_plate> * 8)
    .addOutput(<contenttweaker:infinity_frame> * 4)
    .addInput(<liquid:tachyonfluid> * 200)
    .addInput(<liquid:spaceframefluid> * 200)
    .requireComputationPoint(50000.0F)
    .build();
RecipeBuilder.newBuilder("nqalloy_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:ark_frame>)
    .addInput(<contenttweaker:nq_alloy> * 4)
    .addOutput(<contenttweaker:nqalloy_frame> * 4)
    .addInput(<liquid:tachyonfluid> * 200)
    .addInput(<liquid:spaceframefluid> * 200)
    .requireComputationPoint(50000.0F)
    .build();
RecipeBuilder.newBuilder("arcance_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:nqalloy_frame>)
    .addInput(<contenttweaker:arcance_ingot>)
    .addOutput(<contenttweaker:arcance_frame> * 4)
    .addInput(<liquid:aefe> * 20)
    .addInput(<liquid:fluid_nova_alloy> * 1)
    .requireComputationPoint(50000.0F)
    .build();
RecipeBuilder.newBuilder("ark_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:infinity_frame>)
    .addInput(<additions:novaextended-star_ingot> * 8)
    .addOutput(<contenttweaker:ark_frame> * 4)
    .addInput(<liquid:tachyonfluid> * 200)
    .addInput(<liquid:spaceframefluid> * 200)
    .requireComputationPoint(50000.0F)
    .build();
RecipeBuilder.newBuilder("orichalcos_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:extrememachineblock>)
    .addInput(<extrabotany:material:1> * 8)
    .addOutput(<contenttweaker:orichalcos_frame> * 4)
    .addInput(<liquid:draconic_metal> * 1440)
    .addInput(<liquid:chaotic_metal> * 720)
    .requireComputationPoint(100.0F)
    .build();
RecipeBuilder.newBuilder("quantum_frame", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:advanced_programming_circuit_0>)
    .addInput(<contenttweaker:nqalloy_frame>)
    .addInput(<contenttweaker:quantum_ingot> * 8)
    .addOutput(<contenttweaker:quantum_frame> * 4)
    .addInput(<liquid:anti_quarkgluon> * 200)
    .addInput(<liquid:quarkgluon> * 40000)
    .requireComputationPoint(100.0F)
    .build();
RecipeBuilder.newBuilder("infinity_glass", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:orichalcos_frame>)
    .addInput(<contenttweaker:superglasswhite>)
    .addInput(<avaritiatweaks:enhancement_crystal>)
    .addOutput(<contenttweaker:infinity_glass> * 64)
    .addInput(<liquid:draconic_metal> * 144)
    .addInput(<liquid:chaotic_metal> * 72)
    .requireComputationPoint(10000.0F)
    .build();
RecipeBuilder.newBuilder("quantumgroup_glass", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:starvoidstructure>)
    .addInput(<contenttweaker:lightspeed_overclock_array>)
    .addInput(<contenttweaker:opticsunit> * 4)
    .addInput(<contenttweaker:superglassbluex> * 64)
    .addInput(<contenttweaker:quantum_ingot>)
    .addOutput(<contenttweaker:quantumgroup_glass> * 64)
    .addInput(<liquid:tachyonfluid> * 2000)
    .addInput(<liquid:spaceframefluid> * 2000)
    .requireComputationPoint(10000.0F)
    .build();
//破界者能量立场
RecipeBuilder.newBuilder("dimensioncarver_energyfield", "atomicprocessequipx", 200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInput(<contenttweaker:field_generator_v4> * 4)
    .addInput(<contenttweaker:energycube_mk3>)
    .addOutput(<contenttweaker:dimensioncarver_energyfield> * 256)
    .addInput(<liquid:tachyonfluid> * 2000)
    .addInput(<liquid:spaceframefluid> * 2000)
    .requireComputationPoint(50000.0F)
    .build();
//太空电梯动力模块
RecipeBuilder.newBuilder("space_elevator_power_module", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([
        <contenttweaker:infinitychip> * 4,
        <mekanism:module_teleportation_unit> * 64,
        <contenttweaker:fieldofgravitycore> * 64,
        <contenttweaker:superluminal_core> * 4,
        <contenttweaker:yltj> * 128,
        <contenttweaker:arkforcefieldcontrolblock> * 4,
    ])
    .addInput(<liquid:tachyonfluid> * 8000)
    .addInput(<liquid:spaceframefluid> * 8000)
    .addOutput(<contenttweaker:space_elevator_power_module> * 40)
    .requireResearch("Mega-SpaceElevator-Stage3")
    .requireComputationPoint(500000.0F)
    .build();
//太空电梯支撑结构
RecipeBuilder.newBuilder("space_elevator_structure", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([
        <contenttweaker:infinitychip> * 1,
        <contenttweaker:asteroidcontrolblock> * 16,
        <contenttweaker:dimensiontwistblock> * 16,
        <contenttweaker:dustmatrix>,
        <contenttweaker:stablestructure> * 16,
        <contenttweaker:planet_ff>
    ])
    .addInput(<liquid:tachyonfluid> * 8000)
    .addInput(<liquid:spaceframefluid> * 8000)
    .addOutput(<contenttweaker:space_elevator_structure> * 512)
    .requireResearch("Mega-SpaceElevator-Stage3")
    .requireComputationPoint(500000.0F)
    .build();
// 中子活化器
RecipeBuilder.newBuilder("mega_neutronactivator", "atomicprocessequipx", 20000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(80000000000)
    .addInputs([<super_solar_panels:crafting:30> * 64,<contenttweaker:micro_mmf_accelerator> * 4,<contenttweaker:superconidiosome> * 512,<modularmachinery:laseraccelerator_factory_controller>,<contenttweaker:starmachineblock> * 64,<contenttweaker:spacetime_lens>])
    .addOutput(<modularmachinery:mega_neutronactivator_factory_controller>)
    .requireResearch("theory_transfer_fuel")
    .requireComputationPoint(500000.0F)
    .build();
// 机械方块
RecipeBuilder.newBuilder("spacexmachineblock", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([<contenttweaker:milkmachineblock> * 8,<contenttweaker:antimatter_core> * 1,<contenttweaker:field_generator_v4> * 16,<contenttweaker:industrial_circuit_v4> * 4,<contenttweaker:gama_tialcoil> * 256,<moreplates:infinity_gear> * 16,<contenttweaker:arkmachineblock> * 16,<contenttweaker:nova_ingot> * 4])
    .addOutput(<contenttweaker:spacexmachineblock> * 64)
    .requireResearch("Mega-SpaceElevator-Stage1")
    .requireComputationPoint(100000.0F)
    .build();
RecipeBuilder.newBuilder("neutron_fiber_housing", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([<contenttweaker:starmachineblock> * 64,<contenttweaker:gama_tialcoil> * 128,<contenttweaker:arkmachineblock> * 16,<contenttweaker:neutrondustingot> * 8])
    .addOutput(<contenttweaker:neutron_fiber_housing> * 64)
    .requireResearch("Mega-SpaceElevator-Stage1")
    .requireComputationPoint(10000.0F)
    .build();
RecipeBuilder.newBuilder("spacexlightingblock", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([<contenttweaker:novamatrix>,<contenttweaker:infinity_frame> * 64,<contenttweaker:alloy> * 256,<contenttweaker:etherengine_upgrade> * 8])
    .addOutput(<contenttweaker:spacexlightingblock> * 64)
    .requireComputationPoint(10000.0F)
    .build();
RecipeBuilder.newBuilder("dimensioncarver_reinforcedblock", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .addInputs([<contenttweaker:tearenginee> * 16,<contenttweaker:darkmatters> * 64,<contenttweaker:ctc_computer> * 16,<contenttweaker:asteroidcontrolblock> * 32,<contenttweaker:etherengine_upgrade> * 8])
    .addOutput(<contenttweaker:dimensioncarver_reinforcedblock> * 64)
    .requireComputationPoint(10000.0F)
    .build();
RecipeBuilder.newBuilder("giga_iridiosamariumchipforge_factory_controller", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(800000000000)
    .requireResearch("Giga-OverDimension")
    .addInputs([<modularmachinery:atomicprocessequipx_factory_controller> * 16,<modularmachinery:vaticlaser_factory_controller> * 16,<contenttweaker:hyperdimensional_computer>,<contenttweaker:timespace_ingot> * 16])
    .addOutput(<modularmachinery:giga_iridiosamariumchipforge_factory_controller>)
    .requireComputationPoint(10000000.0F)
    .build();
RecipeBuilder.newBuilder("phantom_calculation_array", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .requireResearch("Mega-DimensionDream")
    .addInputs([<contenttweaker:beccomputer> * 16,<contenttweaker:arkchip> * 16,<novaeng_core:extendable_calculator_subsystem_l9> * 64,<contenttweaker:spacetimeframework> * 256,<contenttweaker:lightplatform> * 256,<contenttweaker:shroudchunk> * 16])
    .addOutput(<contenttweaker:phantom_calculation_array>)
    .requireComputationPoint(10000000.0F)
    .build();
RecipeBuilder.newBuilder("hyperlightspeedplatform", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .requireResearch("Mega-HLSP")
    .addInputs([<contenttweaker:ultminingdevice> * 8,<contenttweaker:ctc_computer> * 8,<contenttweaker:arkchip>,<contenttweaker:etherengine_upgrade>,<contenttweaker:lightplatform> * 64,<contenttweaker:alloy> * 512,<contenttweaker:superluminal_core>])
    .addOutput(<contenttweaker:hyperlightspeedplatform>)
    .requireComputationPoint(10000000.0F)
    .build();
RecipeBuilder.newBuilder("speedlightsite_factory_controller", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .requireResearch("Mega-HLSP")
    .addInputs([<modularmachinery:lightpressurelaunchunit_factory_controller>,<modularmachinery:light-speed_material_accelerator_factory_controller>,<modularmachinery:m2scn_factory_controller>,<contenttweaker:fieldofgravitycore> * 64,<contenttweaker:hyperlightspeedplatform>])
    .addOutput(<modularmachinery:speedlightsite_factory_controller>)
    .requireComputationPoint(10000000.0F)
    .build();
RecipeBuilder.newBuilder("hyper_strenth_machine_block", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .addInputs([<liquid:higgsfluid> * 10000,<liquid:anti_quarkgluon> * 20000,<liquid:quarkgluon> * 40000,<contenttweaker:arkchip>,<contenttweaker:dimensioncarver_reinforcedblock> * 4,<contenttweaker:darkmatterblock> * 16,<contenttweaker:novamatrix>])
    .addOutput(<contenttweaker:hyper_strenth_machine_block> * 512)
    .requireComputationPoint(1000000.0F)
    .build();
RecipeBuilder.newBuilder("hyperspace_structure", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .addInputs([<liquid:higgsfluid> * 10000,<liquid:anti_quarkgluon> * 20000,<liquid:quarkgluon> * 40000,<contenttweaker:nq_alloy> * 64,<contenttweaker:arkmachineblock> * 64,<contenttweaker:coil_v5> * 512,<contenttweaker:darkmatters> * 64])
    .addOutput(<contenttweaker:hyperspace_structure> * 512)
    .requireComputationPoint(1000000.0F)
    .build();
RecipeBuilder.newBuilder("dimensionally_coil", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .addInputs([<liquid:anti_quarkgluon> * 200,<liquid:quarkgluon> * 400,<contenttweaker:quantum_frame>,<contenttweaker:quantum_ingot>,<contenttweaker:gama_tial_coil_block>])
    .addOutput(<contenttweaker:dimensionally_coil>)
    .requireComputationPoint(100000.0F)
    .build();
RecipeBuilder.newBuilder("dimensional_bridge_casing", "atomicprocessequipx", 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000000)
    .addInputs([<liquid:anti_quarkgluon> * 400,<liquid:quarkgluon> * 800,<contenttweaker:arkforcefieldcontrolblock>,<contenttweaker:spacematrix_ingot> * 16,<contenttweaker:quantum_ingot> * 4,<contenttweaker:quantum_frame> * 4,<contenttweaker:dimensionally_transcendent_casing> * 8,<contenttweaker:manipulator> * 8])
    .addOutput(<contenttweaker:dimensional_bridge_casing> * 16)
    .requireComputationPoint(100000.0F)
    .build();
RecipeBuilder.newBuilder("energy_glass_4","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:4>
    ])
    .addOutputs([
        <contenttweaker:superglassyellow>
    ])
    .requireComputationPoint(1000.0)
    .build();
RecipeBuilder.newBuilder("energy_glass_5","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:14>
    ])
    .addOutputs([
        <contenttweaker:superglassred>
    ])
    .requireComputationPoint(1000.0)
    .build();
RecipeBuilder.newBuilder("energy_glass_6","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:1>
    ])
    .addOutputs([
        <contenttweaker:superglassorange>
    ])
    .requireComputationPoint(1000.0)
    .build();
RecipeBuilder.newBuilder("energy_glass_7","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:10>
    ])
    .addOutputs([
        <contenttweaker:superglasspurple>
    ])
    .requireComputationPoint(1000.0)
    .build();
RecipeBuilder.newBuilder("energy_glass_8","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:13>
    ])
    .addOutputs([
        <contenttweaker:superglassgreen>
    ])
    .requireComputationPoint(1000.0)
    .build();
// 发电
RecipeBuilder.newBuilder("mega_psionicsiphonmatrix", "mega_psionicsiphonmatrix", 1200)
    .addInput(<contenttweaker:shroudchunk> * 1)
    .addInput(<contenttweaker:shroudplanet> * 1).setChance(0.01)
    .addOutput(<contenttweaker:voidmatter> * 160)
    .addEnergyPerTickOutput(16000000000000)
    .addRecipeTooltip("虹吸§5虚境区块§f中近乎无穷的§d灵能§f。")
    .requireResearch("Mega-ShroudChunckGenerator")
    .requireComputationPoint(8000.0F)
    .build();
RecipeBuilder.newBuilder("fluid_nova_alloy","starcontrolx",40)
    .addEnergyPerTickInput(16000000)
    .addFluidInputs([
        <liquid:spaceframefluid> * 1000,
        <liquid:tachyonfluid> * 1000,
        <liquid:t1000> * 1000,
    ])
    .addInput(<contenttweaker:voidmatter> * 16)
    .addInput(<contenttweaker:nova_ingot> * 16)
    .addFluidOutputs([
        <liquid:fluid_nova_alloy> * 144
    ])
    .build();
MachineModifier.setMaxThreads("mega_advancedwarmatrix", 0);
MachineModifier.addCoreThread("mega_advancedwarmatrix", FactoryRecipeThread.createCoreThread("§3行星级§e数据计算阵列§f"));
MachineModifier.addCoreThread("mega_advancedwarmatrix", FactoryRecipeThread.createCoreThread("§3行星级§e数据解析阵列§f"));
MachineModifier.addCoreThread("mega_advancedwarmatrix", FactoryRecipeThread.createCoreThread("§3行星级§e物质提取单元§f"));
MachineModifier.addCoreThread("mega_advancedwarmatrix", FactoryRecipeThread.createCoreThread("§3行星级§e魔力共振单元§f"));
RecipeBuilder.newBuilder("mega_advancedwarmatrix_output01", "mega_advancedwarmatrix", 120)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addEnergyPerTickInput(100000000000)
    .addInput(<contenttweaker:planetoflight> * 4).setChance(0)
    .addInput(<contenttweaker:antimatter_core> * 64).setChance(0)
    .addInput(<contenttweaker:novamatrix>).setChance(0)
    .addInput(<contenttweaker:data_model_emerald> * 64).setChance(0)
    .addInput(<contenttweaker:data_model_iridium> * 64).setChance(0)
    .addInput(<avaritiatweaks:enhancement_crystal> * 512).setChance(0)
    .addOutputs([
        <deepmoblearning:pristine_matter_blaze> * 32,
        <deepmoblearning:pristine_matter_creeper> * 32,
        <deepmoblearning:pristine_matter_dragon> * 16,
        <deepmoblearning:pristine_matter_enderman> * 32,
        <deepmoblearning:pristine_matter_ghast> * 32,
        <deepmoblearning:pristine_matter_guardian> * 32,
        <deepmoblearning:pristine_matter_shulker> * 32,
        <deepmoblearning:pristine_matter_skeleton> * 32,
        <deepmoblearning:pristine_matter_slime> * 32,
        <deepmoblearning:pristine_matter_spider> * 32,
        <deepmoblearning:pristine_matter_witch> * 32,
        <deepmoblearning:pristine_matter_wither> * 32,
        <deepmoblearning:pristine_matter_glitch> * 32,
        <deepmoblearning:pristine_matter_wither_skeleton> * 32,
        <deepmoblearning:pristine_matter_zombie> * 32,
        <deepmoblearning:pristine_matter_thermal_elemental> * 32,
        <deepmoblearning:pristine_matter_tinker_slime> * 32,
        <deepmoblearning:pristine_matter_chaosguardian> * 16,
        <deepmoblearning:pristine_matter_inf7yentr60py> * 8,
    ])
    .setThreadName("§3行星级§e数据计算阵列§f")
    .addRecipeTooltip("由 §3行星级§e数据计算阵列§f线程 运行")
    .addRecipeTooltip("该配方具有 §e10485760§f 并行上限")
    .build();
RecipeBuilder.newBuilder("mega_advancedwarmatrix_output02", "mega_advancedwarmatrix", 120)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addEnergyPerTickInput(100000000000)
    .addInput(<contenttweaker:beccomputer> * 4).setChance(0)
    .addInput(<contenttweaker:antimatter_core> * 64).setChance(0)
    .addInput(<contenttweaker:novamatrix>).setChance(0)
    .addInput(<contenttweaker:data_model_emerald> * 64).setChance(0)
    .addInput(<contenttweaker:data_model_iridium> * 64).setChance(0)
    .addInput(<avaritiatweaks:enhancement_crystal> * 512).setChance(0)
    .addOutput(<botania:manaresource:5> * 64)
    .addOutput(<extrabotany:material:3>)
    .addOutput(<botania:manaresource> * 16)
    .addOutput(<botania:managlass> * 16)
    .addOutput(<botania:quartz:1> * 16)
    .addOutput(<botania:manaresource:2> * 16)
    .addOutput(<botania:manaresource:23> * 16)
    .addOutput(<botania:manaresource:1> * 16)
    .addOutput(<extrabotany:buddhistrelics>)
    .addOutputs([
        <minecraft:skull> * 16,
        <minecraft:skull:1> * 16,
        <minecraft:skull:2> * 16,
        <minecraft:skull:3> * 16,
        <minecraft:skull:4> * 16,
    ])
    .setThreadName("§3行星级§e数据解析阵列§f")
    .addRecipeTooltip("由 §3行星级§e数据解析阵列§f线程 运行")
    .addRecipeTooltip("该配方具有 §e10485760§f 并行上限")
    .build();
RecipeBuilder.newBuilder("mega_advancedwarmatrix_output03", "mega_advancedwarmatrix", 120)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addEnergyPerTickInput(100000000000)
    .addInput(<contenttweaker:uu_crystal_3> * 4).setChance(0)
    .addInput(<contenttweaker:antimatter_core> * 64).setChance(0)
    .addInput(<contenttweaker:novamatrix>).setChance(0)
    .addInput(<contenttweaker:data_model_emerald> * 64).setChance(0)
    .addInput(<contenttweaker:data_model_iridium> * 64).setChance(0)
    .addInput(<avaritiatweaks:enhancement_crystal> * 512).setChance(0)
    .addOutput(<deepmoblearning:living_matter_overworldian> * 16)
    .addOutput(<deepmoblearning:living_matter_hellish> * 16)
    .addOutput(<deepmoblearning:living_matter_extraterrestrial> * 16)
    .addOutput(<deepmoblearning:living_matter_legend> * 16)
    .setThreadName("§3行星级§e物质提取单元§f")
    .addRecipeTooltip("由 §3行星级§e物质提取单元§f线程 运行")
    .addRecipeTooltip("该配方具有 §e10485760§f 并行上限")
    .build();
RecipeBuilder.newBuilder("mega_advancedwarmatrix_output04", "mega_advancedwarmatrix", 120)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addEnergyPerTickInput(100000000000)
    .addInput(<contenttweaker:mana_crystal_3> * 4).setChance(0)
    .addInput(<contenttweaker:antimatter_core> * 64).setChance(0)
    .addInput(<contenttweaker:novamatrix>).setChance(0)
    .addInput(<contenttweaker:data_model_emerald> * 64).setChance(0)
    .addInput(<contenttweaker:data_model_iridium> * 64).setChance(0)
    .addInput(<avaritiatweaks:enhancement_crystal> * 512).setChance(0)
    .addOutput(<botania:manaresource:5> * 64)
    .addOutput(<extrabotany:material:3>)
    .addOutput(<botania:manaresource> * 16)
    .addOutput(<botania:managlass> * 16)
    .addOutput(<botania:quartz:1> * 16)
    .addOutput(<botania:manaresource:2> * 16)
    .addOutput(<botania:manaresource:23> * 16)
    .addOutput(<botania:manaresource:1> * 16)
    .addOutput(<extrabotany:buddhistrelics>)
    .addOutput(<botania:gaiahead> * 8)
    .setThreadName("§3行星级§e魔力共振单元§f")
    .addRecipeTooltip("由 §3行星级§e魔力共振单元§f线程 运行")
    .addRecipeTooltip("该配方具有 §e10485760§f 并行上限")
    .build();
MMEvents.onControllerGUIRender("mega_neutronactivator",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val power = data.getInt("power",0);
    var info as string[]=[];
    info += "§a////////////§f中子活化器§a////////////";
    info += "当前中子动能 : " + power + "MeV";
    event.extraInfo = info;
});
MMEvents.onStructureFormed("mega_neutronactivator",function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val power = data.getInt("power",0);
    map["power"] = 0;
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("mega_neutronactivator", 0);
MachineModifier.addCoreThread("mega_neutronactivator", FactoryRecipeThread.createCoreThread("中子监控单元"));
MachineModifier.addCoreThread("mega_neutronactivator", FactoryRecipeThread.createCoreThread("中子放射单元"));
MachineModifier.addCoreThread("mega_neutronactivator", FactoryRecipeThread.createCoreThread("中子屏蔽单元"));
MachineModifier.addCoreThread("mega_neutronactivator", FactoryRecipeThread.createCoreThread("中子活化单元"));
RecipeBuilder.newBuilder("mega_neutronactivator_checkMev","mega_neutronactivator",40)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val block_pos_1 = pos.up(1);
        val block_pos_2 = pos.up(2);
        val block_pos_3 = pos.down(1);
        val coilpos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,1,2);
        val coilpos2 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,2,2);
        val coilpos3 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,3,2);
        val coilpos4 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,4,2);
        val coilpos5 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,5,2);
        val coilpos6 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,6,2);
        val coilpos7 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,7,2);
        val coilpos8 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,8,2);
        val coilpos9 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,9,2);
        val coilpos10 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,10,2);
        val coilpos11 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,11,2);
        val coilpos12 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,12,2);
        val casing1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,1);
        val casing2 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,2);
        val casing3 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,3);
        val casing4 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,0,1);
        val casing5 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,0,2);
        val casing6 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,0,3);
        val casing7 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,0,1);
        val casing8 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,0,2);
        val casing9 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,0,3);
        val casing10 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,13,1);
        val casing11 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,13,2);
        val casing12 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,13,3);
        val casing13 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,13,1);
        val casing14 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,13,2);
        val casing15 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,13,3);
        val casing16 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,13,1);
        val casing17 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,13,2);
        val casing18 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,13,3);
        val input1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,0,0);
        val input2 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,2,0,0);
        val input3 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,0,0);
        val input4 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-2,0,0);
        val input5 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-2,0,1);
        val input6 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-2,0,2);
        val input7 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,2,0,1);
        val input8 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,2,0,2);
        val redpos as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,0,4);
        if (power > 6000 && power < 8000){
            Sync.addSyncTask(function(){
                val redstone = ctrl.world.getBlock(redpos);
                if (redstone.definition.id == "novaeng_core:redstone_logical_port"){
                    val redstonelv = 10;
                    if (redstonelv != redstone.meta){
                        ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${redstonelv}>,redpos);
                    }
                }
            });
        }
        if (power > 8000 && power < 10000){
            Sync.addSyncTask(function(){
                val redstone = ctrl.world.getBlock(redpos);
                if (redstone.definition.id == "novaeng_core:redstone_logical_port"){
                    val redstonelv = 12;
                    if (redstonelv != redstone.meta){
                        ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${redstonelv}>,redpos);
                    }
                }
            });
        }
        if (power > 10000 && power < 12000){
            Sync.addSyncTask(function(){
                val redstone = ctrl.world.getBlock(redpos);
                if (redstone.definition.id == "novaeng_core:redstone_logical_port"){
                    val redstonelv = 14;
                    if (redstonelv != redstone.meta){
                        ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${redstonelv}>,redpos);
                    }
                }
            });
        }
        if (power > 40){
            map["power"] = power - 40;
        }
        if (power < 40){
            map["power"] = 0;
        }
        if (power > 12000){
            Sync.addSyncTask(function(){
                if (!world.remote) {
                    world.setBlockState(<blockstate:draconicevolution:reactor_core>,{BCManagedData: {reactorState: 6 as byte, reactableFuel: 400000.0,explosionCountdown:160,temperature:100000.0,ShieldCharge: 8000000,MaxShieldCharge: 8000000}},block_pos_1);
                    world.setBlockState(<blockstate:minecraft:air>,{},block_pos_2);
                    world.setBlockState(<blockstate:minecraft:air>,{},block_pos_3);
                    world.setBlockState(<blockstate:minecraft:air>,{},pos);
                    world.setBlockState(<blockstate:minecraft:air>,{},redpos);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos1);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos2);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos3);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos4);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos5);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos6);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos7);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos8);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos9);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos10);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos11);
                    world.setBlockState(<blockstate:minecraft:air>,{},coilpos12);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing1);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing2);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing3);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing4);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing5);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing6);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing7);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing8);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing9);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing10);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing11);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing12);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing13);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing14);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing15);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing16);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing17);
                    world.setBlockState(<blockstate:minecraft:air>,{},casing18);
                    world.setBlockState(<blockstate:minecraft:air>,{},input1);
                    world.setBlockState(<blockstate:minecraft:air>,{},input2);
                    world.setBlockState(<blockstate:minecraft:air>,{},input3);
                    world.setBlockState(<blockstate:minecraft:air>,{},input4);
                    world.setBlockState(<blockstate:minecraft:air>,{},input5);
                    world.setBlockState(<blockstate:minecraft:air>,{},input6);
                    world.setBlockState(<blockstate:minecraft:air>,{},input7);
                    world.setBlockState(<blockstate:minecraft:air>,{},input8);
                }
            });
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("检测中子活化器内中子动能的情况。")
    .addRecipeTooltip("当中子动能大于 0MeV 时，每 40Tick 减少 40MeV 中子动能。")
    .addRecipeTooltip("当中子动能大于 6000MeV 时，红石逻辑端口将输出强度为 10 的红石信号。")
    .addRecipeTooltip("当中子动能大于 8000MeV 时，红石逻辑端口将输出强度为 12 的红石信号。")
    .addRecipeTooltip("当中子动能大于 10000MeV 时，红石逻辑端口将输出强度为 14 的红石信号。")
    .addRecipeTooltip("当中子动能大于 12000MeV 时，中子活化器将启动自毁程序。")
    .setThreadName("中子监控单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_produceMev_01","mega_neutronactivator",40)
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power + 20;
        ctrl.customData = data;
    })
    .addRecipeTooltip("利用中子活化器内置的中子源放射中子，每 40Tick 增加 20MeV。")
    .setThreadName("中子放射单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_produceMev_02","mega_neutronactivator",40)
    .addInput(<nuclearcraft:fission_source>).setChance(0)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power + 160;
        ctrl.customData = data;
    })
    .addRecipeTooltip("利用额外的中子源放射中子，每 40Tick 增加 160MeV。")
    .setThreadName("中子放射单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_produceMev_03","mega_neutronactivator",40)
    .addInput(<nuclearcraft:fission_source:1>).setChance(0)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power + 320;
        ctrl.customData = data;
    })
    .addRecipeTooltip("利用额外的中子源放射中子，每 40Tick 增加 320MeV。")
    .setThreadName("中子放射单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_produceMev_04","mega_neutronactivator",40)
    .addInput(<nuclearcraft:fission_source:2>).setChance(0)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power + 640;
        ctrl.customData = data;
    })
    .addRecipeTooltip("利用额外的中子源放射中子，每 40Tick 增加 640MeV。")
    .setThreadName("中子放射单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_reduceMev_01","mega_neutronactivator",1)
    .addInput(<liquid:water> * 819200)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power - 320;
        ctrl.customData = data;
    })
    .addRecipeTooltip("使用阻隔剂减小中子动能，每 Tick 减少 320MeV。")
    .setThreadName("中子屏蔽单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_reduceMev_02","mega_neutronactivator",1)
    .addInput(<ore:plateDenseLead> * 4)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        map["power"] = power - 640;
        ctrl.customData = data;
    })
    .addRecipeTooltip("使用阻隔剂减小中子动能，每 Tick 减少 640MeV。")
    .setThreadName("中子屏蔽单元")
    .build();
RecipeBuilder.newBuilder("mega_neutronactivator_01","mega_neutronactivator",400)
    .addInput(<contenttweaker:nq_powder> * 4)
    .addOutput(<liquid:nq_fuel> * 10000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val power = data.getInt("power",1);
        if(power < 6000){
            event.setFailed("中子动能不足，需要达到6000MeV!");
        }
        if(power > 8000){
            event.setFailed("中子动能过高，需要小于8000MeV!");
        }
    })
    .addRecipeTooltip("只有在中子动能为 6000MeV ~ 8000MeV 才能运行此配方。")
    .setThreadName("中子活化单元")
    .build();
RecipeBuilder.newBuilder("nq_fuel_outputenergy","orionengine",100)
    .addInput(<liquid:nq_fuel> * 1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 64;
        event.activeRecipe.parallelism = 64;
    })
    .addEnergyPerTickOutput(100000000000)
    .addFluidOutput(<liquid:base_fuel> * 107232)
    .addFluidOutput(<liquid:nq_scrap> * 100)
    .setThreadName("液态燃料端口#1")
    .addRecipeTooltip("快速充分燃烧燃料")
    .addRecipeTooltip("该配方并行上限为64")
    .build();
# .addFluidInputs([
#        <liquid:manganese_dioxide> * 1000,
#        <liquid:lead_platinum> * 1000,
#        <liquid:potassium_hydroquinone_solution> * 1000,
#        <liquid:ferroboron> * 1000,
#        <liquid:molybdenum> * 1000,
#        <liquid:alugentum> * 1000,
#        <liquid:dfdps> * 1000,
#        <liquid:bas> * 1000,
#    ])
MMEvents.onControllerGUIRender("speedlightsite",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val HLPP_count = data.getInt("HLPP_count",0);
    val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
    val HLPP_range = data.getInt("HLPP_range",0);
    val HLPP_aera_passed = data.getInt("HLPP_aera_passed",0);
    val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",0);
    var info as string[]=[];
    if(HLPP_lunchcheck == 1){
        info += "§a////////////§9超光速发射坞§a////////////";
        info += "当前§9超光速驱动返回单元§f数量 : " + HLPP_count;
        info += "当前航行距离数量 : " + HLPP_range + "Mly";
        info += "当前§a产出§f倍数 : §a" + HLPP_aera_passed * HLPP_count * 10 + "x§f";
        info += "§7§o*§a§o产出§7§o倍数 : §a§o航行区间数量 * §9§o超光速驱动返回单元§7§o数量 * 10§f";
        if(HyperSpaceStrenth > 0){
            info += "当前§3超空间航道§f强度 : " + HyperSpaceStrenth + "GP";
        }
        if(HyperSpaceStrenth < 1){
            info += "§4超空间航道已坍缩，单元正在返航";
        }
    }
    if(HLPP_lunchcheck != 1){
        info += "§a////////////§9超光速发射坞§a////////////";
        info += "§4当前未发射§9超光速驱动返回单元§f";
        info += "正在停泊的§9超光速驱动返回单元§f数量 : " + HLPP_count;
    }
    event.extraInfo = info;
});
MMEvents.onStructureFormed("speedlightsite" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val HLPP_count = data.getInt("HLPP_count",0);
    val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
    val HLPP_range = data.getInt("HLPP_range",0);
    val HLPP_aera_passed = data.getInt("HLPP_aera_passed",0);
    val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",0);
    map["HLPP_count"] = 0;
    map["HyperSpaceStrenth"] = 0;
    map["HLPP_range"] = 0;
    map["HLPP_aera_passed"] = 1;
    map["HLPP_lunchcheck"] = 0;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("speedlightsite_HLPP_input","speedlightsite",20)
    .addInput(<contenttweaker:world_energy_core>)
    .addInput(<contenttweaker:hyperlightspeedplatform>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        if(HLPP_lunchcheck == 1){
            event.setFailed("§9超光速驱动返回单元§4已发射!§f");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_count = data.getInt("HLPP_count",1);
        map["HLPP_count"] = HLPP_count + 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输入§9超光速驱动返回单元§f。")
    .addRecipeTooltip("每添加 §e1§f台 §9超光速驱动返回单元§f，将会增加 §a1x§f 输入")
    .setThreadName("单元装载")
    .build();
RecipeBuilder.newBuilder("speedlightsite_HLPP_lunch","speedlightsite",20)
    .addInput(<contenttweaker:novamatrix> * 4).setChance(0)
    .addInput(<contenttweaker:world_energy_core> * 16)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        val HLPP_count = data.getInt("HLPP_count",1);
        if(HLPP_lunchcheck == 1){
            event.setFailed("§9超光速驱动返回单元§4已发射!§f");
        }
        if(HLPP_count > 0){
            event.setFailed("§4尚未装载§9超光速驱动返回单元§4!§f");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_count = data.getInt("HLPP_count",0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("unit_mult_item",RecipeModifierBuilder.create("modularmachinery:item","input",HLPP_count,1,false).build());
        thread.addPermanentModifier("unit_mult_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","input",HLPP_count,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        map["HLPP_lunchcheck"] = 1;
        map["HyperSpaceStrenth"] = 200;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射§9超光速驱动返回单元§f。")
    .addRecipeTooltip("提供 200GP §3超空间航道强度§f。")
    .setThreadName("单元发射")
    .build();
RecipeBuilder.newBuilder("speedlightsite_HLPP_check","speedlightsite",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        if(HLPP_lunchcheck != 1){
            event.setFailed("§4尚未发射§9超光速驱动返回单元§4!§f");
        }
        if(HLPP_lunchcheck == 1){
            if(HyperSpaceStrenth < 1){
                event.setFailed("§3超空间航道§4已坍缩!§f");
            }
        }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_range = data.getInt("HLPP_range",0);
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        val HLPP_aera_passed = data.getInt("HLPP_aera_passed",1);
        map["HLPP_range"] = HLPP_range + 40;
        if(HyperSpaceStrenth > 0){
            map["HyperSpaceStrenth"] = HyperSpaceStrenth - 1;
        }
        if(HLPP_range > 200){
            map["HLPP_aera_passed"] = HLPP_range / 200;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("§9超光速驱动返回单元§f每 Tick 将航行 40Mly。")
    .addRecipeTooltip("监测§9超光速驱动返回单元§f，每 200Mly 为一个§a航行区间§f，产出倍率由经过的§a航行区间§f数量决定。")
    .addRecipeTooltip("每Tick减少 1 §3超空间航道强度§f。")
    .addRecipeTooltip("在§3超空间航道强度§f小于 1 时自动回收返回舱。")
    .setThreadName("单元监测")
    .build();
RecipeBuilder.newBuilder("speedlightsite_HLPP_output","speedlightsite",20)
    .addOutput(<liquid:anti_quarkgluon> * 100)
    .addOutput(<liquid:quarkgluon> * 200)
    .addOutput(<contenttweaker:fragments_of_the_space_time_continuum> * 1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",1);
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        if(HLPP_lunchcheck != 1){
            event.setFailed("§4尚未发射§9超光速驱动返回单元§4!§f");
        }
        if(HyperSpaceStrenth > 0){
            event.setFailed("§9超光速驱动返回单元§4尚未返回!§f");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_count = data.getInt("HLPP_count",0);
        val HLPP_aera_passed = data.getInt("HLPP_aera_passed",1);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("unit_mult_item",RecipeModifierBuilder.create("modularmachinery:item","output",HLPP_count * HLPP_aera_passed * 10,1,false).build());
        thread.addPermanentModifier("unit_mult_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",HLPP_count * HLPP_aera_passed * 10,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_count = data.getInt("HLPP_count",0);
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        val HLPP_range = data.getInt("HLPP_range",0);
        val HLPP_aera_passed = data.getInt("HLPP_aera_passed",0);
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",0);
        map["HLPP_lunchcheck"] = 0;
        map["HLPP_count"] = 0;
        map["HyperSpaceStrenth"] = 0;
        map["HLPP_range"] = 0;
        map["HLPP_aera_passed"] = 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("回收§9超光速驱动返回单元§f。")
    .setThreadName("单元回收")
    .build();
RecipeBuilder.newBuilder("speedlightsite_HLPP_upkeep","speedlightsite",20)
    .addInput(<contenttweaker:novamatrix> * 8).setChance(0)
    .addInput(<contenttweaker:voidmatter> * 16)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_lunchcheck = data.getInt("HLPP_lunchcheck",1);
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        if(HLPP_lunchcheck != 1){
            event.setFailed("§4尚未发射§9超光速驱动返回单元§4!§f");
        }
        if(HLPP_lunchcheck == 1){
            if(HyperSpaceStrenth < 1){
                event.setFailed("§3超空间航道§4已坍缩!§f");
            }
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HLPP_count = data.getInt("HLPP_count",0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("unit_mult_item",RecipeModifierBuilder.create("modularmachinery:item","input",HLPP_count,1,false).build());
        thread.addPermanentModifier("unit_mult_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","input",HLPP_count,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val HyperSpaceStrenth = data.getInt("HyperSpaceStrenth",0);
        map["HyperSpaceStrenth"] = HyperSpaceStrenth + 2000;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每 §e1§f台 §9超光速驱动返回单元§f，将会增加 §a1x§f 输入")
    .addRecipeTooltip("提供 2000GP §3超空间航道强度§f。")
    .setThreadName("航道稳定")
    .build();
MachineModifier.setMaxThreads("speedlightsite", 0);
MachineModifier.addCoreThread("speedlightsite", FactoryRecipeThread.createCoreThread("单元装载"));
MachineModifier.addCoreThread("speedlightsite", FactoryRecipeThread.createCoreThread("单元发射"));
MachineModifier.addCoreThread("speedlightsite", FactoryRecipeThread.createCoreThread("单元监测"));
MachineModifier.addCoreThread("speedlightsite", FactoryRecipeThread.createCoreThread("单元回收"));
MachineModifier.addCoreThread("speedlightsite", FactoryRecipeThread.createCoreThread("航道稳定"));
events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val pos = event.position;
    val item = event.item;
    val player = event.player;
    if(!event.world.remote && <contenttweaker:lightspeed_overclock_array>.matches(item)){
        if(block.definition.id != "modularmachinery:eco_y7_factory_controller" && block.definition.id != "modularmachinery:dream_energy_core_factory_controller" && block.definition.id != "modularmachinery:dyson_ball_management_center_factory_controller" && block.definition.id != "modularmachinery:space_generator_factory_controller" && block.definition.id != "modularmachinery:massanomaldevice_factory_controller" && block.definition.id != "modularmachinery:lhcparticle_factory_controller" && block.definition.id != "modularmachinery:dimensionreaper_factory_controller" && block.definition.id != "modularmachinery:lightpressurelaunchunit_factory_controller" && block.definition.id != "modularmachinery:groundzero_factory_controller" && block.definition.id != "modularmachinery:mega_spaceelevator_factory_controller" && block.definition.id != "modularmachinery:giga_negativephasecollector_factory_controller" && block.definition.id != "modularmachinery:speedlightsite_factory_controller" && block.definition.id != "modularmachinery:giga_condenseddarkplasmaturbine_factory_controller" && block.definition.id != "modularmachinery:giga_qft_factory_controller" && block.definition.id != "modularmachinery:mega_spaceelevatorminemodule_factory_controller" && block.definition.id != "modularmachinery:mega_shroudneedle_factory_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            if(block.definition.id == "modularmachinery:solar_panel_0_controller" || block.definition.id == "modularmachinery:solar_panel_1_controller" || block.definition.id =="modularmachinery:gas_generator_controller" || block.definition.id == "modularmachinery:hybrid_generator_factory_controller" || block.definition.id =="modularmachinery:biogas_generator_controller" || block.definition.id == "modularmachinery:weather_generator_controller" || block.definition.id == "modularmachinery:reactor_ic2_2_factory_controller" || block.definition.id == "modularmachinery:stellargenerator_controller" || block.definition.id == "modularmachinery:di_ci_controller" || block.definition.id == "modularmachinery:tidal_generator_controller" || block.definition.id == "modularmachinery:draconic_reactor_factory_controller" || block.definition.id == "modularmachinery:alppm_controller" || block.definition.id == "modularmachinery:ark_auxiliary_warehouse_controller" || block.definition.id == "modularmachinery:dyson_cloud_energy_receiver_controller" || block.definition.id == "modularmachinery:energy_releaser_controller" || block.definition.id == "modularmachinery:advanced_energy_releaser_controller" || block.definition.id == "modularmachinery:energy_crystal_controller" || block.definition.id == "modularmachinery:energy_crystal_2_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_core_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_casing_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_controller" || block.definition.id == "modularmachinery:starburst_reactor_controller" || block.definition.id == "modularmachinery:xihe_star_creation_device_controller" || block.definition.id == "modularmachinery:orionengine_factory_controller" || block.definition.id == "modularmachinery:asteroid_reactor_factory_controller" || block.definition.id == "modularmachinery:zeromatrix_factory_controller" || block.definition.id == "modularmachinery:mega_psionicsiphonmatrix_factory_controller"){
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("LSOA",RecipeModifierBuilder.create("modularmachinery:energy","output",64,1,false).build());
                player.sendMessage("§9光速超频矩阵-§c效率模块§a已安装!§f");
            }else{
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("LSOA",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0009765625,1,false).build());
                player.sendMessage("§9光速超频矩阵-§e速度模块§a已安装!§f");
            }
           
        }
        /*
        if(block.definition.id == "modularmachinery:solar_panel_0_controller" || "modularmachinery:solar_panel_1_controller" ||"modularmachinery:gas_generator_controller" || "modularmachinery:hybrid_generator_factory_controller" ||"modularmachinery:biogas_generator_controller" || "modularmachinery:weather_generator_controller" || "modularmachinery:reactor_ic2_2_factory_controller" || "modularmachinery:stellargenerator_controller" || "modularmachinery:di_ci_controller" || "modularmachinery:tidal_generator_controller" || "modularmachinery:draconic_reactor_factory_controller" || "modularmachinery:alppm_controller" || "modularmachinery:ark_auxiliary_warehouse_controller" || "modularmachinery:dyson_cloud_energy_receiver_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            val data = ctrl.customData;
            val map = data.asMap();
            val LSOA_level = data.getInt("LSOA_level",1.0);
            if(LSOA_level > 0){
                player.sendMessage("§4不可安装多个§9光速超频矩阵§4!§f");
            }
            else{
                map["LSOA_level"] = 1;
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("LSOA",RecipeModifierBuilder.create("modularmachinery:energy","output",1024,1,false).build());
            }
            ctrl.customData = data;
        }
        if(block.definition.id == "modularmachinery:energy_releaser_controller" || "modularmachinery:advanced_energy_releaser_controller" || "modularmachinery:energy_crystal_controller" || "modularmachinery:energy_crystal_2_controller" || "modularmachinery:ultra_zero_point_vacuum_displacer_core_controller" || "modularmachinery:ultra_zero_point_vacuum_displacer_casing_controller" || "modularmachinery:ultra_zero_point_vacuum_displacer_controller" || "modularmachinery:starburst_reactor_controller" || "modularmachinery:xihe_star_creation_device_controller" || "modularmachinery:orionengine_factory_controller" || "modularmachinery:asteroid_reactor_factory_controller" || "modularmachinery:zeromatrix_factory_controller" || "modularmachinery:mega_psionicsiphonmatrix_factory_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            val data = ctrl.customData;
            val map = data.asMap();
            val LSOA_level = data.getInt("LSOA_level",1.0);
            if(LSOA_level > 0){
                player.sendMessage("§4不可安装多个§9光速超频矩阵§4!§f");
            }
            else{
                map["LSOA_level"] = 1;
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("LSOA",RecipeModifierBuilder.create("modularmachinery:energy","output",64,1,false).build());
            }
            ctrl.customData = data;
        }
        */
        if(block.definition.id == "novaeng_core:geocentric_drill_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            item.mutable().shrink(1);
            ctrl.addPermanentModifier("LSOA",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0009765625,1,false).build());
            player.sendMessage("§9光速超频矩阵-§e速度模块§a已安装!§f");
        }
        if(block.definition.id == "modularmachinery:eco_y7_factory_controller" || block.definition.id == "modularmachinery:dream_energy_core_factory_controller" || block.definition.id == "modularmachinery:dyson_ball_management_center_factory_controller" || block.definition.id == "modularmachinery:space_generator_factory_controller" || block.definition.id == "modularmachinery:massanomaldevice_factory_controller" || block.definition.id == "modularmachinery:lhcparticle_factory_controller" || block.definition.id == "modularmachinery:dimensionreaper_factory_controller" || block.definition.id == "modularmachinery:lightpressurelaunchunit_factory_controller" || block.definition.id == "modularmachinery:groundzero_factory_controller" || block.definition.id == "modularmachinery:mega_spaceelevator_factory_controller" || block.definition.id == "modularmachinery:giga_negativephasecollector_factory_controller" || block.definition.id == "modularmachinery:speedlightsite_factory_controller" || block.definition.id == "modularmachinery:giga_condenseddarkplasmaturbine_factory_controller" || block.definition.id == "modularmachinery:giga_qft_factory_controller" || block.definition.id == "modularmachinery:mega_spaceelevatorminemodule_factory_controller" || block.definition.id == "modularmachinery:mega_shroudneedle_factory_controller"){
            player.sendMessage("§4该机器不支持§9光速超频矩阵§4!§f");
        }
        event.cancel();
    }
});
RecipeBuilder.newBuilder("giga_massunpacker_mineral_01","giga_massunpacker",20,1)
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:mineral>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 1048576;
    })
    .addOutput(<minecraft:gold_ingot> * 262144)
    .addOutput(<minecraft:iron_ingot> * 262144)
    .addOutput(<minecraft:dye:4> * 262144)
    .addOutput(<minecraft:diamond> * 262144)
    .addOutput(<minecraft:redstone> * 262144)
    .addOutput(<minecraft:emerald> * 262144)
    .addOutput(<minecraft:quartz> * 262144)
    .addOutput(<minecraft:coal> * 262144)
    .addOutput(<thermalfoundation:material:128> * 262144)
    .addOutput(<thermalfoundation:material:129> * 262144)
    .addOutput(<thermalfoundation:material:130> * 262144)
    .addOutput(<thermalfoundation:material:131> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<thermalfoundation:material:133> * 262144)
    .addOutput(<thermalfoundation:material:134> * 262144)
    .addOutput(<thermalfoundation:material:135> * 262144)
    .addOutput(<thermalfoundation:material:136> * 262144)
    .addOutput(<ic2:ingot:8> * 262144)
    .addOutput(<draconicevolution:draconium_ingot> * 262144)
    .addOutput(<ore:ingotThorium> * 262144)
    .addOutput(<ore:ingotBoron> * 262144)
    .addOutput(<ore:ingotMagnesium> * 262144)
    .addOutput(<ore:ingotManganese> * 262144)
    .addOutput(<additions:novaextended-ingot8> * 262144)
    .addOutput(<taiga:dilithium_ingot> * 262144)
    .addOutput(<libvulpes:productingot:7> * 262144)
    .addOutput(<tconstruct:ingots:0> * 262144)
    .addOutput(<tconstruct:ingots:1> * 262144)
    .addOutput(<appliedenergistics2:material:0> * 262144)
    .addOutput(<appliedenergistics2:material:1> * 262144)
    .addOutput(<mekanism:ingot:1> * 262144)
    .addOutput(<mekanism:fluoriteclump> * 262144)
    .addOutput(<futuremc:netherite_scrap> * 262144)
    .addOutput(<rftools:dimensional_shard> * 262144)
    .addOutput(<ore:gemQuartzBlack> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:1> * 262144)
    .addOutput(<astralsorcery:itemcraftingcomponent:0> * 262144)
    .addOutput(<thermalfoundation:material:132> * 262144)
    .addOutput(<taiga:aurorium_ingot> * 262144)
    .addOutput(<taiga:palladium_ingot> * 262144)
    .addOutput(<taiga:prometheum_ingot> * 262144)
    .addOutput(<taiga:valyrium_ingot> * 262144)
    .addOutput(<taiga:vibranium_ingot> * 262144)
    .addOutput(<taiga:osram_ingot> * 262144)
    .addOutput(<taiga:eezo_ingot> * 262144)
    .addOutput(<taiga:uru_ingot> * 262144)
    .addOutput(<taiga:duranite_ingot> * 262144)
    .addOutput(<taiga:karmesine_ingot> * 262144)
    .addOutput(<taiga:abyssum_ingot> * 262144)
    .addOutput(<taiga:tiberium_ingot> * 262144)
    .addOutput(<taiga:jauxum_ingot> * 262144)
    .addOutput(<taiga:ovium_ingot> * 262144)
    .addOutput(<taiga:obsidiorite_ingot> * 262144)
    .addOutput(<minecraft:glowstone_dust> * 262144)
    .addOutput(<taiga:meteorite_ingot> * 262144)
    .addOutput(<appliedenergistics2:sky_stone_block> * 262144)
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("§9该配方拥有 §a1048576§f 并行")
    .build();
RecipeBuilder.newBuilder("giga_massunpacker_mineral_02","giga_massunpacker",20,1)
    .addInput(<contenttweaker:advanced_programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:mineral>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 1048576;
    })
    .addOutput(<environmentaltech:litherite_crystal> * 262144)
    .addOutput(<environmentaltech:erodium_crystal> * 262144)
    .addOutput(<environmentaltech:lonsdaleite_crystal> * 262144)
    .addOutput(<environmentaltech:kyronite_crystal> * 262144)
    .addOutput(<environmentaltech:pladium_crystal> * 262144)
    .addOutput(<environmentaltech:ionite_crystal> * 262144)
    .addOutput(<environmentaltech:aethium_crystal> * 262144)
    .addOutput(<biomesoplenty:gem:0> * 262144)
    .addOutput(<biomesoplenty:gem:1> * 262144)
    .addOutput(<biomesoplenty:gem:2> * 262144)
    .addOutput(<biomesoplenty:gem:3> * 262144)
    .addOutput(<biomesoplenty:gem:4> * 262144)
    .addOutput(<biomesoplenty:gem:5> * 262144)
    .addOutput(<biomesoplenty:gem:6> * 262144)
    .addOutput(<biomesoplenty:gem:7> * 262144)
    .addOutput(<ebwizardry:magic_crystal:1> * 262144)
    .addOutput(<ebwizardry:magic_crystal:2> * 262144)
    .addOutput(<ebwizardry:magic_crystal:3> * 262144)
    .addOutput(<ebwizardry:magic_crystal:4> * 262144)
    .addOutput(<ebwizardry:magic_crystal:5> * 262144)
    .addOutput(<ebwizardry:magic_crystal:6> * 262144)
    .addOutput(<ebwizardry:magic_crystal:7> * 262144)
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("§9该配方拥有 §a1048576§f 并行")
    .build();
RecipeBuilder.newBuilder("giga_massunpacker_alloy","giga_massunpacker",20,1)
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:alloy> * 1024)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 1048576;
    })
    .addOutputs([
        <additions:novaextended-blue_alloy_ingot> * 262144,
        <additions:novaextended-fallen_star_alloy> * 262144,
        <additions:novaextended-psi_alloy> * 262144,
        <additions:novaextended-terraalloy> * 262144,
        <contenttweaker:universalalloyt1> * 65536,
        <contenttweaker:universalalloyt2> * 32768,
        <contenttweaker:universalalloyt3> * 16384,
        <contenttweaker:gama_tialalloy> * 131072,
        <contenttweaker:neutrondustingot> * 65536,
        <contenttweaker:superconidiosome> * 32768,
        <contenttweaker:weakmag> * 16384,
        <additions:novaextended-star_ingot> * 8192,
        <contenttweaker:spacematrix_ingot> * 4096,
        <contenttweaker:nq_alloy> * 2048,
        <contenttweaker:octingot> * 1024,
        <mekanism:enrichedalloy> * 65536,
        <mekanism:reinforcedalloy> * 65536,
        <mekanism:atomicalloy> * 65536,
        <mekanism:cosmicalloy> * 1024,
        <super_solar_panels:crafting:3> * 262144,
        <super_solar_panels:crafting:6> * 262144,
        <super_solar_panels:crafting:31> * 262144,
        <super_solar_panels:crafting:33> * 262144,
    ])
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("§9该配方拥有 §a1048576§f 并行")
    .build();
/*
<modularmachinery:computation_center_t1_factory_controller>
<modularmachinery:computation_center_t2_factory_controller>
<modularmachinery:computation_center_t3_factory_controller>
<modularmachinery:acdcenter_factory_controller>
<modularmachinery:data_processor_t1_factory_controller>
<modularmachinery:data_processor_t2_factory_controller>
<modularmachinery:data_processor_t3_factory_controller>
<modularmachinery:data_processor_t4_factory_controller>
<modularmachinery:starcomputer_factory_controller>
<modularmachinery:research_station_t1_factory_controller>
<modularmachinery:research_station_t2_factory_controller>
<modularmachinery:research_station_t3_factory_controller>
<modularmachinery:mega_researchstationt4_factory_controller>
<modularmachinery:database_t1_factory_controller>
<modularmachinery:database_t2_factory_controller>
<modularmachinery:spacestation_i_factory_controller>
<modularmachinery:spacestation_ii_factory_controller>
<modularmachinery:spacestation_iii_factory_controller>
<modularmachinery:eco_y7_factory_controller>
<modularmachinery:dream_energy_core_factory_controller>
<modularmachinery:dyson_ball_management_center_factory_controller>
<modularmachinery:space_generator_factory_controller>
<modularmachinery:massanomaldevice_factory_controller>
<modularmachinery:lhcparticle_factory_controller>
<modularmachinery:dimensionreaper_factory_controller>
<modularmachinery:lightpressurelaunchunit_factory_controller>
<modularmachinery:groundzero_factory_controller>
<modularmachinery:mega_spaceelevator_factory_controller>
<modularmachinery:giga_negativephasecollector_factory_controller>
<modularmachinery:speedlightsite_factory_controller>
<modularmachinery:giga_condenseddarkplasmaturbine_factory_controller>
<modularmachinery:giga_qft_factory_controller>
<modularmachinery:mega_spaceelevatorminemodule_factory_controller>
<modularmachinery:mega_shroudneedle_factory_controller>

<modularmachinery:solar_panel_0_controller>
<modularmachinery:solar_panel_1_controller>
<modularmachinery:gas_generator_controller>
<modularmachinery:hybrid_generator_factory_controller>
<modularmachinery:biogas_generator_controller>
<modularmachinery:weather_generator_controller>
<modularmachinery:reactor_ic2_2_factory_controller>
<modularmachinery:stellargenerator_controller>
<modularmachinery:di_ci_controller>
<modularmachinery:tidal_generator_controller>
<modularmachinery:draconic_reactor_factory_controller>
<modularmachinery:alppm_controller>
<modularmachinery:ark_auxiliary_warehouse_controller>
<modularmachinery:dyson_cloud_energy_receiver_controller>

<modularmachinery:energy_releaser_controller>
<modularmachinery:advanced_energy_releaser_controller>
<modularmachinery:energy_crystal_controller>
<modularmachinery:energy_crystal_2_controller>
<modularmachinery:ultra_zero_point_vacuum_displacer_core_controller>
<modularmachinery:ultra_zero_point_vacuum_displacer_casing_controller>
<modularmachinery:ultra_zero_point_vacuum_displacer_controller>
<modularmachinery:starburst_reactor_controller>
<modularmachinery:xihe_star_creation_device_controller>
<modularmachinery:orionengine_factory_controller>
<modularmachinery:asteroid_reactor_factory_controller>
<modularmachinery:zeromatrix_factory_controller>
<modularmachinery:mega_psionicsiphonmatrix_factory_controller>
*/
//新星合金
HyperNetHelper.proxyMachineForHyperNet("irisx_00147");
unique_recipe_with_research([<contenttweaker:neutrondustingot> * 32,<contenttweaker:universalalloyt1> * 1024,<contenttweaker:universalalloyt2> * 256,<contenttweaker:universalalloyt3> * 64,<contenttweaker:octingot> * 4],<contenttweaker:nova_ingot> * 16,600,1,"Mega-SpaceElevator-Stage1",100,8000000000);
unique_recipe_with_research([<contenttweaker:starvoidstructure>,<redstonerepository:material:5> * 4096,<redstonerepository:material:1> * 4096,<extrabotany:material:1> * 256,<contenttweaker:voidmatter> * 64,<contenttweaker:nova_ingot> * 16],<contenttweaker:arcance_ingot> * 32,600,2,"Giga-ShroudAssemblyFactory",100,80000000000);
unique_recipe_with_research([<contenttweaker:mineral> * 2],<contenttweaker:alloy>,600,3,"Mega-SpaceElevator-Stage1",10,80000000000);
unique_recipe_with_research([<liquid:dimensionbeam> * 1000,<liquid:aefe> * 10000,<liquid:spaceframefluid> * 10000,<liquid:space_time_fluids> * 10000,<liquid:tachyonfluid> * 10000,<contenttweaker:fragments_of_the_space_time_continuum> * 1048576,<contenttweaker:arcance_ingot> * 2,<contenttweaker:cosmic_data> * 8,<contenttweaker:alloy> * 512],<contenttweaker:timespace_ingot> * 2,6000,4,"Giga-TimeSpaceSingularity",10000,80000000000);
unique_recipe_with_research([<taiga:adamant_ingot> * 4,<contenttweaker:nq_powder> * 4,<contenttweaker:weakmag>],<contenttweaker:nq_alloy>,600,5,"Mega-SpaceElevator-Stage1",10,800000000);
//oredrone 消耗无人机点数,rocket 消耗运载火箭点数, satellite 消耗遥感卫星点数, purpose 目标控制器,consume 自组装单元消耗数量,input 输入材料组,collectrank 采集阵列等级, carryrank 运载阵列等级 , maintainrank 维护阵列等级
//elevator 是否需要太空电梯参与 energy消耗能量/tick research_name需求的研究名称 require_cp需求算力 time配方时间 require_spacestation_level 空间站等级
var counter = 2;
megabuild(400,800,800,[<contenttweaker:novamatrix> * 2],400,[<contenttweaker:spacexmachineblock> * 4,<contenttweaker:starmachineblock> * 64,<contenttweaker:planetstructure> * 64,<contenttweaker:arkchip>,<contenttweaker:arkforcefieldcontrolblock> * 4,<contenttweaker:field_generator_v4> * 64,<contenttweaker:gama_tialcoil> * 512,<contenttweaker:voidmatter> * 128,<contenttweaker:lockednormalplanet>,<contenttweaker:lockedhellplanet>,<contenttweaker:lockedenderplanet>],1,3,3,false,counter,8000000000000,"Mega-SpaceElevator-Stage3",800000,240,2);counter += 1;
megabuild(400,800,200,[<contenttweaker:se_core>],800,[<contenttweaker:antimatter_core> * 128,<modularmachinery:dimensionreaper_factory_controller>,<modularmachinery:basic_zeropressure_factory_controller>,<modularmachinery:atomicprocessequipx_factory_controller> * 16,],3,3,3,false,counter,8000000000000,"Mega-SpaceElevator-Stage4",8000000,2400,2);counter += 1;
megabuild(1000,1000,1000,[<modularmachinery:mega_spaceelevator_factory_controller>],1000,[<contenttweaker:industrial_circuit_v4> * 256,<contenttweaker:field_generator_v4> * 512,<contenttweaker:coil_v5> * 4096,<contenttweaker:gama_tialcoil> * 1024,<contenttweaker:arkchip> * 16,<modularmachinery:mega_magicalcrafttable_factory_controller>,<contenttweaker:se_core>,<contenttweaker:se_blueprint>,<contenttweaker:ultminingdevice> * 128],3,3,3,false,counter,8000000000000,"Mega-SpaceElevator-Stage4",10000000,2400,2);counter += 1;
megabuild(400,800,800,[<contenttweaker:shroud_needle>],400,[<advancedrocketry:misc>,<contenttweaker:beccomputer> * 4,<contenttweaker:arkchip> * 4,<novaeng_core:extendable_calculator_subsystem_l9> * 32,<contenttweaker:spacetimeframework> * 128,<contenttweaker:recoilengine>,<contenttweaker:lightplatform> * 64,<contenttweaker:mk2observer> * 64],3,3,3,true,counter,8000000000000,"Mega-ShroudNeedle",800000,240,2);counter += 1;
megabuild(400,400,400,[<contenttweaker:sn_core>],200,[<contenttweaker:shroud_needle>,<modularmachinery:mega_magicalcrafttable_factory_controller> * 4,<modularmachinery:starcomputer_factory_controller> * 4],1,2,2,false,counter,8000000000000,"Mega-ShroudNeedle",800000,1200,2);counter += 1;
megabuild(1000,1000,1000,[<modularmachinery:mega_shroudneedle_factory_controller>],1000,[<contenttweaker:industrial_circuit_v4> * 256,<contenttweaker:field_generator_v4> * 512,<contenttweaker:coil_v5> * 4096,<contenttweaker:gama_tialcoil> * 1024,<contenttweaker:arkchip> * 16,<contenttweaker:sn_core>,<contenttweaker:sn_blueprint>,<contenttweaker:se_core>],3,3,3,true,counter,8000000000000,"Mega-ShroudNeedle",10000000,2400,2);counter += 1;
megabuild(400,800,800,[<contenttweaker:psm_core>],400,[<modularmachinery:orichalcos_drill_factory_controller>,<modularmachinery:illum_pool_factory_controller>,<modularmachinery:draconic_reactor_factory_controller>,<modularmachinery:xihe_star_creation_device_controller>,<modularmachinery:starburst_reactor_controller>],1,3,3,true,counter,8000000000000,"Mega-ShroudChunckGenerator",800000,240,2);counter += 1;
megabuild(1000,1000,1000,[<modularmachinery:mega_psionicsiphonmatrix_factory_controller>],1000,[<contenttweaker:industrial_circuit_v4> * 256,<contenttweaker:field_generator_v4> * 512,<contenttweaker:coil_v5> * 4096,<contenttweaker:gama_tialcoil> * 1024,<contenttweaker:arkchip> * 8,<contenttweaker:psm_core>,<contenttweaker:psm_blueprint>],3,3,3,true,counter,8000000000000,"Mega-ShroudChunckGenerator",10000000,2400,2);counter += 1;
megabuild(1500,1500,1500,[<contenttweaker:aal_core>],1000,[<contenttweaker:psm_core>,<contenttweaker:sn_core>,<contenttweaker:se_core>,<contenttweaker:shroudplanet> * 64],4,4,4,true,counter,8000000000000,"Giga-ShroudAssemblyFactory",10000000,2400,2);counter += 1;
megabuild(1000,1000,1000,[<modularmachinery:giga_arcanceassemblyline_factory_controller>],1000,[<contenttweaker:industrial_circuit_v4> * 256,<contenttweaker:field_generator_v4> * 512,<contenttweaker:arcancemachineblock> * 64,<contenttweaker:arkchip> * 64,<contenttweaker:aal_core>,<contenttweaker:aal_blueprint>],3,3,3,true,counter,8000000000000,"Mega-ShroudChunckGenerator",10000000,2400,2);counter += 1;
megabuild(1500,1500,1500,[<contenttweaker:dfea_core>],1000,[<contenttweaker:aal_core>,<modularmachinery:mega_psionicsiphonmatrix_factory_controller>,<modularmachinery:mega_magicalcrafttable_factory_controller>,<contenttweaker:similardarkmatter> * 256],4,4,4,true,counter,80000000000000,"Giga-DimensionFocusEngraving",10000000,2400,2);counter += 1;
megabuild(1000,1000,1000,[<modularmachinery:giga_dimensionallyfocusengravingarray_factory_controller>],1000,[<contenttweaker:industrial_circuit_v4> * 256,<contenttweaker:field_generator_v4> * 512,<contenttweaker:arcancemachineblock> * 64,<contenttweaker:arkchip> * 64,<contenttweaker:dfea_core>,<contenttweaker:dfea_blueprint>],4,4,4,true,counter,80000000000000,"Giga-DimensionFocusEngraving",10000000,2400,2);counter += 1;
megabuild(4000,4000,4000,[<modularmachinery:giga_cosmiccasket_factory_controller>],2000,[<contenttweaker:industrial_circuit_v4> * 1024,<contenttweaker:field_generator_v4> * 1024,<contenttweaker:arcancemachineblock> * 64,<contenttweaker:hyperdimensional_soc> * 4,<contenttweaker:similardarkmatter> * 256,<contenttweaker:cosmiccasket_blueprint>,<contenttweaker:cosmiccasket_core>],6,6,6,true,counter,80000000000000,"Giga-CosmicCasket",10000000,2400,2);counter += 1;
megabuild(4000,4000,4000,[<contenttweaker:timespacesingularity_core>],2000,[<contenttweaker:cosmiccasket_core>,<contenttweaker:entropy_singularity>,<contenttweaker:sn_core>,<contenttweaker:aal_core>,<contenttweaker:axis_blueprint>],6,6,6,true,counter,80000000000000,"Giga-TimeSpaceSingularity",10000000,2400,2);counter += 1;
megabuild(4000,4000,4000,[<modularmachinery:giga_timespacesingularity_factory_controller>],2000,[<contenttweaker:industrial_circuit_v4> * 1024,<contenttweaker:field_generator_v4> * 1024,<contenttweaker:arcancemachineblock> * 64,<contenttweaker:hyperdimensional_soc> * 4,<contenttweaker:similardarkmatter> * 256,<contenttweaker:timespacesingularity_blueprint>,<contenttweaker:timespacesingularity_core>],8,8,8,true,counter,80000000000000,"Giga-TimeSpaceSingularity",40000000,2400,2);counter += 1;
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
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;
MachineModifier.setMaxThreads("endtech_earth_drill",0);
val dMin = 0;
val dMax = 5000;
MachineModifier.addCoreThread("endtech_earth_drill",FactoryRecipeThread.createCoreThread("钻探系统"));
MachineModifier.addCoreThread("endtech_earth_drill",FactoryRecipeThread.createCoreThread("地幔粉碎阵列#1"));
MachineModifier.addCoreThread("endtech_earth_drill",FactoryRecipeThread.createCoreThread("地幔粉碎阵列#2"));
MachineModifier.addCoreThread("endtech_earth_drill",FactoryRecipeThread.createCoreThread("地幔粉碎阵列#3"));
MachineModifier.addCoreThread("endtech_earth_drill",FactoryRecipeThread.createCoreThread("地幔粉碎阵列#4"));
MachineModifier.addSmartInterfaceType("endtech_earth_drill",
    SmartInterfaceType.create("depthMax",0)
         .setHeaderInfo("§4钻探深度§f设置")
         .setValueInfo("当前深度:§a%dkm")
         .setFooterInfo("§4最大钻探深度为§c5000km")
);
RecipeBuilder.newBuilder("endtech_earth_drill_controller_MAKE","machine_arm",1200)
 .addEnergyPerTickInput(5000000)
 .addInputs([
   <modularmachinery:small_ore_drill_factory_controller>*4,
   <minecraft:magma>*128,
   <contenttweaker:industrial_circuit_v1>*16,
   <contenttweaker:robot_arm_v2>*16,
   <contenttweaker:electric_motor_v2>*16,
   <modularmachinery:blockcasing:4>*4,
   <minecraft:coal_block>*32
 ])
 .addOutput(<modularmachinery:endtech_earth_drill_factory_controller>)
 .build();
MMEvents.onMachinePostTick("endtech_earth_drill",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("depthMax");
    var depthMax = isNull(nullable) ? 1 : nullable.value;
    depthMax = depthMax > dMax ? dMax : (depthMax < dMin ? dMin : depthMax);
    map["depthMax"]=depthMax;
    ctrl.customData = data;
});
function depthin(circuit as IItemStack,rank as int,increase as int,duration as int){
   RecipeBuilder.newBuilder("earth_drill_depth_of_fuel"+rank,"endtech_earth_drill",duration,2)
      .addPreCheckHandler(function(event as RecipeCheckEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         var depth = data.getInt("depth",0);
         var depthMax = data.getInt("depthMax",0);
         if(depth == depthMax){
            event.setFailed("已达最大深度");
         }
         if(depth > depthMax){
            data.asMap()["depth"]=depthMax;
            ctrl.customData = data;
         }
      })
      .addInput(circuit).setChance(0)
      .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         val map = data.asMap();
         val thread = event.factoryRecipeThread;
         thread.addPermanentModifier("energy_cost",RecipeModifierBuilder.create("modularmachinery:energy", "input",rank, 1, false).build());
         map["active"]=1;
         ctrl.customData = data;
      })
      .addEnergyPerTickInput(40000)
      .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         var depth = data.getInt("depth",0);
         val map = data.asMap();
         depth+=increase*event.activeRecipe.parallelism;
         val thread = event.factoryRecipeThread;
         thread.removePermanentModifier("energy_cost");
         map["depth"]=depth;
         ctrl.customData = data;
      })
      .addRecipeTooltip("在§a"+ duration/20 +"秒§f内向下推进§b"+ increase +"km")
      .addRecipeTooltip("每tick耗电为原来的"+rank+"倍")
      .setThreadName("钻探系统")
      .build();
}
depthin(<contenttweaker:programming_circuit_0>,1,400,600);
depthin(<contenttweaker:programming_circuit_a>,5,600,500);
depthin(<contenttweaker:programming_circuit_b>,10,800,400);
depthin(<contenttweaker:programming_circuit_c>,15,1000,300);
depthin(<contenttweaker:programming_circuit_d>,20,1200,200);

RecipeBuilder.newBuilder("earth_drill_output_endtech_1","endtech_earth_drill",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth = data.getInt("depth",0);
   if(depth < 500){
      event.setFailed("未达到最低钻探深度");
   }
 })
 .addEnergyPerTickInput(5000000)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth= data.getInt("depth",0);
   var mult = (depth/1000)as float+1.0f;
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("multR",RecipeModifierBuilder.create("modularmachinery:item","output",mult,1,false).build());
 })
  .addOutputs([
   <minecraft:stone:1>*32,
   <minecraft:stone:3>*32,
   <minecraft:stone>*32,
   <minecraft:sand>*32,
   <minecraft:clay_ball>*64,
   <minecraft:gravel>*64
  ])
  .addRecipeTooltip("当钻探深度大于500km时启动")
  .addRecipeTooltip("钻探深度每增加1000km,产出增加一倍")
  .setThreadName("地幔粉碎阵列#1")
  .build();


RecipeBuilder.newBuilder("earth_drill_output_endtech_2","endtech_earth_drill",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth = data.getInt("depth",0);
   if(depth < 1500){
      event.setFailed("未达到最低钻探深度");
   }
 })
 .addEnergyPerTickInput(5000000)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth= data.getInt("depth",0);
   var mult = (depth/1000)as float+1.0f;
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("multR",RecipeModifierBuilder.create("modularmachinery:item","output",mult,1,false).build());
 })
  .addOutputs([
   <mets:niobium_dust>*16,
   <ic2:misc_resource:1>*16,
   <taiga:obsidiorite_block>*8,
   <taiga:meteorite_block>*8,
   <novaeng_core:raw_ore_eezo>*16
  ])
  .addRecipeTooltip("当钻探深度大于1500km时启动")
  .addRecipeTooltip("钻探深度每增加1000km,产出增加一倍")
  .setThreadName("地幔粉碎阵列#2")
  .build();

RecipeBuilder.newBuilder("earth_drill_output_endtech_3","endtech_earth_drill",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth = data.getInt("depth",0);
   if(depth < 2500){
      event.setFailed("未达到最低钻探深度");
   }
 })
 .addEnergyPerTickInput(5000000)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth= data.getInt("depth",0);
   var mult = (depth/1000)as float+1.0f;
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("multR",RecipeModifierBuilder.create("modularmachinery:item","output",mult,1,false).build());
 })
  .addOutputs([
   <minecraft:obsidian>*32,
   <minecraft:magma>*18,
   <futuremc:netherite_scrap>*16,
   <minecraft:netherrack>*64,
   <tconstruct:metal:2>*8
  ])
  .addRecipeTooltip("当钻探深度大于2500km时启动")
  .addRecipeTooltip("钻探深度每增加1000km,产出增加一倍")
  .setThreadName("地幔粉碎阵列#3")
  .build();

RecipeBuilder.newBuilder("earth_drill_output_endtech_lava","endtech_earth_drill",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth = data.getInt("depthMax",0);
   if(depth < 1000){
      event.setFailed("未达到最低钻探深度");
   }
 })
 .addEnergyPerTickInput(5000000)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth= data.getInt("depthMax",0);
   var mult = (depth/500)as float+1.0f;
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("multF",RecipeModifierBuilder.create("modularmachinery:fluid","output",mult,1,false).build());
 })
  .addOutputs([
   <liquid:lava>*2500
  ])
  .addRecipeTooltip("当钻探深度大于1000km时启动")
  .addRecipeTooltip("钻探深度每增加500km,产出增加一倍")
  .setThreadName("地幔粉碎阵列#4")
  .build();
RecipeBuilder.newBuilder("earthdrill_envirtechcrystal_out","endtech_earth_drill",40,1)
 .addEnergyPerTickInput(1000)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val depth = data.getInt("depthMax",0);
   if(depth < 4000){
      event.setFailed("未达到最低钻探深度");
   }
 })
     .addCatalystInput(<contenttweaker:additional_component_0>,
        ["优化采集策略", "使产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_1>,
        ["优化采集策略", "使产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_raw_ore>,
        ["优化采集策略", "使产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_2>,
        ["优化采集策略", "使产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output",4.0F, 1, false).build(),
        ]
    ).setChance(0)
            .addCatalystInput(<contenttweaker:additional_component_3>,
        ["解放寰宇之力", "使产量翻8倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output",8.0F, 1, false).build(),
        ]
    ).setChance(0)
 .addOutput(<environmentaltech:litherite_crystal>*16).setChance(0.6)
 .addOutput(<environmentaltech:erodium_crystal>*16).setChance(0.6)
 .addOutput(<environmentaltech:kyronite_crystal>*8).setChance(0.4)
 .addOutput(<environmentaltech:pladium_crystal>*8).setChance(0.4)
 .addOutput(<environmentaltech:ionite_crystal>*4).setChance(0.4)
 .addOutput(<environmentaltech:aethium_crystal>*4).setChance(0.4)
 .addRecipeTooltip("没有循序渐进,只有力大砖飞")
 .addRecipeTooltip("让环境水晶无处遁形")
 .addRecipeTooltip("当钻探深度大于4000km时启动")
 .addRecipeTooltip("其产出结算依赖于催化剂,不享有深度加成")
 .build();
  MMEvents.onControllerGUIRender("endtech_earth_drill",function(event as ControllerGUIRenderEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var depth = data.getInt("depth",0);
   var info as string [] = [];
      info += "当前钻探深度:§6"+depth;
   event.extraInfo = info;
});

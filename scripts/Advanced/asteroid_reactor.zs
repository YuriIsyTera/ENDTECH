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
val dMin = 0;
val dMax = 6000;
MachineModifier.addSmartInterfaceType("asteroid_reactor",
    SmartInterfaceType.create("depthMax",0)
         .setHeaderInfo("§a钻探深度§f设置")
         .setValueInfo("当前深度:§a%dkm")
         .setFooterInfo("§a最大钻探深度为6000km")
);
MMEvents.onMachinePostTick("asteroid_reactor",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("depthMax");
    var depthMax = isNull(nullable) ? 1 : nullable.value;
    depthMax = depthMax > dMax ? dMax : (depthMax < dMin ? dMin : depthMax);
    map["depthMax"]=depthMax;
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("asteroid_reactor",0);
MachineModifier.addCoreThread("asteroid_reactor",FactoryRecipeThread.createCoreThread("行星锁定系统").addRecipe("hellplanet_input"));
MachineModifier.addCoreThread("asteroid_reactor",FactoryRecipeThread.createCoreThread("化学燃料推进系统").addRecipe("depth_of_fuel1").addRecipe("depth_of_fuel2").addRecipe("depth_of_fuel3").addRecipe("depth_of_fuel4"));
MachineModifier.addCoreThread("asteroid_reactor",FactoryRecipeThread.createCoreThread("重核元素衰变能量井").addRecipe("energy_output"));
MachineModifier.addCoreThread("asteroid_reactor",FactoryRecipeThread.createCoreThread("极点熔煅").addRecipe("spacematrix_forge").addRecipe("superconidiosome_forge").addRecipe("nanoporcelain_forge"));
MachineModifier.addCoreThread("asteroid_reactor",FactoryRecipeThread.createCoreThread("残骸解压单元").addRecipe("output_dust"));
function depthin(fuel as IItemStack,increase as int,duration as int,rank as int,fuel_out as IItemStack){
   RecipeBuilder.newBuilder("depth_of_fuel"+rank,"asteroid_reactor",duration,2)
      .addPreCheckHandler(function(event as RecipeCheckEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         var get_planet = data.getInt("get_planet",0);
         var depth = data.getInt("depth",0);
         var depthMax = data.getInt("depthMax",0);
         event.activeRecipe.maxParallelism = 10;
         event.activeRecipe.parallelism = 10;
         if(get_planet == 0){
            event.setFailed("暂未锚定热域行星");
         }
         if(depth == depthMax){
            event.setFailed("已达最大深度");
         }
         if(depth > depthMax){
            data.asMap()["depth"]=depthMax;
            ctrl.customData = data;
         }
      })
      .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         val map = data.asMap();
         map["active"]=1;
         ctrl.customData = data;
      })
      .addInput(fuel)
      .addOutput(fuel_out)
      .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
         val ctrl = event.controller;
         val data = ctrl.customData;
         var depth = data.getInt("depth",0);
         val map = data.asMap();
         depth+=increase*event.activeRecipe.parallelism;
         map["depth"]=depth;
         ctrl.customData = data;
      })
      .addRecipeTooltip("用"+ rank +"级燃料,在§a"+ duration/20 +"秒§f内向下推进§b"+ increase +"km")
      .addRecipeTooltip("该配方的并行为10")
      .setThreadName("化学燃料推进系统")
      .build();
}
depthin(<contenttweaker:energized_fuel_v1>,1,200,1,<contenttweaker:energized_fuel_depleted_v1>);
depthin(<contenttweaker:energized_fuel_v2>,5,200,2,<contenttweaker:energized_fuel_depleted_v2>);
depthin(<contenttweaker:energized_fuel_v3>,20,200,3,<contenttweaker:energized_fuel_depleted_v3>);
depthin(<contenttweaker:energized_fuel_v4>,50,200,4,<contenttweaker:energized_fuel_depleted_v4>);
depthin(<contenttweaker:charged_fuel_v1>,40,200,5,<contenttweaker:energized_fuel_depleted_v1>*16);
depthin(<contenttweaker:charged_fuel_v2>,60,200,6,<contenttweaker:energized_fuel_depleted_v2>*16);
depthin(<contenttweaker:charged_fuel_v3>,80,200,7,<contenttweaker:energized_fuel_depleted_v3>*16);
depthin(<contenttweaker:charged_fuel_v4>,100,200,8,<contenttweaker:energized_fuel_depleted_v4>*16);
depthin(<contenttweaker:charged_fuel_v5>,200,200,9,<contenttweaker:dust>*64);
RecipeBuilder.newBuilder("hellplanet_input","asteroid_reactor",400)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var get_planet = data.getInt("get_planet",0);
        if(get_planet != 0){
            event.setFailed("当前已锚定热域行星");
        }
     })
     .addInputs(<contenttweaker:hellplanet>)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["get_planet"]=1;
        map["completeness"]=100.0f;
        ctrl.customData = data;
     })
     .addRecipeTooltip("锁定一颗§c热域行星")
     .addRecipeTooltip("只能同时锁定一颗行星")
     .setThreadName("行星锁定系统")
     .build();
RecipeBuilder.newBuilder("energy_output","asteroid_reactor",200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var get_planet =data.getInt("get_planet");
      var depth = data.getInt("depth");
      var hellplanet_complete = data.getInt("hellplanet_complete",0);
      if(get_planet == 0){
         event.setFailed("暂未锚定热域行星");
      }
      if(depth < 1000){
         event.setFailed("未达到最低发电深度");
      }
      if(hellplanet_complete == 1){
         event.setFailed("正在解除锚定");
      }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var depth = data.getInt("depth",0);
      var count = (depth / 1000) as float;
      val Thread = event.factoryRecipeThread.addRecipe("energy_output");
      Thread.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:energy", "output",count, 1, false).build());
      Thread.addModifier("multiple_instance",RecipeModifierBuilder.create("modularmachinery:item","output",count,1,false).build());
      Thread.addModifier("multiple_instance",RecipeModifierBuilder.create("modularmachinery:fluid","output",count,1,false).build());
    })
    .addOutput(<contenttweaker:skydust>*2560)
    .addOutput(<contenttweaker:degenerationmatter>*3640)
    .addOutput(<contenttweaker:dust>*128).setChance(0.4)
    .addFluidOutput(<liquid:plasma>*50000)
    .addEnergyPerTickOutput(100000000000)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      var completeness = data.getFloat("completeness",0.0f);
      var depth = data.getInt("depth",0);
      var costlevel = depth/1000;
      if(completeness > 0.0f){
         completeness -= ctrl.world.random.nextFloat(0.5,0.5*costlevel);
         if(completeness < 0.0f){
            completeness = 0.0f;
         map["hellplanet_complete"]=1;
         }
      }else{
         completeness = 0.0f;
         map["hellplanet_complete"]=1;
      }
      map["completeness"]=completeness;
      ctrl.customData = data;
    })
    .addRecipeTooltip("§c深入热域行星的深处")
    .addRecipeTooltip("深度大于§a1000§fkm时开始发电,同时产出行星物质")
    .addRecipeTooltip("每深入§a1000§fkm额外提供§b100G/tick§f发电")
    .addRecipeTooltip("同时提供物质的额外一倍产出")
    .addRecipeTooltip("但是行星的§c稳定度§f开始加快减少")
    .addRecipeTooltip("每次完成配方稳定度减少§c(0.5,0.5*钻探深度/1000)")
    .setThreadName("重核元素衰变能量井")
    .build();
RecipeBuilder.newBuilder("spacematrix_forge","asteroid_reactor",600,4)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var get_planet = data.getInt("get_planet",0);
      var depth = data.getInt("depth",0);
      if(get_planet == 0){
         event.setFailed("暂未锚定热域行星");
      }
      if(depth < 2000){
         event.setFailed("未达到最低熔炼深度");
      }
      if(depth >= 2000){
         event.activeRecipe.maxParallelism = depth/100;
      }
   })
   .addInputs([
      <avaritia:resource:6>,
      <minecraft:nether_star>*100,
      <extendedcrafting:material>*768,
      <avaritia:resource:4>*16,
      <contenttweaker:degenerationmatter>*968,
   ])
   .addOutputs(<contenttweaker:spacematrix_ingot>)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var completeness = data.getFloat("completeness",0.0f);
      val map = data.asMap();
      completeness -= 0.1f*event.activeRecipe.parallelism;
      map["completeness"]=completeness;
      ctrl.customData = data;
   })
   .setThreadName("极点熔煅")
   .addRecipeTooltip("用行星内核的§4极端压力§f将铁原子核与中子压入无尽之锭中")
   .addRecipeTooltip("制造一种足以承受行星级别应力的§e特殊合金")
   .addRecipeTooltip("深度大于等于§c2000§fkm时可执行")
   .addRecipeTooltip("该配方的并行为§b钻探深度/§a100")
   .addRecipeTooltip("每完成一次配方消耗§c0.1§f行星稳定度")
   .build();
RecipeBuilder.newBuilder("superconidiosome_forge","asteroid_reactor",400,4)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var get_planet = data.getInt("get_planet",0);
      var depth = data.getInt("depth",0);
      if(get_planet == 0){
         event.setFailed("暂未锚定热域行星");
      }
      if(depth < 2000){
         event.setFailed("未达到最低熔炼深度");
      }
      if(depth >= 2000){
         event.activeRecipe.maxParallelism = depth/100;
      }
   })
   .addInputs([
      <contenttweaker:carbon_nanotube>*96,
      <ic2:crafting:3>*128,
      <mets:superconducting_cable>*54,
      <gravisuite:crafting:1>*108,
      <mets:niobium_titanium_ingot>
   ])
   .addOutputs(<contenttweaker:superconidiosome>)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var completeness = data.getFloat("completeness",0.0f);
      val map = data.asMap();
      completeness -= 0.1f*event.activeRecipe.parallelism;
      map["completeness"]=completeness;
      ctrl.customData = data;
   })
   .setThreadName("极点熔煅")
   .addRecipeTooltip("在行星的强约束磁场中制造一种特殊的§b超导材料")
   .addRecipeTooltip("深度大于等于§c2000§fkm时可执行")
   .addRecipeTooltip("该配方的并行为§b钻探深度/§a100")
   .addRecipeTooltip("每完成一次配方消耗§c0.1§f行星稳定度")
   .build();
RecipeBuilder.newBuilder("nanoporcelain_forge","asteroid_reactor",1000,4)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var get_planet = data.getInt("get_planet",0);
      var depth = data.getInt("depth",0);
      if(get_planet == 0){
         event.setFailed("暂未锚定热域行星");
      }
      if(depth < 4000){
         event.setFailed("未达到最低熔炼深度");
      }
      if(depth >= 4000){
         event.activeRecipe.maxParallelism = depth/100;
      }
   })
   .addInputs([
      <tconevo:metal:13>,
      <contenttweaker:cfcm>*128,
      <contenttweaker:nanoswarm>*1
   ])
   .addOutputs(<contenttweaker:nanoglassmetal>)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var completeness = data.getFloat("completeness",0.0f);
      val map = data.asMap();
      completeness -= 0.1f*event.activeRecipe.parallelism;
      map["completeness"]=completeness;
      ctrl.customData = data;
   })
   .setThreadName("极点熔煅")
   .addRecipeTooltip("在金属母体上引入纳米级纤维")
   .addRecipeTooltip("深度大于等于§c4000§fkm时可执行")
   .addRecipeTooltip("该配方的并行为§b钻探深度/§a100")
   .addRecipeTooltip("每完成一次配方消耗§c0.1§f行星稳定度")
   .build();
   RecipeBuilder.newBuilder("output_dust","asteroid_reactor",40,5)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var get_planet = data.getInt("get_planet",0);
      var hellplanet_complete = data.getInt("hellplanet_complete",0);
      if(get_planet == 0){
         event.setFailed("暂未锚定热域行星");
      }
      if(get_planet == 1 && hellplanet_complete == 0){
         event.setFailed("正在收集...");
      }
   })
   .addOutput(<contenttweaker:dust>*276)
   .addOutput(<contenttweaker:neutrondustingot>*76)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      var hellplanet_complete = data.getInt("hellplanet_complete",0);
      val map = data.asMap();
      map["hellplanet_complete"]=0;
      map["get_planet"]=0;
      ctrl.customData = data;
   })
   .addRecipeTooltip("从热域行星的§7残骸§f中获取一种残留着§4高温的物质")
   .addRecipeTooltip("当§a反应§f完一颗热域行星时执行")
   .setThreadName("残骸解压单元")
   .build();
MMEvents.onControllerGUIRender("asteroid_reactor",function(event as ControllerGUIRenderEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var get_planet = data.getInt("get_planet",0);
   var depth = data.getInt("depth",0);
   var completeness = data.getFloat("completeness",0.0f);
   var info as string [] = [];
   if(get_planet == 0){
      info += "§4§l尚未锚定热域行星";
   }
   if(get_planet != 0){
      info += "当前钻探深度:§6"+depth;
      info += "当前行星稳定度:"+completeness;
      info += "§c请在机器顶部的§4智能数据接口§c中指定深度";
   }
   event.extraInfo = info;
});



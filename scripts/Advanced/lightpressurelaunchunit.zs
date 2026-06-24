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
MachineModifier.setMaxThreads("lightpressurelaunchunit",0);
MachineModifier.addCoreThread("lightpressurelaunchunit",FactoryRecipeThread.createCoreThread("单元装载"));
MachineModifier.addCoreThread("lightpressurelaunchunit",FactoryRecipeThread.createCoreThread("发射航道"));
MachineModifier.addCoreThread("lightpressurelaunchunit",FactoryRecipeThread.createCoreThread("远航信标同步装置"));
MachineModifier.addCoreThread("lightpressurelaunchunit",FactoryRecipeThread.createCoreThread("返回单元接驳"));

RecipeBuilder.newBuilder("unit_load","lightpressurelaunchunit",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val is_launch = data.getInt("is_launch",0);
    val is_unload = data.getInt("is_unload",0);
    if(is_launch == 1){
        event.setFailed("单元已发射");
    }else if(is_launch == 0 && is_unload == 1){
        event.setFailed("正在回收返回单元");
    }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   map["is_back"]=0;
   map["distance"]=0;
   ctrl.customData = data;
 })
 .addFluidInputs([
    <liquid:liquid_energy>*1000,
 ])
 .addInputs([
    <contenttweaker:lightplatform>,
    <super_solar_panels:crafting:34>*18,
 ])
 .addEnergyPerTickInput(10000000)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var unit_count = data.getInt("unit_count",0);
    unit_count+=1;
    map["unit_count"]=unit_count;
    map["is_launch"]=0;
    ctrl.customData = data;
 })
 .addRecipeTooltip("为发射区装载§e光驱单元")
 .addRecipeTooltip("每添加§91台§e光驱单元,将会增加§a1倍§f的光子消耗")
 .addRecipeTooltip("相应的产出也会增加§a10倍")
 .setThreadName("单元装载")
 .build();

RecipeBuilder.newBuilder("unit_launch_start","lightpressurelaunchunit",40,2)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val is_launch = data.getInt("is_launch",0);
   val is_unload = data.getInt("is_unload",0);
   val unit_count = data.getInt("unit_count",0);
   if(is_launch == 1){
      event.setFailed("单元已发射");
   }else if(is_launch == 0 && is_unload == 1){
      event.setFailed("正在回收返回单元");
   }else if(is_launch == 0 && is_unload == 0 && unit_count <= 0){
      event.setFailed("尚未装载单元");
   }
 })
.addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   val unit_count = data.getInt("unit_count",0);
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("unit_mult",RecipeModifierBuilder.create("modularmachinery:item","input",unit_count,1,false).build());
})
.addEnergyPerTickInput(1000000)
.addInputs([
   <contenttweaker:ljgz>*128,
   <contenttweaker:tyf1>*16,
])
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   val thread = event.factoryRecipeThread;
   thread.removePermanentModifier("unit_mult");
   map["is_launch"]=1;
   ctrl.customData = data;
})
.addRecipeTooltip("发射所有§a已装载§f的§e光驱单元")
.addRecipeTooltip("每多装载§91§f台§e光驱单元§f,所需要的§9物质§f加§a1§f倍")
.setThreadName("发射航道")
.build();

RecipeBuilder.newBuilder("traveling","lightpressurelaunchunit",20,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val is_launch = data.getInt("is_launch",0);
   val is_unload = data.getInt("is_unload",0);
   val is_back = data.getInt("is_back",0);
   if(is_launch == 0){
      event.setFailed("光驱单元未发射");
   }
   if(is_launch == 0 && is_unload == 1){
      event.setFailed("正在回收返回单元");
   }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   val unit_count = data.getFloat("unit_count",0);
   val acc_count = data.getInt("acc_count",0);
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("cost",RecipeModifierBuilder.create("modularmachinery:item","input",(unit_count+acc_count)*1.0,1,false).build());
   ctrl.customData = data;
 })
 .addInputs([
   <contenttweaker:ljgz>*50
 ])
 .addEnergyPerTickInput(10000000)
 .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   var distance = data.getInt("distance",0);
   distance+=40;
   map["distance"]=distance;
   ctrl.customData = data;
 })
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   val distance = data.getInt("distance",0);
   val acc_count = distance/20000;
   val thread = event.factoryRecipeThread;
   thread.removePermanentModifier("cost");
   map["acc_count"]=acc_count;
   ctrl.customData = data;
 })
 .addRecipeTooltip("使用§b光子源§f持续轰击§e光驱单元")
 .addRecipeTooltip("每§ctick§f可以使得光驱单元前进§940km")
 .addRecipeTooltip("每§620000§fkm为一个§9稳定抵近区间")
 .addRecipeTooltip("完成一次§9抵近区间的航行§f时最终产出增加§a10§f倍,但每次光子消耗也增加§41倍§f")
 .addRecipeTooltip("一旦光子输入停止,§4光驱单元将会立即返航并结算产出")
 .setThreadName("远航信标同步装置")
 .build();

 RecipeBuilder.newBuilder("back_to","lightpressurelaunchunit",40,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val is_launch = data.getInt("is_launch",0);
   val is_bacak = data.getInt("is_back",0);
   val is_unload = data.getInt("is_unload",0);
   if(is_launch == 0){
      event.setFailed("光驱单元未发射");
   }else if(is_launch == 1 && is_bacak == 0){
      event.setFailed("光驱单元飞行姿态稳定");
   }
  })
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   map["is_unload"]=1;
   ctrl.customData = data;
   val unit_count = data.getInt("unit_count",0);
   val acc_count = data.getInt("acc_count",0);
   val thread = event.factoryRecipeThread;
   thread.addPermanentModifier("output_beam",RecipeModifierBuilder.create("modularmachinery:fluid","output",acc_count*10+unit_count*10,1,false).build());
   thread.addPermanentModifier("output_voidmatter",RecipeModifierBuilder.create("modularmachinery:item","output",acc_count+unit_count,1,false).build());
  })
  .addFluidOutputs([
   <liquid:dimensionbeam>*10000,
   <liquid:zerotempaturefluid>*10000
  ])
  .addOutputs([
   <contenttweaker:voidmatter>*2
  ])
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data =ctrl.customData;
   val map = data.asMap();
   val thread = event.factoryRecipeThread;
   thread.removePermanentModifier("output_beam");
   thread.removePermanentModifier("output_voidmatter");
   map["unit_count"]=0;
   map["acc_count"]=0;
   map["is_unload"]=0;
   map["is_launch"]=0;
   map["is_back"]=0;
   ctrl.customData = data;
  })
  .addRecipeTooltip("取出§9返回单元§f中的§6物质")
  .addRecipeTooltip("从时空裂隙附近获取了一种§7奇异物质")
  .addRecipeTooltip("物质的产出与跨越的§9抵近区间的数量§f有关")
  .setThreadName("返回单元接驳")
  .build();
 RecipeBuilder.newBuilder("destroy","lightpressurelaunchunit",1,5)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val is_launch = data.getInt("is_launch",0);
   if(is_launch == 0){
      event.setFailed("尚未发射光驱单元");
   }
 })
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   map["is_back"]=1;
   ctrl.customData =data;
 })
 .setThreadName("远航信标同步装置")
 .build();
MMEvents.onControllerGUIRender("lightpressurelaunchunit",function(event as ControllerGUIRenderEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val is_launch = data.getInt("is_launch",0);
   val is_unload = data.getInt("is_unload",0);
   val is_back = data.getInt("is_back",0);
   val unit_count = data.getInt("unit_count",0);
   val acc_count = data.getInt("acc_count",0);
   val mult = (acc_count + unit_count)*50;
   val distance = data.getInt("distance",0);
   val accl = (acc_count+unit_count)*10;
   var info as string [] = [];
   if(is_launch == 0){
      info += "§4尚未发射光驱单元";
      if(unit_count>0){
         info += "§e当前发射区待命设备数量:§a"+unit_count;
      }
   }
   if(is_launch == 1){
      info += "§b光驱单元已驶离空港";
      info += "§6当前距离:§b"+distance+"§6km";
      info += "当前已经过的§9抵近区间§6:"+acc_count;
      info += "当前§9每次同步光子消耗量:§b"+mult+"§6/s";
      info += "当前流体结算产出:x§a"+accl;
   }
   if(is_back == 1){
      info += "§4飞行姿态无法维持,返回单元已进入返回轨道";
   }
   event.extraInfo = info;
});
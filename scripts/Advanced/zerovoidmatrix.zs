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
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;
MachineModifier.setMaxThreads("zeromatrix",0);
MachineModifier.addCoreThread("zeromatrix",FactoryRecipeThread.createCoreThread("真空零点能反应腔"));
MachineModifier.addCoreThread("zeromatrix",FactoryRecipeThread.createCoreThread("极高压环境"));
MachineModifier.addCoreThread("zeromatrix",FactoryRecipeThread.createCoreThread("局部亚稳态希格斯场衰退"));
MachineModifier.addCoreThread("zeromatrix",FactoryRecipeThread.createCoreThread("反应堆更换").addRecipe("mode_change_1x").addRecipe("mode_change_2x"));
MMEvents.onStructureFormed("zeromatrix" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var superspace = ctrl.getBlocksInPattern(<contenttweaker:superspace_star_controlmatrix>);
    if(superspace == 1){
        map["superspace_online"]=1;
    }else{
      map["superspace_online"]=0;
    }
    map["higgs_mode"]=0;
    map["schwinger"]=1;
    map["matter_produce"]=1.0f;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("zero_energy","zeromatrix",400,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val higgs_mode = data.getInt("higgs_mode",0);
      if(higgs_mode == 1){
         event.setFailed("当前运行模式:局部亚稳态希格斯场衰退");
      }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      map["matter_produce"]=1.0;
      ctrl.customData = data;
      val Thread = event.factoryRecipeThread;
      val matter_produce = data.getFloat("matter_produce",1.0);
      Thread.addModifier("more", RecipeModifierBuilder.create("modularmachinery:item", "output",matter_produce, 1, false).build());
   })
   .addEnergyPerTickOutput(40000000000000)
   .addOutputs([
    <contenttweaker:voidmatter> *16,
    <mekanism:antimatterpellet>*64
   ])
   .addRecipeTooltip("§9极强的电场瞬间分离了涨落的正反粒子对")
   .addRecipeTooltip("在§6施温格效应电场模式§f下运行")
   .setThreadName("真空零点能反应腔")
   .build();

RecipeBuilder.newBuilder("sp_zero_energy","zeromatrix",200,2)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
     val ctrl = event.controller;
     val data = ctrl.customData;
     val superspace_online = data.getInt("superspace_online",0);
     val higgs_mode = data.getInt("higgs_mode",0);
     if(superspace_online == 0){
        event.setFailed("未检测到超时空核心反应矩阵");
     }
     if(superspace_online == 1 && higgs_mode == 1){
      event.setFailed("当前模式:局部亚稳态希格斯场衰退");
     }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      map["matter_produce"]=1.0f;
      ctrl.customData = data;
      val matter_produce = data.getInt("matter_produce",1.0);
      val Thread = event.factoryRecipeThread;
      Thread.addModifier("more", RecipeModifierBuilder.create("modularmachinery:item", "output",matter_produce, 1, false).build());
   })
   .addEnergyPerTickOutput(200000000000000)
   .addInput(<contenttweaker:lockedhellplanet>).setChance(0.2)
   .addOutputs([
    <contenttweaker:voidmatter> *32,
    <mekanism:antimatterpellet>*128,
   ])
   .addRecipeTooltip("在可控的§c类恒星环境§f内,实现更高效的§e量子过程")
   .addRecipeTooltip("需要装载§1超§9时§b空§e核心反应矩阵")
   .addRecipeTooltip("在§6施温格效应电场模式§f下运行")
   .setThreadName("极高压环境")
   .build();
RecipeBuilder.newBuilder("mode_change_1x","zeromatrix",20,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val higgs_mode = data.getInt("higgs_mode",0);
   val superspace_online = data.getInt("superspace_online",0);
   if(superspace_online == 0){
      event.setFailed("未检测到超时空核心反应矩阵");
   }
  })
  .addInput(<contenttweaker:programming_circuit_a>)
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   map["higgs_mode"]=1;
   map["schwinger"]=0;
   ctrl.customData = data;
  })
  .addRecipeTooltip("更换反应堆,切换为局部亚稳态希格斯场衰退")
  .addRecipeTooltip("需要装载§1超§9时§b空§e核心反应矩阵")
  .setThreadName("反应堆更换")
  .build();

RecipeBuilder.newBuilder("mode_change_2x","zeromatrix",20,4)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val schwinger = data.getInt("schwinger",0);
   val superspace_online = data.getInt("superspace_online",0);
   if(schwinger == 1){
      event.setFailed("当前模式:施温格效应电场");
   }
  })
  .addInput(<contenttweaker:programming_circuit_b>)
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val map = data.asMap();
   map["schwinger"]=1;
   map["higgs_mode"]=0;
   ctrl.customData = data;
  })
  .addRecipeTooltip("更换反应堆,切换为施温格效应电场")
  .setThreadName("反应堆更换")
  .build();
RecipeBuilder.newBuilder("higgs_energy","zeromatrix",100,3)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val schwinger = data.getInt("schwinger",0);
      if(schwinger == 1){
         event.setFailed("当前模式:施温格效应电场");
      }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      val superspace_online = data.getInt("superspace_online",0);
      val Thread = event.factoryRecipeThread;
      if(superspace_online == 1){
         map["matter_produce"]=4.0;
         ctrl.customData = data;
      }
      val matter_produce = data.getFloat("matter_produce",1.0);
      Thread.addModifier("more", RecipeModifierBuilder.create("modularmachinery:item", "output",matter_produce, 1, false).build());
   })
   .addFluidPerTickInput(<liquid:higgsfluid>*100)
   .addEnergyPerTickOutput(2000000000000000)
   .addOutputs([
      <contenttweaker:voidmatter>*64,
      <mekanism:antimatterpellet>*256
   ])
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      map["matter_produce"]=1.0;
      ctrl.customData = data;
   })
   .addRecipeTooltip("通过§9异常希格斯介质§f在局部真空内创造一个§c超低能§f真空泡")
   .addRecipeTooltip("极不稳定的真空泡向基态真空转变")
   .addRecipeTooltip("释放出巨量§1零点能§f和§b物质")
   .addRecipeTooltip("需要装载§1超§9时§b空§e核心反应矩阵")
   .addRecipeTooltip("物质产出倍率§ax4")
   .addRecipeTooltip("在§9局部亚稳态希格斯场衰退模式§f下运行")
   .setThreadName("局部亚稳态希格斯场衰退")
   .build();
MMEvents.onControllerGUIRender("zeromatrix",function(event as ControllerGUIRenderEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var info as string [] = [];
   val superspace_online = data.getInt("superspace_online",0);
   val higgs_mode = data.getInt("higgs_mode",0);
   val matter_produce = data.getFloat("matter_produce",1.0);
   if(superspace_online == 0){
      info += "当前未装载§1超§9时§b空§e核心反应矩阵";
   }
   if(superspace_online == 1){
      info += "当前§1超§9时§b空§e核心反应矩阵§a等级:§7恒星";
   }
   if(higgs_mode == 0){
      info += "当前运行模式:§6施温格效应电场";
   }else if(higgs_mode == 1){
      info += "当前运行模式:§9局部亚稳态希格斯场衰退";
   }
   info += "§b物质生成倍率:"+matter_produce;
   event.extraInfo = info;
});
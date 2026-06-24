#loader crafttweaker reloadable
import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import novaeng.hypernet.HyperNetHelper;
import mods.modularmachinery.SmartInterfaceType;
import crafttweaker.item.IIngredient;
var index = 0;
val MP = 1;
val MX = 512;
MachineModifier.setMaxThreads("warmatrix",0);
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("文明集群拟合-主世界"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("文明集群拟合-下界"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("文明集群拟合-末地"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("文明集群拟合-传奇"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("主世界演绎"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("下界演绎"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("末地演绎"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("传奇演绎"));
MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("数据恢复"));
MachineModifier.addSmartInterfaceType("warmatrix",
     SmartInterfaceType.create("MI",1)
     .setHeaderInfo("§9并行§f上限设置")
     .setValueInfo("当前并行:§a%.2f")
     .setJeiTooltip("输入上限：最低 §a%.0f §f,最高 §a%.0f", 2)
);
MMEvents.onMachinePostTick("warmatrix",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("MI");
    var MI = isNull(nullable) ? 1 : nullable.value;
    if(MI > MX || MI < MP){
        nullable.value=1;
    }
    map["MI"]= MI;
    ctrl.customData = data;
});
for items in loadedMods["deepmoblearning"].items{
    val id = items.definition.id;
    if(id.startsWith("deepmoblearning:data_model_")&&!id.endsWith("blank")){
        val model_name = id.substring(27);
        MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("模型演化模块#"+index).addRecipe("warmatrix_evolve"+model_name));
        MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("模型导入模块#"+index).addRecipe("warmatrix_integrate"+model_name));
        MachineModifier.addCoreThread("warmatrix",FactoryRecipeThread.createCoreThread("模型聚合模块#"+index).addRecipe("warmatrix_create"+model_name));
        RecipeBuilder.newBuilder("warmatrix_evolve"+model_name,"warmatrix",100)
        .addInputs(items).setTag("left2")
        .addEnergyPerTickInput(1000000)
        .addInputs([
            <contenttweaker:hypernet_gpu_t2>,
            <contenttweaker:hypernet_ram_t3>,
            <liquid:lifeessence>*3688,
        ])
        .addOutput(items.withTag({tier:4})).setTag("right2")
        .setThreadName("模型演化模块#"+index)
        .addRecipeTooltip("通过§b算力元件§f进行§9快速演算§f,将模型提升至§6自我意识§f等级")
        .addRecipeTooltip("在左2仓室输入,右2仓室输出")
        .build();
        RecipeBuilder.newBuilder("warmatrix_integrate"+model_name,"warmatrix",1)
        .addEnergyPerTickInput(100000)
        .addInputs(items.withTag({tier:4})).setTag("left2")
        .addOutputs(items.withTag({tier:0})).setTag("right2")
        .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
          val ctrl = event.controller;
          val data = ctrl.customData;
          val map = data.asMap();
          var count_temp = data.getInt("count"+model_name,0);
          count_temp += 1;
          map["count"+model_name]=count_temp;
          if(model_name == "creeper"||model_name == "spider"||model_name == "zombie"||model_name=="guardian"||model_name=="tinker_slime"||model_name=="slime"||model_name=="skeleton"||model_name == "witch"||model_name=="thermal_elemental"){
            var overworld_group = data.getInt("overworld_group",0);
            overworld_group += 1;
            map["overworld_group"]=overworld_group;
            ctrl.customData = data;
          }else if(model_name == "blaze"||model_name == "ghast"||model_name == "wither_skeleton"){
            var hell_group = data.getInt("hell_group",0);
            hell_group += 1;
            map["hell_group"]=hell_group;
            ctrl.customData = data;
          }else if(model_name == "enderman"||model_name == "shulker"){
            var ender_group = data.getInt("ender_group",0);
            ender_group += 1;
            map["ender_group"]=ender_group;
            ctrl.customData = data;
          }else if(model_name == "dragon"||model_name == "wither"||model_name == "chaosguardian"||model_name=="glitch"){
            var legend_group = data.getInt("legend_group",0);
            legend_group += 1;
            map["legend_group"]=legend_group;
            ctrl.customData = data;
          }
          ctrl.customData = data;
        })
        .setThreadName("模型导入模块#"+index)
        .addRecipeTooltip("将§9自我意识模型§F导入§9矩阵演算机")
        .addRecipeTooltip("每输入一个§e相关模型§f都会使得该模型的对应产出翻§a1§f倍")
        .addRecipeTooltip("同时为所在的§e文明集群§f提供§a1§f点生物数据")
        .addRecipeTooltip("每§91§f点生物数据为模型产出翻§a1§f倍")
        .addRecipeTooltip("每§91§f点生物数据为世界产出翻§a1§f倍")
        .addRecipeTooltip("§5末影龙§f,§7凋灵§f,§4混沌守卫§f,§b系统故障§f均独立算为一个集群")
        .addRecipeTooltip("在左2仓室输入,右2仓室输出")
        .build();
        RecipeBuilder.newBuilder("warmatrix_create"+model_name,"warmatrix",40)
        .addPreCheckHandler(function(event as RecipeCheckEvent){
          val ctrl = event.controller;
          val data = ctrl.customData;
          var count_temp = data.getInt("count"+model_name,0);
          val MI = data.getInt("MI",1);
          if(count_temp <= 0){
            event.setFailed("未找到战争集群");
          }
          event.activeRecipe.maxParallelism = MI;
        })
         .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
          val ctrl = event.controller;
          val data = ctrl.customData;
          val map = data.asMap();
          val thread = event.factoryRecipeThread;
          var count_entity = data.getFloat("count"+model_name,1.0);
          var count_group = 0.0f;
          var count_world = 0.0f;
          if(model_name == "creeper"||model_name == "spider"||model_name == "zombie"||model_name=="guardian"||model_name=="tinker_slime"||model_name=="slime"||model_name=="skeleton"||model_name == "witch"||model_name=="thermal_elemental"){
            count_group = data.getFloat("overworld_group",0.0);
            count_world = data.getFloat("overworld_level",0.0);
          }else if(model_name == "blaze"||model_name == "ghast"||model_name == "wither_skeleton"){
            count_group = data.getFloat("hell_group",0.0);
            count_world = data.getFloat("hell_level",0.0);
          }else if(model_name == "enderman"||model_name == "shulker"){
            count_group = data.getFloat("ender_group",0.0);
            count_world = data.getFloat("ender_level",0.0);
          }else if(model_name == "dragon"||model_name == "wither"||model_name == "chaosguardian"||model_name=="glitch"){
            count_group = data.getFloat("legend_group",0.0);
            count_world = data.getFloat("legend_level",0.0);
          }
          thread.addPermanentModifier("multipleX",RecipeModifierBuilder.create("modularmachinery:item","output",count_entity+count_group+count_world,1,false).build());
         })
         .addInput(<deepmoblearning:polymer_clay>).setTag("left1")
         .addEnergyPerTickInput(100)
         .addOutput(<item:deepmoblearning:pristine_matter_${model_name}>*64).setTag("right1")
         .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
          val ctrl = event.controller;
          val data = ctrl.customData;
          val map = data.asMap();
          val thread = event.factoryRecipeThread;
          thread.removePermanentModifier("multipleX");
         })
         .setThreadName("模型聚合模块#"+index)
         .addRecipeTooltip("通过输入的模型数据进行§9物质演算")
         .addRecipeTooltip("其产出乘数为:§e文明集群原始数据§9+§a模型载入数量§9+§a生物数据")
         .addRecipeTooltip("输入的聚合粘土将被均分至各个模拟线程")
         .addRecipeTooltip("该配方的并行上限为512")
         .addRecipeTooltip("§9在智能数据接口处调整并行上限")
         .addRecipeTooltip("在左1仓室输入,在右1仓室输出")
         .build();
        index+=1;
    }
}
RecipeBuilder.newBuilder("overworld_organize","warmatrix",100)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 100;
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:normalplanet>*1,
    <minecraft:grass>*64,
    <minecraft:sapling>*16,
  ])
  .addFluidInput(<liquid:water>*10000)
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var overworld_level = data.getInt("overworld_level",0);
    val bxcount = event.activeRecipe.parallelism;
    overworld_level += bxcount;
    map["overworld_level"]=overworld_level;
    ctrl.customData = data;
  })
  .setThreadName("文明集群拟合-主世界")
  .addRecipeTooltip("为§a主世界§b文明§f集群提供§9原始数据")
  .addRecipeTooltip("每完成一次配方增加§a1§f点§9原型数据")
  .addRecipeTooltip("每§a1§f点§9原型数据§f可提供§a1倍§f产出")
  .addRecipeTooltip("该配方拥有100的并行上限")
  .addRecipeTooltip("当原始数据大于10时开放对应的演绎线程")
  .build();

RecipeBuilder.newBuilder("hell_organize","warmatrix",100)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 100;
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:hellplanet>*1,
    <minecraft:magma>*64,
    <minecraft:magma_cream>*16,
  ])
  .addFluidInput(<liquid:lava>*10000)
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var hell_level = data.getInt("hell_level",0);
    val bxcount = event.activeRecipe.parallelism;
    hell_level += bxcount;
    map["hell_level"]=hell_level;
    ctrl.customData = data;
  })
  .setThreadName("文明集群拟合-下界")
  .addRecipeTooltip("为§c下界§6文明§f集群提供§4原始数据")
  .addRecipeTooltip("每完成一次配方增加§c1§f点§4原型数据")
  .addRecipeTooltip("每§c1§f点§4原型数据§f可提供§c1倍§f产出")
  .addRecipeTooltip("该配方拥有100的并行上限")
  .addRecipeTooltip("当原始数据大于10时开放对应的演绎线程")
  .build();

  RecipeBuilder.newBuilder("lengend_organize","warmatrix",100)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 100;
  })
  .addEnergyPerTickInput(10000000)
  .addIngredientArrayInput(IngredientArrayBuilder.newBuilder().addIngredients([<contenttweaker:shingplanet>,<contenttweaker:orichalcosplanet>,<contenttweaker:infinityplanet>]))
  .addInputs([
    <minecraft:nether_star>*100,
    <deepmoblearning:glitch_heart>*16,
    <draconicevolution:chaos_shard>*16
  ])
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var legend_level = data.getInt("legend_level",0);
    val bxcount = event.activeRecipe.parallelism;
    legend_level += bxcount;
    map["legend_level"]=legend_level;
    ctrl.customData = data;
  })
  .setThreadName("文明集群拟合-传奇")
  .addRecipeTooltip("为§d传奇§1文明§f集群提供§5原始数据")
  .addRecipeTooltip("每完成一次配方增加§d1§f点§5原型数据")
  .addRecipeTooltip("每§d1§f点§5原型数据§f可提供§d1倍§f产出")
  .addRecipeTooltip("该配方拥有100的并行上限")
  .addRecipeTooltip("当原始数据大于10时开放对应的演绎线程")
  .build();

RecipeBuilder.newBuilder("ender_organize","warmatrix",100)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 100;
  })
  .addEnergyPerTickInput(10000000)
  .addInputs([
    <contenttweaker:enderplanet>*1,
    <minecraft:end_stone>*64,
    <minecraft:chorus_fruit>*16,
  ])
  .addFluidInput(<liquid:ender>*10000)
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var ender_level = data.getInt("ender_level",0);
    val bxcount = event.activeRecipe.parallelism;
    ender_level += bxcount;
    map["ender_level"]=ender_level;
    ctrl.customData = data;
  })
  .setThreadName("文明集群拟合-末地")
  .addRecipeTooltip("为§5末地§d文明§f集群提供§9原始数据")
  .addRecipeTooltip("每完成一次配方增加§a1§f点§9原型数据")
  .addRecipeTooltip("每§a1§f点§9原型数据§f可提供§a1倍§f产出")
  .addRecipeTooltip("该配方拥有100的并行上限")
  .addRecipeTooltip("当原始数据大于10时开放对应的演绎线程")
  .build();

RecipeBuilder.newBuilder("warmatrix_overworld","warmatrix",40)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  var overworld_level = data.getInt("overworld_level",0);
  if(overworld_level < 10){
    event.setFailed("未达到最低文明集群拟合");
  }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  val overworld_level = data.getInt("overworld_level",0);
  val overworld_group = data.getInt("overworld_group",0);
  val thread = event.factoryRecipeThread;
  thread.addPermanentModifier("multiple_overworld",RecipeModifierBuilder.create("modularmachinery:item","output",overworld_group+overworld_level,1,false).build());
   thread.addPermanentModifier("multiple_overworldx",RecipeModifierBuilder.create("modularmachinery:fluid","output",overworld_group+overworld_level,1,false).build());
 })
 .addInput(<contenttweaker:wisecore>).setChance(0).setParallelizeUnaffected(true).setTag("left3")
 .addFluidInput(<liquid:ic2uu_matter>*20)
 .addOutputs([
  <deepmoblearning:living_matter_overworldian>*512,
  <minecraft:gunpowder>*128,
  <minecraft:bone>*128,
  <minecraft:rotten_flesh>*128,
  <minecraft:string>*128,
  <minecraft:glowstone_dust>*128,
  <minecraft:redstone>*128,
  <minecraft:sugar>*128,
  <minecraft:spider_eye>*128,
  <minecraft:prismarine_shard>*128,
  <minecraft:prismarine_crystals>*128,
  <minecraft:slime_ball>*128,
  <minecraft:skull>*64,
  <minecraft:skull:2>*64,
  <minecraft:skull:4>*64,
  <liquid:lifeessence>*10000
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val thread = event.factoryRecipeThread;
  thread.removePermanentModifier("multiple_overworld");
  thread.removePermanentModifier("multiple_overworldx");
 })
 .setThreadName("主世界演绎")
 .addRecipeTooltip("调用智慧核心的算力对数据进行推演")
 .addRecipeTooltip("产出主世界物质")
 .addRecipeTooltip("其产出乘数为:§e文明集群原始数据§9+§a生物数据")
 .addRecipeTooltip("§9智慧核心§f在左3仓室输入")
 .build();

 RecipeBuilder.newBuilder("warmatrix_hell","warmatrix",40)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  var hell_level = data.getInt("hell_level",0);
  if(hell_level < 10){
    event.setFailed("未达到最低文明集群拟合");
  }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  val hell_level = data.getInt("hell_level",0);
  val hell_group = data.getInt("hell_group",0);
  val thread = event.factoryRecipeThread;
  thread.addPermanentModifier("multiple_hell",RecipeModifierBuilder.create("modularmachinery:item","output",hell_group+hell_level,1,false).build());
   thread.addPermanentModifier("multiple_hellx",RecipeModifierBuilder.create("modularmachinery:fluid","output",hell_group+hell_level,1,false).build());
 })
 .addInput(<contenttweaker:wisecore>).setChance(0).setParallelizeUnaffected(true).setTag("left3")
 .addFluidInput(<liquid:ic2uu_matter>*20)
 .addOutputs([
  <deepmoblearning:living_matter_hellish>*512,
  <minecraft:blaze_rod>*128,
  <minecraft:ghast_tear>*128,
  <minecraft:skull:1>*64,
  <liquid:lifeessence>*1000
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val thread = event.factoryRecipeThread;
  thread.removePermanentModifier("multiple_hell");
  thread.removePermanentModifier("multiple_hellx");
 })
 .setThreadName("下界演绎")
 .addRecipeTooltip("调用智慧核心的算力对数据进行推演")
 .addRecipeTooltip("产出地狱物质")
 .addRecipeTooltip("其产出乘数为:§e文明集群原始数据§9+§a生物数据")
 .addRecipeTooltip("§9智慧核心§f在左3仓室输入")
 .build();

 RecipeBuilder.newBuilder("warmatrix_ender","warmatrix",40)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  var ender_level = data.getInt("ender_level",0);
  if(ender_level < 10){
    event.setFailed("未达到最低文明集群拟合");
  }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  val ender_level = data.getInt("ender_level",0);
  val ender_group = data.getInt("ender_group",0);
  val thread = event.factoryRecipeThread;
  thread.addPermanentModifier("multiple_ender",RecipeModifierBuilder.create("modularmachinery:item","output",ender_group+ender_level,1,false).build());
  thread.addPermanentModifier("multiple_enderx",RecipeModifierBuilder.create("modularmachinery:fluid","output",ender_group+ender_level,1,false).build());
 })
 .addInput(<contenttweaker:wisecore>).setChance(0).setParallelizeUnaffected(true).setTag("left3")
 .addFluidInput(<liquid:ic2uu_matter>*20)
 .addOutputs([
  <deepmoblearning:living_matter_extraterrestrial>*512,
  <minecraft:ender_pearl>*128,
  <minecraft:shulker_shell>*128,
  <enderio:block_enderman_skull>*64,
  <minecraft:chorus_fruit>*128,
  <minecraft:end_crystal>*16,
  <minecraft:end_stone>*256,
  <liquid:lifeessence>*1000
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val thread = event.factoryRecipeThread;
  thread.removePermanentModifier("multiple_ender");
  thread.removePermanentModifier("multiple_enderx");
 })
 .setThreadName("末地演绎")
 .addRecipeTooltip("调用智慧核心的算力对数据进行推演")
 .addRecipeTooltip("产出末地物质")
 .addRecipeTooltip("其产出乘数为:§e文明集群原始数据§9+§a生物数据")
 .addRecipeTooltip("§9智慧核心§f在左3仓室输入")
 .build();

  RecipeBuilder.newBuilder("warmatrix_legend","warmatrix",40)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  var legend_level = data.getInt("legend_level",0);
  if(legend_level < 10){
    event.setFailed("未达到最低文明集群拟合");
  }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  val legend_level = data.getInt("legend_level",0);
  val legend_group = data.getInt("legend_group",0);
  val thread = event.factoryRecipeThread;
  thread.addPermanentModifier("multiple_legend",RecipeModifierBuilder.create("modularmachinery:item","output",legend_group+legend_level,1,false).build());
  thread.addPermanentModifier("multiple_legendx",RecipeModifierBuilder.create("modularmachinery:fluid","output",legend_group+legend_level,1,false).build());
 })
 .addInput(<contenttweaker:wisecore>).setChance(0).setParallelizeUnaffected(true).setTag("left3")
 .addFluidInput(<liquid:ic2uu_matter>*20)
 .addOutputs([
  <deepmoblearning:living_matter_legend>*128,
  <minecraft:nether_star>*256,
  <deepmoblearning:glitch_heart>*256,
  <draconicevolution:chaos_shard>*64,
  <contenttweaker:hxs>*16,
  <minecraft:dragon_egg>*8,
  <liquid:lifeessence>*1000
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val thread = event.factoryRecipeThread;
  thread.removePermanentModifier("multiple_legend");
  thread.removePermanentModifier("multiple_legendx");
 })
 .setThreadName("传奇演绎")
 .addRecipeTooltip("调用智慧核心的算力对数据进行推演")
 .addRecipeTooltip("产出传奇稀有物质")
 .addRecipeTooltip("其产出乘数为:§e文明集群原始数据§9+§a生物数据")
 .addRecipeTooltip("§9智慧核心§f在左3仓室输入")
 .build();
RecipeBuilder.newBuilder("upgrade_omg_wm","warmatrix",100,1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val is_upgrade = data.getInt("is_upgrade",0);
  if(is_upgrade == 1){
    event.setFailed("不要贪心");
  }
})
 .addInputs(<contenttweaker:warmatrix_terminal>)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  map["overworld_level"] = 500;
map["ender_level"] = 500;
map["hell_level"] = 500;
map["legend_level"] = 500;
map["countcreeper"] = 100;
map["overworld_group"]=900;
map["hell_group"]=300;
map["ender_group"]=200;
map["legend_group"]=400;
map["countspider"] = 100;
map["countzombie"] = 100;
map["countguardian"] = 100;
map["counttinker_slime"] = 100;
map["countslime"] = 100;
map["countskeleton"] = 100;
map["countwitch"] = 100;
map["countthermal_elemental"] = 100;
map["countblaze"] = 100;
map["countghast"] = 100;
map["countwither_skeleton"] = 100;
map["countenderman"] = 100;
map["countshulker"] = 100;
map["countdragon"] = 100;
map["countwither"] = 100;
map["countchaosguardian"] = 100;
map["countglitch"] = 100;
map["is_upgrade"]=1;
ctrl.customData = data;
 })
.addRecipeTooltip("数据还原")
.addRecipeTooltip("这是一个用于恢复数据的最终手段")
.addRecipeTooltip("无条件将文明集群等级提升500,各个模型装载提升100")
.addRecipeTooltip("只能使用一次!")
.setThreadName("数据恢复")
.build();
MMEvents.onControllerGUIRender("warmatrix", function(event as ControllerGUIRenderEvent){
  val ctrl  = event.controller;
  val data = ctrl.customData;
  val overworld_group = data.getInt("overworld_group",0);
  val overworld_level = data.getInt("overworld_level",0);
  val ender_group = data.getInt("ender_group",0);
  val ender_level = data.getInt("ender_level",0);
  val hell_group = data.getInt("hell_group",0);
  val hell_level = data.getInt("hell_level",0);
  val legend_group = data.getInt("legend_group",0);
  val legend_level = data.getInt("legend_level",0);
  val countcreeper = data.getInt("countcreeper",0);
val countspider = data.getInt("countspider",0);
val countzombie = data.getInt("countzombie",0);
val countguardian = data.getInt("countguardian",0);
val counttinker_slime = data.getInt("counttinker_slime",0);
val countslime = data.getInt("countslime",0);
val countskeleton = data.getInt("countskeleton",0);
val countwitch = data.getInt("countwitch",0);
val countthermal_elemental = data.getInt("countthermal_elemental",0);
val countblaze = data.getInt("countblaze",0);
val countghast = data.getInt("countghast",0);
val countwither_skeleton = data.getInt("countwither_skeleton",0);
val countenderman = data.getInt("countenderman",0);
val countshulker = data.getInt("countshulker",0);
val countdragon = data.getInt("countdragon",0);
val countwither = data.getInt("countwither",0);
val countchaosguardian = data.getInt("countchaosguardian",0);
val countglitch = data.getInt("countglitch",0);
  var info as string [] = [];
  info += "§c//////////§4战争矩阵§c//////////";
  info += "§2僵尸:§6"+countzombie+"§f|"+"§7骷髅:§6"+countskeleton+"§f|"+"§4蜘蛛:§6"+countspider+"§f|"+"§a爬行者:§6"+countcreeper+"§f|";
  info += "§b守卫者:§6"+countguardian+"§f|"+"§a史莱姆:§6"+countslime+"§f|"+"§5女巫:§6"+countwitch+"§f|"+"§9蓝色史莱姆:§6"+counttinker_slime+"§f|";
  info += "§1热力元素:§6"+countthermal_elemental+"§f|"+"§6烈焰人:§6"+countblaze+"§f|"+"§7恶魂:§6"+countghast+"§f|"+"§8凋零骷髅:§6"+countwither_skeleton+"§f|";
  info += "§d末影人:§6"+countenderman+"§f|"+"§5潜影贝:§6"+countshulker+"§f|"+"§d末影龙:§6"+countdragon+"§f|"+"§7凋灵:§6"+countwither+"§f|";
  info += "§4混沌守卫:§6"+countchaosguardian+"§f|"+"§9系统故障:§6"+countglitch+"§f|";
  info += "§a世界§b原始数据:§6"+overworld_level+"§f|§b模型装载量:§6"+overworld_group+"§f|";
  info += "§4下界§c原始数据:§6"+hell_level+"§f|§b模型装载量:§6"+hell_group+"§f|";
  info += "§5末地§d原始数据:§6"+ender_level+"§f|§b模型装载量:§6"+ender_group+"§f|";
  info += "§c传奇§6原始数据:§6"+legend_level+"§f|§b模型装载量:§6"+legend_group+"§f|";
  event.extraInfo = info;
});
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

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

MachineModifier.setMaxThreads("mega_spaceelevator",0);
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯§2中枢§f"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§2异星矿机单元§f"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§2异星钻机单元§f"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§2异次元入侵单元§f"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§2异星装配单元§f上行链路"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#1"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#2"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#3"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#4"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#5"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#6"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#7"));
MachineModifier.addCoreThread("mega_spaceelevator", FactoryRecipeThread.createCoreThread("§9太空电梯模块§f下行链路#8"));

MMEvents.onControllerGUIRender("mega_spaceelevator",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val SE_level = data.getInt("SE_level",0);
    val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
    val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
    val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
    var info as string[]=[];
    info += "§a////////////§b太空电梯控制台§a////////////";
    info += "当前§b太空电梯§f等级 : " + SE_level;
    info += "当前§e速度§f乘数 : " + SE_time_modifier;
    info += "当前§a效率§f乘数 : " + SE_produce_modifier;
    info += "当前§c能耗§f乘数 : " + SE_energy_modifier;
    event.extraInfo = info;
});
MMEvents.onStructureFormed("mega_spaceelevator" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val SE_level = data.getInt("SE_level",0);
    map["SE_level"] = 1;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("SE_input_energy","mega_spaceelevator",100,1)
    .addEnergyPerTickInput(5120000000)
    .addRecipeTooltip("连接§a近地轨道§b通信中枢§f结构")
    .addRecipeTooltip("解锁额外的§a近地轨道§b通信中枢太空电梯§e独有配方")
    .addRecipeTooltip("同时启用§a近地轨道§b通信中枢§a效率乘数§f计算")
    .addRecipeTooltip("根据航天器数量§a减少巨构装配时间")
    .addRecipeTooltip("效率乘数=(§6航天器总数§f*§c空间站等级§f)/§a1000§f + §91")
    .setThreadName("§2异星装配单元§f上行链路")
    .build();
RecipeBuilder.newBuilder("SE_upgrade","mega_spaceelevator",360,1)
    .addEnergyPerTickInput(51200000000)
    .addInput(<contenttweaker:se_core>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",1.0);
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        map["SE_level"] = SE_level + 1;
        map["SE_time_modifier"] = SE_time_modifier * 0.5;
        map["SE_produce_modifier"] = SE_level * 1.5;
        map["SE_energy_modifier"] = SE_energy_modifier * 1.5;
        ctrl.customData = data;
    })
    .addRecipeTooltip("对§b太空电梯§f进行扩建以满足我们的需求")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .addRecipeTooltip("请重点注意§c能耗§f!!!")
    .setThreadName("§9太空电梯§2中枢§f")
    .build();
RecipeBuilder.newBuilder("SE_produce_minerals","mega_spaceelevator",4000,1)
    .addOutput(<contenttweaker:mineral> * 20)
    .addOutput(<contenttweaker:mineral> * 10).setChance(0.75)
    .addOutput(<contenttweaker:mineral> * 10).setChance(0.5)
    .addOutput(<contenttweaker:mineral> * 10).setChance(0.25)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(5120000000)
    .addRecipeTooltip("根据§b太空电梯§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .setThreadName("§2异星矿机单元§f")
    .build();
RecipeBuilder.newBuilder("SE_produce_exoticgasess","mega_spaceelevator",4000,1)
    .addOutput(<contenttweaker:exoticgases> * 20)
    .addOutput(<contenttweaker:exoticgases> * 10).setChance(0.75)
    .addOutput(<contenttweaker:exoticgases> * 10).setChance(0.5)
    .addOutput(<contenttweaker:exoticgases> * 10).setChance(0.25)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(5120000000)
    .addRecipeTooltip("根据§b太空电梯§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .setThreadName("§2异星钻机单元§f")
    .build();
RecipeBuilder.newBuilder("SE_produce_rareitems","mega_spaceelevator",8000,1)
    .addInput(<contenttweaker:dimensiontwistblock>).setChance(0)
    .addOutput(<avaritia:resource:5> * 128000)
    .addOutput(<avaritia:block_resource> * 512000)
    .addOutput(<mekanism:antimatterpellet> * 1024000)
    .addOutput(<avaritia:block_resource:2> * 256000)
    .addOutput(<eternalsingularity:eternal_singularity> * 2560)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(51200000000)
    .addRecipeTooltip("根据§b太空电梯§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .setThreadName("§2异次元入侵单元§f")
    .build();
RecipeBuilder.newBuilder("SE_produce_rarefluids","mega_spaceelevator",8000,1)
    .addInput(<contenttweaker:etherengine_upgrade>).setChance(0)
    .addOutput(<liquid:tachyonfluid> * 2000)
    .addOutput(<liquid:spaceframefluid> * 2000)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:fluid","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(51200000000)
    .addRecipeTooltip("根据§b太空电梯§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .setThreadName("§2异次元入侵单元§f")
    .build();
RecipeBuilder.newBuilder("SE_module_linker1","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos1 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,6,-1,4);
        val subctrl1 = MachineController.getControllerAt(world,subctrlpos1);
        val subdata1 = subctrl1.customData;
        val submap1 = subdata1.asMap();
        submap1["LinkValidation"] = 1;
        submap1["SE_time_modifier"] = SE_time_modifier;
        submap1["SE_produce_modifier"] = SE_produce_modifier;
        submap1["SE_energy_modifier"] = SE_energy_modifier;    
        subctrl1.customData = subdata1;
    })
    .addRecipeTooltip("链接§b太空电梯模块#1§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#1")
    .build();
RecipeBuilder.newBuilder("SE_module_linker2","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos2 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-6,-1,4);
        val subctrl2 = MachineController.getControllerAt(world,subctrlpos2);
        val subdata2 = subctrl2.customData;
        val submap2 = subdata2.asMap();
        submap2["LinkValidation"] = 1;
        submap2["SE_time_modifier"] = SE_time_modifier;
        submap2["SE_produce_modifier"] = SE_produce_modifier;
        submap2["SE_energy_modifier"] = SE_energy_modifier;
        subctrl2.customData = subdata2;
    })
    .addRecipeTooltip("链接§b太空电梯模块#2§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#2")
    .build();
RecipeBuilder.newBuilder("SE_module_linker3","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos3 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,-1,9);
        val subctrl3 = MachineController.getControllerAt(world,subctrlpos3);
        val subdata3 = subctrl3.customData;
        val submap3 = subdata3.asMap();
        submap3["LinkValidation"] = 1;
        submap3["SE_time_modifier"] = SE_time_modifier;
        submap3["SE_produce_modifier"] = SE_produce_modifier;
        submap3["SE_energy_modifier"] = SE_energy_modifier;
        subctrl3.customData = subdata3;
    })
    .addRecipeTooltip("链接§b太空电梯模块#3§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#3")
    .build();
RecipeBuilder.newBuilder("SE_module_linker4","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos4 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,-1,9);
        val subctrl4 = MachineController.getControllerAt(world,subctrlpos4);
        val subdata4 = subctrl4.customData;
        val submap4 = subdata4.asMap();
        submap4["LinkValidation"] = 1;
        submap4["SE_time_modifier"] = SE_time_modifier;
        submap4["SE_produce_modifier"] = SE_produce_modifier;
        submap4["SE_energy_modifier"] = SE_energy_modifier;
        subctrl4.customData = subdata4;
    })
    .addRecipeTooltip("链接§b太空电梯模块#4§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#4")
    .build();
RecipeBuilder.newBuilder("SE_module_linker5","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos5 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,6,-1,2);
        val subctrl5 = MachineController.getControllerAt(world,subctrlpos5);
        val subdata5 = subctrl5.customData;
        val submap5 = subdata5.asMap();
        submap5["LinkValidation"] = 1;
        submap5["SE_time_modifier"] = SE_time_modifier;
        submap5["SE_produce_modifier"] = SE_produce_modifier;
        submap5["SE_energy_modifier"] = SE_energy_modifier;
        subctrl5.customData = subdata5;
    })
    .addRecipeTooltip("链接§b太空电梯模块#5§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#5")
    .build();
RecipeBuilder.newBuilder("SE_module_linker6","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos6 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-6,-1,2);
        val subctrl6 = MachineController.getControllerAt(world,subctrlpos6);
        val subdata6 = subctrl6.customData;
        val submap6 = subdata6.asMap();
        submap6["LinkValidation"] = 1;
        submap6["SE_time_modifier"] = SE_time_modifier;
        submap6["SE_produce_modifier"] = SE_produce_modifier;
        submap6["SE_energy_modifier"] = SE_energy_modifier;
        subctrl6.customData = subdata6;
    })
    .addRecipeTooltip("链接§b太空电梯模块#6§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#6")
    .build();
RecipeBuilder.newBuilder("SE_module_linker7","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos7 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,1,-1,-3);
        val subctrl7 = MachineController.getControllerAt(world,subctrlpos7);
        val subdata7 = subctrl7.customData;
        val submap7 = subdata7.asMap();
        submap7["LinkValidation"] = 1;
        submap7["SE_time_modifier"] = SE_time_modifier;
        submap7["SE_produce_modifier"] = SE_produce_modifier;
        submap7["SE_energy_modifier"] = SE_energy_modifier;
        subctrl7.customData = subdata7;
    })
    .addRecipeTooltip("链接§b太空电梯模块#7§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#7")
    .build();
RecipeBuilder.newBuilder("SE_module_linker8","mega_spaceelevator",20,1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val world = ctrl.world;
        val pos = ctrl.pos;
        val ifacing = ctrl.facing;
        val subctrlpos8 as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,-1,-1,-3);
        val subctrl8 = MachineController.getControllerAt(world,subctrlpos8);
        val subdata8 = subctrl8.customData;
        val submap8 = subdata8.asMap();
        submap8["LinkValidation"] = 1;
        submap8["SE_time_modifier"] = SE_time_modifier;
        submap8["SE_produce_modifier"] = SE_produce_modifier;
        submap8["SE_energy_modifier"] = SE_energy_modifier;
        subctrl8.customData = subdata8;
    })
    .addRecipeTooltip("链接§b太空电梯模块#8§f并进行§a数据同步§f")
    .setThreadName("§9太空电梯模块§f下行链路#8")
    .build();
MachineModifier.setMaxThreads("mega_spaceelevatorminemodule",0);
MachineModifier.addCoreThread("mega_spaceelevatorminemodule", FactoryRecipeThread.createCoreThread("§b太空电梯资源采集模块§f"));
MachineModifier.addCoreThread("mega_spaceelevatorminemodule", FactoryRecipeThread.createCoreThread("§1星阵§f取出单元"));
MMEvents.onControllerGUIRender("mega_spaceelevatorminemodule",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val LinkValidation = data.getInt("LinkValidation",0);
    val SE_level = data.getInt("SE_level",0);
    val SE_level_second = data.getInt("SE_level_second",0);
    val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
    val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
    val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
    val Initialization = data.getDouble("Initialization",1.0);
    var info as string[]=[];
    if(LinkValidation == 0){
        info += "§a////////////§b太空电梯资源采集模块§a////////////";
        info += "§4尚未链接太空电梯主方块!§f";
        event.extraInfo = info;
    }
    if(LinkValidation == 1){
        info += "§a////////////§b太空电梯资源采集模块§a////////////";
        info += "当前§e速度§f乘数 : " + SE_time_modifier;
        info += "当前§a效率§f乘数 : " + SE_produce_modifier;
        info += "当前§c能耗§f乘数 : " + SE_energy_modifier;
        info += "当前§1星阵§f数量 : " + SE_level + " / 16";
        info += "§7§o并行计算公式: §1§o星阵§f§o数量 ^ 2 * 160§f";
        info += "§7§o*以上数据由太空电梯主控制器等级决定§f";
        event.extraInfo = info;
    }
});
MMEvents.onStructureFormed("mega_spaceelevatorminemodule" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val LinkValidation = data.getInt("LinkValidation",0);
    val Initialization = data.getInt("Initialization",0);
    val SE_level = data.getInt("SE_level",0);
    val SE_level_second = data.getInt("SE_level_second",0);
    map["LinkValidation"] = 0;
    map["Initialization"] = 1;
    if(Initialization != 1){
        map["Initialization"] = 1;
        map["SE_level"] = 1;
        map["SE_level_second"] = 1;
    }
    ctrl.customData = data;
});
recipes.addShapeless(<contenttweaker:space_elevator_connector>,[<contenttweaker:space_elevator_structure>]);
recipes.addShaped(<modularmachinery:mega_spaceelevatorminemodule_factory_controller> * 8,[
    [<contenttweaker:spacexmachineblock>,<contenttweaker:spacexmachineblock>,<contenttweaker:spacexmachineblock>],
    [<contenttweaker:spacexmachineblock>,<contenttweaker:se_core>,<contenttweaker:spacexmachineblock>],
    [<contenttweaker:spacexmachineblock>,<contenttweaker:spacexmachineblock>,<contenttweaker:spacexmachineblock>]
]);
recipes.addShaped(<contenttweaker:space_array>,[
    [<contenttweaker:timespace_ingot>,<contenttweaker:etherengine_upgrade>,<contenttweaker:timespace_ingot>],
    [<contenttweaker:etherengine_upgrade>,<contenttweaker:novamatrix>,<contenttweaker:etherengine_upgrade>],
    [<contenttweaker:timespace_ingot>,<contenttweaker:etherengine_upgrade>,<contenttweaker:timespace_ingot>]
]);
RecipeBuilder.newBuilder("SEmm_produce_01","mega_spaceelevatorminemodule",4000,1)
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
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
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",0);
        val SE_level_second = data.getInt("SE_level_second",0);
        val LinkValidation = data.getInt("LinkValidation",0);
        if(LinkValidation == 0){
            event.setFailed("尚未链接§b太空电梯主机§f!");
        }
        event.activeRecipe.maxParallelism = SE_level * SE_level_second * 160;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("根据§b太空电梯主方块§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .addRecipeTooltip("并行计算公式: §1星阵§f数量 ^ 2 * 160")
    .setThreadName("§b太空电梯资源采集模块§f")
    .build();
RecipeBuilder.newBuilder("SEmm_produce_02","mega_spaceelevatorminemodule",4000,1)
    .addInput(<contenttweaker:advanced_programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
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
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",0);
        val SE_level_second = data.getInt("SE_level_second",0);
        val LinkValidation = data.getInt("LinkValidation",0);
        if(LinkValidation == 0){
            event.setFailed("尚未链接§b太空电梯主机§f!");
        }
        event.activeRecipe.maxParallelism = SE_level * SE_level_second * 160;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("根据§b太空电梯主方块§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .addRecipeTooltip("并行计算公式: §1星阵§f数量 ^ 2 * 160")
    .setThreadName("§b太空电梯资源采集模块§f")
    .build();
RecipeBuilder.newBuilder("SEmm_produce_03","mega_spaceelevatorminemodule",4000,1)
    .addInput(<contenttweaker:advanced_programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs([
        <liquid:dimensionbeam> * 10000,
        <liquid:zerotempaturefluid> * 50000,
        <liquid:jfh> * 10000,
        <liquid:helium_3> * 10000,
        <liquid:unsteady_plasma> * 10000,
        <liquid:xprotonfluid> * 2000,
        <liquid:plasma> * 10000,
        <contenttweaker:skydust> * 1280,
        <contenttweaker:degenerationmatter> * 512,
        <appliedenergistics2:sky_stone_block> * 1024,
        <avaritia:resource:2> * 2048,
        <contenttweaker:dust> * 1024,
        <taiga:obsidiorite_block> * 1024,
        <psi:material:1> * 1024
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",0);
        val SE_level_second = data.getInt("SE_level_second",0);
        val LinkValidation = data.getInt("LinkValidation",0);
        if(LinkValidation == 0){
            event.setFailed("尚未链接§b太空电梯主机§f!");
        }
        event.activeRecipe.maxParallelism = SE_level * SE_level_second * 160;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("根据§b太空电梯主方块§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .addRecipeTooltip("并行计算公式: §1星阵§f数量 ^ 2 * 160")
    .setThreadName("§b太空电梯资源采集模块§f")
    .build();
RecipeBuilder.newBuilder("SEmm_produce_04","mega_spaceelevatorminemodule",4000,1)
    .addInput(<contenttweaker:advanced_programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addOutputs([
        <contenttweaker:darkmatters> * 4,
        <extrabotany:material:1> * 640,
        <extrabotany:material:8> * 640,
        <extrabotany:material:5> * 640,
        <contenttweaker:weakmag> * 160,
        <contenttweaker:voidmatter> * 40
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",0);
        val SE_level_second = data.getInt("SE_level_second",0);
        val LinkValidation = data.getInt("LinkValidation",0);
        if(LinkValidation == 0){
            event.setFailed("尚未链接§b太空电梯主机§f!");
        }
        event.activeRecipe.maxParallelism = SE_level * SE_level_second * 160;
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_time_modifier = data.getDouble("SE_time_modifier",1.0);
        val SE_produce_modifier = data.getDouble("SE_produce_modifier",1.0);
        val SE_energy_modifier = data.getDouble("SE_energy_modifier",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_energy",RecipeModifierBuilder.create("modularmachinery:energy","input",SE_energy_modifier,1, false).build());
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",SE_time_modifier,1,false).build());
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SE_produce_modifier,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_energy");
        thread.removePermanentModifier("decrease_time");
        thread.removePermanentModifier("increase_product");
    })
    .addEnergyPerTickInput(1000000000)
    .addRecipeTooltip("根据§b太空电梯主方块§f等级决定产出")
    .addRecipeTooltip("具体效率计算公式如下(设§b太空电梯§f等级等级为x):")
    .addRecipeTooltip("§e速度§f乘数 = 0.5 ^ ( x - 1 )")
    .addRecipeTooltip("§a效率§f乘数 = 1.5 * x")
    .addRecipeTooltip("§c能耗§f乘数 = 1.5 ^ ( x - 1 )")
    .addRecipeTooltip("并行计算公式: §1星阵§f数量 ^ 2 * 160")
    .setThreadName("§b太空电梯资源采集模块§f")
    .build();
RecipeBuilder.newBuilder("SEmm_space_array_output","mega_spaceelevatorminemodule",20,1)
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addOutput(<contenttweaker:space_array>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",0);
        if(SE_level <= 1){
            event.setFailed("尚未输入§1星阵§f!");
        }
        event.activeRecipe.maxParallelism = 1;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SE_level = data.getInt("SE_level",1.0);
        val SE_level_second = data.getInt("SE_level_second",1.0);
        map["SE_level"] = SE_level - 1;
        map["SE_level_second"] = SE_level_second - 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输出§b太空电梯资源采集模块§f内部的§1星阵§f")
    .addRecipeTooltip("该配方不会获得并行")
    .setThreadName("§1星阵§f取出单元")
    .build();
events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val pos = event.position;
    val item = event.item;
    if(!event.world.remote && <contenttweaker:space_array>.matches(item)){
        if(block.definition.id == "modularmachinery:mega_spaceelevatorminemodule_factory_controller"){
            val player = event.player;
            val ctrl = MachineController.getControllerAt(event.world,pos);
            val data = ctrl.customData;
            val map = data.asMap();
            val SE_level = data.getInt("SE_level",1.0);
            val SE_level_second = data.getInt("SE_level_second",1.0);
            if(SE_level < 16){
                map["SE_level"] = SE_level + 1;
                map["SE_level_second"] = SE_level_second + 1;
                ctrl.customData = data;
                item.mutable().shrink(1);
            }
            if(SE_level >= 16){
                player.sendMessage("§1星阵§4数量过多!§f");
            }
            event.cancel();
        }
    }
});
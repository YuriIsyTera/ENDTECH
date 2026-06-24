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
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import novaeng.hypernet.HyperNetHelper;

MachineModifier.setMaxThreads("planetobserver", 0);
MachineModifier.addCoreThread("planetobserver", FactoryRecipeThread.createCoreThread("近地轨道信息处理阵列"));
MachineModifier.addCoreThread("planetobserver", FactoryRecipeThread.createCoreThread("行星分析模块"));
MachineModifier.addCoreThread("planetobserver", FactoryRecipeThread.createCoreThread("推进导航器"));
MachineModifier.addCoreThread("planetobserver", FactoryRecipeThread.createCoreThread("深空探测平台维护"));
MachineModifier.addCoreThread("planetobserver", FactoryRecipeThread.createCoreThread("异常天体监听"));

// 近地轨道信息处理阵列发射
RecipeBuilder.newBuilder("planetseeking", "planetobserver", 360,1)
    .addInputs([
        <modularmachinery:data_processor_t4_factory_controller> * 1,
        <advancedrocketry:satellitebuilder> * 1,
        <contenttweaker:energized_fuel_v2> * 128,
        <contenttweaker:sensor_v3> * 64,
        <contenttweaker:starmachineblock> * 128
    ])
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val solve_array = data.getInt("solve_array", 0);
        val map = data.asMap();
        map["strange_point"] = 0;
        if(solve_array == 1){
            event.setFailed("信息中控在线");
        }
    })
    .addFactoryFinishHandler(function (event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["solve_array"] = 1;
        ctrl.customData = data;
    })
    .addOutputs(<contenttweaker:energized_fuel_depleted_v2> * 128)
    .addRecipeTooltip("发射信息控制中枢")
    .addRecipeTooltip("只有当信息控制中枢§9在线§f时，才能执行其他操作")
    .addRecipeTooltip("只需要发射一次即可")
    .setThreadName("近地轨道信息处理阵列")
    .build();
//行星分析模块
RecipeBuilder.newBuilder("planetobtaining", "planetobserver", 1000, 3)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val solve_array = data.getInt("solve_array", 0);
        val computer_point = data.getInt("computer_point", 0);
        val map = data.asMap();
        if( solve_array !=1) {
            event.setFailed("信息中控离线");
        }
        if(solve_array==1&&computer_point < 200) {
            event.setFailed("中继卫星链接缺少维护单元");
        }
    })
    .addInputs(<contenttweaker:unknownplanet> * 1)
    .addEnergyPerTickInput(10000)
.addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val strange_point = data.getInt("strange_point", 0);
        val computer_point = data.getInt("computer_point", 0);
        val bonus = computer_point - 200;
        val bl = event.factoryRecipeThread;
         if(computer_point == 400 || (computer_point>400&&computer_point <600)){
            bl.addModifier("durax3",RecipeModifierBuilder.create("modularmachinery:duration", "input",0.8 , 1, false).build());
         }
         if(computer_point == 600 || (computer_point>600&&computer_point <800)){
            bl.addModifier("durax", RecipeModifierBuilder.create("modularmachinery:duration", "input",0.6, 1, false).build());
         }
         if(computer_point == 800 || (computer_point>800&&computer_point <1000)){
            bl.addModifier("durax", RecipeModifierBuilder.create("modularmachinery:duration", "input",0.4, 1, false).build());
         }
         if(computer_point == 1000){
            bl.addModifier("durax", RecipeModifierBuilder.create("modularmachinery:duration", "input",0.2, 1, false).build());
         }
    if(strange_point == 0 && ctrl.world.getRandom().nextFloat() < 0.001) {
        data.asMap()["strange_point"] = 1;
        ctrl.customData = data;
    }
})
    .addOutputs(<contenttweaker:normalplanet> * 1).setChance(0.6)
    .addOutputs(<contenttweaker:enderplanet> * 1).setChance(0.6)
    .addOutputs(<contenttweaker:hellplanet> * 1).setChance(0.6)
    .addOutputs(<contenttweaker:infinityplanet> * 1).setChance(0.1)
    .addOutputs(<contenttweaker:shingplanet> * 1).setChance(0.1)
    .addOutputs(<contenttweaker:orichalcosplanet>).setChance(0.1)
    .addRecipeTooltip("让探测阵列环绕行星，对其具体构成进行详细分析")
    .addRecipeTooltip("只有当链接维护点数大于§a200§f时，分析模块才能正常运作")
    .addRecipeTooltip("此后每§c200点§f链接维护点数可以减少§c1/5的运行时间")
    .setThreadName("行星分析模块")
    .build();
// 深空监测平台
RecipeBuilder.newBuilder("computer_point_get", "planetobserver", 1,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val solve_array = data.getInt("solve_array", 0);
        val computer_point = data.getInt("computer_point",0);
        if(solve_array != 1) {
            event.setFailed("信息中控离线");
        }
        if(computer_point >= 1000){
            event.setFailed("在线的遥感卫星已达最大值");
        }
    })
    .addInput(<contenttweaker:mk1satellite> * 1)
    .addEnergyPerTickInput(5000)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val computer_point = data.getInt("computer_point", 0);
        map["computer_point"] = computer_point + 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("向深空中发射遥感卫星组成解析行星结构的探测阵列")
    .addRecipeTooltip("每颗遥感卫星§9Mk1§f提供§c1§f点链接维护点数")
    .addRecipeTooltip("最高链接维护点数为§c1000")
    .addRecipeTooltip("需要信息中控在线")
    .setThreadName("深空探测平台维护")
    .build();

RecipeBuilder.newBuilder("computer_point_get_2", "planetobserver", 1,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val solve_array = data.getInt("solve_array", 0);
        val computer_point = data.getInt("computer_point",0);
        if(solve_array != 1) {
            event.setFailed("信息中控离线");
        }
        if(computer_point >= 1000){
            event.setFailed("在线的遥感卫星已达最大值");
        }
    })
    .addInput(<contenttweaker:mk2satellite> * 1)
    .addEnergyPerTickInput(5000)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val computer_point = data.getInt("computer_point", 0);
        map["computer_point"] = computer_point + 100;
        ctrl.customData = data;
    })
    .addRecipeTooltip("向深空中发射遥感卫星组成解析行星结构的探测阵列")
    .addRecipeTooltip("每颗遥感卫星§9Mk2§f提供§c100§f点链接维护点数")
    .addRecipeTooltip("最高链接维护点数为§c1000")
    .addRecipeTooltip("需要信息中控在线")
    .setThreadName("深空探测平台维护")
    .build();

//异常天体监听
RecipeBuilder.newBuilder("strangeplanet","planetobserver",4000,5)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val strange_point = data.getInt("strange_point",0);
        val solve_array = data.getInt("solve_array",0);
        val computer_point = data.getInt("computer_point",0);
        if(solve_array != 1){
            event.setFailed("信息中控离线");
        }
        if(solve_array == 1 && computer_point < 200){
            event.setFailed("未检测到探测平台阵列");
        }
        if(solve_array == 1 && strange_point == 0){
            event.setFailed("正在扫描异常天体");
        }
    })
    .addEnergyPerTickInput(100000)
    .addOutputs([
        <contenttweaker:nanoplanet>
    ]).setChance(0.5)
    .addOutputs([
        <contenttweaker:sparkunit>
    ]).setChance(0.8)
    .addOutputs([
        <contenttweaker:magnetplanet>
    ]).setChance(0.5)
    .addOutputs([<contenttweaker:depressplanet>]).setChance(0.1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val strange_point = data.getInt("strange_point",0);
        if(strange_point == 1){
            val temp = 0;
            data.asMap()["strange_point"]=0;
            ctrl.customData = data;
        }
    })
    .setThreadName("异常天体监听")
    .addRecipeTooltip("在行星探测模块的运作过程中")
    .addRecipeTooltip("每§ctick§f有§a0.1%§f的概率捕捉到一种异常天体信号")
    .build();
//推进导航器
RecipeBuilder.newBuilder("satellite_collapse","planetobserver",2000,4)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val solve_array = data.getInt("solve_array",0);
    val computer_point = data.getInt("computer_point",0);
      if(solve_array != 1){
        event.setFailed("信息中控离线");
      }
      if(solve_array == 1&&computer_point <= 0){
        event.setFailed("未检测到探测平台阵列");
      }
   })
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val computer_point = data.getInt("computer_point",0);
      val reduc = ctrl.world.getRandom().nextInt(10,21);
      val temp = max(0, computer_point - reduc);
      
      data.asMap()["computer_point"] = temp;
      ctrl.customData = data;
   })
   .addRecipeTooltip("§a每运行一个周期会坠毁一定数量的中继卫星")
   .setThreadName("推进导航器")
   .build();
// GUI
MMEvents.onControllerGUIRender("planetobserver", function(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val solve_array = data.getInt("solve_array", 0);
    val computer_point = data.getInt("computer_point", 0);
    val strange_point = data.getInt("strange_point",0);
    var info as string[] = [];
    
    if(solve_array != 1) {
        info += "§c信息中控离线";
    } else {
        info += "§a/////////// 深空监测平台状态同步器 ////////////";
        info += "中继卫星链接维护点数: " + computer_point + "/1000";
        
        if(computer_point >= 200) {
            if(computer_point <= 400) {
                info += "§b当前运行时间: 500s(§c-0s§b)";
                info += "§6加速等级: 无";
                info += "§7下一级加速需要: " + (400 - computer_point) + "点";
            } else if(computer_point <= 600) {
                info += "§b当前运行时间: 400s(§c-100s§b)";
                info += "§6加速等级: 1";
                info += "§7下一级加速需要: " + (600 - computer_point) + "点";
            } else if(computer_point <=800) {
                info += "§b当前运行时间: 300s(§c-200s§b)";
                info += "§6加速等级: 2";
                info += "§7下一级加速需要: " + (800 - computer_point) + "点";
            } else if(computer_point<1000){
                info += "§b当前运行时间: 200s(§c-300s§b)";
                info += "§6加速等级: 3";
                info += "§7下一级加速需要: " + (1000 - computer_point) + "点";
            }else if(computer_point == 1000){
                info+= "§b当前运行时间: 100s(§c-400s§b)";
                info += "§6★ 已达最大加速等级 ★";
            }
        } else if(computer_point > 0) {
            info += "§7运行时间: 500s";
            info += "§c需要200点以上才能启用加速";
            info += "§e还需§b" + (200 - computer_point) + "§e点启用加速";
        } else {
            info += "§7运行时间: 500s";
            info += "§c暂无维护点数，无法加速";
        }
        info += "§a///// 异常天体监听平台状态同步器 /////";
        if(strange_point == 1){
            info +="§c----------- 发现异常行星 -----------";
        }
        if(strange_point == 0 && computer_point >=200 && solve_array == 1){
            info +="§c----------- 监听阵列活跃中 -----------";
        }
        if(solve_array==1&&computer_point<200){
            info +="§c监听阵列离线";
        }
    }
    
    event.extraInfo = info;
});
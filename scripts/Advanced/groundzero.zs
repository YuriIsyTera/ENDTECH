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
var big_point_array as int [] = [];
MachineModifier.setMaxThreads("groundzero",0);
MachineModifier.addSmartInterfaceType("groundzero",
     SmartInterfaceType.create("terminal_interface",1)
     .setHeaderInfo("§9异常点§f选择设置")
     .setValueInfo("当前选择:§a%.2f")
     .setFooterInfo("§r具体范围请根据机器GUI中的异常点数量")
);
MMEvents.onMachinePostTick("groundzero",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("terminal_interface");
    var terminal_interface = isNull(nullable) ? 1 : nullable.value;
    if(terminal_interface > 12 || terminal_interface < 1){
        nullable.value=1;
    }
    map["terminal_interface"]= terminal_interface;
    ctrl.customData = data;
});
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("天体锁定"));
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("行星引力干涉阵列构建"));
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("运动观测"));
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("校正运算阵列"));
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("开采单元"));
MachineModifier.addCoreThread("groundzero", FactoryRecipeThread.createCoreThread("运行模式覆写"));

RecipeBuilder.newBuilder("planet_locked","groundzero",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  var is_locked = data.getInt("is_locked",0);
  if(is_locked == 1){
    event.setFailed("当前已锁定一颗行星");
  }
 })
 .addInputs([
  <contenttweaker:infinityplanet>,
  <contenttweaker:energized_fuel_v4>*256,
  <contenttweaker:nanoswarm>*64,
  <contenttweaker:nanites>*128
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  map["is_locked"]=1;
  map["is_locked_inf"]=1;
  val strange_point_limit = ctrl.world.random.nextInt(9,12);
  map["strange_point_limit"]=strange_point_limit;
  ctrl.customData = data;
 })
 .addRecipeTooltip("锁定一颗处在可观测周期内的§c虹§e彩§b行§a星")
 .addRecipeTooltip("每颗虹彩行星的§9异常点数量§f在§6天体锁定§f后可以被§a确定")
 .addRecipeTooltip("§4每颗行星的异常点都是固定的,不可更改")
 .addRecipeTooltip("异常点的数量范围为§6[§b9,12§6]")
 .setThreadName("天体锁定")
 .build();
RecipeBuilder.newBuilder("planet_locked_mag","groundzero",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  var is_locked = data.getInt("is_locked",0);
  if(is_locked == 1){
    event.setFailed("当前已锁定一颗行星");
  }
 })
 .addInputs([
  <contenttweaker:magnetplanet>,
  <contenttweaker:energized_fuel_v4>*512,
  <contenttweaker:nanoswarm>*128,
  <contenttweaker:nanites>*256
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  map["is_locked"]=1;
  map["is_locked_mag"]=1;
  val strange_point_limit = ctrl.world.random.nextInt(9,12);
  map["strange_point_limit"]=strange_point_limit;
  ctrl.customData = data;
 })
 .addRecipeTooltip("锁定一颗处在可观测周期内的§7弱§8磁§7行星")
 .addRecipeTooltip("每颗弱磁行星的§9异常点数量§f在§6天体锁定§f后可以被§a确定")
 .addRecipeTooltip("§4每颗行星的异常点都是固定的,不可更改")
 .addRecipeTooltip("异常点的数量范围为§6[§b9,12§6]")
 .setThreadName("天体锁定")
 .build();

 RecipeBuilder.newBuilder("locked_unit_create","groundzero",400,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val mode_cur = data.getInt("mode_cur",0);
    var is_locked = data.getInt("is_locked",0);
    var terminal_interface = data.getInt("terminal_interface",1);
    var is_active = data.getInt("is_active"+terminal_interface,0);
    if(is_locked == 0){
      event.setFailed("未锁定行星");
    }else if(is_locked == 1 && is_active == 1 && mode_cur == 2){
      event.setFailed("当前异常点已行星构建引力干涉阵列");
    }else if(is_locked == 1 && mode_cur == 1){
      event.setFailed("当前非观测模式");
    }
  })
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val recipe_level = data.getInt("recipe_level",0);
    ctrl.customData = data;
  })
  .addInputs([
    <contenttweaker:lockednormalplanet>,
    <contenttweaker:lockedhellplanet>,
    <contenttweaker:lockedenderplanet>,
    <eternalsingularity:eternal_singularity> * 2,
    <avaritia:resource:5>*2
  ])
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var recipe_level = data.getInt("recipe_level",1);
    val terminal_interface = data.getInt("terminal_interface",0);
    var mult = data.getDouble("mult",0.0);
    val thread = event.factoryRecipeThread;
    var sp1 = data.getInt("sp1",0);
    var sp2 = data.getInt("sp2",0);
    var sp3 = data.getInt("sp3",0);
    var sp4 = data.getInt("sp4",0);
    var sp5 = data.getInt("sp5",0);
    map["is_active"+terminal_interface]=1;
    ctrl.customData = data;
    var is_active1 = data.getInt("is_active"+sp1,0);
    var is_active2 = data.getInt("is_active"+sp2,0);
    var is_active3 = data.getInt("is_active"+sp3,0);
    var is_active4 = data.getInt("is_active"+sp4,0);
    var is_active5 = data.getInt("is_active"+sp5,0);
    var multipleR = data.getInt("multipleR",0);
 if(sp5 == 0){
      if(is_active1 == 1 && is_active2==1&& is_active3==1&&is_active4==1){
        mult=1.0;
        map["is_sp_full"]=1;
        ctrl.customData = data;
      }else{
        mult= pow(2,recipe_level);
      }
    }else if(sp5!=0){
        if(is_active1 == 1 && is_active2==1&& is_active3==1&&is_active4==1&&is_active5==1){
        mult=1.0;
        map["is_sp_full"]=1;
        ctrl.customData = data;
      }else{
        mult= pow(2,recipe_level);
      }
    }
    thread.addPermanentModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "input",mult, 1, false).build());
    recipe_level+=1;
    multipleR+=1;
    map["multipleR"]=multipleR;
    map["recipe_level"]=recipe_level;
    ctrl.customData=data;
  })
  .addRecipeTooltip("在相应的异常点构建§9行星引力干涉阵列")
  .addRecipeTooltip("当行星落入当前异常点时且§a存在阵列")
  .addRecipeTooltip("则按照§a已构建阵列的数量§f作为§6倍增倍数§f产出物质")
  .addRecipeTooltip("如若所有§c大概率异常点§f上已全部建立§9干涉阵列")
  .addRecipeTooltip("则其余的异常点阵列构建§e均按照标准构建阵列所消耗的物品作为基准")
  .addRecipeTooltip("其他情况则消耗的物品数量为§a2§6^§c(已构建阵列的数量)")
  .addRecipeTooltip("在§9智能数据输入端口§f处选择相应的异常点")
  .addRecipeTooltip("§c仅在观测模式下可执行")
  .setThreadName("行星引力干涉阵列构建")
  .build();

  RecipeBuilder.newBuilder("motivation_forecast","groundzero",400,3)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_locked = data.getInt("is_locked",0);
    val is_create = data.getInt("is_create",0);
    if(is_locked == 0){
      event.setFailed("未锁定行星");
    }else if(is_locked == 1 && is_create == 1){
      event.setFailed("异常点阵列已生成");
    }
  })
  .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var basic = data.getInt("basic",0);
    if(basic == 0){
        basic = ctrl.world.random.nextInt(1,4);
        map["basic"]=basic;
        map["sp1"]=basic;
        map["sp2"]=0;
        map["sp3"]=0;
        map["sp4"]=0;
        map["sp5"]=0;
        ctrl.customData = data;
    }else if(basic != 0){
        var temp = ctrl.world.random.nextInt(1,2);
        var basic = data.getInt("basic",0);
        var strange_point_limit = data.getInt("strange_point_limit",0);
        var target = basic + temp;
        var sp1 = data.getInt("sp1",0);
        var sp2 = data.getInt("sp2",0);
        var sp3 = data.getInt("sp3",0);
        var sp4 = data.getInt("sp4",0);
        var sp5 = data.getInt("sp5",0);
        if(sp1!=0 && sp2 == 0){
            map["sp2"]=target;
            ctrl.customData = data;
        }else if(sp2!=0 && sp3 == 0){
            map["sp3"]=target;
        }else if(sp3!=0 && sp4 == 0){
            map["sp4"]=target;
        }
        if(sp4!=0){
            var jud = ctrl.world.random.nextInt(1,4);
            var strange_point_limit = data.getInt("strange_point_limit");
            if(jud > 2){
                map["sp5"]=strange_point_limit;
                ctrl.customData = data;
            }
            map["is_create"]=1;
            ctrl.customData = data;
        }
        map["basic"]=target;
        ctrl.customData =data;
  }
  })
  .setThreadName("运动观测")
  .addRecipeTooltip("确定大概率异常点的运动周期")
  .addRecipeTooltip("执行§a5个周期§f的运动观测,随机生成§a3~5§f个大概率异常点")
  .addRecipeTooltip("行星有§b更大可能§f出现在大概率异常点内")
  .build();
  RecipeBuilder.newBuilder("planet_transfer","groundzero",200,4)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val mode_cur = data.getInt("mode_cur",0);
    val is_locked = data.getInt("is_locked",0);
    val is_create = data.getInt("is_create",0);
    if(is_locked == 0){
        event.setFailed("未锁定行星");
    }else if(is_locked == 1 && is_create == 0 && mode_cur == 2){
        event.setFailed("正在获取原始轨道运行数据");
    }else if(is_locked == 1 && mode_cur == 1){
      event.setFailed("当前模式非观测模式");
    }
   })
   .addInputs([
    <contenttweaker:atomicclock>,
    <contenttweaker:opticsunit>*16
   ])
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var is_big = ctrl.world.random.nextFloat(0.0f,1.0f);
    if(is_big > 0.4){
      var target = ctrl.world.random.nextInt(1,5);
      val sp5 = data.getInt("sp5",0);
      if(sp5==0){
        target = ctrl.world.random.nextInt(1,4);
        var choose = data.getInt("sp"+target,0);
        map["target"]=choose;
        ctrl.customData=data;
      }
      var choose = data.getInt("sp"+target,0);
      map["target"]=choose;
      ctrl.customData = data;
    }else{
      val sp1 = data.getInt("sp1",0);
      val sp2 = data.getInt("sp2",0);
      val sp3 = data.getInt("sp3",0);
      val sp4 = data.getInt("sp4",0);
      val sp5 = data.getInt("sp5",0);
      val strange_point_limit = data.getInt("strange_point_limit",0);
      var choose = ctrl.world.random.nextInt(1,strange_point_limit);
      while(choose==sp1||choose==sp2||choose==sp3||choose==sp4||choose==sp5){
        choose = ctrl.world.random.nextInt(1,strange_point_limit);
      }
      map["target"]=choose;
      ctrl.customData=data;
    }
   })
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val target = data.getInt("target",0);
    var appear = data.getInt("appear"+target,0);
    var cycle = data.getInt("cycle",1);
    appear+=1;
    map["appear"+target]=appear;
    ctrl.customData=data;
    cycle+=1;
    if(cycle == 20){
      val sp1 = data.getInt("sp1",0);
      val sp2 = data.getInt("sp2",0);
      val sp3 = data.getInt("sp3",0);
      val sp4 = data.getInt("sp4",0);
      val sp5 = data.getInt("sp5",0);
      var appear1 = data.getInt("appear"+sp1,0);
      appear1+=1;
      map["appear"+sp1]=appear1;
      var appear2 = data.getInt("appear"+sp1,0);
      appear2+=1;
      map["appear"+sp2]=appear2;
      var appear3 = data.getInt("appear"+sp1,0);
      appear3+=1;
      map["appear"+sp3]=appear3;
      var appear4 = data.getInt("appear"+sp1,0);
      appear4+=1;
      map["appear"+sp4]=appear4;
      ctrl.customData = data;
      if(sp5!=0){
        var appear5 = data.getInt("appear"+sp5,0);
        appear5+=1;
        map["appear"+sp5]=appear5;
        ctrl.customData=data;
      }
      map["cycle"]=0;
      ctrl.customData=data;
    }
    map["cycle"]=cycle;
    ctrl.customData = data;
   })
   .setThreadName("校正运算阵列")
   .addRecipeTooltip("当异常点阵列构建完毕后,开始对行星进行位置监测")
   .addRecipeTooltip("行星每§a10s§f移动一次,有§960%§f的概率落入异常点")
   .addRecipeTooltip("每运行§b20§f个周期,可以基于当前计算出的§a运动方程")
   .addRecipeTooltip("为所有可能的行星异常点§c增加观测权重")
   .addRecipeTooltip("即所有的异常观测点行星出现次数加§41")
   .addRecipeTooltip("§c仅在观测模式下可执行")
   .build();
   RecipeBuilder.newBuilder("mode_change_groundzero_observe","groundzero",20,7)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val mode_cur = data.getInt("mode_cur",0);
      if(mode_cur == 2){
        event.setFailed("当前已处于观测模式");
      }
    })
    .addInputs(<contenttweaker:programming_circuit_a>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      map["mode_cur"]=2;
      ctrl.customData = data;
    })
    .addRecipeTooltip("更改运行模式为:观测模式")
    .setThreadName("运行模式覆写")
    .build();

   RecipeBuilder.newBuilder("mode_change_groundzero_mining","groundzero",20,7)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val mode_cur = data.getInt("mode_cur",0);
      if(mode_cur == 1){
        event.setFailed("当前已处于采掘模式");
      }
    })
    .addInputs(<contenttweaker:programming_circuit_b>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val map = data.asMap();
      map["mode_cur"]=1;
      ctrl.customData = data;
    })
    .addRecipeTooltip("更改运行模式为:采掘模式")
    .setThreadName("运行模式覆写")
    .build();
  
  RecipeBuilder.newBuilder("groundzero_mining","groundzero",80,5)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val mode_cur = data.getInt("mode_cur",0);
    val is_locked = data.getInt("is_locked",0);
    val is_create = data.getInt("is_create",0);
    val is_locked_inf = data.getInt("is_locked_inf",0);
    if(is_locked == 0){
      event.setFailed("未锁定行星");
    }else if(is_locked == 1 && is_locked_inf == 0){
      event.setFailed("未锁虹彩行星");
    }else if(is_locked == 1 && is_locked_inf == 1 && mode_cur == 2){
      event.setFailed("当前未处于采掘模式");
    }else if(is_locked == 1 && is_locked_inf == 1 && mode_cur == 1 && is_create == 0){
      event.setFailed("正在获取轨道原始数据");
    }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var is_big = ctrl.world.random.nextFloat(0.0f,1.0f);
    if(is_big > 0.4){
      var target = ctrl.world.random.nextInt(1,5);
      val sp5 = data.getInt("sp5",0);
      if(sp5==0){
        target = ctrl.world.random.nextInt(1,4);
        var choose = data.getInt("sp"+target,0);
        map["target"]=choose;
        ctrl.customData=data;
      }
      var choose = data.getInt("sp"+target,0);
      map["target"]=choose;
      ctrl.customData = data;
    }else{
      val sp1 = data.getInt("sp1",0);
      val sp2 = data.getInt("sp2",0);
      val sp3 = data.getInt("sp3",0);
      val sp4 = data.getInt("sp4",0);
      val sp5 = data.getInt("sp5",0);
      val strange_point_limit = data.getInt("strange_point_limit",0);
      var choose = ctrl.world.random.nextInt(1,strange_point_limit);
      while(choose==sp1||choose==sp2||choose==sp3||choose==sp4||choose==sp5){
        choose = ctrl.world.random.nextInt(1,strange_point_limit);
      }
      map["target"]=choose;
      ctrl.customData=data;
    }
      val target_mining = data.getInt("target",0);
      val strange_point_limit = data.getInt("strange_limit_point",0);
      val is_working = data.getInt("is_active"+target_mining,0);
      val multipleR = data.getFloat("multipleR",0);
      val thread = event.factoryRecipeThread;
      var multX= data.getFloat("multX",0.0);
      val zero = data.getFloat("zero",0.0);
      if(is_working==0){
        multX = zero;
        map["multX"]=multX;
        ctrl.customData = data;
      }else{
        multX = multipleR;
        map["multX"]=multX;
        ctrl.customData = data;
      }
      val multXX = data.getInt("multX",0);
      thread.addPermanentModifier("multipleX",RecipeModifierBuilder.create("modularmachinery:item","output",multXX,1,false).build());
   })
   .addInputs(<contenttweaker:ultminingdevice>).setChance(0.01)
   .addFluidPerTickInputs([
    <liquid:zerotempaturefluid>*100,
    <liquid:crystalloid>*1000
   ])
   .addOutput(<avaritia:resource:5>*800)
   .addOutput(<avaritia:resource:5>*1200).setChance(0.5)
   .addOutput(<avaritia:resource:6>*100)
   .addOutput(<avaritia:resource:6>*500).setChance(0.3)
   .addOutput(<avaritia:block_resource:1>*100).setChance(0.2)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    ctrl.customData = data;
    val thread = event.factoryRecipeThread;
    thread.removePermanentModifier("multipleX");
   })
   .addRecipeTooltip("§e启动§d异星§b开采单元§e获取矿物")
   .addRecipeTooltip("如若当前虹彩行星落入§c存在§9引力干涉阵列的异常点")
   .addRecipeTooltip("则按照§9已构建阵列的数量§f作为倍增")
   .addRecipeTooltip("反之则不会有§c任何产出")
   .setThreadName("开采单元")
   .build();

  RecipeBuilder.newBuilder("groundzero_mag","groundzero",80,5)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val mode_cur = data.getInt("mode_cur",0);
    val is_locked = data.getInt("is_locked",0);
    val is_create = data.getInt("is_create",0);
    val is_locked_mag = data.getInt("is_locked_mag",0);
    if(is_locked == 0){
      event.setFailed("未锁定行星");
    }else if(is_locked == 1 && is_locked_mag == 0){
      event.setFailed("未锁定弱磁行星");
    }else if(is_locked == 1 && is_locked_mag == 1 && mode_cur == 2){
      event.setFailed("当前未处于采掘模式");
    }else if(is_locked == 1 && is_locked_mag == 1 && mode_cur == 1 && is_create == 0){
      event.setFailed("正在获取轨道原始数据");
    }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var is_big = ctrl.world.random.nextFloat(0.0f,1.0f);
    if(is_big > 0.4){
      var target = ctrl.world.random.nextInt(1,5);
      val sp5 = data.getInt("sp5",0);
      if(sp5==0){
        target = ctrl.world.random.nextInt(1,4);
        var choose = data.getInt("sp"+target,0);
        map["target"]=choose;
        ctrl.customData=data;
      }
      var choose = data.getInt("sp"+target,0);
      map["target"]=choose;
      ctrl.customData = data;
    }else{
      val sp1 = data.getInt("sp1",0);
      val sp2 = data.getInt("sp2",0);
      val sp3 = data.getInt("sp3",0);
      val sp4 = data.getInt("sp4",0);
      val sp5 = data.getInt("sp5",0);
      val strange_point_limit = data.getInt("strange_point_limit",0);
      var choose = ctrl.world.random.nextInt(1,strange_point_limit);
      while(choose==sp1||choose==sp2||choose==sp3||choose==sp4||choose==sp5){
        choose = ctrl.world.random.nextInt(1,strange_point_limit);
      }
      map["target"]=choose;
      ctrl.customData=data;
    }
      val target_mining = data.getInt("target",0);
      val strange_point_limit = data.getInt("strange_limit_point",0);
      val is_working = data.getInt("is_active"+target_mining,0);
      val multipleR = data.getFloat("multipleR",0);
      val thread = event.factoryRecipeThread;
      var multX= data.getFloat("multX",0.0);
      val zero = data.getFloat("zero",0.0);
      if(is_working==0){
        multX = zero;
        map["multX"]=multX;
        ctrl.customData = data;
      }else{
        multX = multipleR;
        map["multX"]=multX;
        ctrl.customData = data;
      }
      val multXX = data.getInt("multX",0);
      thread.addPermanentModifier("multipleX",RecipeModifierBuilder.create("modularmachinery:item","output",multXX,1,false).build());
   })
   .addInputs(<contenttweaker:ultminingdevice>).setChance(0.01)
   .addFluidPerTickInputs([
    <liquid:zerotempaturefluid>*100,
    <liquid:crystalloid>*1000
   ])
   .addOutput(<contenttweaker:weakmag>*4)
   .addOutput(<contenttweaker:weakmag>*16).setChance(0.6)
   .addOutput(<contenttweaker:weakmag>*20).setChance(0.4)
   .addOutput(<contenttweaker:weakmag>*24).setChance(0.2)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    ctrl.customData = data;
    val thread = event.factoryRecipeThread;
    thread.removePermanentModifier("multipleX");
   })
   .addRecipeTooltip("§e启动§d异星§b开采单元§e获取矿物")
   .addRecipeTooltip("如若当前弱磁行星落入§c存在§9引力干涉阵列的异常点")
   .addRecipeTooltip("则按照§9已构建阵列的数量§f作为倍增")
   .addRecipeTooltip("反之则不会有§c任何产出")
   .setThreadName("开采单元")
   .build();
   
// 纳米行星锁定配方
RecipeBuilder.newBuilder("planet_locked_nano","groundzero",100,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  var is_locked = data.getInt("is_locked",0);
  if(is_locked == 1){
    event.setFailed("当前已锁定一颗行星");
  }
 })
 .addInputs([
  <contenttweaker:nanoplanet>,
  <contenttweaker:energized_fuel_v4>*256,
  <contenttweaker:nanoswarm>*64,
  <contenttweaker:nanites>*128
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  map["is_locked"]=1;
  map["is_locked_nano"]=1;
  val strange_point_limit = ctrl.world.random.nextInt(9,12);
  map["strange_point_limit"]=strange_point_limit;
  ctrl.customData = data;
 })
 .addRecipeTooltip("锁定一颗处在可观测周期内的§4纳米§7残骸行星")
 .addRecipeTooltip("每颗纳米行星的§9异常点数量§f在§6天体锁定§f后可以被§a确定")
 .addRecipeTooltip("§4每颗行星的异常点都是固定的,不可更改")
 .addRecipeTooltip("异常点的数量范围为§6[§b9,12§6]")
 .setThreadName("天体锁定")
 .build();

// 纳米行星开采配方
RecipeBuilder.newBuilder("groundzero_nano","groundzero",80,5)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val mode_cur = data.getInt("mode_cur",0);
  val is_locked = data.getInt("is_locked",0);
  val is_create = data.getInt("is_create",0);
  val is_locked_nano = data.getInt("is_locked_nano",0);
  if(is_locked == 0){
    event.setFailed("未锁定行星");
  }else if(is_locked == 1 && is_locked_nano == 0){
    event.setFailed("未锁定纳米残骸行星");
  }else if(is_locked == 1 && is_locked_nano == 1 && mode_cur == 2){
    event.setFailed("当前未处于采掘模式");
  }else if(is_locked == 1 && is_locked_nano == 1 && mode_cur == 1 && is_create == 0){
    event.setFailed("正在获取轨道原始数据");
  }
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  var is_big = ctrl.world.random.nextFloat(0.0f,1.0f);
  if(is_big > 0.4){
    var target = ctrl.world.random.nextInt(1,5);
    val sp5 = data.getInt("sp5",0);
    if(sp5==0){
      target = ctrl.world.random.nextInt(1,4);
      var choose = data.getInt("sp"+target,0);
      map["target"]=choose;
      ctrl.customData=data;
    }
    var choose = data.getInt("sp"+target,0);
    map["target"]=choose;
    ctrl.customData = data;
  }else{
    val sp1 = data.getInt("sp1",0);
    val sp2 = data.getInt("sp2",0);
    val sp3 = data.getInt("sp3",0);
    val sp4 = data.getInt("sp4",0);
    val sp5 = data.getInt("sp5",0);
    val strange_point_limit = data.getInt("strange_point_limit",0);
    var choose = ctrl.world.random.nextInt(1,strange_point_limit);
    while(choose==sp1||choose==sp2||choose==sp3||choose==sp4||choose==sp5){
      choose = ctrl.world.random.nextInt(1,strange_point_limit);
    }
    map["target"]=choose;
    ctrl.customData=data;
  }
    val target_mining = data.getInt("target",0);
    val strange_point_limit = data.getInt("strange_limit_point",0);
    val is_working = data.getInt("is_active"+target_mining,0);
    val multipleR = data.getFloat("multipleR",0);
    val thread = event.factoryRecipeThread;
    var multX= data.getFloat("multX",0.0);
    val zero = data.getFloat("zero",0.0);
    if(is_working==0){
      multX = zero;
      map["multX"]=multX;
      ctrl.customData = data;
    }else{
      multX = multipleR;
      map["multX"]=multX;
      ctrl.customData = data;
    }
    val multXX = data.getInt("multX",0);
    thread.addPermanentModifier("multipleX",RecipeModifierBuilder.create("modularmachinery:item","output",multXX,1,false).build());
 })
 .addInputs(<contenttweaker:ultminingdevice>).setChance(0.01)
 .addFluidPerTickInputs([
  <liquid:zerotempaturefluid>*100,
  <liquid:crystalloid>*1000
 ])
 .addOutput(<contenttweaker:reverseunit_1>)
 .addOutput(<contenttweaker:reverseunit_2>).setChance(0.6)
 .addOutput(<contenttweaker:reverseunit_3>).setChance(0.4)
 .addOutput(<contenttweaker:reverseunit_4>).setChance(0.2)
 .addOutput(<contenttweaker:reverseunit_5>).setChance(0.1)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
  val ctrl = event.controller;
  val data = ctrl.customData;
  val map = data.asMap();
  ctrl.customData = data;
  val thread = event.factoryRecipeThread;
  thread.removePermanentModifier("multipleX");
 })
 .addRecipeTooltip("§e启动§d异星§b开采单元§e获取矿物")
 .addRecipeTooltip("如若当前§4纳米§7残骸行星§f落入§c存在§9引力干涉阵列的异常点")
 .addRecipeTooltip("则按照§9已构建阵列的数量§f作为倍增")
 .addRecipeTooltip("反之则不会有§c任何产出")
 .setThreadName("开采单元")
 .build();
  MMEvents.onControllerGUIRender("groundzero",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    var info as string [] = [];
    var strange_point_limit = data.getInt("strange_point_limit",0);
    strange_point_limit+=1;
    val is_locked = data.getInt("is_locked",0);
    val mode_cur = data.getInt("mode_cur",0);
    var recipe_level = data.getInt("recipe_level",1);
    recipe_level-=1;
    val is_sp_full = data.getInt("is_sp_full",0);
    val target_mining = data.getInt("target",0);
    if(is_locked == 0){
        info += "§4未锁定行星";
    }else if(is_locked==1&&mode_cur==2){
        for index in 1 to strange_point_limit{
            var is_active = data.getInt("is_active"+index,0);
            val target = data.getInt("target",0);
            val appear = data.getInt("appear"+index,0);
            if(is_active == 0 &&target!=index)info+="§6"+index+"异常点§f-"+"§c未建立行星引力干涉阵列-"+"§4未检测到天体波动§9"+"(§a"+appear+"§9)";
            else if(is_active==1&&target!=index)info+="§6"+index+"异常点§f-"+"§9已建立行星引力干涉阵列-"+"§4未检测到天体波动§9"+"(§a"+appear+"§9)";
            else if(is_active == 0 && target == index)info+="§6"+index+"异常点§f-"+"§c未建立行星引力干涉阵列-"+"§e检测到天体波动!§9"+"(§a"+appear+"§9)";
            else if(is_active == 1 && target==index)info+="§6"+index+"异常点§f-"+"§9已建立行星引力干涉阵列-"+"§e检测到天体波动!§9"+"(§a"+appear+"§9)";
        }
    }
    if(is_locked == 1 && mode_cur == 0){
      info +="§4未指定运行模式";
    }
    if(is_locked !=0 &&mode_cur == 2 && is_sp_full == 0)info+="当前构建引力干涉阵列的材料消耗倍数"+pow(2,recipe_level);
    else if(is_locked !=0 &&mode_cur == 2 && is_sp_full == 1)info+="当前构建引力干涉阵列的材料消耗倍数:1.0";
    if(is_locked == 1 && mode_cur == 1){
      info+="§d当前为开采模式";
      info+="§c当前行星落点:§9"+target_mining;
    }
    event.extraInfo =info;
  });
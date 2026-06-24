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
import crafttweaker.item.IIngredient;
MachineModifier.setMaxThreads("loftstormsite",0);
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("链接器维护"));
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("发射环轨道构建"));
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("遥感卫星发射平台"));
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("运载火箭发射平台"));
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("采集无人机发射平台"));
MachineModifier.addCoreThread("loftstormsite", FactoryRecipeThread.createCoreThread("射电望远镜阵列组件发射平台"));
RecipeBuilder.newBuilder("site_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(40000000)
    .addItemInputs([
      <modularmachinery:orbital_framework_launch_site_factory_controller>*2,
      <modularmachinery:transition_orbit_emitter_factory_controller>*4,
      <contenttweaker:sensor_v3>*128,
      <contenttweaker:mk1rocket>*64,
      <contenttweaker:mk1satellite>*64,
      <contenttweaker:mk1observer>*64,
      <contenttweaker:oredrone1>*64,
      <contenttweaker:cfcm>*512
    ])
    .addOutputs([
        <modularmachinery:loftstormsite_factory_controller>
    ])
    .requireResearch("site")
    .build();
//链接器维护
RecipeBuilder.newBuilder("loft_check_connect","loftstormsite",100,1)
  .addInput(<contenttweaker:zbk>).setChance(0)
  .setNBTChecker(function(ctrl as IMachineController, item as IItemStack){
        val x = item.tag.getInt("x",0);
        val y = item.tag.getInt("y",0);
        val z = item.tag.getInt("z",0);
        val dim = item.tag.getInt("dim", 0);
        val data = ctrl.customData;
        data.asMap()["lx"] = x;
        data.asMap()["ly"] = y;
        data.asMap()["lz"] = z;
        data.asMap()["ldim"] = dim;
        ctrl.customData = data;
        return true;
    })
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(zsctrl)){
                event.setFailed("未找到通信中枢,区块可能被卸载");
                return ;
            }else{
                val controllerId = zsctrl.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId != "modularmachinery:communication_center_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定中枢控制器");
                    return ;
                }else{
                    if(!zsctrl.isWorking||zsctrl.customData.getInt("loftstormsite_online")==0){
                        event.setFailed("中枢未处于工作状态,或尚未连接至基座");
                        return ;
                    }
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl=event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val oredrone_max = zsctrl.customData.getInt("manage_limit",0);
        map["oredrone_max"]=oredrone_max;
        map["orbit_admit"]=1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("检查与近地通信中枢的链接")
    .addRecipeTooltip("链接§a稳定§f时可构建§9发射轨道")
    .setThreadName("链接器维护")
    .build();
//发射轨道构建
launch_orbit_create(1,[<contenttweaker:micro_mmf_accelerator>*8,<contenttweaker:shieldcase>*16,<contenttweaker:charging_crystal_block>*24,<contenttweaker:industrial_circuit_v3>*16,<contenttweaker:programming_circuit_a>],1000000);
launch_orbit_create(2,[<contenttweaker:micro_mmf_accelerator>*16,<contenttweaker:shieldcase>*24,<contenttweaker:charging_crystal_block>*36,<contenttweaker:industrial_circuit_v3>*20,<contenttweaker:spacematrix_ingot>*8,<contenttweaker:programming_circuit_b>],2000000);
//采集无人机发射
launch_unit_oredrone(1,100,<contenttweaker:oredrone1>,1);
launch_unit_oredrone(2,120,<contenttweaker:mk2oredrone>,50);
//运载火箭发射
launch_unit_rocket(1,100,<contenttweaker:mk1rocket>,1);
launch_unit_rocket(2,120,<contenttweaker:mk2rocket>,50);
//遥感卫星发射
launch_unit_satellite(1,100,<contenttweaker:mk1satellite>,1);
launch_unit_satellite(2,120,<contenttweaker:mk2satellite>,50);
//射电望远镜阵列组件发射
launch_unit_observer(1,100,<contenttweaker:mk1observer>,1);
launch_unit_observer(2,120,<contenttweaker:mk2observer>,50);
MMEvents.onControllerGUIRender("loftstormsite",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    var info as string[]=[];
    val lx = data.getInt("lx",0);
    val ly = data.getInt("ly",0);
    val lz = data.getInt("lz",0);
    val ldim = data.getInt("ldim",0);
    val world = IWorld.getFromID(ldim);
    val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
    if(!isNull(zsctrl)){
    val zsdata = zsctrl.customData;
    val oredrone_count = data.getInt("oredrone_count",0);
    val rocket_count = data.getInt("rocket_count",0);
    val satellite_count = data.getInt("satellite_count",0);
    val orbit_admit = data.getInt("orbit_admit");
    val oredrone_max = data.getInt("oredrone_max",0);
    val observer_max = data.getInt("oredrone_max",0);
    val observer_count = data.getInt("observer_count",0);
    val orbit_level = data.getInt("orbit_level");
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        info += "§4未连接至通信中枢";
    }
    else if(!isNull(zsctrl)){
        info += "§a////////////§6洛夫斯特罗姆基座§a////////////";
        info += "当前发射轨道等级:"+ orbit_level;
        if(orbit_admit==1){
            info += "采集无人机在线数量:"+oredrone_count+"/"+"§6"+oredrone_max;
            info += "运载火箭在线数量:"+rocket_count+"/"+"§a"+oredrone_max;
            info += "遥感卫星在线数量:"+satellite_count+"/"+"§b"+oredrone_max;
            info += "射电望远镜阵列组件在线数量:"+observer_count+"/"+"§c"+observer_max;
        }

    }
    event.extraInfo = info;
    }
});

function launch_unit_rocket(level as int,time as int,rocket as IItemStack,degree as int){
    RecipeBuilder.newBuilder("launch"+rocket.name+level,"loftstormsite",time,1)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_admit = data.getInt("orbit_admit",0);
        val orbit_level = data.getInt("orbit_level",0);
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val rocket_max = zsctrl.customData.getInt("manage_limit");
        var rocket_count = data.getInt("rocket_count",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)||orbit_admit == 0){
            event.setFailed("链接器离线");
        }
        if(orbit_admit == 0){
            event.setFailed("尚未构建发射轨道");
        }
        if(orbit_admit == 1 && orbit_level < level){
            event.setFailed("发射轨道等级过低,无法发射");
        }
        if(rocket_count >= rocket_max){
            event.setFailed("已达最大上限");
        }
     })
     .addInput(rocket)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val rocket_max = zsctrl.customData.getInt("manage_limit");
        val map = data.asMap();
        map["rocket_max"] = rocket_max;
        var rocket_count = data.getInt("rocket_count",0);
        ctrl.customData = data;
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_level = data.getInt("orbit_level",0);
        val Thread = event.factoryRecipeThread;
        var current_time = 1.0f;
            if(orbit_level > 1){
            current_time = 1.0f-(0.1f*orbit_level);
        }
        Thread.addModifier("less", RecipeModifierBuilder.create("modularmachinery:duration", "input",current_time, 1, false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var rocket_count = data.getInt("rocket_count",0);
        var rocket_max = data.getInt("rocket_max",0);
        if(rocket_count < rocket_max){
            rocket_count+=degree;
        }else{
            rocket_count = rocket_max;
        }
        val map = data.asMap();
        map["rocket_count"]=rocket_count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射Mk"+level+"级§a运载火箭")
    .addRecipeTooltip("需要"+level+"级及以上发射轨道可以发射")
    .addRecipeTooltip("提供§b"+degree+"§f点运载阵列点数")
    .setThreadName("运载火箭发射平台")
    .build();
}
function launch_unit_oredrone(level as int,time as int,drone as IItemStack,degree as int){
    RecipeBuilder.newBuilder("launch"+drone.name+level,"loftstormsite",time,1)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_admit = data.getInt("orbit_admit",0);
        val orbit_level = data.getInt("orbit_level",0);
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val oredrone_max = zsctrl.customData.getInt("manage_limit");
        var oredrone_count = data.getInt("oredrone_count",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)||orbit_admit == 0){
            event.setFailed("链接器离线");
        }
        if(orbit_admit == 0){
            event.setFailed("尚未构建发射轨道");
        }
        if(orbit_admit == 1 && orbit_level < level){
            event.setFailed("发射轨道等级过低,无法发射");
        }
        if(oredrone_count >= oredrone_max){
            event.setFailed("已达最大上限");
        }
     })
     .addInput(drone)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val oredrone_max = zsctrl.customData.getInt("manage_limit");
        val map = data.asMap();
        map["oredrone_max"] = oredrone_max;
        var oredrone_count = data.getInt("oredrone_count",0);
        ctrl.customData = data;
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_level = data.getInt("orbit_level",0);
        val Thread = event.factoryRecipeThread;
        var current_time = 1.0f;
        if(orbit_level > 1){
            current_time = 1.0f-(0.1f*orbit_level);
        }
        Thread.addModifier("less", RecipeModifierBuilder.create("modularmachinery:duration", "input",current_time, 1, false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var oredrone_count = data.getInt("oredrone_count",0);
        var oredrone_max = data.getInt("oredrone_max",0);
        if(oredrone_count < oredrone_max){
            oredrone_count+=degree;
        }else{
            oredrone_count = oredrone_max;
        }
        val map = data.asMap();
        map["oredrone_count"]=oredrone_count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射Mk"+level+"级§6采集无人机")
    .addRecipeTooltip("需要"+level+"级及以上发射轨道可以发射")
    .addRecipeTooltip("提供§b"+degree+"§f点采集阵列点数")
    .setThreadName("采集无人机发射平台")
    .build();
}
function launch_unit_satellite(level as int,time as int,satellite as IItemStack,degree as int){
    RecipeBuilder.newBuilder("launch"+satellite.name+level,"loftstormsite",time,1)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_admit = data.getInt("orbit_admit",0);
        val orbit_level = data.getInt("orbit_level",0);
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val satellite_max = zsctrl.customData.getInt("manage_limit");
        var satellite_count = data.getInt("satellite_count",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)||orbit_admit == 0){
            event.setFailed("链接器离线");
        }
        if(orbit_admit == 0){
            event.setFailed("尚未构建发射轨道");
        }
        if(orbit_admit == 1 && orbit_level < level){
            event.setFailed("发射轨道等级过低,无法发射");
        }
        if(satellite_count >= satellite_max){
            event.setFailed("已达最大上限");
        }
     })
     .addInput(satellite)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val satellite_max = zsctrl.customData.getInt("manage_limit");
        val map = data.asMap();
        map["satellite_max"] = satellite_max;
        var satellite_count = data.getInt("satellite_count",0);
        ctrl.customData = data;
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_level = data.getInt("orbit_level",0);
        val Thread = event.factoryRecipeThread;
        var current_time = 1.0f;
        if(orbit_level > 1){
            current_time = 1.0f-(0.1f*orbit_level);
        }
        Thread.addModifier("less", RecipeModifierBuilder.create("modularmachinery:duration", "input",current_time, 1, false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var satellite_count = data.getInt("satellite_count",0);
        var satellite_max = data.getInt("satellite_max",0);
        if(satellite_count < satellite_max){
            satellite_count+=degree;
        }else{
            satellite_count = satellite_max;
        }
        val map = data.asMap();
        map["satellite_count"]=satellite_count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射Mk"+level+"级§b遥感卫星")
    .addRecipeTooltip("需要"+level+"级及以上发射轨道可以发射")
    .addRecipeTooltip("提供§b"+degree+"§f点维护阵列点数")
    .setThreadName("遥感卫星发射平台")
    .build();
}
function launch_unit_observer(level as int,time as int,observer as IItemStack,degree as int){
    RecipeBuilder.newBuilder("launch"+observer.name+level,"loftstormsite",time,1)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_admit = data.getInt("orbit_admit",0);
        val orbit_level = data.getInt("orbit_level",0);
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val observer_max = zsctrl.customData.getInt("manage_limit");
        var observer_count = data.getInt("observer_count",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)||orbit_admit == 0){
            event.setFailed("链接器离线");
        }
        if(orbit_admit == 0){
            event.setFailed("尚未构建发射轨道");
        }
        if(orbit_admit == 1 && orbit_level < level){
            event.setFailed("发射轨道等级过低,无法发射");
        }
        if(observer_count >= observer_max){
            event.setFailed("已达最大上限");
        }
     })
     .addInput(observer)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val observer_max = zsctrl.customData.getInt("manage_limit");
        val map = data.asMap();
        map["observer_max"] = observer_max;
        var observer_count = data.getInt("observer_count",0);
        ctrl.customData = data;
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_level = data.getInt("orbit_level",0);
        val Thread = event.factoryRecipeThread;
        var current_time = 1.0f;
        if(orbit_level > 1){
            current_time = 1.0f-(0.1f*orbit_level);
        }
        Thread.addModifier("less", RecipeModifierBuilder.create("modularmachinery:duration", "input",current_time, 1, false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var observer_count = data.getInt("observer_count",0);
        var observer_max = data.getInt("observer_max",0);
        if(observer_count < observer_max){
            observer_count+=degree;
        }else{
            observer_count = observer_max;
        }
        val map = data.asMap();
        map["observer_count"]=observer_count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射Mk"+level+"级§c射电望远镜阵列组件")
    .addRecipeTooltip("需要"+level+"级及以上发射轨道可以发射")
    .addRecipeTooltip("提供§b"+degree+"§f点观测阵列点数")
    .setThreadName("射电望远镜阵列组件发射平台")
    .build();
}
function launch_orbit_create(level as int,orbit_materials as IIngredient[],energy as int){
    RecipeBuilder.newBuilder("launch_orbit"+level,"loftstormsite",800,3)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val orbit_level = data.getInt("orbit_level",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
            event.setFailed("链接器离线");
        }
    })
     .addInputs(orbit_materials)
     .addEnergyPerTickInput(energy)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["orbit_level"]=level;
        map["orbit_admit"]=1;
        ctrl.customData = data;
     })
     .addRecipeTooltip("构建"+level+"级§9发射轨道")
     .addRecipeTooltip("除了一级轨道外")
     .addRecipeTooltip("每提升一级发射轨道,航天器发射时间缩短§a10%")
     .setThreadName("发射环轨道构建")
     .build();
}
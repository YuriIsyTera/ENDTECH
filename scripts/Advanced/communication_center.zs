import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.item.IIngredient;
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
import crafttweaker.event.PlayerInteractBlockEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.hypernet.HyperNetHelper;
HyperNetHelper.proxyMachineForHyperNet("communication_center");
RecipeBuilder.newBuilder("communication_center_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(40000000)
    .addItemInputs([
        <modularmachinery:dyson_ball_management_center_factory_controller>,
        <appliedenergistics2:material:47>*512,
        <contenttweaker:sensor_v1>*256,
        <contenttweaker:sensor_v2>*128,
        <contenttweaker:sensor_v3>*64,
        <appliedenergistics2:material:41>*256,
        <gravisuite:crafting:3>*68,
        <contenttweaker:kjcl>*128,
        <contenttweaker:kjzj>*16
    ])
    .addOutputs([
        <modularmachinery:communication_center_factory_controller>
    ])
    .requireResearch("site")
    .requireComputationPoint(8000.0)
    .build();

MMEvents.onStructureFormed("communication_center" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var comhostmk1 = ctrl.getBlocksInPattern(<contenttweaker:comhostmk1>);
    var comhostmk2 = ctrl.getBlocksInPattern(<contenttweaker:comhostmk2>);
    var comhostmk3 = ctrl.getBlocksInPattern(<contenttweaker:comhostmk3>);
    if(comhostmk1 == 36){
        map["manage_online"]=1;
        map["manage_limit"]=200;
    }
    if(comhostmk2  == 36){
        map["manage_online"]=1;
        map["manage_limit"]=1000;
    }
    if(comhostmk3  == 36){
        map["manage_online"]=1;
        map["manage_limit"]=2000;
    }
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("communication_center",0);
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("信息管理中枢"));
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("在轨设备同步器"));
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("深空巨构装配"));
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("地对空上行链路维护单元"));
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("太空电梯连接模块"));
MachineModifier.addCoreThread("communication_center", FactoryRecipeThread.createCoreThread("射电望远镜阵列"));
RecipeBuilder.newBuilder("message_core","communication_center",600,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl=event.controller;
    val data = ctrl.customData;
    var message_core_online = data.getInt("message_core_online",0);
    var manage_online = data.getInt("manage_online",0);
    if(message_core_online == 1 && manage_online == 1){
        event.setFailed("当前中枢在线");
    }
    if(manage_online == 0){
        event.setFailed("未找到有效的通信阵列,请检查主机数量");
    }
   })
   .addEnergyPerTickInput(1000000000)
   .addInputs([
    <advancedrocketry:warpmonitor>*64,
    <advancedrocketry:satellitebuilder>*128,
    <contenttweaker:starmachineblock>*512,
    <contenttweaker:industrial_circuit_v3>*32,
    <contenttweaker:hypernet_gpu_t3>*8,
    <contenttweaker:sensor_v3>*16,
    <contenttweaker:energized_fuel_v3>*32,
   ])
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["message_core_online"]=1;
    ctrl.customData = data;
   })
   .addRecipeTooltip("发射§9近地通信中枢")
   .addRecipeTooltip("同时将中枢信息发送到同步器上用于应对异常情况")
   .addRecipeTooltip("需要有完整的信息阵列才可执行")
   .addRecipeTooltip("当结构中为§7通信主机§bMk1§f时,发射航天器上限为§e200")
   .addRecipeTooltip("当结构中为§7通信主机§aMk2§f时,发射航天器上限为§e1000")
   .addRecipeTooltip("当结构中为§7通信主机§9Mk3§f时,发射航天器上限为§e2000")
   .addOutput(<contenttweaker:central_saved>)
   .setThreadName("信息管理中枢")
   .build();
RecipeBuilder.newBuilder("reconnect_terminal","communication_center",40,2)
 .addInput(<contenttweaker:central_saved>).setChance(0)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val  ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["message_core_online"]=1;
    ctrl.customData = data;
 })
 .addRecipeTooltip("修复因§9电子干扰§f原因丢失的§6通信中枢链接线路")
 .setThreadName("信息管理中枢")
 .build();
RecipeBuilder.newBuilder("loftstormsite_connect","communication_center",100,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var message_core_online = data.getInt("message_core_online",0);
        var manage_online = data.getInt("manage_online",0);
        if(message_core_online == 0){
            event.setFailed("未找到近地通信中枢");
        }
    })
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
        val loftstormsite = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(loftstormsite)){
                event.setFailed("未找到发射回路基座,区块可能被卸载");
                return ;
            }else{
                val controllerId = loftstormsite.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId!="modularmachinery:loftstormsite_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定基座控制器");
                    return ;
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        if(ly != 0){
            val loftstormsite = MachineController.getControllerAt(world,lx,ly,lz);
        if(!isNull(loftstormsite)){
        val loftstormsite = MachineController.getControllerAt(world,lx,ly,lz);
        val collectMatrix = loftstormsite.customData.getInt("oredrone_count")/200;
        val carryMatrix = loftstormsite.customData.getInt("rocket_count")/200;
        val maintainMatrix = loftstormsite.customData.getInt("satellite_count")/200;
        val observeMatrix = loftstormsite.customData.getInt("observer_count")/200;
        map["collectMatrix"]=collectMatrix;
        map["carryMatrix"]=carryMatrix;
        map["maintainMatrix"]=maintainMatrix;
        map["observeMatrix"]=observeMatrix;
        map["loftstormsite_online"]=1;
            }
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("连接洛夫斯特罗姆基座,监测近地轨道飞行器")
    .addRecipeTooltip("在§9GUI§f中查看§6采集阵列§f,§a运载阵列§f,§b维护阵列§f,§c观测阵列§f的等级")
    .addRecipeTooltip("结构中通信主机的数量决定了基座的航天器发射上限")
    .addRecipeTooltip("Mk1=200点数,Mk2=1000点数")
    .setThreadName("在轨设备同步器")
    .build();
//T.H.O.R-行星解构机集成控制器



RecipeBuilder.newBuilder("telescope","communication_center",1000,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val observeMatrix = data.getInt("observeMatrix",0);
    if(observeMatrix < 1){
        event.setFailed("未检测到射电望远镜结构");
    }
 })
 .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val observeMatrix = data.getInt("observeMatrix",0);
    val Thread = event.factoryRecipeThread;
    val map = data.asMap();
    var current_time = 1.0f;
        if(observeMatrix > 1){
            current_time = 1.0f-(0.1f*observeMatrix);
        }
    var current_produce = 1.0f;
    if(observeMatrix > 1){
        current_produce = 1.0f+observeMatrix;
    }    
        Thread.addModifier("less", RecipeModifierBuilder.create("modularmachinery:duration", "input",current_time, 1, true).build());
        Thread.addModifier("more", RecipeModifierBuilder.create("modularmachinery:item", "output",current_produce, 1, false).build());
 })
 .addOutputs([<contenttweaker:unknownplanet>*4])
 .addOutputs([<contenttweaker:unknownplanet>*8]).setChance(0.8)
 .addOutputs([<contenttweaker:unknownplanet> *16]).setChance(0.2)
 .addOutputs([<contenttweaker:unknownplanet> *18]).setChance(0.05)
 .setThreadName("射电望远镜阵列")
 .addRecipeTooltip("观测宇宙中沉默的天体")
 .addRecipeTooltip("需要§cT1观测阵列")
 .addRecipeTooltip("每提升一级§c观测阵列§f,产出增加§a100%")
 .build();

RecipeBuilder.newBuilder("spacestation_center","communication_center",100,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var message_core_online = data.getInt("message_core_online",0);
        var manage_online = data.getInt("manage_online",0);
        if(message_core_online == 0){
            event.setFailed("未找到近地通信中枢");
        }
    })
    .addInput(<contenttweaker:fallenstarforcefieldcontrolblock>).setChance(0)
    .addInput(<contenttweaker:scan_terminal_spacestation>).setChance(0)
    .setNBTChecker(function(ctrl as IMachineController, item as IItemStack){
        val x = item.tag.getInt("x",0);
        val y = item.tag.getInt("y",0);
        val z = item.tag.getInt("z",0);
        val dim = item.tag.getInt("dim", 0);
        val data = ctrl.customData;
        data.asMap()["spacestationx"] = x;
        data.asMap()["spacestationy"] = y;
        data.asMap()["spacestationz"] = z;
        data.asMap()["spacestationdim"] = dim;
        ctrl.customData = data;
        return true;
    })
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("spacestationx",0);
        val ly = data.getInt("spacestationy",0);
        val lz = data.getInt("spacestationz",0);
        val ldim = data.getInt("spacestationdim",0);
        val world = IWorld.getFromID(ldim);
        val spacestation = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(spacestation)){
                event.setFailed("未找到空间站,区块可能被卸载");
                return ;
            }else{
                val controllerId = spacestation.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId!="modularmachinery:spacestation_i_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定空间站控制器");
                    return ;
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val lx = data.getInt("spacestationx",0);
        val ly = data.getInt("spacestationy",0);
        val lz = data.getInt("spacestationz",0);
        val ldim = data.getInt("spacestationdim",0);
        val world = IWorld.getFromID(ldim);
        val spacestation = MachineController.getControllerAt(world,lx,ly,lz);
        if(!isNull(spacestation)){
        val spacestation_level = spacestation.customData.getInt("spacestation_level");
        map["spacestation_level"]=spacestation_level;
        ctrl.customData = data;
        }
    })
    .addRecipeTooltip("连接§9一级空间站结构")
    .addRecipeTooltip("解锁额外的空间站独有配方")
    .setThreadName("地对空上行链路维护单元")
    .build();

RecipeBuilder.newBuilder("spacestation_center_ii","communication_center",100,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var message_core_online = data.getInt("message_core_online",0);
        var manage_online = data.getInt("manage_online",0);
        if(message_core_online == 0){
            event.setFailed("未找到近地通信中枢");
        }
    })
    .addInput(<contenttweaker:universalforcefieldcontrolblock>).setChance(0)
    .addInput(<contenttweaker:scan_terminal_spacestation>).setChance(0)
    .setNBTChecker(function(ctrl as IMachineController, item as IItemStack){
        val x = item.tag.getInt("x",0);
        val y = item.tag.getInt("y",0);
        val z = item.tag.getInt("z",0);
        val dim = item.tag.getInt("dim", 0);
        val data = ctrl.customData;
        data.asMap()["spacestationx"] = x;
        data.asMap()["spacestationy"] = y;
        data.asMap()["spacestationz"] = z;
        data.asMap()["spacestationdim"] = dim;
        ctrl.customData = data;
        return true;
    })
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("spacestationx",0);
        val ly = data.getInt("spacestationy",0);
        val lz = data.getInt("spacestationz",0);
        val ldim = data.getInt("spacestationdim",0);
        val world = IWorld.getFromID(ldim);
        val spacestation = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(spacestation)){
                event.setFailed("未找到空间站,区块可能被卸载");
                return ;
            }else{
                val controllerId = spacestation.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId!="modularmachinery:spacestation_ii_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定空间站控制器");
                    return ;
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val lx = data.getInt("spacestationx",0);
        val ly = data.getInt("spacestationy",0);
        val lz = data.getInt("spacestationz",0);
        val ldim = data.getInt("spacestationdim",0);
        val world = IWorld.getFromID(ldim);
        val spacestation = MachineController.getControllerAt(world,lx,ly,lz);
        if(!isNull(spacestation)){
        val spacestation_level = spacestation.customData.getInt("spacestation_level");
        map["spacestation_level"]=spacestation_level;
        ctrl.customData = data;
        }
    })
    .addRecipeTooltip("连接§b二级空间站结构")
    .addRecipeTooltip("解锁额外的空间站独有配方")
    .setThreadName("地对空上行链路维护单元")
    .build();

RecipeBuilder.newBuilder("elevator_center","communication_center",100,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var message_core_online = data.getInt("message_core_online",0);
        var manage_online = data.getInt("manage_online",0);
        if(message_core_online == 0){
            event.setFailed("未找到近地通信中枢");
        }
    })
    .addInput(<contenttweaker:scan_terminal_elevator>).setChance(0)
    .setNBTChecker(function(ctrl as IMachineController, item as IItemStack){
        val x = item.tag.getInt("x",0);
        val y = item.tag.getInt("y",0);
        val z = item.tag.getInt("z",0);
        val dim = item.tag.getInt("dim", 0);
        val data = ctrl.customData;
        data.asMap()["elevatorx"] = x;
        data.asMap()["elevatory"] = y;
        data.asMap()["elevatorz"] = z;
        data.asMap()["elevatordim"] = dim;
        ctrl.customData = data;
        return true;
    })
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("elevatorx",0);
        val ly = data.getInt("elevatory",0);
        val lz = data.getInt("elevatorz",0);
        val ldim = data.getInt("elevatordim",0);
        val world = IWorld.getFromID(ldim);
        val elevator = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(elevator)){
                event.setFailed("未找到太空电梯,区块可能被卸载");
                return ;
            }else{
                val controllerId = elevator.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId!="modularmachinery:mega_spaceelevator_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定太空电梯");
                    return ;
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["enable_elevator"]=1;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val loftstormsite = MachineController.getControllerAt(world,lx,ly,lz);
        if(!isNull(loftstormsite)){
        val observer_count = loftstormsite.customData.getFloat("observer_count");
        val oredrone_count = loftstormsite.customData.getFloat("oredrone_count");
        val satellite_count = loftstormsite.customData.getFloat("satellite_count");
        val rocket_count = loftstormsite.customData.getInt("rocket_count");
        val spacestation_level = data.getInt("spacestation_level",0);
        var efficiency = ((oredrone_count + satellite_count + rocket_count + observer_count)*spacestation_level/1000)+1.0;
        map["efficiency"]=efficiency;
        ctrl.customData = data;
        }
    })
    .addRecipeTooltip("连接§9太空电梯结构")
    .addRecipeTooltip("解锁额外的§9太空电梯§e独有配方")
    .addRecipeTooltip("同时启用§a效率乘数§f计算")
    .addRecipeTooltip("根据航天器数量§a减少巨构装配时间")
    .addRecipeTooltip("效率乘数=(§6航天器总数§f*§c空间站等级§f)/§a1000§f + §91")
    .setThreadName("太空电梯连接模块")
    .build();

MMEvents.onControllerGUIRender("communication_center",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val message_core_online = data.getInt("message_core_online",0);
    val collectMatrix = data.getInt("collectMatrix",0);
    val carryMatrix = data.getInt("carryMatrix",0);
    val maintainMatrix = data.getInt("maintainMatrix",0);
    val observeMatrix = data.getInt("observeMatrix",0);
    val spacestation_level = data.getInt("spacestation_level",0);
    val enable_elevator = data.getInt("enable_elevator",0);
    var info as string[]=[];
    if(message_core_online == 0){
        info += "§4近地通信中枢离线";
    }
    if(message_core_online == 1){
        info += "§a////////////§b近地通信中枢§a////////////";
        info += "§6采集阵列:T"+collectMatrix;
        info += "§a运载阵列:T"+carryMatrix;
        info += "§b维护阵列:T"+maintainMatrix;
        info += "§c观测阵列:T"+observeMatrix;
    }
        if(spacestation_level == 0){
        info += "§4未找到空间站结构";
    }else if(spacestation_level == 2){
        info += "当前在轨空间站:§9远视者§b空间站-§9II级§e深空巨构装配体";
    }else if(spacestation_level == 1){
        info += "当前在轨空间站:§2探索者§b空间站-§9I级§e深空巨构装配体";
    }
    if(enable_elevator == 0){
        info += "§4未找到太空电梯模块";
    }
    event.extraInfo = info;
});
megabuild(100,50,80,[<modularmachinery:asteroid_destroyer_factory_controller>],256,[<contenttweaker:thor_blueprint>],1,1,1,false);
megabuild(50,50,50,[<modularmachinery:asteroid_reactor_factory_controller>],247,[<contenttweaker:harc_blueprint>],1,1,1,false);
megabuild(400,400,400,[<modularmachinery:groundzero_factory_controller>],512,[<contenttweaker:perihelion_blueprint>,<modularmachinery:atomic_reconstructor_factory_controller>*4,<modularmachinery:asteroid_destroyer_factory_controller>,<modularmachinery:tokmak_reactor_controller>,
<modularmachinery:asteroid_reactor_factory_controller>,<contenttweaker:arkchip>*2,<contenttweaker:infinityplanet>,
<contenttweaker:tyf3>*18],2,2,2,false);
megabuild(300,300,300,[<modularmachinery:basic_zeropressure_factory_controller>],384,[<contenttweaker:zero_pressure_blueprint>],2,2,2,false);
megabuild(600,600,600,[<modularmachinery:stargate_centralx_factory_controller>],999,[<contenttweaker:axis_blueprint>],3,3,3,false);
megabuild(400,400,400,[<modularmachinery:simulateneutronstarpointx_factory_controller>],476,[<contenttweaker:neutron_similar_blueprint>],3,3,3,false);
megabuild(100,100,100,[<modularmachinery:spacestation_i_factory_controller>],128,[<contenttweaker:spacestation_i_blueprint>],1,1,1,false);
megabuild(500,500,500,[<modularmachinery:spacestation_ii_factory_controller>],289,[<contenttweaker:spacestation_ii_blueprint>],5,5,5,false);
megabuild(600,600,600,[<modularmachinery:collapse_generator_factory_controller>],124,[<contenttweaker:collapse_blueprint>],5,5,5,false);
megabuild(800,800,800,[<modularmachinery:omhd_factory_controller>],574,[<contenttweaker:omhd_blueprint>],5,5,5,false);
megabuild(1000,1000,1000,[<modularmachinery:star_annihilation_engine_factory_controller>],995,[<contenttweaker:ceas_blueprint>],5,5,5,false);
//oredrone 消耗无人机点数,rocket 消耗运载火箭点数, satellite 消耗遥感卫星点数, purpose 目标控制器,consume 运载单元消耗数量,input 输入材料组,collectrank 采集阵列等级, carryrank 运载阵列等级 , maintainrank 维护阵列等级, elevator 是否需要太空电梯参与
function megabuild(oredrone as int,rocket as int,satellite as int,purpose as IIngredient[],consume as int,input as IIngredient[],collectrank as int,carryrank as int,maintainrank as int,elevator as bool){
RecipeBuilder.newBuilder("M"+consume+"create","communication_center",1000,3)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
     val ctrl = event.controller;
     val data = ctrl.customData;
     val collectMatrix = data.getInt("collectMatrix",0);
     val carryMatrix = data.getInt("carryMatrix",0);
     val maintainMatrix = data.getInt("maintainMatrix",0);
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
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val enable_elevator = data.getInt("enable_elevator",0);
    if(enable_elevator == 1){
        val efficiency = data.getFloat("efficiency",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","output",1/efficiency,0,false).build());
    }
   })
   .addInputs(input)
   .addEnergyPerTickInput(10000000)
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
     if(!isNull(loftstormsite)){
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
     }
   })
   .addRecipeTooltip("协调在轨航天器,组建深空巨构")
   .addRecipeTooltip("需要§6T"+collectrank+"采集阵列,§aT"+carryrank+"运载阵列,§bT"+maintainrank+"维护阵列")
   .addRecipeTooltip("将消耗§c"+oredrone+"§f点§6采集无人机点数")
   .addRecipeTooltip("将消耗§c"+rocket+"§f点§a运载火箭点数")
   .addRecipeTooltip("将消耗§c"+satellite+"§f点§b遥感卫星点数")
   .addRecipeTooltip("当连接§9太空电梯§f时将不会消耗点数")
   .setThreadName("深空巨构装配")
   .build();
}
//断连初始化
RecipeBuilder.newBuilder("refresh_loft","communication_center",1,7)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val collectMatrix = data.getInt("collectMatrix",0);
    val maintainMatrix = data.getInt("maintainMatrix",0);
    val carryMatrix = data.getInt("carryMatrix",0);
    val observeMatrix = data.getInt("observeMatrix",0);
    if(collectMatrix == 0 || maintainMatrix == 0 || maintainMatrix == 0 || observeMatrix == 0){
        event.setFailed("请连接基座");
    }
 })
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["collectMatrix"]=0;
    map["maintainMatrix"]=0;
    map["observeMatrix"]=0;
    map["carryMatrix"]=0;
    ctrl.customData = data;
 })
 .setThreadName("在轨设备同步器")
 .build();
//坐标卡区分
    events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
        val xc  = event.position.x;
        val yc  = event.position.y;
        val zc  = event.position.z;
        val dim = event.world.provider.dimensionID;
        val item = event.item;   
        val pos as int[] = [xc,yc,zc,dim];
        if(!event.world.remote && <contenttweaker:scan_terminal_spacestation>.matches(item)){
            item.mutable().updateTag({display: {Lore: ["§9绑定空间站所在维度ID：§a" + dim,"§9x坐标：§a" + xc, "§9y坐标：§a" + yc, "§9z坐标：§a" + zc]}, x: xc, y: yc, z: zc,pos : pos, dim: dim,binding : "yes!"});
            event.cancel();
        } 
    });

    events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
        val xc  = event.position.x;
        val yc  = event.position.y;
        val zc  = event.position.z;
        val dim = event.world.provider.dimensionID;
        val item = event.item;   
        val pos as int[] = [xc,yc,zc,dim];
        if(!event.world.remote && <contenttweaker:scan_terminal_elevator>.matches(item)){
            item.mutable().updateTag({display: {Lore: ["§9绑定太空电梯所在维度ID：§a" + dim,"§9x坐标：§a" + xc, "§9y坐标：§a" + yc, "§9z坐标：§a" + zc]}, x: xc, y: yc, z: zc,pos : pos, dim: dim,binding : "yes!"});
            event.cancel();
        } 
    });

    
   
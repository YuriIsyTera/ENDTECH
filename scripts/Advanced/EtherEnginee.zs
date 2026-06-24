import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineStructureUpdateEvent;
import crafttweaker.block.IBlock;
import novaeng.hypernet.HyperNetHelper;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.event.BlockBreakEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;
import mods.modularmachinery.MachineController;
import crafttweaker.liquid.ILiquidStack;
import mods.modularmachinery.MachineStructureFormedEvent;

import crafttweaker.data.IData;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;

MachineModifier.setMaxThreads("dimensionreaper", 0);
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("撕裂引擎").addRecipe("engine_start"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("时空场监测").addRecipe("judgespace"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("异界相位操纵").addRecipe("strange_produce"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("以太势阱").addRecipe("dark_matter_produce"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("时空反演").addRecipe("anti_entropy_produce"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("稳定框架维护").addRecipe("steady_structure"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("引力单元注入").addRecipe("production_structure"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("产出端口#1").addRecipe("clear_1"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("产出端口#2").addRecipe("clear_2"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("产出端口#3").addRecipe("clear_3"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("模式切换#1").addRecipe("mode_change_1"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("模式切换#2").addRecipe("mode_change_2"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("模式切换#3").addRecipe("mode_change_3"));
MachineModifier.addCoreThread("dimensionreaper",FactoryRecipeThread.createCoreThread("模式切换#4").addRecipe("mode_change_4"));
MMEvents.onStructureFormed("dimensionreaper" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["is_end"]=1;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("dimensionreaper_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(500000000)
    .addFluidInputs([
       <liquid:dimensionbeam>*100000,
       <liquid:crystalloid>*1000000
    ])
    .addItemInputs([
        <contenttweaker:tearenginee>*16,
        <contenttweaker:neutronchip>*32,
        <contenttweaker:neutrondustingot>*256,
        <contenttweaker:superconidiosome>*32,
        <modularmachinery:alppm_controller>,
        <modularmachinery:atomic_reconstructor_factory_controller>,
        <modularmachinery:nsemc_factory_controller>,
        <modularmachinery:neutron_particle_crystal_controller>*4,
        <contenttweaker:fallenstarforcefieldcontrolblock>*64
    ])
    .addOutputs([
        <modularmachinery:dimensionreaper_factory_controller>
    ])
    .requireResearch("theory_reap_spacetime")
    .build();

//异界相位操纵切换
RecipeBuilder.newBuilder("mode_change_1","dimensionreaper",20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        if(stat == 1){
            event.setFailed("运行中，无法切换模式");
        }
    })
    .addInputs(<contenttweaker:programming_circuit_0>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        data.asMap()["mode_1"]=1;
        data.asMap()["mode_2"]=0;
        data.asMap()["mode_3"]=0;
        data.asMap()["mode_4"]=0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("将运行模式变更为:异界相位操纵")
    .setThreadName("模式切换#1")
    .build();
//以太势阱切换
RecipeBuilder.newBuilder("mode_change_2","dimensionreaper",20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        if(stat == 1){
            event.setFailed("运行中，无法切换模式");
        }
    })
    .addInputs(<contenttweaker:programming_circuit_a>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        data.asMap()["mode_1"]=0;
        data.asMap()["mode_2"]=1;
        data.asMap()["mode_3"]=0;
        data.asMap()["mode_4"]=0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("将运行模式变更为:以太势阱")
    .setThreadName("模式切换#2")
    .build();
//时空反演切换
RecipeBuilder.newBuilder("mode_change_3","dimensionreaper",20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        if(stat == 1){
            event.setFailed("运行中，无法切换模式");
        }
    })
    .addInputs(<contenttweaker:programming_circuit_b>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        data.asMap()["mode_1"]=0;
        data.asMap()["mode_2"]=0;
        data.asMap()["mode_3"]=1;
        data.asMap()["mode_4"]=0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("将运行模式变更为:时空反演")
    .setThreadName("模式切换#3")
    .build();
//深度撕裂切换
RecipeBuilder.newBuilder("mode_change_4","dimensionreaper",20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        if(stat == 1){
            event.setFailed("运行中，无法切换模式");
        }
    })
    .addInputs(<contenttweaker:programming_circuit_c>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        data.asMap()["mode_1"]=0;
        data.asMap()["mode_2"]=0;
        data.asMap()["mode_3"]=0;
        data.asMap()["mode_4"]=1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("将运行模式变更为:深度撕裂")
    .setThreadName("模式切换#4")
    .build();

//启动天幕引擎
RecipeBuilder.newBuilder("engine_start","dimensionreaper",2000,1)
    .addInputs([
        <contenttweaker:darkmatters>*1,
        <contenttweaker:voidmatter>*64,
    ])
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        data.asMap()["is_complete"]=1;
        data.asMap()["active_engine"]=1;
        data.asMap()["R"]=1.0;
        data.asMap()["strange_X"]=0;
        data.asMap()["darkmatter_X"]=0;
        data.asMap()["is_end"]=0;
        data.asMap()["steady_point"]=100.0;
        data.asMap()["production_structure"]=1.0;
        data.asMap()["R"]=0.0;
        ctrl.customData = data;
    })
    
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        data.asMap()["active_engine"]= 0;
        data.asMap()["is_end"]=2;
        ctrl.customData=data;
    })
    .addRecipeTooltip("启动天幕引擎 ,撕裂稳定时空")
    .addRecipeTooltip("异常时空区域的存在时间为§c100§fs")
    .build();
//R判定
RecipeBuilder.newBuilder("judgespace","dimensionreaper",40,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val active_engine = data.getInt("active_engine",0);
        val is_complete = data.getInt("is_complete",0);
        if(active_engine == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(active_engine == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val steady_point = data.getFloat("steady_point",0.0);
        val production_structure = data.getFloat("production_structure",0.0);
        var R = steady_point / production_structure;
        Sync.addSyncTask(function(){
            val redpos as IBlockPos = ctrl.pos.createPosByFacing(ctrl.facing,0,-1,12);
            val redstone = ctrl.world.getBlock(redpos);
            val redstonelv = 10;
            if(redstone.definition.id == "novaeng_core:redstone_logical_port"){
                if(R>60.0&&R<160.0){
                    val redstonelv = 10;
                    if(redstonelv!=redstone.meta){
                        ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${redstonelv}>,redpos);
                    }
                }else if(R <= 60.0 || R >= 160.0){
                    val redstonelv = 14;
                    if(redstonelv!=redstone.meta){
                        ctrl.world.setBlockState(<blockstate:novaeng_core:redstone_logical_port:power=${redstonelv}>,redpos);
                    }
                }
            }
        });
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val steady_point = data.getFloat("steady_point",0);
        val production_structure = data.getFloat("production_structure",0);
        var R = steady_point / production_structure;
        data.asMap()["R"]=R;
        if(R>200.0||R<10.0||steady_point > 200||steady_point < 10){
            data.asMap()["is_complete"]=0;
            data.asMap()["production_structure"]=0.0;
            data.asMap()["steady_point"]=0.0;
            ctrl.customData = data;
        }
        val temp = steady_point - 5;
        data.asMap()["steady_point"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个周期结束的时候会检查一次比例系数")
    .addRecipeTooltip("结束时也会降低§c5§f的稳定度")
    .addRecipeTooltip("当稳定阈值处于(60,160)这个区间时,红石逻辑端口输出强度为§910")
    .addRecipeTooltip("反之则输出强度为§414")
    .setThreadName("时空场监测")
    .build();
//异界相位操纵
RecipeBuilder.newBuilder("strange_produce","dimensionreaper",400,3)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val mode_1 = data.getInt("mode_1",0);
        val mode_2 = data.getInt("mode_2",0);
        val mode_3 = data.getInt("mode_3",0);
        val mode_4 = data.getInt("mode_4",0);
        if(stat == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && mode_2 == 1){
            event.setFailed("当前模式:以太势阱");
        }
        if(stat == 1 && mode_3 == 1){
            event.setFailed("当前模式:时空反演");
        }
        if(stat == 1 && mode_4 == 1){
            event.setFailed("当前模式:不稳定希格斯场");
        }
                if(mode_1==0&&mode_2==0&&mode_3==0&&mode_4==0){
            event.setFailed("尚未指定运行模式");
        }
     })
     .addEnergyPerTickInput(100000000000)
     .addInputs([<additions:novaextended-crystal4>*1])
     .addFluidInput(<liquid:dimensionbeam>*1000)
     .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
     })
     .addOutputs(<contenttweaker:crystalgreen>).setChance(0)
     .addOutputs(<contenttweaker:crystalpurple>).setChance(0)
     .addOutputs(<contenttweaker:crystalred>).setChance(0)
     .addOutputs(<contenttweaker:voidmatter>).setChance(0)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl =event.controller;
        val data = ctrl.customData;
        val strange_X = data.getInt("strange_X",0);
        val temp = strange_X + 1;
        data.asMap()["strange_X"]=temp;
        ctrl.customData=data;
     })
     .addRecipeTooltip("引导时空束流§f进入异常时空点")
     .addRecipeTooltip("来模拟异世界水晶的结构")
     .addRecipeTooltip("§d异界相位操纵§f模式下运行")
     .addRecipeTooltip("仅用于标识，具体产出请参照机制说明")
     .setThreadName("异界相位操纵")
     .build();
//以太势阱
RecipeBuilder.newBuilder("dark_matter_produce","dimensionreaper",400,3)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val mode_1 = data.getInt("mode_1",0);
        val mode_2 = data.getInt("mode_2",0);
        val mode_3 = data.getInt("mode_3",0);
        val mode_4 = data.getInt("mode_4",0);
        if(stat == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && mode_1 == 1){
            event.setFailed("当前模式:异界相位操纵");
        }
        if(stat == 1 && mode_3 == 1){
            event.setFailed("当前模式:时空反演");
        }
        if(stat == 1 && mode_4 == 1){
            event.setFailed("当前模式:不稳定希格斯场");
        }
                if(mode_1==0&&mode_2==0&&mode_3==0&&mode_4==0){
            event.setFailed("尚未指定运行模式");
        }
     })
     .addEnergyPerTickInput(100000000000)
     .addInputs([<eternalsingularity:eternal_singularity>*256])
     .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
     })
     .addOutputs(<contenttweaker:darkmatters>).setChance(0)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl =event.controller;
        val data = ctrl.customData;
        val darkmatter_X = data.getInt("darkmatter_X",0);
        val temp = darkmatter_X + 1;
        data.asMap()["darkmatter_X"]=temp;
        ctrl.customData=data;
     })
     .addRecipeTooltip("利用大量§9永恒奇点§f创造一个§4时空畸变点")
     .addRecipeTooltip("捕获人造引力异常点旁的奇异时空来获取§7暗物质")
     .addRecipeTooltip("仅用于标识，具体产出请参照机制说明")
     .addRecipeTooltip("§7以太势阱§f模式下运行")
     .setThreadName("以太势阱")
     .build();

//时空反演
RecipeBuilder.newBuilder("anti_entropy_produce","dimensionreaper",400,3)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val mode_1 = data.getInt("mode_1",0);
        val mode_2 = data.getInt("mode_2",0);
        val mode_3 = data.getInt("mode_3",0);
        val mode_4 = data.getInt("mode_4",0);
        if(stat == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && mode_1 == 1){
            event.setFailed("当前模式:异界相位操纵");
        }
        if(stat == 1 && mode_2 == 1){
            event.setFailed("当前模式:以太势阱");
        }
        if(stat == 1 && mode_4 == 1){
            event.setFailed("当前模式:不稳定希格斯场");
        }
        if(mode_1==0&&mode_2==0&&mode_3==0&&mode_4==0){
            event.setFailed("尚未指定运行模式");
        }
     })
     .addEnergyPerTickInput(100000000000)
     .addFluidInputs([
        <liquid:t1000> * 10000,
        <liquid:zerotempaturefluid> * 10000,
        <liquid:higgsfluid> * 100000,
        <liquid:dimensionbeam> * 10000,
     ])
     .addInputs([<contenttweaker:novamatrix>,
     <contenttweaker:tearenginee>,
     <contenttweaker:arcance_ingot>])
     .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
     })
     .addOutputs(<liquid:aefe>*100).setChance(0)
     .addOutputs(<liquid:tachyonfluid>*500).setChance(0)
     .addOutputs(<liquid:spaceframefluid>*500).setChance(0)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl =event.controller;
        val data = ctrl.customData;
        val antientropy_X = data.getInt("antientropy_X",0);
        val temp = antientropy_X + 1;
        data.asMap()["antientropy_X"]=temp;
        ctrl.customData=data;
     }) 
     .addRecipeTooltip("借助§8异常时空区域§f创造负熵构型。")
     .addRecipeTooltip("使用§3异常希格斯介质§f与§8时空束流§f突破§7熵§f的限制。")
     .addRecipeTooltip("仅用于标识，具体产出请参照机制说明")
     .addRecipeTooltip("§9时空反演§f模式下运行")
     .setThreadName("时空反演")
     .build();

//稳定度操作
RecipeBuilder.newBuilder("steady_structure","dimensionreaper",1,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val steady_point = data.getInt("steady_point",0);
        val stat = data.getInt("active_engine",0);
        val is_complete = data.getInt("is_complete",0);
        if(stat == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }
    })
    .addInputs(<contenttweaker:spacetimeframework>*1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val steady_point = data.getFloat("steady_point",0);
        val production_structure = data.getFloat("production_structure",0);
        val temp = steady_point+30.0;
        val temp2=production_structure*0.9;
        data.asMap()["steady_point"] =temp;
        data.asMap()["production_structure"] =temp2;
        ctrl.customData = data;
    })
    .addRecipeTooltip("稳定异常时空，延长异常时空区域的存在时间")
    .addRecipeTooltip("提供§930§f点稳定度，但使得产出乘数§cx0.9")
    .setThreadName("稳定框架维护")
    .build();

//产出乘数操作
RecipeBuilder.newBuilder("production_structure","dimensionreaper",1,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val steady_point = data.getFloat("steady_point",0);
        val stat = data.getInt("active_engine",0);
        val is_complete =data.getInt("is_complete",0);
        if(stat == 0){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }
    })
    .addInputs(<contenttweaker:fieldofgravitycore>*1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val steady_point = data.getFloat("steady_point",0);
        val production_structure = data.getFloat("production_structure",0);
        val temp = steady_point - 20;
        val temp2=production_structure*1.5;
        data.asMap()["steady_point"] =temp;
        data.asMap()["production_structure"] =temp2;
        ctrl.customData = data;
    })
    .addRecipeTooltip("注入引力节点，进一步扰乱异常时空稳定结构")
    .addRecipeTooltip("减少§c20§f点稳定度，但使得产出乘数§cx1.5")
    .setThreadName("引力单元注入")
    .build();

//异界相位操纵输出端口
RecipeBuilder.newBuilder("clear_1","dimensionreaper",40,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val is_end = data.getInt("is_end",0);
        val mode_1 = data.getInt("mode_1",0);
        val is_complete =data.getInt("is_complete",0);
        if( is_end == 1 ){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && is_end == 0){
            event.setFailed("异常时空已形成，反应正在进行");
        }
        if(stat==1&&is_end==2&&mode_1==0){
            event.setFailed("当前输出端口未启用");
        }
        if(stat == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }if(mode_1!=1){
            event.setFailed("端口未开放");
        }
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val strange_X = data.getInt("strange_X",0);
        val production_structure = data.getInt("production_structure",0);
        val p1 = event.factoryRecipeThread.addRecipe("clear_1");
        val temp = strange_X * production_structure;
        p1.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output" , temp, 1, false).build());
        p1.addModifier("multipler", RecipeModifierBuilder.create("modularmachinery:fluid", "output" , temp, 1, false).build());
    })
    .addOutputs([
        <contenttweaker:crystalgreen>*192,
        <contenttweaker:crystalpurple>*192,
        <contenttweaker:crystalred>*192,
        <contenttweaker:voidmatter>*64,
        <contenttweaker:superluminal_core>
    ])
    .addFluidOutputs([
        <liquid:spaceframefluid>*10000,
        <liquid:tachyonfluid>*10000
    ])
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("multiple");
        thread.removePermanentModifier("multipler");
        data.asMap()["is_end"]=1;
        data.asMap()["is_complete"]=1;
        data.asMap()["active_engine"]=0;
        data.asMap()["R"]=1.0;
        data.asMap()["strange_X"]=0;
        data.asMap()["darkmatter_X"]=0;
        data.asMap()["is_end"]=1;
        data.asMap()["steady_point"]=100.0;
        data.asMap()["production_structure"]=1.0;
        data.asMap()["R"]=0.0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§d异界相位操纵")
    .addRecipeTooltip("每运行完成一次配方则将产出加算一次")
    .addRecipeTooltip("最终产出与产出乘数§c乘算")
    .setThreadName("产出端口#1")
    .build();
//以太势阱
RecipeBuilder.newBuilder("clear_2","dimensionreaper",40,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val is_end = data.getInt("is_end",0);
        val mode_2 = data.getInt("mode_2",0);
        val is_complete =data.getInt("is_complete",0);
        if( is_end == 1 ){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && is_end == 0){
            event.setFailed("异常时空已形成，反应正在进行");
        }
        if(stat==1&&is_end==2&&mode_2==0){
            event.setFailed("当前输出端口未启用");
        }
        if(stat == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }if(mode_2!=1){
            event.setFailed("端口未开放");
        }
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val darkmatter_X = data.getInt("darkmatter_X",0);
        val production_structure = data.getInt("production_structure",0);
        val p1 = event.factoryRecipeThread.addRecipe("clear_2");
        val temp = darkmatter_X * production_structure;
        p1.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output" , temp, 1, false).build());
        p1.addModifier("multipler", RecipeModifierBuilder.create("modularmachinery:fluid", "output" , temp, 1, false).build());
    })
    .addOutputs([
        <contenttweaker:darkmatters> *1,
        <contenttweaker:superluminal_core>
    ])
    .addFluidOutputs([
        <liquid:spaceframefluid>*10000,
        <liquid:tachyonfluid>*10000
    ])
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("multiple");
        thread.removePermanentModifier("multipler");
        data.asMap()["is_end"]=1;
        data.asMap()["is_complete"]=1;
        data.asMap()["active_engine"]=0;
        data.asMap()["R"]=1.0;
        data.asMap()["strange_X"]=0;
        data.asMap()["darkmatter_X"]=0;
        data.asMap()["is_end"]=1;
        data.asMap()["steady_point"]=100.0;
        data.asMap()["production_structure"]=1.0;
        data.asMap()["R"]=0.0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§7以太势阱")
    .addRecipeTooltip("每运行完成一次配方则将产出加算一次")
    .addRecipeTooltip("最终产出与产出乘数§c乘算")
    .setThreadName("产出端口#2")
    .build();

//时空反演
RecipeBuilder.newBuilder("clear_3","dimensionreaper",40,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val stat = data.getInt("active_engine",0);
        val is_end = data.getInt("is_end",0);
        val mode_3 = data.getInt("mode_3",0);
        val is_complete =data.getInt("is_complete",0);
        if( is_end == 1 ){
            event.setFailed("未检测到异常时空区域");
        }
        if(stat == 1 && is_end == 0){
            event.setFailed("异常时空已形成，反应正在进行");
        }
        if(stat==1&&is_end==2&&mode_3==0){
            event.setFailed("当前输出端口未启用");
        }
        if(stat == 1 && is_complete == 0){
            event.setFailed("异常时空区域结构已被破坏");
        }if(mode_3!=1){
            event.setFailed("端口未开放");
        }
    })
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val antientropy_X = data.getInt("antientropy_X",0);
        val production_structure = data.getInt("production_structure",0);
        val p1 = event.factoryRecipeThread.addRecipe("clear_3");
        val temp = antientropy_X * production_structure;
        p1.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output" , temp, 1, false).build());
        p1.addModifier("multipler", RecipeModifierBuilder.create("modularmachinery:fluid", "output" , temp, 1, false).build());
    })
    .addFluidOutputs([
        <liquid:aefe>*4000,
        <liquid:spaceframefluid>*50000,
        <liquid:tachyonfluid>*50000
    ])
    .addOutputs([
        <contenttweaker:superluminal_core>
    ])
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("multiple");
        thread.removePermanentModifier("multipler");
        data.asMap()["is_end"]=1;
        data.asMap()["is_complete"]=1;
        data.asMap()["active_engine"]=0;
        data.asMap()["R"]=1.0;
        data.asMap()["strange_X"]=0;
        data.asMap()["darkmatter_X"]=0;
        data.asMap()["is_end"]=1;
        data.asMap()["steady_point"]=100.0;
        data.asMap()["production_structure"]=1.0;
        data.asMap()["R"]=0.0;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§9时空反演")
    .addRecipeTooltip("每运行完成一次配方则将产出加算一次")
    .addRecipeTooltip("最终产出与产出乘数§c乘算")
    .setThreadName("产出端口#3")
    .build();

MMEvents.onControllerGUIRender("dimensionreaper",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val active_engine = data.getInt("active_engine",0);
    val is_complete = data.getInt("is_complete",0);
    val steady_point = data.getInt("steady_point",0);
    val production_structure = data.getFloat("production_structure",0);
    val R = data.getInt("R",0);
    val mode_1 =data.getInt("mode_1",0);
    val mode_2 =data.getInt("mode_2",0);
    val mode_3 = data.getInt("mode_3",0);
    val mode_4 = data.getInt("mode_4",0);
    var info as string[] = [];
    info += "§9///////// §b天幕引擎时空监测器 §9//////////";
    if(active_engine == 0){
        info +="§c-------------§4撕裂引擎尚未启动§c-------------";
    }
    info += "当前运行模式:";
    if(mode_1==0&&mode_2==0&&mode_3==0&&mode_4==0){
        info += "§c尚未指定运行模式";
    }
    if(mode_1==1){
        info += "§d§l异界相位操纵";
    }else if(mode_2==1){
        info += "§7§l以太势阱";
    }else if(mode_3==1){
        info += "§9§l时空反演";
    }else if(mode_4==1){
        info += "§6§l深度撕裂";
    }
    if(active_engine == 1 && is_complete == 1){
    info += "异常时空区域已生成";
    info += "异常时空场§9稳定度§f:§a"+steady_point;
    info += "最终§a产出乘数§f:§a"+production_structure;
    info += "稳定阈值:§a"+R;
    info += "§4当稳定阈值小于§610§4时,空间紊乱将失控,引擎进程会被强制切断";
    info += "§9当稳定阈值大于§e200§9时,空间波动趋于稳定,届时异常时空也会消失";
    info += "§9稳定度同样遵循稳定阈值的判断";
    }
    if(is_complete == 0 && active_engine == 1){
        info += "异常时空已被破坏";
        info += "稳定阈值:§4"+R;
        info += "§c请拆除控制器,手动强行停止当前运行";
    }
    event.extraInfo = info;
});
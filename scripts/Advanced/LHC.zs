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
import crafttweaker.liquid.ILiquidStack;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;
import mods.modularmachinery.MachineController;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
val EIMAX=10;
val EIMIN = 1;
val MIMIN = 1;
val MIMAX = 10000;
val base_speed = 0.001f;
MachineModifier.setMaxThreads("lhcparticle",0);
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("超导维护"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("同步加速器阵列"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("LHC"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("粒子注入腔"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("ATLAS-CMS"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("对撞计算系统"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("暗物质拟合"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("LHCb"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("ALICE"));
MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("额外设备安装"));

MachineModifier.addCoreThread("lhcparticle",FactoryRecipeThread.createCoreThread("温控系统"));
//加速
MachineModifier.addSmartInterfaceType("lhcparticle",
    SmartInterfaceType.create("EI",1)
         .setHeaderInfo("§a能量输入§f速度范围设置")
         .setValueInfo("当前输入速度:§a%.2f")
         .setFooterInfo("§r每1倍可使加速效率提升100%%")
         .setJeiTooltip("速度范围：最低 §a%.0f 倍§f,最高 §a%.0f §f倍", 2)
);
MMEvents.onMachinePostTick("lhcparticle",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("EI");
    var EI = isNull(nullable) ? 1.0f : nullable.value;
    if(EI > EIMAX || EI < EIMIN){
        nullable.value=1.0f;
    }
    map["EI"]= EI;
    ctrl.customData = data;
});
//粒子注入上限
MachineModifier.addSmartInterfaceType("lhcparticle",
     SmartInterfaceType.create("MI",1)
     .setHeaderInfo("§9粒子输入流§f上限设置")
     .setValueInfo("当前输入上限:§a%.2f")
     .setFooterInfo("§r每1倍可使加速并行提升1点")
     .setJeiTooltip("输入上限：最低 §a%.0f 倍§f,最高 §a%.0f §f倍", 2)
);
MMEvents.onMachinePostTick("lhcparticle",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("MI");
    var MI = isNull(nullable) ? 1 : nullable.value;
    if(MI > MIMAX || MI < MIMIN){
        nullable.value=1;
    }
    map["MI"]= MI;
    ctrl.customData = data;
});
// 粒子注入腔
RecipeBuilder.newBuilder("get_particle","lhcparticle",100,1)
    .addFluidPerTickInput(<liquid:xprotonfluid> * 1)
    .addSmartInterfaceDataInput("MI",MIMIN,MIMAX)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var is_acc = data.getInt("is_acc",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        var MI = data.getInt("MI",1);
        var amount_particle = data.getInt("amount_particle");
        if(is_acc == 1){
            event.setFailed("加速器已启动");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
        if(MI == amount_particle){
            event.setFailed("达到输入上限");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var is_acc = data.getInt("is_acc",0);
        var amount_particle = data.getInt("amount_particle",0);
        if(is_acc==0){
            amount_particle+=1;
        }
        data.asMap()["amount_particle"]=amount_particle;
        ctrl.customData=data;
    })
    .addRecipeTooltip("为加速器源腔注入粒子")
    .addRecipeTooltip("每完成一次注入将为加速器添加§91§f点加速并行")
    .addRecipeTooltip("在同步加速器启动前执行")
    .setThreadName("粒子注入腔")
    .build();

//超导维护 lqjx 冷却极限 lqsd 冷却速度 ksjs 开始加速
function cdwh(liquid as ILiquidStack,lqjx as float,lqsd as float){
    RecipeBuilder.newBuilder("ltzr"+liquid.name,"lhcparticle",20,1)
         .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            var tempcontrolx =data.getInt("tempcontrolx",0);
            if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
            val temperatureX = data.getFloat("temperatureX",0.0f);
            if(temperatureX > lqjx - 0.00001f){
                event.setFailed("已达当前最大冷却");
            }
         })
         .addFluidPerTickInput(liquid*1)
         .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val map = data.asMap();
            var temperatureX = data.getFloat("temperatureX",0.0f);
            if(temperatureX < lqjx){
                temperatureX +=lqsd;
                if(temperatureX > lqjx){
                    temperatureX = lqjx;
                }
                map["temperatureX"]=temperatureX;
                ctrl.customData = data;
            }
         })
         .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val temperatureX = data.getFloat("temperatureX",0.0f);
            val map = data.asMap();
            val ksjs = data.getInt("ksjs",0);
            if(temperatureX > 27000.0f){
                map["ksjs"]=1;
            }
            ctrl.customData = data;
         })
         .addRecipeTooltip("为磁体制造极低温的工作环境")
         .addRecipeTooltip("以§a"+lqsd+"*10^-2℃/t§f的速度降低到§a-"+lqjx+"℃*10^-2℃§f左右")
         .setThreadName("超导维护")
         .build();
}
cdwh(<liquid:superfluid_he>,27100.0f,100.0f);
cdwh(<liquid:zerotempaturefluid>,27100.0f,200.0f);
//同步加速器阵列
RecipeBuilder.newBuilder("acc","lhcparticle",700,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl =event.controller;
        val data =ctrl.customData;
        var amount_particle = data.getInt("amount_particle",0);
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);

        if(ksjs == 0){
            event.setFailed("未达到最低温度要求");
        }
        if(amount_particle == 0){
            event.setFailed("尚未注入粒子流");
        }
        if(lhc==1){
            event.setFailed("当前粒子流在LHC运行");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
    })
    .addEnergyPerTickInput(10000000)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var is_acc = data.getInt("is_acc",0);
        map["ein"]=0;
        map["velo"]=0.0f;
        map["is_acc"]=1;
        ctrl.customData = data;
    })
    .addSmartInterfaceDataInput("EI",EIMIN,EIMAX)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data=ctrl.customData;
        val map = data.asMap();
        var amount_particle = data.getInt("amount_particle",0);
        val bl = event.factoryRecipeThread;
        var Estatus = data.getInt("EI",1);
        var ein = data.getFloat("ein",0.0f);
        var einsign = data.getInt("einsign",0);
        var lhc = data.getInt("lhc",0);
        bl.addModifier("mul",RecipeModifierBuilder.create("modularmachinery:energy","input",Estatus*amount_particle,1,false).build());
        var velo = data.getFloat("velo",0.0f);
        if(velo < 2.99f){
            velo+=base_speed*Estatus*2;
            if(velo > 2.99f){
                velo=2.99f;
                einsign=1;
            }
        }
        if(einsign==1 && lhc==0){
            ein+=0.01f;
        }
        map["velo"]=velo;
        map["ein"]=ein;
        map["einsign"]=einsign;
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        val map = data.asMap();
        map["lhc"]=1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("当温度低于§9-27000*10^-2℃§f时可以启动")
    .addRecipeTooltip("加速粒子至§e亚光速§f状态")
    .addRecipeTooltip("当粒子处于§e亚光速§f状态时且仍处于§a加速周期§f内")
    .addRecipeTooltip("每§ctick§f粒子的§9相对论质量§f都会增加")
    .addRecipeTooltip("影响产物的§c产出")
    .addRecipeTooltip("在§9智能数据接口§f处选择能量输入倍率")
    .setThreadName("同步加速器阵列")
    .build();
//LHC
RecipeBuilder.newBuilder("mainlhc","lhcparticle",40,4)
     .addFluidPerTickInput(<liquid:xprotonfluid>*1)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var ksjs = data.getInt("ksjs",0);
        var lhc = data.getInt("lhc",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        if(lhc==0&&ksjs==1){
            event.setFailed("尚未打开环舱");
        }
        if(ksjs==0){
            event.setFailed("未达到最低温度要求");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
     })
     .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var atlasx = data.getInt("atlasx",0);
        var lhcb = data.getInt("lhcb",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var lhcb_point = data.getInt("lhcb_point",0);
        val thread = event.factoryRecipeThread;
        val amount_particle = data.getInt("amount_particle",0);
        val EI = data.getFloat("EI",0.0f);
        thread.addPermanentModifier("mule",RecipeModifierBuilder.create("modularmachinery:energy","input",EI*amount_particle,1,false).build());
        thread.addPermanentModifier("mulp",RecipeModifierBuilder.create("modularmachinery:fluid","input",amount_particle*1.0f,1,false).build());
        data.asMap()["atlasx"]=atlasx;
        data.asMap()["lhcb"]=lhcb;
        ctrl.customData=data;
     })
     .addEnergyPerTickInput(1000000)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var ein =data.getFloat("ein",0.0f);
        var amount_particle = data.getFloat("amount_particle",0.0f);
        var prod1 = data.getFloat("prod1",0.0f);
        var prod2 =data.getFloat("prod2",0.0f);
        var dark_point = data.getInt("dark_point",0);
        var einsign =data.getInt("einsign",0);
        var strengthmodel = data.getInt("strengthmodel",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var temperatureX = data.getFloat("temperatureX",0.0f);
        if(einsign == 1){
            map["atlasx"]=1;
            map["lhcb"]=1;
        }
        if(ctrl.world.getRandom().nextFloat() < 0.6 && atlas_cms_point!= 0){
            dark_point += 1;
            map["dark_point"]=dark_point;
        }
        if(ctrl.world.getRandom().nextFloat() < 0.6 && atlas_cms_point!= 0){
            strengthmodel += 1;
            map["strengthmodel"]=strengthmodel;
        }
        if(einsign == 1){
            atlas_cms_point += ctrl.world.random.nextInt(15,30);
        }
        map["atlas_cms_point"]=atlas_cms_point;
        prod1 = Math.max(ein,1.0f);
        prod2 = amount_particle*1.0f;
        if(einsign == 1){
       var punish = (amount_particle*0.005f) ;
        var tempXX = temperatureX*(1.0f-punish);
        map["temperatureX"]=tempXX;
        }
        map["prod1"]=prod1;
        map["prod2"]=prod2;
        val  thread = event.factoryRecipeThread;
        thread.removePermanentModifier("mule");
        thread.removePermanentModifier("mulp");
        ctrl.customData = data;
     })
     .addRecipeTooltip("最终的加速阶段与粒子对撞")
     .addRecipeTooltip("当LHC激活时,同步加速器的§a运行策略§f将会§c被记录§f")
     .addRecipeTooltip("每§91§f点加速并行可以增加§a1§f倍产出")
     .addRecipeTooltip("每§91§f点相对论膨胀指数可以增加§a1§f倍产出")
     .addRecipeTooltip("每完成一次运行")
     .addRecipeTooltip("每束§9质子流§f都会增加当前温度§c0.5%§f的热量")
     .setThreadName("LHC")
     .build();
RecipeBuilder.newBuilder("ctc_install","lhcparticle",20,6)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var ctc_install = data.getInt("ctc_install",0);
    if(ctc_install != 0){
        event.setFailed("已安装计算模型");
    }
 })
 .addInput(<contenttweaker:ctc_computer>*16)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["ctc_install"]=1;
    ctrl.customData = data;
 })
 .setThreadName("额外设备安装")
 .addRecipeTooltip("为LHC安装§9封闭类时曲线计算系统")
 .addRecipeTooltip("通过安装额外的§e装载系统§f增加LHC的§a观测精度")
 .addRecipeTooltip("通过§9反演系统§f的计算增加§b对撞产出")
 .build();
//ATLAS-CMS-II
RecipeBuilder.newBuilder("atlas_cms_ii","lhcparticle",80,5)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        var atlasx = data.getInt("atlasx",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        val ctc_install = data.getInt("ctc_install");
        if(ctc_install == 0){
            event.setFailed("未装载计算系统");
        }
        if(ksjs == 0 && ctc_install == 1){
            event.setFailed("未达到最低温度要求");
        }
        if(ksjs == 1 && lhc == 1 && atlasx == 0 && ctc_install == 1){
            event.setFailed("探测器离线");
        }
        if(ksjs == 1 && lhc == 1 && atlasx == 1 && atlas_cms_point <= 0 && ctc_install == 1){
            event.setFailed("未检测到对撞");
        }
        if(lhc == 0 && ksjs == 1 && ctc_install == 1){
            event.setFailed("LHC未开放");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
     })
     .addFluidPerTickOutput(<liquid:higgsfluid> * 500)
     .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        val bl = event.factoryRecipeThread;
        var prod1 = data.getFloat("prod1",0.0f);
        var prod2 = data.getFloat("prod2",0.0f);
        bl.addPermanentModifier("mule",RecipeModifierBuilder.create("modularmachinery:fluid","output",prod1+prod2,1,false).build());
     })
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        atlas_cms_point -= ctrl.world.getRandom().nextInt(5,21);
        if(atlas_cms_point < 0){
            atlas_cms_point = 0;
        }
        map["atlas_cms_point"]=atlas_cms_point;
        val bl = event.factoryRecipeThread;
        bl.removePermanentModifier("mule");
        ctrl.customData = data;
     })
     .addRecipeTooltip("§9封闭类时曲线计算系统§f可以在对撞时进行§e大规模§f的§a高精度计算")
     .addRecipeTooltip("与ATLAS-CMS监测器§9并行执行")
     .addRecipeTooltip("增加LHC的对撞产出")
     .setThreadName("对撞计算系统")
     .build();

//ATLAS-CMS
RecipeBuilder.newBuilder("atlas_cms","lhcparticle",80,5)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        var atlasx = data.getInt("atlasx",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        if(ksjs == 0){
            event.setFailed("未达到最低温度要求");
        }
        if(ksjs == 1 && lhc == 1 && atlasx == 0){
            event.setFailed("探测器离线");
        }
        if(ksjs == 1 && lhc == 1 && atlasx == 1 && atlas_cms_point <= 0){
            event.setFailed("未检测到对撞");
        }
        if(lhc == 0 && ksjs == 1){
            event.setFailed("LHC未开放");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
     })
     .addFluidPerTickOutput(<liquid:higgsfluid> * 10)
     .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        val bl = event.factoryRecipeThread;
        var prod1 = data.getFloat("prod1",0.0f);
        var prod2 = data.getFloat("prod2",0.0f);
        bl.addPermanentModifier("mule",RecipeModifierBuilder.create("modularmachinery:fluid","output",prod1+prod2,1,false).build());
     })
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        atlas_cms_point -= ctrl.world.getRandom().nextInt(5,21);
        if(atlas_cms_point < 0){
            atlas_cms_point = 0;
        }
        map["atlas_cms_point"]=atlas_cms_point;
        val bl = event.factoryRecipeThread;
        bl.removePermanentModifier("mule");
        ctrl.customData = data;
     })
     .addRecipeTooltip("启动§cATLAS§f-§eCMS§f探测器,监控粒子对撞")
     .addRecipeTooltip("每tick产出§a10mb§9异常希格斯介质")
     .addRecipeTooltip("产出受到§9加速并行§f和§9相对论膨胀指数§f影响")
     .addRecipeTooltip("每次完成后会减少§a5~20§f的对撞粒子流")
     .setThreadName("ATLAS-CMS")
     .build();

//暗物质拟合
RecipeBuilder.newBuilder("darkmatter_prod","lhcparticle",600,6)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        var lhcb = data.getInt("lhcb",0);
        var dark_point = data.getInt("dark_point",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        if(ksjs == 0){
            event.setFailed("未达到最低温度要求");
        }
        if(ksjs == 1 && lhc == 1 && lhcb == 0){
            event.setFailed("探测器离线");
        }
        if(lhc == 0 && ksjs == 1){
            event.setFailed("LHC未开放");
        }
         if(ksjs == 1 && lhc == 1 && lhcb == 1 && dark_point < 20 && atlas_cms_point != 0){
            event.setFailed("正在分析对撞粒子流");
        }
        if(ksjs == 1 && lhc == 1 && lhcb == 1 && atlas_cms_point <= 0){
            event.setFailed("未检测到对撞");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
     })
     .addInputs(<contenttweaker:voidmatter>*16)
     .addOutputs(<contenttweaker:darkmatters>)
     .addEnergyPerTickInput(10000000)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var dark_point = data.getInt("dark_point",0);
        val map = data.asMap();
        var temp = dark_point - 20;
        if(temp <0){
            temp = 0;
        }
        map["dark_point"]=temp;
        ctrl.customData = data;
     })
     .addRecipeTooltip("启动§cATLAS§f-§eCMS§f探测器,监控粒子对撞")
     .addRecipeTooltip("§9超对称粒子§f有助于我们理解暗物质的本质")
     .addRecipeTooltip("通过§7\"虚空\"§f的力量,制造出这种§7超乎寻常§f的物质")
     .addRecipeTooltip("当微观超对称捕获点数为§a20§f时执行")
     .setThreadName("暗物质拟合")
     .build();
//LHCb
RecipeBuilder.newBuilder("strengthmodel_prod","lhcparticle",100,6)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        var lhcb = data.getInt("lhcb",0);
        var strengthmodel = data.getInt("strengthmodel",0);
        var atlas_cms_point = data.getInt("atlas_cms_point",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        if(ksjs == 0){
            event.setFailed("未达到最低温度要求");
        }
        if(ksjs == 1 && lhc == 1 && lhcb == 0){
            event.setFailed("探测器离线");
        }
        if(lhc == 0 && ksjs == 1){
            event.setFailed("LHC未开放");
        }
         if(ksjs == 1 && lhc == 1 && lhcb == 1 && strengthmodel < 10 && atlas_cms_point != 0){
            event.setFailed("正在分析对撞粒子流");
        }
        if(ksjs == 1 && lhc == 1 && lhcb == 1 && atlas_cms_point <= 0){
            event.setFailed("未检测到对撞");
        }
        if(tempcontrolx == 1){
            event.setFailed("触发温控!");
        }
     })
     .addInputs(<contenttweaker:forcemanucontainer>)
     .addInputs(<mekanism:antimatterpellet>*180)
     .addInputs(<contenttweaker:hypernet_gpu_t3>)
     .addEnergyPerTickInput(10000000)
     .addOutputs(<contenttweaker:forcecontainer>)
     .addOutputs(<mekanism:antimatterpellet>*76).setChance(0.75)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var strengthmodel = data.getInt("strengthmodel",0);
        val map = data.asMap();
        var temp = strengthmodel - 5;
        if(temp <0){
            temp = 0;
        }
        map["strengthmodel"]=temp;
        ctrl.customData = data;
     })
     .addRecipeTooltip("启动§bLHCb§f探测器,监控粒子对撞")
     .addRecipeTooltip("揭开§d反物质§f神秘的面纱,找到一种§b特殊§f的粒子")
     .addRecipeTooltip("这种粒子有利于我们更好的理解力场的本质")
     .addRecipeTooltip("将§c算力核心§f与§b粒子井§f结合,通过复杂的分析获得一种全新的装置")
     .addRecipeTooltip("当奇异粒子捕获点数为§a5§f时执行")
     .setThreadName("LHCb")
     .build();
//温控系统
RecipeBuilder.newBuilder("tempcontrol","lhcparticle",1,7)
     .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var lhc = data.getInt("lhc",0);
        var ksjs = data.getInt("ksjs",0);
        val temperatureX = data.getInt("temperatureX",0);
        var tempcontrolx = data.getInt("tempcontrolx",0);
        if(ksjs == 0){
            event.setFailed("同步加速器未启动");
        }
        if(ksjs == 1 && lhc ==0){
            event.setFailed("LHC未启动");
        }
        if(temperatureX > 20000.0f + 0.00001f && lhc == 1){
            event.setFailed("当前温度正常");
        }
        if(tempcontrolx == 1){
            event.setFailed("温控触发,建议重新放置控制器");
        }
     })
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["tempcontrolx"]=1;
        ctrl.customData = data;
     })
     .addRecipeTooltip("当LHC启动时,温度高于§9-20000*10^-2℃§f将触发温控系统")
     .addRecipeTooltip("系统将§4强制停机§f")
     .setThreadName("温控系统")
     .build();
MMEvents.onControllerGUIRender("lhcparticle", function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    var ein = data.getInt("ein",0);
    var ksjs = data.getInt("ksjs",0);
    var tempcontrolx = data.getInt("tempcontrolx",0);
    var temperatureX = data.getFloat("temperatureX",0.0f);
    var velo = data.getFloat("velo",0.0f);
    var amount_particle = data.getInt("amount_particle",0);
    var atlas_cms_point = data.getInt("atlas_cms_point",0);
    var atlasx = data.getInt("atlasx",0);
    var lhcb = data.getInt("lhcb",0);
    var prod1 = data.getFloat("prod1",0.0f);
    var prod2 = data.getFloat("prod2",0.0f);
    var dark_point = data.getInt("dark_point",0);
    var einsign = data.getInt("einsign",0);
    var punish = data.getFloat("punish",0.0f);
    var strengthmodel = data.getInt("strengthmodel",0);
    var lhc = data.getInt("lhc",0);
    var info as string [] = [];
    info += "§b/////////// §9大型强子对撞机 §b////////////";
    info += "当前温度:-"+temperatureX+"*10^-2℃";
    if(lhc==0 && tempcontrolx == 0)info += "有效质子束流:"+amount_particle;
    if(lhc == 0 && ksjs == 1&& tempcontrolx == 0){
        info += "§9-------------同步加速器--------------";
        info += "单质子束流相对论膨胀指数:"+ein;
        info += "粒子速度:"+velo+"*10^8 m/s";
        info += "§9-------------------------------------";
    }
    if(atlasx == 1&& tempcontrolx== 0){
        info += "§9----------------------------";
        info += "§cATLAS§f-§eCMS§f探测器§a在线";
        info += "当前§9加速并行§f产出乘数"+prod2;
        info += "当前§e相对论膨胀指数§f产出乘数"+prod1;
        info+="当前微观§b超对称§f捕获点数:"+dark_point;
    }
    if(lhcb == 1&& tempcontrolx == 0){
        info+="§9LHCb§f探测器§a在线";
        info+="当前§b奇异§f粒子捕获点数:"+strengthmodel;
        info += "§9----------------------------";
    }
    if(lhc==1&&einsign==0&& tempcontrolx == 0){
        info+="§4粒子未处于亚光速状态,建议重启加速器";
    }
    if(lhc == 1&& tempcontrolx == 0){
        info+="当前质子流输入速度要求:"+amount_particle*10+"mb/tick";
        info+="当前对撞粒子流点数:"+atlas_cms_point;
    }
    if(tempcontrolx == 1){
        info += "§4系统因温控停机";
    }
    event.extraInfo =info;
});
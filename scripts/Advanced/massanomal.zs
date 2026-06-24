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
import native.morph.avaritia.recipe.AvaritiaRecipeManager;
val INPUT_MIN = 1;
val INPUT_MAX = 10000000;
val oreMax = 2000000000;
MachineModifier.addSmartInterfaceType("massanomaldevice",
    SmartInterfaceType.create("mode_change",1)
         .setHeaderInfo("§a运行模式§f设置")
         .setValueInfo("当前运行模式:§a%d")
         .setFooterInfo("§a1:§e稳态希格斯场,§a2:§b干涉希格斯场")
);
MMEvents.onMachinePostTick("massanomaldevice",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("mode_change");
    var mode_change = isNull(nullable) ? 1 : nullable.value;
    if(mode_change != 1 && mode_change != 2){
        nullable.value=1;
    }
    map["mode_change"]=mode_change;
    ctrl.customData = data;
});
MachineModifier.addSmartInterfaceType("massanomaldevice",
    SmartInterfaceType.create("mode_2_input",1)
         .setHeaderInfo("§a时空束流注入速度§f")
         .setValueInfo("当前注入速度:§a%d")
         .setFooterInfo("§f只有处于§a2:§b干涉希格斯场§f下才会起效")
         .setJeiTooltip("速度范围：最低 §a%.0f mb/tick§f,最高 §a%.0f §fmb/tick", 2)
);
MMEvents.onMachinePostTick("massanomaldevice",function(event as MachineTickEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val nullable = ctrl.getSmartInterfaceData("mode_2_input");
    val mode_change = data.getInt("mode_change");
    var mode_2_input = isNull(nullable) ? 1 : nullable.value;
    if((mode_2_input > INPUT_MAX && mode_2_input < INPUT_MIN)&&(mode_change == 2)){
        nullable.value=1.0f;
    }
    map["mode_2_input"]=mode_2_input;
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("massanomaldevice", 0);
MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("非范式时空激发器#1").addRecipe("ma_start"));
MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("非范式时空激发器#2").addRecipe("ma2_start"));
MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("反常物质聚合").addRecipe("ma_end"));
MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("引导系统监控").addRecipe("ma2_mult"));
MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("时空束流注入").addRecipe("ma2_in"));
function reflect_ingot(nameX as string)as IOreDictEntry{
    for oreDics in oreDict.entries{
        if(oreDics.name.startsWith("ingot") && oreDics.name.contains(nameX)){
            //钴
            if(oreDics.name.contains("Oxide"))return <tconstruct:ingots>;
            return oreDics;
        }
    }
    return <contenttweaker:skydust>;
}

function reflect_singularity(nameX as string) as IOreDictEntry{
    for oreDics in oreDict.entries{
        if(oreDics.name.startsWith("singularity")&& oreDics.name.contains(nameX)){
            return oreDics;
        }
    }
    return <contenttweaker:skydust>;
}
function reflect_gem(nameX as string) as IOreDictEntry{
    for oreDics in oreDict.entries{
        if(oreDics.name.startsWith("gem") && oreDics.name.contains(nameX)){
            return oreDics;
        }
    }
    return <contenttweaker:skydust>;
}

function reflect_redstone(nameX as string) as IOreDictEntry{
    for oreDics in oreDict.entries{
        if(oreDics.name.startsWith("dust")&&oreDics.name.contains(nameX)){
            return oreDics;
        }
    }
    return <contenttweaker:skydust>;
}
var ores as IItemStack[] = [];
var nameList as string [] = [];
var nameListGem as string [] = [];
var index = 0;
var singularityname as string[] = [
    "Iron","Gold","Lapis","Redstone","Quartz","Diamond","Emerald","Copper","Tin","Lead","Silver","Nickel","Platinum","Iridium"
];
var oresofstring as string[] = [];

        for oreDics in oreDict.entries{
            if(oreDics.name.startsWith("rawOre")){
                MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("物质输出端口#"+index).addRecipe("output"+oreDics.name));
                oresofstring += "MA"+oreDics.name;
                RecipeBuilder.newBuilder("ma"+oreDics.name,"massanomaldevice",20,2)
                .addInput(oreDics)
                .addPreCheckHandler(function(event as RecipeCheckEvent){
                    val ctrl = event.controller;
                    val data = ctrl.customData;
                    var sign = data.getInt("sign",0);
                    var react = data.getInt("react",0);
                    var orecount = data.getLong("orecount",0);
                    if(sign == 0){
                        event.setFailed("未检测到异常时空场");
                    }
                    if(sign == 1){
                        event.activeRecipe.maxParallelism = 2000000000;
                    }
                    if(react == 1){
                        event.setFailed("当前状态无法输入物质");
                    }
                    if(orecount >= oreMax ){
                        event.setFailed("已达最大输入上限");
                    }
                })
                .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
                    val ctrl = event.controller;
                    val data = ctrl.customData;
                    var single_kw =data.getLong("MA"+oreDics.name,0);
                    var temp_string = oreDics.name;
                    var orecount = data.getLong("orecount",0);
                    var bxcount = event.activeRecipe.parallelism;
                    if(orecount + bxcount < oreMax){
                        single_kw += bxcount;
                    }
                    else if(orecount + bxcount > oreMax){
                        single_kw += (oreMax-orecount);
                    }
                    data.asMap()["MA"+oreDics.name]=single_kw;
                    if(orecount < oreMax){
                        data.asMap()["orecount"]=orecount+bxcount;
                    }else if(orecount > oreMax){
                        data.asMap()["orecount"]=oreMax;
                    }
                    ctrl.customData = data;
                })
                
                .addRecipeTooltip("输入粗矿,增加1点矿物单位")
                .setParallelized(true)
                .build();
                var check as string = "temp";
                var target as IOreDictEntry = <ore:arrow>;
                var singularityX as IOreDictEntry = <contenttweaker:skydust>;
                if(oreDics.name.contains("Gem")){
                    check = oreDics.name.substring("rawOreGem".length);
                    target = reflect_gem(check);
                    singularityX = reflect_singularity(check);
                }
                if(!oreDics.name.contains("Gem")){
                   check = oreDics.name.substring("rawOre".length);
                   target = reflect_ingot(check);
                   singularityX = reflect_singularity(check);
                   if(oreDics.name.contains("Redstone")){
                    target = reflect_redstone(check);
                   }
                }
                   if(!singularityX.matches(<contenttweaker:skydust>)){
                    MachineModifier.addCoreThread("massanomaldevice", FactoryRecipeThread.createCoreThread("奇点聚合端口:"+check).addRecipe("output"+singularityX.name));
                    RecipeBuilder.newBuilder("output"+singularityX.name,"massanomaldevice",20,2)
                    .addPreCheckHandler(function(event as RecipeCheckEvent){
                        val ctrl = event.controller;
                        val data = ctrl.customData;
                        var sign = data.getInt("sign",0);
                        var endsign = data.getInt("endsign",0);
                        var mult = data.getLong(check+"singularity");
                        if(sign == 1 && endsign == 1 && mult == 0){
                            event.setFailed("无法聚合奇点");
                        }
                        if(sign == 0){
                            event.setFailed("未检测到异常时空场");
                        }
                        if(sign == 1 && endsign == 0){
                            event.setFailed("反应进行中");
                        }
                    })
                    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
                        val ctrl = event.controller;
                        val data = ctrl.customData;
                        var mult = data.getLong(check+"singularity",0);
                        val Thread = event.factoryRecipeThread;
                        if(mult > 0){
                            Thread.addModifier("multiple",RecipeModifierBuilder.create("modularmachinery:item","output",mult,1,false).build());
                        }else{
                            Thread.addModifier("multiple",RecipeModifierBuilder.create("modularmachinery:item","output",mult,1,false).build());
                        }
                    })
                    .addOutputs(singularityX)
                    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
                        val ctrl = event.controller;
                        val data = ctrl.customData;
                        val map = data.asMap();
                        map[check+"singularity"]=0;
                        ctrl.customData = data;
                    })
                    .setThreadName("奇点聚合端口:"+check)
                    .addRecipeTooltip("输出奇点，仅用于标识")
                    .build();
                   }
                RecipeBuilder.newBuilder("output"+oreDics.name,"massanomaldevice",20,3)
                .addPreCheckHandler(function(event as RecipeCheckEvent){
                    val ctrl = event.controller;
                    val data = ctrl.customData;
                    var sign = data.getInt("sign",0);
                    var endsign = data.getInt("endsign",0);
                    var kwdl = data.getLong("MA"+oreDics.name);
                    if(sign == 1 && endsign == 1 && kwdl <= 0){
                        event.setFailed("没有相关物质");
                    }
                    if(sign == 0){
                        event.setFailed("未检测到异常时空场");
                    }
                    if(sign == 1 && endsign == 0){
                        event.setFailed("反应进行中");
                    }
                })
                .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
                    val ctrl = event.controller;
                    val data = ctrl.customData;
                    var kwdl = data.getLong("MA"+oreDics.name,0);
                    val Thread = event.factoryRecipeThread.addRecipe("output"+oreDics.name);
                    if(kwdl > 0){
                        Thread.addModifier("mult",RecipeModifierBuilder.create("modularmachinery:item","output",kwdl,1,false).build());
                    }else{
                        Thread.addModifier("mult",RecipeModifierBuilder.create("modularmachinery:item","output",kwdl,1,false).build());
                    }
                })
                .addOutputs(target)
                .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
                    val ctrl = event.controller;
                    val data = ctrl.customData;
                    val map = data.asMap();
                    var orecount = data.getLong("orecount",0);
                    map["orecount"]=0;
                    map["endsign"]=2;
                    map["sign"]=0;
                    map["react"]=0;
                    map["cycle"]=0;
                    map["fluidcount"]=0;
                    map["MA"+oreDics.name]=0;
                    ctrl.customData = data;
                })
                .setThreadName("物质输出端口#"+index)
                .addRecipeTooltip("输出物质，仅用于标识")
                .build();
                index=index+1;
            }
        }
for i in 1 to 10 {
    MachineModifier.addCoreThread("massanomaldevice", 
        FactoryRecipeThread.createCoreThread("物质输入端口#" + i)
    );
}
RecipeBuilder.newBuilder("ma_start", "massanomaldevice", 1000, 1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var sign = data.getInt("sign",0);
        var react = data.getInt("react",0);
        var mode_change = data.getInt("mode_change",1);
        if(mode_change == 2){
            event.setFailed("当前运行模式:干涉希格斯场");
        }
        if(sign == 1){
            event.setFailed("反应正在进行");
        }
        if(react == 1){
            event.setFailed("结算中");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var map = data.asMap();
        map["endsign"]=0;
        map["sign"]=1;
        ctrl.customData = data;
    })
    .addFluidInputs(<liquid:crystalloid>*1000)
    .addEnergyPerTickInput(1000000)
    .addFluidPerTickInput(<liquid:sulfuric_acid>*60)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var react = data.getInt("react",0);
        react = 1;
        data.asMap()["react"]=1;
        for orename in oresofstring{
            var temp = data.getLong(orename,0);
            temp*=32;
            data.asMap()[orename]=temp;
            ctrl.customData = data;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("§e稳态希格斯场的模式下启用")
    .addRecipeTooltip("通过§5紫晶素§f与§9介质§f的作用产生一级异常时空场")
    .addRecipeTooltip("固定§6x32倍§f产出矿物")
    .addRecipeTooltip("处理上限为:§c2000000000§f矿物单位,超出的会被§4销毁")
    .setThreadName("非范式时空激发器#1")
    .build();
RecipeBuilder.newBuilder("ma2_start","massanomaldevice",2400,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mode_change = data.getInt("mode_change");
        var react = data.getInt("react",0);
        val sign = data.getInt("sign",0);
        if(mode_change == 1){
            event.setFailed("当前运行模式:稳态希格斯场");
        }
        if(sign == 1){
            event.setFailed("反应进行中");
        }
        if(react == 1){
            event.setFailed("结算中");
        }
    })
    .addFluidInputs(<liquid:higgsfluid>*1000)
    .addInputs(<contenttweaker:tearenginee>).setChance(0)
    .addFluidInputs(<liquid:dimensionbeam>*1000)
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["endsign"]=0;
        map["sign"]=1;
        map["tear"]=4;
        ctrl.customData = data;
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var react = data.getInt("react",0);
        var tear = data.getInt("tear",0);
        react = 1;
        data.asMap()["react"]=1;
        for orename in oresofstring{
            var temp = data.getLong(orename,0);
            temp*=tear;
            data.asMap()[orename]=temp;
            ctrl.customData = data;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("通过§7时空束流§f与§9介质§f的相互作用")
    .addRecipeTooltip("激活§c撕裂引擎§f,产生二级异常时空场")
    .setThreadName("非范式时空激发器#2")
    .build();
    RecipeBuilder.newBuilder("ma_end","massanomaldevice",20,4)
    .addPreCheckHandler(function(event  as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var react = data.getInt("react",0);
        var endsign = data.getInt("endsign",0);
        var  sign = data.getInt("sign",0);
        if(sign == 0){
            event.setFailed("未检测到异常时空场");
        }
        if(react == 0 && sign == 1){
            event.setFailed("反应正在进行中");
        }
        if(sign == 1&&(endsign == 1 || endsign == 2)){
            event.setFailed("结算中");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        for oname in oresofstring{
            for siname in singularityname{
                var kwdl = data.getLong(oname,0);
                if(oname.contains(siname)){
                    data.asMap()[siname+"singularity"]=kwdl/56250;
                    data.asMap()[oname]=kwdl%56250;
                    ctrl.customData = data;
                }
            }
        }
        data.asMap()["endsign"]=1;
        ctrl.customData = data;
    })
    .setThreadName("反常物质聚合")
    .addRecipeTooltip("结算当前反应")
    .build();
    RecipeBuilder.newBuilder("ma2_in","massanomaldevice",20,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var mode_change = data.getInt("mode_change",1);
        var sign = data.getInt("sign",0);
        var react = data.getInt("react",0);
        var cycle = data.getInt("cycle",0);
        if(mode_change == 1){
            event.setFailed("当前运行模式:稳态希格斯场");
        }
        if(sign == 0){
            event.setFailed("未检测到异常时空场");
        }
        if(sign == 1 && react == 1){
            event.setFailed("结算中");
        }
        if(cycle == 5){
            event.setFailed("输入已终止");
        }
    })
    .addFluidPerTickInput(<liquid:dimensionbeam>)
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mode_2_input = data.getFloat("mode_2_input",0);
        val Thread = event.factoryRecipeThread.addRecipe("ma2_in");
        Thread.addModifier("multiple",RecipeModifierBuilder.create("modularmachinery:fluid","input",mode_2_input,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var mode_2_input = data.getFloat("mode_2_input");
        var fluidcount = data.getLong("fluidcount",0);
        val map = data.asMap();
        fluidcount += mode_2_input * 20;
        map["fluidcount"]=fluidcount;
        ctrl.customData = data;
    })
    .addRecipeTooltip("在二级异常时空场中注入§7时空束流")
    .addRecipeTooltip("需要§c适当控制§f流体的输入量,以§a维持§f异常时空场存在")
    .setThreadName("时空束流注入")
    .build();
    RecipeBuilder.newBuilder("ma2_mult","massanomaldevice",400,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var mode_change = data.getInt("mode_change",1);
        var react = data.getInt("react",0);
        var cycle = data.getInt("cycle",1);
        var sign = data.getInt("sign",0);
        if(mode_change == 1){
            event.setFailed("当前运行模式:稳态希格斯场");
        }
        if(sign == 0){
            event.setFailed("未检测到异常时空场");
        }
        if(sign == 1 && react == 1){
            event.setFailed("结算中");
        }
        if(cycle == 5){
            event.setFailed("结算中");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        var fluidcount = data.getLong("fluidcount",0);
        var orecount = data.getLong("orecount",0);
        var judge_max = orecount/100;
        var judge_min = orecount/1000;
        val map = data.asMap();
        var cycle = data.getInt("cycle",1);
        if(fluidcount >= judge_min *0.95 && fluidcount <= judge_max * 1.05){
            var tear = data.getInt("tear",4);
            tear*=4;
            if(tear > 512)tear = 512;
            map["tear"]=tear;
            ctrl.customData = data;
        }
        cycle+=1;
        map["cycle"]=cycle;
        map["fluidcount"]=0;
        ctrl.customData = data;
    })
    .setThreadName("引导系统监控")
    .addRecipeTooltip("§b干涉希格斯场的模式下启用")
    .addRecipeTooltip("每次输入的§7时空束流")
    .addRecipeTooltip("不应§4超过§f矿物总量的§e1/100§f，不§9低于§f矿物总量的§e1/1000§f")
    .addRecipeTooltip("允许§c5%§f的误差")
    .addRecipeTooltip("每次检查通过则将产出乘数§a翻倍")
    .addRecipeTooltip("总共§e五个§f检查周期,最高可达§6x512§f倍产出")
    .addRecipeTooltip("处理上限为:§c2000000000§f矿物单位,超出的会被§4销毁")
    .build();
MMEvents.onControllerGUIRender("massanomaldevice",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    var orecount = data.getLong("orecount",0);
    var mode_change = data.getInt("mode_change",0);
    var info as string [] = [];
    val sign = data.getInt("sign",0);
    val tear = data.getInt("tear",4);

    info += "当前矿物总量:"+orecount;
    if(mode_change == 1){
        info += "当前运行模式:§e稳态希格斯场";
    }
    if(mode_change == 2){
        info += "当前运行模式:§b干涉希格斯场";
    }
    event.extraInfo = info;
});
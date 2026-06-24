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
val MP = 1;
val MX = 32;
MachineModifier.setMaxThreads("m2scn",0);
MachineModifier.addCoreThread("m2scn",FactoryRecipeThread.createCoreThread("黑洞发生器").addRecipe("create_singularity"));
MachineModifier.addCoreThread("m2scn",FactoryRecipeThread.createCoreThread("质量投射单元").addRecipe("mass_input"));
MachineModifier.addCoreThread("m2scn",FactoryRecipeThread.createCoreThread("霍金辐射传感器").addRecipe("evaporate"));
RecipeBuilder.newBuilder("blackhole_controller","workshop",3600)
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <modularmachinery:space_generator_factory_controller>,
    <contenttweaker:charging_crystal_block>*16,
    <avaritia:neutronium_compressor>*24,
    <eternalsingularity:eternal_singularity>*8,
    <contenttweaker:field_generator_v3>*4,
    <environmentaltech:aethium_crystal>*126
 ])
 .addOutput(<modularmachinery:m2scn_factory_controller>)
 .build();
MachineModifier.addSmartInterfaceType("m2scn",
     SmartInterfaceType.create("MI",1)
     .setHeaderInfo("§9并行§f上限设置")
     .setValueInfo("当前并行:§a%.2f")
     .setJeiTooltip("输入上限：最低 §a%.0f §f,最高 §a%.0f", 2)
);
MMEvents.onMachinePostTick("m2scn",function(event as MachineTickEvent){
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
RecipeBuilder.newBuilder("create_singularity","m2scn",40,1)
.addInputs([
    <appliedenergistics2:material:47>*16,
    <liquid:crystalloid>*1000,
])
.addEnergyPerTickInput(100)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var singularity_duration = data.getInt("duration",0);
    singularity_duration += 100;
    map["duration"]=singularity_duration;
    ctrl.customData = data;
})
.setThreadName("黑洞发生器")
.addRecipeTooltip("装填奇点,创造局部§0亚稳态黑洞")
.addRecipeTooltip("每完成1次配方将为§0亚稳态黑洞§f添加§9100稳定度")
.build();

RecipeBuilder.newBuilder("mass_input","m2scn",10,2)
.addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val duration = data.getFloat("duration",0.0);
    if(duration <= 0){
        event.setFailed("未找到黑洞");
    }
    event.activeRecipe.maxParallelism = 2000000;
    event.activeRecipe.parallelism = 2000000;
})
.addInputs([
    <minecraft:cobblestone>
])
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var mass = data.getInt("mass",0);
    var bxcount = event.activeRecipe.parallelism;
    mass+=bxcount;
    map["mass"]=mass;
    ctrl.customData = data;
})
.addRecipeTooltip("质量投射单元")
.addRecipeTooltip("投入质量,每完成1次配方将增加1点黑洞质量")
.addRecipeTooltip("该配方的并行上限为§22000000")
.build();
RecipeBuilder.newBuilder("evaporate","m2scn",20,5)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val duration = data.getInt("duration",0);
    if(duration <= 0 ){
        event.setFailed("未找到黑洞");
    }
 })
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var duration = data.getInt("duration",0);
    duration -= 1.0;
    map["duration"]=duration;
    ctrl.customData = data;
 })
 .addOutput(<appliedenergistics2:material:6>*968)
 .addOutput(<appliedenergistics2:material:47>*64)
 .setThreadName("霍金辐射传感器")
 .addRecipeTooltip("每1s黑洞稳定度减少1.0")
 .addRecipeTooltip("同时抛射出一些黑洞物质")
 .build();
    MachineModifier.addCoreThread("m2scn",FactoryRecipeThread.createCoreThread("物质解压单元").addRecipe("singularity_output"));
    RecipeBuilder.newBuilder("singularity_output","m2scn",100,3)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val mass = data.getInt("mass",0);
        val MI = data.getInt("MI",0);
        var produce = data.getFloat("produce",1.0);
        val duration = data.getInt("duration",0);
        if(duration <= 0){
            event.setFailed("未找到黑洞");
        }else if(duration > 0 && mass <= 0){
            event.setFailed("质量装填不足");
        }else if(mass-MI*959250<0){
            event.setFailed("质量装填不足");
        }
        else{
            val para = data.getInt("MI",1);
            event.activeRecipe.parallelism = para;
            event.activeRecipe.maxParallelism = para;
            val mass_jud = mass/100;
            var jud = (mass_jud/duration) as float;
            if(jud > 400.0){
                map["produce"]=1.0;
                ctrl.customData = data;
            }else if(jud > 100.0 && jud < 400.0){
                map["produce"] = 5.0;
                ctrl.customData = data;
            }else if(jud < 100.0){
                map["produce"]=1.0;
                ctrl.customData = data;
            }
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val produce = data.getFloat("produce",1.0);
        val thread = event.factoryRecipeThread;
        thread.addModifier("mult",RecipeModifierBuilder.create("modularmachinery:item","output",produce,1,false).build());
    })
    .addEnergyPerTickInput(1000000)
    .addInput(<contenttweaker:data_model_copper>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_gold>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_silver>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_platinum>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_lead>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_nickel>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_redstone>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_diamond>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_iridium>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_quartz>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_emerald>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_iron>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_electrum_flux>).setParallelizeUnaffected(true).setChance(0)
    .addInput(<contenttweaker:data_model_tin>).setParallelizeUnaffected(true).setChance(0)
    .addOutput(<eternalsingularity:eternal_singularity>*16)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var mass = data.getInt("mass",0);
        var bxcount = event.activeRecipe.parallelism;
        if(mass-(959250*bxcount)<0){
            map["mass"]=0;
            ctrl.customData = data;
        }else{
            mass-=959250*bxcount;
            map["mass"]=mass;
            ctrl.customData = data;
        }
    })
    .setThreadName("物质解压单元")
    .addRecipeTooltip("解压物质奇点")
    .addRecipeTooltip("每1并行的解压将消耗§6959250§f质量单位")
    .addRecipeTooltip("§c100.0§f<(§0黑洞质量§f/§a100§f)/§9稳定度§f<§e400.0§f时,产出将会翻§a5§f倍")
    .addRecipeTooltip("在§9智能数据接口§f处调整并行")
    .addRecipeTooltip("该配方的并行上限为32")
    .build();
MMEvents.onControllerGUIRender("m2scn",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val mass = data.getInt("mass",0);
    val duration = data.getInt("duration",0);
    val produce = data.getFloat("produce",0);
    var info as string [] = [];
    info += "§5////////§9奇点监测核心§5////////";
    info += "§9当前质量:§6"+mass;
    info += "§9当前稳定度:§a"+duration;
    info += "§9产值比:§e"+(mass/100)/duration;
    info += "§9当前产出倍数:§a"+produce;
    event.extraInfo = info;
});
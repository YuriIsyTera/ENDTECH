#reloadable


import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.IngredientArrayPrimer;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MMEvents;
import crafttweaker.item.IItemStack;
RecipeBuilder.newBuilder("nast_controllerMAKE","machine_arm",800,1)
.addEnergyPerTickInput(100000)
 .addInputs([
    <contenttweaker:sensor_v1>*8,
    <thermalfoundation:fertilizer>*64,
    <immersiveengineering:metal_device1:13>*16,
    <minecraft:sapling>*64,
    <minecraft:glowstone>*8,
    <liquid:water>*10000
 ])
 .addOutput(<modularmachinery:nast_factory_controller>)
 .build();
val catalystarray = IngredientArrayBuilder.newBuilder().addIngredients([<thermalfoundation:fertilizer> * 3,<thermalfoundation:fertilizer:1> * 2,<thermalfoundation:fertilizer:2> * 1]);
MachineModifier.setMaxThreads("nast",0);
for i in 1 to 47{
    MachineModifier.addCoreThread("nast",FactoryRecipeThread.createCoreThread("生态垂直培养基#"+i));
}
RecipeBuilder.newBuilder("stew_nast_output","nast",200,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val count = data.getInt("count",0);
    if(count < 16000){
        event.setFailed("未达到最低输出点数");
    }
    var limit_bx = count / 16000;
    var bx = min(limit_bx,64);
    event.activeRecipe.maxParallelism = bx;
    event.activeRecipe.parallelism = bx;
 })
     .addInputs([
        <avaritia:resource:2>*16,
        <liquid:crystalloid>*100
    ])
    .addEnergyPerTickInput(1000000)
    .addOutput(<avaritia:ultimate_stew>)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var count = data.getInt("count",0);
        count -= event.activeRecipe.parallelism*16000;
        if(count > 0){
            map["count"]=count;
            ctrl.customData = data;
        }else{
            map["count"]=0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("通过生态演化点数导出一种神奇的产物")
    .addRecipeTooltip("每16000点数可执行一次配方")
    .addRecipeTooltip("该配方并行上限为64")
    .setThreadName("无尽聚合模块")
    .build();
MachineModifier.addCoreThread("nast",FactoryRecipeThread.createCoreThread("无尽聚合模块").addRecipe("stew_nast_output"));
MachineModifier.addCoreThread("nast",FactoryRecipeThread.createCoreThread("魔力培养模块").addRecipe("flower_nast"));
RecipeAdapterBuilder.create("nast", "thermalexpansion:insolator_tree")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input",0.025, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy","input",19980.0f,0, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 2048;
    })
    .addCatalystInput(catalystarray,
        ["输入肥料时,产出乘16,并且时间减半"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 16.0f, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05f, 1, false).build(),
        ]
    ).setChance(1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var bxcount = event.activeRecipe.parallelism;
        var count = data.getInt("count",0);
        count += bxcount;
        map["count"]=count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每完成一次培养将增加1点生态点数")
    .addRecipeTooltip("每个配方最高拥有2048并行")
    .setMaxThreads(1)
    .build();

RecipeAdapterBuilder.create("nast", "thermalexpansion:insolator")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input",0.05, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy","input",19980.0f,0, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 2048;
    })
    .addCatalystInput(catalystarray,
        ["输入肥料时,产出乘16,并且时间减半"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 16.0f, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.05f, 1, false).build(),
        ]
    ).setChance(1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var bxcount = event.activeRecipe.parallelism;
        var count = data.getInt("count",0);
        count += bxcount;
        map["count"]=count;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每完成一次培养将增加1点生态点数")
    .addRecipeTooltip("每个配方最高拥有2048并行")
    .setMaxThreads(1)
    .build();
    RecipeBuilder.newBuilder("flower_nast","nast",40,1)
    .addInputs([
        <liquid:fluidedmana>*1
    ])
        .addCatalystInput(catalystarray,
        ["输入肥料时,产出乘16,并且时间减半"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 16.0f, 1, false).build(),
            RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.5f, 1, false).build(),
        ]
    ).setChance(1)
    .addOutputs([
        <botania:petal>*16,
        <botania:petal:1>*16,
        <botania:petal:2>*16,
        <botania:petal:3>*16,
        <botania:petal:4>*16,
        <botania:petal:5>*16,
        <botania:petal:6>*16,
        <botania:petal:7>*16,
        <botania:petal:8>*16,
        <botania:petal:9>*16,
        <botania:petal:10>*16,
        <botania:petal:11>*16,
        <botania:petal:12>*16,
        <botania:petal:13>*16,
        <botania:petal:14>*16,
    ])
    .addOutput(<contenttweaker:iridescence>*16).setChance(0.5)
    .addRecipeTooltip("产出魔力花瓣")
    .setThreadName("魔力培养模块")
    .build();

    MMEvents.onControllerGUIRender("nast", function(event as ControllerGUIRenderEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        var count = data.getInt("count",0);
        var info as string[] = ["生态演化点数:" + count + ""];
        event.extraInfo = info;
    });
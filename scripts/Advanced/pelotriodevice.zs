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
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;
MachineModifier.setMaxThreads("pelotriodevice",0);
MachineModifier.addCoreThread("pelotriodevice",FactoryRecipeThread.createCoreThread("唤生锚点"));
MachineModifier.addCoreThread("pelotriodevice",FactoryRecipeThread.createCoreThread("混沌苏生仪式"));
MachineModifier.addCoreThread("pelotriodevice",FactoryRecipeThread.createCoreThread("盖亚苏生仪式"));
MachineModifier.addCoreThread("pelotriodevice",FactoryRecipeThread.createCoreThread("解包仪式"));
RecipeBuilder.newBuilder("pelotrio_controllerMAKE","machine_arm",3600)
    .addEnergyPerTickInput(40000000)
    .addInputs([
        <liquid:fluidedmana>*100000,
        <liquid:astralsorcery.liquidstarlight>*100000
    ])
    .addItemInputs([
        <draconicadditions:chaotic_energy_core>*4,
        <additions:novaextended-novaextended_medal5>*4,
        <draconicevolution:awakened_core>*8,
        <botania:storage:4>*64,
        <botania:storage>*32,
        <botania:storage:1>*4,
        <extrabotany:blockorichalcos>,
        <extrabotany:lens:6>.withTag({}),
        <contenttweaker:charging_crystal_block>*16
    ])
    .addOutputs([
        <modularmachinery:pelotriodevice_factory_controller>
    ])
    .build();
RecipeBuilder.newBuilder("maintain_connect_pelotriodevice_2","pelotriodevice",2000,1)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["dragon"]=1;
    map["mana"]=0;
    ctrl.customData = data;
 })
 .addInput(<minecraft:dragon_egg>).setChance(0).setParallelizeUnaffected(true)
 .addFluidPerTickInput(<liquid:lifeessence>*10)
 .setThreadName("唤生锚点")
 .addRecipeTooltip("唤醒新生的生命")
 .addRecipeTooltip("当唤生锚点运行此配方时可执行混沌苏生仪式")
 .build();
 RecipeBuilder.newBuilder("maintain_connect_pelotriodevice_1","pelotriodevice",2000,1)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["dragon"]=0;
    map["mana"]=1;
    ctrl.customData = data;
 })
 .addInput(<extrabotany:natureorb>.withTag({})).setChance(0).setParallelizeUnaffected(true)
 .addFluidPerTickInput(<liquid:fluidedmana>*10)
 .setThreadName("唤生锚点")
 .addRecipeTooltip("唤醒新生的生命")
 .addRecipeTooltip("当唤生锚点运行此配方时可执行盖亚苏生仪式")
 .build();

RecipeBuilder.newBuilder("output_dragon_pelotrio","pelotriodevice",400,1)
 .addPostCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val dragon = data.getInt("dragon",0);
    if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        event.setFailed("未检测到唤生锚点");
    }else if(!isNull(ctrl.recipeThreadList[0].activeRecipe)&& dragon == 0){
        event.setFailed("混沌仪式无法激活");
    }
 })
 .addEnergyPerTickInput(1000000)
     .addCatalystInput(<contenttweaker:awakened_draconium_plasma_nozzle>,
        ["启动龙素等离子喷口,产出x2"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2.0,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<contenttweaker:chaostic_draconium_resonant_tube>,
        ["启动混沌谐振管,产出x2"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2.0,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
 .addInput(<draconicevolution:draconic_ingot>*4)
 .addOutput(<draconicevolution:dragon_heart>*2)
 .addOutput(<draconicadditions:chaos_heart>)
 .addOutput(<draconicevolution:chaos_shard>*16)
 .addOutput(<draconicevolution:draconic_block>*4).setChance(0.5)
 .addRecipeTooltip("生命于混沌的涨落")
 .setThreadName("混沌苏生仪式")
 .build();

RecipeBuilder.newBuilder("output_mana_pelotrio","pelotriodevice",400,1)
 .addPostCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val mana = data.getInt("mana",0);
    if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        event.setFailed("未检测到唤生锚点");
    }else if(!isNull(ctrl.recipeThreadList[0].activeRecipe)&& mana == 0){
        event.setFailed("盖亚仪式无法激活");
    }
 })
 .addEnergyPerTickInput(1000000)
 .addInput(<extrabotany:material:6>).setChance(0.5)
 .addInput(<extrabotany:material:9>).setChance(0.5)
 .addOutput(<extrabotany:material:3>*8)
      .addCatalystInput(<contenttweaker:mana_core>,
        ["解放魔力,产出x2"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2.0,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<botania:specialflower>.withTag({type: "asgardandelion"}),
        ["无尽催化,产出x2"],
        [RecipeModifierBuilder.create("modularmachinery:item","output",2.0,1,false).build()]
    ).setChance(0).setParallelizeUnaffected(true)
 .addOutputs([
    <extrabotany:blockphotonium>*4,
    <extrabotany:blockshadowium>*4,
    <botania:manaresource:5>*18,
    <botania:manaresource:14>*8,
    <extrabotany:material:6>,
    <extrabotany:material:9>,
    <extrabotany:specialbag>*4
 ])
 .addOutput(<avaritiatweaks:gaia_block>*4).setChance(0.5)
 .addRecipeTooltip("魔力之复苏")
 .setThreadName("盖亚苏生仪式")
 .build();

 RecipeBuilder.newBuilder("unpack_pelotriodevice","pelotriodevice",20)
  .addInput(<extrabotany:specialbag>*16)
      .addOutput(<extrabotany:lens:6>).setChance(0.46)
    .addOutput(<extrabotany:silenteternity>).setChance(0.24)
    .addOutput(<extrabotany:coregod>).setChance(0.18)
    .addOutput(<extrabotany:material:3>*8)
    .addRecipeTooltip("UNPACK!")
    .build();
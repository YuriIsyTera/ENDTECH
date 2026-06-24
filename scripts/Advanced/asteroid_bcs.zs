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

MachineModifier.setMaxThreads("asteroidbcs",0);
MachineModifier.addCoreThread("asteroidbcs",FactoryRecipeThread.createCoreThread("采集模块"));
MachineModifier.addCoreThread("asteroidbcs",FactoryRecipeThread.createCoreThread("数据拟合"));
RecipeBuilder.newBuilder("normal_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:normalplanet>).setChance(0)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
 .addItemOutput(<novaeng_core:raw_ore_gem_lapis> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_coal> * 100).setChance(0.689)
.addItemOutput(<mets:niobium_ore> * 100).setChance(0.689)
.addItemOutput(<thermalfoundation:ore_fluid:2> * 100).setChance(0.168)
.addItemOutput(<novaeng_core:raw_ore_lithium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_platinum> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_nickel> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_silver> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_iridium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gold> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_osmium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_iron> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_boron> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_karmesine> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_vibranium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_copper> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_tin>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_lead> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_redstone> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_charged_certus_quartz> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_certus_quartz> * 100).setChance(0.689)
.addItemOutput(<astralsorcery:blockcustomore> * 100).setChance(0.689)
.addItemOutput(<draconicevolution:draconium_ore> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_dilithium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_ovium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_jauxum> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_titanium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_thorium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_uranium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_magnesium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_diamond> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_aluminium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_emerald>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_dimensional_shard>* 100).setChance(0.689)
.addItemOutput(<draconicevolution:draconium_dust>*100).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();

RecipeBuilder.newBuilder("hell_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:hellplanet>).setChance(0)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
.addItemOutput(<novaeng_core:raw_ore_tiberium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_prometheum> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_gem_quartz> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_valyrium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_cobalt>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_ardite> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_ancient_debris> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_osram> * 100).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();
RecipeBuilder.newBuilder("ender_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:enderplanet>).setChance(0)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
.addItemOutput(<novaeng_core:raw_ore_palladium> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_uru> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_abyssum> * 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_aurorium>* 100).setChance(0.689)
.addItemOutput(<novaeng_core:raw_ore_duranite> * 100).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();

RecipeBuilder.newBuilder("shing_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:shingplanet>).setChance(0)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
.addItemOutput(<minecraft:nether_star> * 256).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();

RecipeBuilder.newBuilder("oristcha_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:orichalcosplanet>).setChance(0)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
.addItemOutput(<botania:manaresource:1> * 100).setChance(0.689)
.addItemOutput(<botania:manaresource:2> * 100).setChance(0.689)
.addItemOutput(<botania:manaresource> * 256).setChance(0.689)
.addItemOutput(<botania:manaresource:5> * 32).setChance(0.689)
.addItemOutput(<botania:manaresource:14> * 24).setChance(0.689)
.addItemOutput(<extrabotany:material:3> * 10).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();

RecipeBuilder.newBuilder("infinity_asteroid_minig","asteroidbcs",40,1)
 .addEnergyPerTickInput(10000)
 .addInput(<contenttweaker:infinityplanet>).setChance(0.1)
 .addInput(<contenttweaker:oredrone1>).setChance(0.2)
 .addInput(<contenttweaker:mk1rocket>).setChance(0.2)
.addItemOutput(<avaritia:resource:5> * 64).setChance(0.689)
.addItemOutput(<avaritia:resource:6>*4).setChance(0.1)
.addItemOutput(<avaritia:block_resource:1>).setChance(0.01)
.addItemOutput(<contenttweaker:ljgz>* 256).setChance(0.689)
.addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var data_upgrade = data.getInt("data_upgrade",0);
    data_upgrade += 1;
    map["data_upgrade"]=data_upgrade;
    ctrl.customData = data;
})
.addRecipeTooltip("§9在行星表面进行采集,并通过运载系统运输返回")
.addRecipeTooltip("由于技术限制,我们目前无法将采集系统永久部署在虹彩行星上")
.addRecipeTooltip("每完成一次开采增加§c1§f点§a行星地质分析点数")
.setThreadName("采集模块")
.build();
// RecipeBuilder.newBuilder("data_output","asteroidbcs",40,2)
//  .addPreCheckHandler(function(event as RecipeCheckEvent){
//     val ctrl = event.controller;
//     val data = ctrl.customData;
//     val map = data.asMap();
//     var data_upgrade = data.getInt("data_upgrade",0);

//  })
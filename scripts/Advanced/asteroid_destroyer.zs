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

MachineModifier.setMaxThreads("asteroid_destroyer", 0);
MachineModifier.addCoreThread("asteroid_destroyer", FactoryRecipeThread.createCoreThread("行星集群拟合 #1").addRecipe("getgroup_normal"));
MachineModifier.addCoreThread("asteroid_destroyer", FactoryRecipeThread.createCoreThread("行星集群拟合 #2").addRecipe("getgroup_hell"));
MachineModifier.addCoreThread("asteroid_destroyer", FactoryRecipeThread.createCoreThread("行星集群拟合 #3").addRecipe("getgroup_ender"));
for i in 1 to 5 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("智能解构阵列#" + i).addRecipe("overworldmining")
    );
}

for i in 5 to 9 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("智能解构阵列#" + i).addRecipe("hellmining")
    );
}

for i in 9 to 13 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("智能解构阵列#" + i).addRecipe("endermining")
    );
}
for i in 1 to 5 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("余烬解构阵列#" + i).addRecipe("overworldmining_fuse")
    );
}
for i in 5 to 9 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("余烬解构阵列#" + i).addRecipe("hellmining_fuse")
    );
}
for i in 9 to 13 {
    MachineModifier.addCoreThread("asteroid_destroyer", 
        FactoryRecipeThread.createCoreThread("余烬解构阵列#" + i).addRecipe("endermining_fuse")
    );
}
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("额外解构阵列 #1").addRecipe("nether_star_mining"));
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("额外解构阵列 #2").addRecipe("infinite_star_mining"));
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("额外解构阵列 #3").addRecipe("oriha_star_mining"));
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("数据恢复").addRecipe("upgrade_omg_thor"));
//闪耀行星开采
RecipeBuilder.newBuilder("nether_star_mining","asteroid_destroyer",40,3)
         .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
            if(is_speed_upgrade == 0){
                event.setFailed("尚未安装对应的改装模块");
            }
         })
         .addEnergyPerTickInput(96000)
         .addItemInput(<contenttweaker:shingplanet>).setChance(0.001)
         .addItemOutput(<minecraft:nether_star>*10000)
         .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val destroy_level=data.getInt("destroy_level",0);
            val countX = (destroy_level / 200) + 2;
            val nthread = event.factoryRecipeThread.addRecipe("nether_star_mining");
            nthread.addModifier("multipleX", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
         })
         .setThreadName("额外解构阵列 #1")
         .addRecipeTooltip("通过对基本资源行星的采集策略优化")
         .addRecipeTooltip("我们可以将这个额外的采集阵列交给内置AI进行代理")
         .addRecipeTooltip("有§c0.1%§f会使得闪耀行星消失")
         .addRecipeTooltip("产出也受§c解构等级§f提供的额外倍率影响")
         .build();
//虹彩行星开采
RecipeBuilder.newBuilder("infinite_star_mining","asteroid_destroyer",40,3)
         .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
            if(is_speed_upgrade == 0){
                event.setFailed("尚未安装对应的改装模块");
            }
         })
         .addEnergyPerTickInput(96000)
         .addItemInput(<contenttweaker:infinityplanet>).setChance(0.01)
         .addOutput(<avaritia:resource:5>*32).setChance(0.4)
         .addOutput(<avaritia:resource:6>*16).setChance(0.01)
         .addOutput(<avaritia:block_resource:1>*8).setChance(0.001)
         .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val destroy_level=data.getInt("destroy_level",0);
            val countX = (destroy_level / 200) + 2;
            val nthread = event.factoryRecipeThread.addRecipe("infinite_star_mining");
            nthread.addModifier("multipleX", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
         })
         .setThreadName("额外解构阵列 #2")
         .addRecipeTooltip("通过对稀有资源行星的采集策略优化")
         .addRecipeTooltip("我们可以将这个额外的采集阵列交给内置AI进行代理")
         .addRecipeTooltip("有§c1%§f会使得虹彩行星消失")
         .addRecipeTooltip("产出也受§c解构等级§f提供的额外倍率影响")
         .build();
//山铜行星开采
RecipeBuilder.newBuilder("oriha_star_mining","asteroid_destroyer",40,3)
         .addPreCheckHandler(function(event as RecipeCheckEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
            if(is_speed_upgrade == 0){
                event.setFailed("尚未安装对应的改装模块");
            }
         })
         .addEnergyPerTickInput(96000)
         .addInput(<contenttweaker:orichalcosplanet>).setChance(0.01)
         .addOutput(<botania:manaresource:5>*460).setChance(0.9)
         .addOutput(<extrabotany:material:1>*320).setChance(0.8)
         .addOutput(<extrabotany:blockorichalcos>*80).setChance(0.1)
         .addOutput(<extrabotany:material:8>*460).setChance(0.8)
         .addOutput(<extrabotany:material:5>*460).setChance(0.8)
         .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
            val ctrl = event.controller;
            val data = ctrl.customData;
            val destroy_level=data.getInt("destroy_level",0);
            val countX = (destroy_level / 200) + 2;
            val nthread = event.factoryRecipeThread.addRecipe("oriha_star_mining");
            nthread.addModifier("multipleX", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
         })
         .setThreadName("额外解构阵列 #3")
         .addRecipeTooltip("通过对稀有资源行星的采集策略优化")
         .addRecipeTooltip("我们可以将这个额外的采集阵列交给内置AI进行代理")
         .addRecipeTooltip("有§c1%§f会使得山铜行星消失")
         .addRecipeTooltip("产出也受§c解构等级§f提供的额外倍率影响")
         .build();

MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("#改装模块-高能激光").addRecipe("upgrade_structure"));
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("#改装模块-余烬熔炼").addRecipe("upgrade_structure_2"));
RecipeBuilder.newBuilder("upgrade_structure","asteroid_destroyer",200,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        val destroy_level = data.getInt("destroy_level",0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade");
        //  if(destroy_level < 200){
        //      event.setFailed("解构等级不足,改装平台尚未开放");
        //  }
        if(is_speed_upgrade == 1){
            event.setFailed("模块已安装");
        }
    })
    .addItemInput(<contenttweaker:thorupgrade1>*8)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val destroy_level = data.getInt("destroy_level",0);
        if(destroy_level <= 10000){
            val temp = destroy_level + 2000;
           data.asMap()["destroy_level"] = temp;
        data.asMap()["is_speed_upgrade"] = 1;
        }else if(destroy_level > 10000){
            val temp = 12000;
                   data.asMap()["destroy_level"] = temp;
        data.asMap()["is_speed_upgrade"] = 1;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("通过高能激光来进行更精准和快速的分解")
    .addRecipeTooltip("提高§c2000§f级的解构等级")
    .addRecipeTooltip("可开采:闪耀行星,虹彩行星,山铜行星")
    .setThreadName("#改装模块-高能激光")
    .build();

RecipeBuilder.newBuilder("upgrade_structure_2","asteroid_destroyer",200,4)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data =ctrl.customData;
        val destroy_level = data.getInt("destroy_level",0);
        val is_speed_upgrade_admit = data.getInt("is_speed_upgrade_admit");
        //  if(destroy_level < 200){
        //      event.setFailed("解构等级不足,改装平台尚未开放");
        //  }
        if(is_speed_upgrade_admit == 1){
            event.setFailed("模块已安装");
        }
    })
    .addItemInput(<contenttweaker:dustupgrade>*8)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_speed_upgrade_admit = data.getInt("is_speed_upgrade_admit",0);
        val destroy_level = data.getInt("destroy_level",0);
        if(destroy_level <= 10000){
            val temp = destroy_level + 2000;
           data.asMap()["destroy_level"] = temp;
        data.asMap()["is_speed_upgrade_admit"] = 1;
        }else if(destroy_level > 10000){
            val temp = 12000;
                   data.asMap()["destroy_level"] = temp;
        data.asMap()["is_speed_upgrade_admit"] = 1;
        }
        ctrl.customData = data;
    })
    .addRecipeTooltip("通过余烬解构模块来直接熔炼粗矿")
    .addRecipeTooltip("提高§c2000§f级的解构等级")
    .addRecipeTooltip("增加模式切换,可选择粗矿产出和锭产出")
    .setThreadName("#改装模块-余烬熔炼")
    .build();
MachineModifier.addCoreThread("asteroid_destroyer",FactoryRecipeThread.createCoreThread("运行模式切换").addRecipe("mode_change_thor_raw").addRecipe("mode_change_thor_fuse"));
//粗矿模式切换
RecipeBuilder.newBuilder("mode_change_thor_raw","asteroid_destroyer",20,5)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData ;
    val map = data.asMap();
    val mode = data.getInt("mode",1);
    if(mode == 1)event.setFailed("当前为粗矿模式");
 })
 .addInput(<contenttweaker:advanced_programming_circuit_a>)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["mode"]=1;
    ctrl.customData = data;
 })
 .addRecipeTooltip("将运行模式切换为粗矿输出")
 .setThreadName("运行模式切换")
 .build();
//熔炼模式切换
RecipeBuilder.newBuilder("mode_change_thor_fuse","asteroid_destroyer",20,5)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData ;
    val map = data.asMap();
    val mode = data.getInt("mode",1);
    val is_speed_upgrade_admit = data.getInt("is_speed_upgrade_admit",0);
    if(is_speed_upgrade_admit == 0){
        event.setFailed("未检测到余烬升级组件");
    }else if(is_speed_upgrade_admit == 1 && mode == 2){
        event.setFailed("当前为熔炼模式");
    }
 })
 .addInput(<contenttweaker:advanced_programming_circuit_b>)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["mode"]=2;
    ctrl.customData = data;
 })
 .addRecipeTooltip("将运行模式切换为锭输出")
 .addRecipeTooltip("需要装载余烬组件升级")
 .setThreadName("运行模式切换")
 .build();
// 普通重核行星集群输入
RecipeBuilder.newBuilder("getgroup_normal", "asteroid_destroyer", 20,1)
    .addItemInputs(<contenttweaker:normalplanet> * 1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
        val temp = asteroid_perfection_normal + 10000;
        data.asMap()["asteroid_perfection_normal"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("为§7普通重核行星集群§f添加§c10000§f点待开采总量")
    .setThreadName("行星集群拟合 #1")
    .build();

// 热域重核行星集群输入
RecipeBuilder.newBuilder("getgroup_hell", "asteroid_destroyer", 20,1)
    .addItemInputs(<contenttweaker:hellplanet> * 1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
        val temp = asteroid_perfection_hell + 10000;
        data.asMap()["asteroid_perfection_hell"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("为§c热域重核行星集群§f添加§c10000§f点待开采总量")
    .setThreadName("行星集群拟合 #2")
    .build();

// 末地重核行星集群输入
RecipeBuilder.newBuilder("getgroup_ender", "asteroid_destroyer", 20,1)
    .addItemInputs(<contenttweaker:enderplanet> * 1)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
        val temp = asteroid_perfection_ender + 10000;
        data.asMap()["asteroid_perfection_ender"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("为§5末地重核行星集群§f添加§c10000§f点待开采总量")
    .setThreadName("行星集群拟合 #3")
    .build();
// 普通重核行星开采
RecipeBuilder.newBuilder("overworldmining", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_normal == 0) {
            event.setFailed("暂无可开采的普通行星集群");
        }else if(asteroid_perfection_normal > 0 && mode == 2){
            event.setFailed("当前模式为熔炼模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val overworld_mine = event.factoryRecipeThread.addRecipe("overworldmining");
        val is_speed_upgrade =data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            overworld_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
.addItemOutput(<novaeng_core:raw_ore_gem_lapis> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_coal> * 20480).setChance(0.214)
.addItemOutput(<mets:niobium_ore> * 20480).setChance(0.214)
.addItemOutput(<thermalfoundation:ore_fluid:2> * 20480).setChance(0.168)
.addItemOutput(<novaeng_core:raw_ore_lithium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_platinum> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_nickel> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_silver> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_iridium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gold> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_osmium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_iron> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_boron> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_karmesine> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_vibranium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_copper> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_tin>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_lead> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_redstone> * 20480).setChance(0.214)
.addItemOutput(<ic2:misc_resource:1>*20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_astral_starmetal>*20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_charged_certus_quartz> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_certus_quartz> * 20480).setChance(0.214)
.addItemOutput(<astralsorcery:blockcustomore> * 20480).setChance(0.214)
.addItemOutput(<draconicevolution:draconium_ore> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_dilithium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_ovium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_jauxum> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_titanium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_thorium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_uranium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_magnesium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_diamond> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_aluminium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_aquamarine>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_amethyst>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_emerald>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_ruby>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_amber>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_peridot>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_sapphire>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_malachite>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_tanzanite>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_topaz>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_fluorite>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_dimensional_shard>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_quartz_black>* 20480).setChance(0.214)
.addItemOutput(<environmentaltech:litherite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:erodium_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:kyronite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:pladium_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:ionite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:aethium_crystal>* 4096).setChance(0.214)
.addItemOutput(<draconicevolution:draconium_dust>*20480).setChance(0.214)
.addItemOutput(<contenttweaker:geocentric_crystal>*20480).setChance(0.214)
.addItemOutput(<contenttweaker:nq_powder>*20480).setChance(0.214)
.addItemOutput(<minecraft:clay_ball>*20480).setChance(0.214)
.addItemOutput(<taiga:obsidiorite_ingot>*20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_willowalloy>*20480).setChance(0.214)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
        val destroy_degree_normal = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_normal = data.getInt("destroy_span_normal", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_normal + 1;
        data.asMap()["destroy_span_normal"] = temp1;
        ctrl.customData = data;
        if (destroy_span_normal == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_normal"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_normal == 100) {
            data.asMap()["destroy_span_normal"] = 0;
            ctrl.customData = data;
        }

        
        val temp = max(asteroid_perfection_normal - destroy_degree_normal, 0);
        data.asMap()["asteroid_perfection_normal"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .build();

// 普通重核行星熔炼
RecipeBuilder.newBuilder("overworldmining_fuse", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_normal == 0) {
            event.setFailed("暂无可开采的普通行星集群");
        }else if(asteroid_perfection_normal > 0 && mode == 1){
            event.setFailed("当前模式为粗矿模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val overworld_mine = event.factoryRecipeThread.addRecipe("overworldmining_fuse");
        val is_speed_upgrade =data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            overworld_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
    .addItemOutput(<minecraft:dye:4>*20480).setChance(0.214)
    .addItemOutput(<minecraft:coal>*20480).setChance(0.214)
    .addItemOutput(<mets:niobium_titanium_ingot>*20480).setChance(0.214)
    .addItemOutput(<nuclearcraft:ingot:6>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:134>*20480).setChance(0.214)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:1>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:133>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:130>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:135>*20480).setChance(0.214)
    .addItemOutput(<minecraft:gold_ingot>*20480).setChance(0.214)
    .addItemOutput(<mekanism:ingot:1>*20480).setChance(0.214)
    .addItemOutput(<minecraft:iron_ingot>*20480).setChance(0.214)
    .addItemOutput(<taiga:karmesine_ingot>*20480).setChance(0.214)
    .addItemOutput(<nuclearcraft:ingot:5>*20480).setChance(0.214)
    .addItemOutput(<taiga:vibranium_ingot>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:128>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:129>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:131>*20480).setChance(0.214)
    .addItemOutput(<minecraft:redstone>*20480).setChance(0.214)
    .addItemOutput(<appliedenergistics2:material>*20480).setChance(0.214)
    .addItemOutput(<appliedenergistics2:material:1>*20480).setChance(0.214)
    .addItemOutput(<draconicevolution:draconium_ingot>*20480).setChance(0.214)
    .addItemOutput(<taiga:dilithium_ingot>*20480).setChance(0.214)
    .addItemOutput(<taiga:ovium_ingot>*20480).setChance(0.214)
    .addItemOutput(<taiga:jauxum_ingot>*20480).setChance(0.214)
    .addItemOutput(<mets:titanium_ingot>*20480).setChance(0.214)
    .addItemOutput(<nuclearcraft:ingot:3>*20480).setChance(0.214)
    .addItemOutput(<mekanism:ingot:8>*20480).setChance(0.214)
    .addItemOutput(<nuclearcraft:ingot:7>*20480).setChance(0.214)
    .addItemOutput(<minecraft:diamond>*20480).setChance(0.214)
    .addItemOutput(<thermalfoundation:material:132>*20480).setChance(0.214)
    .addItemOutput(<astralsorcery:itemcraftingcomponent>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem>*20480).setChance(0.214)
    .addItemOutput(<minecraft:emerald>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:1>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:7>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:2>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:6>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:5>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:4>*20480).setChance(0.214)
    .addItemOutput(<biomesoplenty:gem:3>*20480).setChance(0.214)
    .addItemOutput(<mekanism:otherdust:7>*20480).setChance(0.214)
    .addItemOutput(<rftools:dimensional_shard>*20480).setChance(0.214)
    .addItemOutput(<actuallyadditions:item_misc:5>*20480).setChance(0.214)
    .addItemOutput(<contenttweaker:geocentric_quartz_crystal_charged>*20480).setChance(0.214)
    .addItemOutput(<environmentaltech:litherite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:erodium_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:kyronite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:pladium_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:ionite_crystal>* 4096).setChance(0.214)
.addItemOutput(<environmentaltech:aethium_crystal>* 4096).setChance(0.214)
.addItemOutput(<contenttweaker:nq_powder>*20480).setChance(0.214)
.addItemOutput(<minecraft:clay_ball>*20480).setChance(0.214)
.addItemOutput(<taiga:obsidiorite_ingot>*20480).setChance(0.214)
.addItemOutput(<additions:novaextended-ingot8>*20480).setChance(0.214)
.addItemOutput(<taiga:meteorite_ingot>*20480).setChance(0.214)
.addItemOutput(<contenttweaker:tci>*20480).setChance(0.214)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
        val destroy_degree_normal = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_normal = data.getInt("destroy_span_normal", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_normal + 1;
        data.asMap()["destroy_span_normal"] = temp1;
        ctrl.customData = data;
        if (destroy_span_normal == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_normal"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_normal == 100) {
            data.asMap()["destroy_span_normal"] = 0;
            ctrl.customData = data;
        }

        
        val temp = max(asteroid_perfection_normal - destroy_degree_normal, 0);
        data.asMap()["asteroid_perfection_normal"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .build();

// 热域重核行星开采
RecipeBuilder.newBuilder("hellmining", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_hell == 0) {
            event.setFailed("暂无可开采的热域行星集群");
        }else if(asteroid_perfection_hell > 0 && mode == 2){
            event.setFailed("当前模式为熔炼模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val hell_mine = event.factoryRecipeThread.addRecipe("hellmining");
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            hell_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
.addItemOutput(<novaeng_core:raw_ore_tiberium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_prometheum> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_gem_quartz> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_valyrium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_cobalt>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_ardite> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_ancient_debris> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_osram> * 10240).setChance(0.214)
.addItemOutput(<contenttweaker:dust>*2048).setChance(0.686)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
        val destroy_degree_hell = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_hell = data.getInt("destroy_span_hell", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_hell + 1;
        data.asMap()["destroy_span_hell"] = temp1;
        ctrl.customData = data;
        if (destroy_span_hell == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_hell"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_hell == 100) {
            data.asMap()["destroy_span_hell"] = 0;
            ctrl.customData = data;
        }
        
        val temp = max(asteroid_perfection_hell - destroy_degree_hell, 0);
        data.asMap()["asteroid_perfection_hell"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .build();
//热域行星熔炼
RecipeBuilder.newBuilder("hellmining_fuse", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_hell == 0) {
            event.setFailed("暂无可开采的热域行星集群");
        }else if(asteroid_perfection_hell > 0 && mode == 1){
            event.setFailed("当前模式为粗矿模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val hell_mine = event.factoryRecipeThread.addRecipe("hellmining_fuse");
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            hell_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
.addItemOutput(<taiga:tiberium_ingot> * 20480).setChance(0.214)
.addItemOutput(<taiga:prometheum_ingot> * 20480).setChance(0.214)
.addItemOutput(<minecraft:quartz> * 20480).setChance(0.214)
.addItemOutput(<taiga:valyrium_ingot> * 20480).setChance(0.214)
.addItemOutput(<tconstruct:ingots>* 20480).setChance(0.214)
.addItemOutput(<tconstruct:ingots:1> * 20480).setChance(0.214)
.addItemOutput(<futuremc:netherite_scrap> * 20480).setChance(0.214)
.addItemOutput(<taiga:osram_ingot> * 10240).setChance(0.214)
.addItemOutput(<contenttweaker:dust>*2048).setChance(0.686)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
        val destroy_degree_hell = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_hell = data.getInt("destroy_span_hell", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_hell + 1;
        data.asMap()["destroy_span_hell"] = temp1;
        ctrl.customData = data;
        if (destroy_span_hell == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_hell"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_hell == 100) {
            data.asMap()["destroy_span_hell"] = 0;
            ctrl.customData = data;
        }
        
        val temp = max(asteroid_perfection_hell - destroy_degree_hell, 0);
        data.asMap()["asteroid_perfection_hell"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .addRecipeTooltip("需要装载§4余烬升级组件")
    .build();

// 末地重核行星开采
RecipeBuilder.newBuilder("endermining", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_ender == 0) {
            event.setFailed("暂无可开采的末地行星集群");
        }else if(asteroid_perfection_ender > 0 && mode == 2){
            event.setFailed("当前模式为熔炼模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val ender_mine = event.factoryRecipeThread.addRecipe("endermining");
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            ender_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
.addItemOutput(<novaeng_core:raw_ore_palladium> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_uru> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_abyssum> * 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_aurorium>* 20480).setChance(0.214)
.addItemOutput(<novaeng_core:raw_ore_duranite> * 20480).setChance(0.214)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
        val destroy_degree_ender = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_ender = data.getInt("destroy_span_ender", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_ender + 1;
        
        data.asMap()["destroy_span_ender"] = temp1;
        ctrl.customData = data;
        if (destroy_span_ender == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_ender"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_ender == 100) {
            data.asMap()["destroy_span_ender"] = 0;
            ctrl.customData = data;
        }
        val temp = max(asteroid_perfection_ender - destroy_degree_ender, 0);
        data.asMap()["asteroid_perfection_ender"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .addRecipeTooltip("需要装载§4余烬升级组件")
    .build();


// 末地重核行星熔炼
RecipeBuilder.newBuilder("endermining_fuse", "asteroid_destroyer", 20,2)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
        val mode = data.getInt("mode",1);
        if (asteroid_perfection_ender == 0) {
            event.setFailed("暂无可开采的末地行星集群");
        }else if(asteroid_perfection_ender > 0 && mode == 1){
            event.setFailed("当前模式为粗矿模式");
        }
    })
    .addEnergyPerTickInput(96000)
    .addFactoryPreTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val destroy_level=data.getInt("destroy_level",0);
        val countX = (destroy_level / 200) + 2;
        val ender_mine = event.factoryRecipeThread.addRecipe("endermining_fuse");
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        if(destroy_level >= 200){
            ender_mine.addModifier("multiple", RecipeModifierBuilder.create("modularmachinery:item", "output",countX, 1, false).build());
        }
        data.asMap()["countX"] = countX;
        ctrl.customData = data;
    })
.addItemOutput(<taiga:palladium_ingot> * 20480).setChance(0.214)
.addItemOutput(<taiga:uru_ingot> * 20480).setChance(0.214)
.addItemOutput(<taiga:abyssum_ingot> * 20480).setChance(0.214)
.addItemOutput(<taiga:aurorium_ingot>* 20480).setChance(0.214)
.addItemOutput(<taiga:duranite_ingot> * 20480).setChance(0.214)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent) {
        val ctrl = event.controller;
        val data = ctrl.customData;
        val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
        val destroy_degree_ender = 1;
        val destroy_level = data.getInt("destroy_level", 0);
        val destroy_span_ender = data.getInt("destroy_span_ender", 0);
        val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
        val temp1 = destroy_span_ender + 1;
        
        data.asMap()["destroy_span_ender"] = temp1;
        ctrl.customData = data;
        if (destroy_span_ender == 100 && destroy_level < 12000) {
            val upX = destroy_level + 1;
            data.asMap()["destroy_level"] = upX;
            data.asMap()["destroy_span_ender"] = 0;
            ctrl.customData = data;
        } else if (destroy_span_ender == 100) {
            data.asMap()["destroy_span_ender"] = 0;
            ctrl.customData = data;
        }
        val temp = max(asteroid_perfection_ender - destroy_degree_ender, 0);
        data.asMap()["asteroid_perfection_ender"] = temp;
        ctrl.customData = data;
    })
    .addRecipeTooltip("每个线程每完成一次采集减少§c1§f点的待开采总量")
    .addRecipeTooltip("每完成100点采集总量就可以使得§c解构等级§f提升1级")
    .addRecipeTooltip("每200点§c解构等级§f将增加§a2§f倍产出(加算)")
    .addRecipeTooltip("需要装载§4余烬升级组件")
    .build();
    RecipeBuilder.newBuilder("upgrade_omg_thor","asteroid_destroyer",10,10)
    .addInput(<contenttweaker:thor_terminal>)
     .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["destroy_level"] = 12000;
        map["is_speed_upgrade_admit"] = 1;
        map["is_speed_upgrade"] = 1;
        map["countX"]=62;
        ctrl.customData = data;
     })
     .addRecipeTooltip("恢复解构机丢失的数据")
     .addRecipeTooltip("将解构等级提升至满级,并装配两个升级组件")
     .setThreadName("数据恢复")
     .build();
// GUI渲染事件处理
MMEvents.onControllerGUIRender("asteroid_destroyer", function(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val destroy_level = data.getInt("destroy_level", 0);
    val asteroid_perfection_normal = data.getInt("asteroid_perfection_normal", 0);
    val asteroid_perfection_hell = data.getInt("asteroid_perfection_hell", 0);
    val asteroid_perfection_ender = data.getInt("asteroid_perfection_ender", 0);
    val destroy_degree_normal = data.getInt("destroy_degree_normal", 0);
    val destroy_degree_hell = data.getInt("destroy_degree_hell", 0);
    val destroy_degree_ender = data.getInt("destroy_degree_ender", 0);
    val is_speed_upgrade_admit = data.getInt("is_speed_upgrade_admit",0);
    val countX = data.getInt("countX",0);
    val mode = data.getInt("mode",1);
    val is_speed_upgrade = data.getInt("is_speed_upgrade",0);
    var info as string[] = [];
    info += "§4/////////// §cT.H.O.R状态同步器 §4////////////";
    info += "§7普通行星集群§f可用开采点数§6:" + asteroid_perfection_normal;
    info += "§c热域行星集群§f可用开采点数§6:" + asteroid_perfection_hell;
    info += "§5末地行星集群§f可用开采点数§6:" + asteroid_perfection_ender;
    info += "§e当前§c行星§e解构等级§6:" + destroy_level;
    if(mode == 1){
        info += "§e当前模式§6:粗矿模式";
    }
    if(mode == 2){
        info += "§e当前模式§6:熔炼模式";
    }
    if(destroy_level >= 200){
        info += "§a当前§6产量§a:x"+countX;
        if(destroy_level >= 200 && is_speed_upgrade == 1){
            info += "§a高能激光组件§6已激活";
        }
        if(destroy_level >= 200 && is_speed_upgrade_admit == 1){
            info += "§4余烬熔炼组件§6已激活";
        }
    }
    event.extraInfo = info;
});
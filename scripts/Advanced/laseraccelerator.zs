#loader crafttweaker reloadable
import crafttweaker.data.IData;
import crafttweaker.enchantments.IEnchantment;
import crafttweaker.item.IItemStack;
import mods.nuclearcraft.AlloyFurnace;
import moretweaker.draconicevolution.FusionCrafting;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.research.ResearchCognitionData;
import crafttweaker.item.IIngredient;
import crafttweaker.liquid.ILiquidStack;
import mod.mekanism.gas.IGasStack;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import crafttweaker.item.IItemDefinition;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.events.IEventManager;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.ControllerGUIRenderEvent;
import crafttweaker.event.EntityLivingDeathEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import crafttweaker.event.ItemTossEvent;
import crafttweaker.event.EntityJoinWorldEvent;
import crafttweaker.entity.IEntityItem;
import crafttweaker.world.IBlockPos;
import crafttweaker.util.Math;
import mods.thermalexpansion.InductionSmelter;
import mods.modularmachinery.Sync;
import crafttweaker.world.IWorld;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import novaeng.NovaEngUtils;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.RecipeTickEvent;

MMEvents.onStructureFormed("laseraccelerator" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var cube1 = ctrl.getBlocksInPattern(<contenttweaker:energycube_mk1>);
    var cube2 = ctrl.getBlocksInPattern(<contenttweaker:energycube_mk2>);
    var cube3 = ctrl.getBlocksInPattern(<contenttweaker:energycube_mk3>);
    map["cube1"]=cube1;
    map["cube2"]=cube2;
    map["cube3"]=cube3;
    var energy_limit = data.getInt("energy_limit",0);
    energy_limit = cube1*100000+cube2*1000000+cube3*2000000;
    map["energy_limit"]=energy_limit;
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("laseraccelerator",0);
MachineModifier.addCoreThread("laseraccelerator", FactoryRecipeThread.createCoreThread("能量密度监控电脑"));
MachineModifier.addCoreThread("laseraccelerator", FactoryRecipeThread.createCoreThread("紧凑轰击舱"));
RecipeBuilder.newBuilder("energy_storage","laseraccelerator",40,1)
   .addPreCheckHandler(function(event as RecipeCheckEvent){
     val ctrl = event.controller;
     val data = ctrl.customData;
     val energy_limit = data.getLong("energy_limit",0.0);
     val energy_storage = data.getLong("energy_storage",0.0);
     val is_begin = data.getInt("is_begin",0);
     if(energy_storage >= energy_limit){
        event.setFailed("能量存储已达上限");
     }else if(is_begin == 1){
        event.setFailed("当前模式无法输入能量");
     }
   })
   .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val cube1 = data.getInt("cube1",0);
    val cube2 = data.getInt("cube2",0);
    val cube3 = data.getInt("cube3",0);
    var srsl = data.getInt("srsl",1);
    if(cube1 == 55){
        srsl=20;
    }else if(cube2 == 55){
        srsl = 100;
    }else if(cube3 == 55){
        srsl = 200;
    }
    map["srsl"]=srsl;
    ctrl.customData = data;
    val bl = event.factoryRecipeThread;
    bl.addModifier("energycost",RecipeModifierBuilder.create("modularmachinery:energy", "input",srsl, 1, false).build());
   })
   .addEnergyPerTickInput(500000)
   .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val srsl = data.getInt("srsl",1);
    val map = data.asMap();
    var energy_storage = data.getLong("energy_storage",0.0);
    val energy_limit = data.getLong("energy_limit",0.0);
    if(energy_storage + srsl*100000 >= energy_limit){
        map["energy_storage"]=energy_limit;
        map["is_full"]=1;
        ctrl.customData = data;
    }else{
        energy_storage += srsl*100000;
        map["energy_storage"]=energy_storage;
        ctrl.customData = data;
    }
   })
   .addRecipeTooltip("将能量存入能量立方中")
   .addRecipeTooltip("能量的输入速率由能量立方的等级和数量决定")
   .addRecipeTooltip("当结构内所有可替换方块为§c能量立方§7Mk§41§b§f时,输入速率为原来§a20§f倍")
   .addRecipeTooltip("全部为§e能量立方§7Mk§62§f时,输入速率为原来§a100§f倍")
   .addRecipeTooltip("全部为§b能量立方§7Mk§93§f时,输入速率为原来§a200§f倍")
   .addRecipeTooltip("不同等级的能量立方提供的容量分别为§c100K§f,§e1M§F,§b2M")
   .addRecipeTooltip("充能完毕时自动进入待机状态")
   .setThreadName("能量密度监控电脑")
   .build();

laser_recipe(<liquid:hydrogen>,<liquid:xprotonfluid>,1000,20,2,1000,1000);
laser_recipe_3(<liquid:pyrotheum>,<liquid:glowstone>,<liquid:osmium>,<liquid:phi_matter>,5000,20,3,4000,1440,1440,2000);
laser_recipe_3(<liquid:crystalloid>,<liquid:obsidian>,<liquid:osmium>,<liquid:oslash_matter>,5000,20,4,4000,1440,1440,2000);
laser_recipe_2(<liquid:plasma>,<liquid:draconic_metal>,<liquid:chaotic_metal>,<liquid:unsteady_plasma>,5000,40,5,1000,1000);
laser_recipe_1(<liquid:liquidlithium>,<liquid:xprotonfluid>,<liquid:anti_protron>,10000,40,6,1000,2000);
laser_recipe_1(<liquid:pyrotheum>,<liquid:plasma>,<liquid:anti_electron>,10000,40,7,1000,2000);
laser_recipe_1(<liquid:anti_protron>,<liquid:anti_electron>,<liquid:anti_neutron>,20000,60,8,1000,2000);
laser_recipe_1(<liquid:anti_protron>,<liquid:cryotheum>,<liquid:anti_hydrogen>,20000,60,9,4000,2000);
laser_recipe_1(<liquid:anti_protron>,<liquid:anti_electron>,<liquid:anti_heilum_4>,40000,60,10,4000,1000);
MMEvents.onControllerGUIRender("laseraccelerator", function(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val cube1 = data.getInt("cube1",0);
    val cube2 = data.getInt("cube2",0);
    val cube3 = data.getInt("cube3",0);
    val energy_limit = data.getLong("energy_limit",0.0);
    val energy_storage = data.getLong("energy_storage",0.0);
    var maxbx = cal_parel(cube1,cube2,cube3);
    var bx = maxbx - energy_storage/100000;
    var info as string[] = [
        "§1//////////// §9激光脉冲靶向§b轰击加速器 §1////////////",
        "§6能量存储:§a"+energy_storage+"§b/"+energy_limit,
        "§c能量立方§7Mk§41§b:"+cube1,
        "§e能量立方§7Mk§62§b:"+cube2,
        "§b能量立方§7Mk§93§b:"+cube3,
        "§6当前最大并行:§b"+bx,
        "并行上限:"+maxbx,
    ];

    event.extraInfo = info;
});
function laser_recipe(input as ILiquidStack,output as ILiquidStack,cost as int,time as int,priority as int,input_count as int,output_count as int){
    RecipeBuilder.newBuilder("laser_recipe"+priority,"laseraccelerator",time,priority)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val energy_storage = data.getLong("energy_storage",0.0);
        val is_full = data.getInt("is_full",0);
        if(is_full == 0){
            event.setFailed("当前尚未充满能量");
        }else{
            var bx = energy_storage/100000;
            var bxc = maxbx - bx;
            event.activeRecipe.maxParallelism = bxc;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["is_begin"]=1;
        ctrl.customData = data;
    })
    .addFluidPerTickInputs(input*input_count)
    .addFluidPerTickOutputs(output*output_count)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        var energy_storage = data.getLong("energy_storage",0.0);
        val bxc = maxbx - energy_storage/100000;
        if(energy_storage - bxc*cost > 0){
            energy_storage -= bxc*cost;
            map["energy_storage"]=energy_storage;
            ctrl.customData = data;
        }else if(energy_storage - bxc*cost <= 0){
            map["energy_storage"]=0;
            map["is_begin"]=0;
            map["is_full"]=0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("使用周期性的激光脉冲轰击物质靶")
    .addRecipeTooltip("将消耗能量立方中§6"+cost+"§f的能量")
    .addRecipeTooltip("当能量消耗完毕时自动进入充能状态")
    .setThreadName("紧凑轰击舱")
    .build();
}
function laser_recipe_1(input1 as ILiquidStack,input2 as ILiquidStack,output as ILiquidStack,cost as int,time as int,priority as int,input_count as int,output_count as int){
    RecipeBuilder.newBuilder("laser_recipe"+priority,"laseraccelerator",time,priority)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val energy_storage = data.getLong("energy_storage",0.0);
        val is_full = data.getInt("is_full",0);
        if(is_full == 0){
            event.setFailed("当前尚未充满能量");
        }else{
            var bx = energy_storage/100000;
            event.activeRecipe.maxParallelism = maxbx - bx;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["is_begin"]=1;
        ctrl.customData = data;
    })
    .addFluidPerTickInputs(input1*input_count)
    .addFluidPerTickInputs(input2*input_count)
    .addFluidPerTickOutputs(output*output_count)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var energy_storage = data.getLong("energy_storage",0.0);
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val bxc = maxbx - energy_storage/100000;
        if(energy_storage - bxc*cost > 0){
            energy_storage -= bxc*cost;
            map["energy_storage"]=energy_storage;
            ctrl.customData = data;
        }else if(energy_storage - bxc*cost <= 0){
            map["energy_storage"]=0;
            map["is_begin"]=0;
            map["is_full"]=0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("使用周期性的激光脉冲轰击物质靶")
    .addRecipeTooltip("将消耗能量立方中§6"+cost+"§f的能量")
    .addRecipeTooltip("当能量消耗完毕时自动进入充能状态")
    .setThreadName("紧凑轰击舱")
    .build();
}
function laser_recipe_2(input1 as ILiquidStack,input2 as ILiquidStack,output1 as ILiquidStack,output2 as ILiquidStack,cost as int,time as int,priority as int,input_count as int,output_count as int){
    RecipeBuilder.newBuilder("laser_recipe"+priority,"laseraccelerator",time,priority)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val energy_storage = data.getLong("energy_storage",0.0);
        val is_full = data.getInt("is_full",0);
        if(is_full == 0){
            event.setFailed("当前尚未充满能量");
        }else{
            var bx = energy_storage/100000;
            event.activeRecipe.maxParallelism = maxbx - bx;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["is_begin"]=1;
        ctrl.customData = data;
    })
    .addFluidPerTickInputs(input1*input_count)
    .addFluidPerTickInputs(input2*input_count)
    .addFluidPerTickOutputs(output1*output_count)
    .addFluidPerTickOutputs(output2*output_count)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var energy_storage = data.getLong("energy_storage",0.0);
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val bxc = maxbx - energy_storage/100000;
        if(energy_storage - bxc*cost > 0){
            energy_storage -= bxc*cost;
            map["energy_storage"]=energy_storage;
            ctrl.customData = data;
        }else if(energy_storage - bxc*cost <= 0){
            map["energy_storage"]=0;
            map["is_begin"]=0;
            map["is_full"]=0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("使用周期性的激光脉冲轰击物质靶")
    .addRecipeTooltip("将消耗能量立方中§6"+cost+"§f的能量")
    .addRecipeTooltip("当能量消耗完毕时自动进入充能状态")
    .setThreadName("紧凑轰击舱")
    .build();
}
function laser_recipe_3(input1 as ILiquidStack,input2 as ILiquidStack,input3 as ILiquidStack,output1 as ILiquidStack,cost as int,time as int,priority as int,input_count1 as int,input_count2 as int,input_count3 as int,output_count as int){
    RecipeBuilder.newBuilder("laser_recipe"+priority,"laseraccelerator",time,priority)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val energy_storage = data.getLong("energy_storage",0.0);
        val is_full = data.getInt("is_full",0);
        if(is_full == 0){
            event.setFailed("当前尚未充满能量");
        }else{
            var bx = energy_storage/100000;
            event.activeRecipe.maxParallelism = maxbx - bx;
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["is_begin"]=1;
        ctrl.customData = data;
    })
    .addFluidInputs(input1*input_count1)
    .addFluidInputs(input2*input_count2)
    .addFluidInputs(input3*input_count3)
    .addFluidOutputs(output1*output_count)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        var energy_storage = data.getLong("energy_storage",0.0);
        val cube1 = data.getInt("cube1",0);
        val cube2 = data.getInt("cube2",0);
        val cube3 = data.getInt("cube3",0);
        val maxbx = cal_parel(cube1,cube2,cube3);
        val bxc = maxbx - energy_storage/100000;
        if(energy_storage - bxc*cost > 0){
            energy_storage -= bxc*cost;
            map["energy_storage"]=energy_storage;
            ctrl.customData = data;
        }else if(energy_storage - bxc*cost <= 0){
            map["energy_storage"]=0;
            map["is_begin"]=0;
            map["is_full"]=0;
            ctrl.customData = data;
        }
    })
    .addRecipeTooltip("使用周期性的激光脉冲轰击物质靶")
    .addRecipeTooltip("将消耗能量立方中§6"+cost+"§f的能量")
    .addRecipeTooltip("当能量消耗完毕时自动进入充能状态")
    .setThreadName("紧凑轰击舱")
    .build();
}
function cal_parel(cube1 as int,cube2 as int,cube3 as int)as int{
    return 10+cube1*1+cube2*10+cube3*20;
}
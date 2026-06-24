import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.util.Math;
import crafttweaker.event.PlayerInteractBlockEvent;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

HyperNetHelper.proxyMachineForHyperNet("mega_shroudneedle");
MachineModifier.setMaxThreads("mega_shroudneedle",0);
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("§5虚境§e观测站§f中枢"));
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("§5外虚境§e观测站§f"));
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("§5虚境§8刺针§e发射平台§f"));
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("§5虚境§8刺针§e回收平台§f"));
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("自维护单元#1"));
MachineModifier.addCoreThread("mega_shroudneedle", FactoryRecipeThread.createCoreThread("自维护单元#2"));

MMEvents.onControllerGUIRender("mega_shroudneedle",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val SN_initialization = data.getInt("SN_initialization",0);
    val SN_level = data.getInt("SN_level",0);
    val SN_count = data.getInt("SN_count",0);
    var info as string[]=[];
    if(SN_initialization == 0){
        info += "§a////////////§5虚境§e观测站§b控制台§a////////////";
        info += "§4未部署§5虚境§e观测站§f核心";
    }
    if(SN_initialization == 1){
        info += "§a////////////§5虚境§e观测站§b控制台§a////////////";
        info += "当前§5虚境§e观测站§f等级 : " + SN_level;
        info += "当前§5虚境§8刺针§f数量 : " + SN_count;
    }
    event.extraInfo = info;
});
RecipeBuilder.newBuilder("SN_input_energy","mega_shroudneedle",4000,100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
    })
    .addEnergyPerTickInput(5120000000)
    .addRecipeTooltip("对§5虚境§e观测站§f进行§a基础§f维护")
    .setThreadName("自维护单元#1")
    .build();
RecipeBuilder.newBuilder("SN_input_fluids_and_items","mega_shroudneedle",4000,100)
    .addFluidInput(<liquid:zerotempaturefluid> * 800000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
    })
    .addRecipeTooltip("对§5虚境§e观测站§f进行§b进阶§f维护")
    .addRecipeTooltip("使用零度行星流体创建一个在类空间中的立场，防止§5虚境§e观测站§f被摧毁。")
    .setThreadName("自维护单元#2")
    .build();
RecipeBuilder.newBuilder("SN_production01","mega_shroudneedle",1200,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
        if(isNull(event.controller.recipeThreadList[4].activeRecipe)){
            event.setFailed("尚未进行§a基础§f维护!");
            return;
        }
        if(isNull(event.controller.recipeThreadList[5].activeRecipe)){
            event.setFailed("尚未进行§b进阶§f维护!");
            return;
        }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_level = data.getInt("SN_level",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SN_level,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_product");
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addOutput(<contenttweaker:shroudplanet> * 1).setChance(0.1)
    .addEnergyPerTickInput(5120000000)
    .requireResearch("Mega-ShroudConsciousness")
    .requireComputationPoint(1000000.0F)
    .addRecipeTooltip("对§5虚境§f进行探测，产出§5虚境星球§e观测数据§f")
    .addRecipeTooltip("根据§5虚境§e观测站§f等级决定产出。")
    .setThreadName("§5外虚境§e观测站§f")
    .build();
RecipeBuilder.newBuilder("SN_production02","mega_shroudneedle",1200,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
        if(isNull(event.controller.recipeThreadList[4].activeRecipe)){
            event.setFailed("尚未进行§a基础§f维护!");
            return;
        }
        if(isNull(event.controller.recipeThreadList[5].activeRecipe)){
            event.setFailed("尚未进行§b进阶§f维护!");
            return;
        }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_count = data.getFloat("SN_count",1.0);
        val SN_level = data.getFloat("SN_level",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SN_count,1,false).build());
        thread.addPermanentModifier("increase_product_by_upgrade",RecipeModifierBuilder.create("modularmachinery:item","output",SN_level,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_product");
        thread.removePermanentModifier("increase_product_by_upgrade");
    })
    .addOutput(<contenttweaker:shroudplanet> * 1)
    .addOutput(<contenttweaker:shroudchunk> * 1)
    .addEnergyPerTickInput(5120000000)
    .requireResearch("Mega-ShroudConsciousness")
    .addRecipeTooltip("对§5虚境§f进行探测，产出§5虚境星球§e观测数据§f与§5虚境§e区块§f")
    .addRecipeTooltip("根据§5虚境§8刺针§f数量与§5虚境§e观测站§f等级决定产出。")
    .setThreadName("§5虚境§8刺针§e回收平台§f")
    .build();
RecipeBuilder.newBuilder("SN_lunch","mega_shroudneedle",360,1)
    .addEnergyPerTickInput(5120000000000)
    .addInput(<contenttweaker:shroud_needle>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
        if(isNull(event.controller.recipeThreadList[4].activeRecipe)){
            event.setFailed("尚未进行§a基础§f维护!");
            return;
        }
        if(isNull(event.controller.recipeThreadList[5].activeRecipe)){
            event.setFailed("尚未进行§b进阶§f维护!");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_count = data.getFloat("SN_count",1.0);
        map["SN_count"] = SN_count + 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("发射§5虚境§8刺针§f以探测更深层的§5虚境§f")
    .setThreadName("§5虚境§8刺针§e发射平台§f")
    .build();
RecipeBuilder.newBuilder("SN_upgrade","mega_shroudneedle",360,1)
    .addEnergyPerTickInput(5120000000000)
    .addInput(<contenttweaker:sn_core>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
        if(isNull(event.controller.recipeThreadList[4].activeRecipe)){
            event.setFailed("尚未进行§a基础§f维护!");
            return;
        }
        if(isNull(event.controller.recipeThreadList[5].activeRecipe)){
            event.setFailed("尚未进行§b进阶§f维护!");
            return;
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_level = data.getInt("SN_level",1.0);
        map["SN_level"] = SN_level + 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("对§5虚境§e观测站§f进行扩建以满足我们的需求")
    .setThreadName("§5虚境§e观测站§f中枢")
    .build();
RecipeBuilder.newBuilder("SN_initialization","mega_shroudneedle",720,1)
    .addEnergyPerTickInput(5120000000000)
    .addInput(<contenttweaker:sn_core>)
    .addInput(<contenttweaker:novamatrix> * 2)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 1){
            event.setFailed("§4已部署§5虚境§e观测站§f核心");
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_level = data.getInt("SN_level",1.0);
        val SN_initialization = data.getFloat("SN_initialization",1.0);
        map["SN_level"] = SN_level + 1;
        map["SN_initialization"] = 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("部署§5虚境§e观测站§f核心")
    .setThreadName("§5虚境§e观测站§f中枢")
    .build();
RecipeBuilder.newBuilder("SN_production03","mega_shroudneedle",1200,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val SN_initialization = data.getInt("SN_initialization",0);
        if(SN_initialization == 0){
            event.setFailed("§4未部署§5虚境§e观测站§f核心");
        }
        if(isNull(event.controller.recipeThreadList[4].activeRecipe)){
            event.setFailed("尚未进行§a基础§f维护!");
            return;
        }
        if(isNull(event.controller.recipeThreadList[5].activeRecipe)){
            event.setFailed("尚未进行§b进阶§f维护!");
            return;
        }
    })
    .addFactoryPostTickHandler(function(event as FactoryRecipeTickEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val SN_level = data.getInt("SN_level",1.0);
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("increase_product",RecipeModifierBuilder.create("modularmachinery:item","output",SN_level,1,false).build());
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val thread = event.factoryRecipeThread;
        thread.removePermanentModifier("increase_product");
    })
    .addInput(<contenttweaker:hyperdimensional_lens>).setChance(0.01)
    .addOutput(<contenttweaker:cosmic_data> * 1).setChance(0.1)
    .addEnergyPerTickInput(5120000000)
    .requireResearch("Giga-CosmicCasket")
    .requireComputationPoint(1000000.0F)
    .addRecipeTooltip("对§8宇宙§f进行探测，产出§9寰宇§f数据")
    .addRecipeTooltip("根据§5虚境§e观测站§f等级决定产出。")
    .setThreadName("§5外虚境§e观测站§f")
    .build();
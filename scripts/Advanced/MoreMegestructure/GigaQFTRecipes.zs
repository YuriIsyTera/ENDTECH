//这是一坨大便
#priority 10
#loader crafttweaker reloadable

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
import mods.modularmachinery.GeoMachineModel;
import mods.modularmachinery.ControllerModelAnimationEvent;

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

HyperNetHelper.proxyMachineForHyperNet("giga_qft");
MachineModifier.setMaxThreads("giga_qft", 16);
MachineModifier.addCoreThread("giga_qft", FactoryRecipeThread.createCoreThread("§1星阵§f取出单元").addRecipe("qft_space_array_output"));
MMEvents.onStructureFormed("giga_qft" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val Universe_level = data.getInt("Universe_level",0);
    val Initialization = data.getInt("Initialization",0);
    val arcane_spacetime_expansion_generator = ctrl.getBlocksInPattern(<contenttweaker:arcane_spacetime_expansion_generator>);
    if(arcane_spacetime_expansion_generator  == 36){
        ctrl.addPermanentModifier("arcane_spacetime_expansion_generator_modifier_item",RecipeModifierBuilder.create("modularmachinery:item","output",64,1,false).build());
        ctrl.addPermanentModifier("arcane_spacetime_expansion_generator_modifier_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",64,1,false).build());
        map["arcane_spacetime_expansion_generator_check"] = 1;
    }
    if(Initialization != 1){
        map["Universe_level"] = 1;
        map["Initialization"] = 1;
    }
    ctrl.customData = data;
});
MMEvents.onControllerGUIRender("giga_qft",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val arcane_spacetime_expansion_generator_check = data.getInt("arcane_spacetime_expansion_generator_check",0);
    val Universe_level = data.getInt("Universe_level",0);
    val Initialization = data.getInt("Initialization",0);
    var info as string[]=[];
    if(arcane_spacetime_expansion_generator_check != 1){
        info += "§a////////////§1量子操纵者§b控制台§a////////////";
        info += "§5§l奥术§8§l时空§9§l膨胀§b§l发生器§4 : 未安装";
        info += "当前§1星阵§f数量 : " + Universe_level + " / 64";
        info += "当前§a产出§f倍数 : " + Universe_level * 64;
    }
    if(arcane_spacetime_expansion_generator_check == 1){
        info += "§a////////////§1量子操纵者§b控制台§a////////////";
        info += "§5§l奥术§8§l时空§9§l膨胀§b§l发生器§a : 已安装";
        info += "当前§1星阵§f数量 : " + Universe_level + " / 64";
        info += "当前§a产出§f倍数 : " + Universe_level * 4096;
    }
    event.extraInfo = info;
});
events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val pos = event.position;
    val item = event.item;
    if(!event.world.remote && <contenttweaker:space_array>.matches(item)){
        if(block.definition.id == "modularmachinery:giga_qft_factory_controller"){
            val player = event.player;
            val ctrl = MachineController.getControllerAt(event.world,pos);
            val data = ctrl.customData;
            val map = data.asMap();
            val Universe_level = data.getInt("Universe_level",1.0);
            if(Universe_level < 64){
                map["Universe_level"] = Universe_level + 1;
                ctrl.customData = data;
                item.mutable().shrink(1);
            }
            if(Universe_level >= 64){
                player.sendMessage("§1星阵§4数量过多!§f");
            }
            event.cancel();
        }
    }
});
RecipeBuilder.newBuilder("qft_space_array_output","giga_qft",20,1)
    .addInput(<contenttweaker:advanced_programming_circuit_0>).setChance(0)
    .addOutput(<contenttweaker:space_array>)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        event.activeRecipe.maxParallelism = 1;  
        val Universe_level = data.getInt("Universe_level",0);
        if(Universe_level < 2){
            event.setFailed("尚未输入§1星阵§f!");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val arcane_spacetime_expansion_generator_check = data.getInt("arcane_spacetime_expansion_generator_check",0);
        if(arcane_spacetime_expansion_generator_check == 1){
            event.factoryRecipeThread.addModifier("decrease_space_array",RecipeModifierBuilder.create("modularmachinery:item","output",1/64,1,false).build());
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val Universe_level = data.getInt("Universe_level",1.0);
        map["Universe_level"] = Universe_level - 1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("输出§1量子操纵者§f内部的§1星阵§f")
    .addRecipeTooltip("该配方不会获得并行")
    .build();
RecipeAdapterBuilder.create("giga_qft", "modularmachinery:ion_generator")
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        if(ctrl.blockState.block.definition.id == "modularmachinery:giga_qft_factory_controller"){
            event.activeRecipe.maxParallelism = 10485760;  
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        if(ctrl.blockState.block.definition.id == "modularmachinery:giga_qft_factory_controller"){
            event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
            event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
            event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.001,1,false).build());
        }
    })
    .build();
RecipeBuilder.newBuilder("nq_fuel", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:timespace_ingot>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:nq_powder> * 64)
    .addOutput(<liquid:nq_fuel> * 1000)
    .build();
    
RecipeBuilder.newBuilder("mm_ldx1", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:glass> * 64)
    .addOutput(<mets:superconducting_cable> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx2", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ic2:crafting:2> * 64)
    .addOutput(<mets:super_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx3", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:super_circuit> * 64)
    .addOutput(<mets:living_circuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx4", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<mets:niobium_titanium_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:niobium_titanium_ingot> * 64)
    .addOutput(<mets:nano_living_metal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx6", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mets:nano_living_metal> * 64)
    .addOutput(<mets:neutron_plate> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx7", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:diamond> * 64)
    .addOutput(<avaritia:resource> * 64)
    .build();

RecipeBuilder.newBuilder("fluix_pure1_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemCertusQuartz> * 4,
    ])
    .addOutputs(<ore:crystalPureCertusQuartz> * 8)
    .build();
    
RecipeBuilder.newBuilder("fluix_pure2_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemQuartz> * 4,
    ])
    .addOutputs(<ore:crystalPureNetherQuartz> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_pure3_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(8192)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:gemFluix> * 4,
    ])
    .addOutputs(<ore:crystalPureFluix> * 8)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustCertusQuartz> * 3,
        <ore:dustQuartz> * 3
    ])
    .addOutputs(<ore:gemFluix> * 6)
    .build();

RecipeBuilder.newBuilder("fluix_fluix_complex_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustCoal> * 3,
        <ore:dustFluix> * 3,
        <ore:itemSilicon> * 4,
    ])
    .addOutputs(<threng:material:1> * 4)
    .build();

RecipeBuilder.newBuilder("fluix_vibrant_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:gemDiamond> * 1)
    .addOutputs(<threng:material:5> * 1)
    .build();

RecipeBuilder.newBuilder("fluix_spectus_giga_qft", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(16384)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:dustSkyStone> * 48,
    ])
    .addOutputs(<threng:material:13> * 1)
    .build();

RecipeBuilder.newBuilder("mm_ldx9", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:gemDiamond> * 64)
    .addOutput(<appliedenergistics2:material:24> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx10", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:gold_ingot> * 64)
    .addOutput(<appliedenergistics2:material:22> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx11", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:material:10> * 64)
    .addOutput(<appliedenergistics2:material:23> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx12", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<threng:material:5> * 64)
    .addOutput(<threng:material:6> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx13", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<threng:material:13> * 64)
    .addOutput(<threng:material:14> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx14", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:132> * 64)
    .addOutput(<modularmachinery:itemmodularium> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx15", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:material:24> * 64)
    .addInput(<appliedenergistics2:material:23> * 64)
    .addInput(<appliedenergistics2:material:22> * 64)
    .addInput(<threng:material:6> * 64)
    .addInput(<threng:material:14> * 64)
    .addOutput(<contenttweaker:lifesense_processor> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx16", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:lifesense_processor> * 64)
    .addOutput(<contenttweaker:exponential_level_processor> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx17", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:water> * 1000000)
    .addOutput(<liquid:ic2coolant> * 1000000)
    .build();

RecipeBuilder.newBuilder("mm_ldx18", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:coal> * 64)
    .addOutput(<ic2:crafting:15> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx19", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:emerald> * 64)
    .addOutput(<enderio:item_material:15> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ldx20", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:15> * 64)
    .addOutput(<contenttweaker:charging_crystal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld21", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:charging_crystal> * 64)
    .addOutput(<contenttweaker:charging_crystal_block> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld22", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<modularmachinery:itemmodularium> * 64)
    .addOutput(<modularmachinery:blockcasing> * 64)
    .addOutput(<modularmachinery:blockcasing:1> * 64)
    .addOutput(<modularmachinery:blockcasing:2> * 64)
    .addOutput(<modularmachinery:blockcasing:3> * 64)
    .addOutput(<modularmachinery:blockcasing:4> * 64)
    .addOutput(<modularmachinery:blockcasing:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld23", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:ingot:1> * 64)
    .addOutput(<mekanism:controlcircuit> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld24", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit> * 64)
    .addOutput(<mekanism:controlcircuit:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld25", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit:1> * 64)
    .addOutput(<mekanism:controlcircuit:2> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld26", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:controlcircuit:2> * 64)
    .addOutput(<mekanism:controlcircuit:3> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld27", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:redstone> * 64)
    .addOutput(<botania:manaresource:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld28", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:iron_ingot> * 64)
    .addOutput(<botania:manaresource:4> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld29", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:4> * 64)
    .addOutput(<botania:manaresource:14> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld30", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource:14> * 64)
    .addOutput(<extrabotany:material:1> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld31", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<draconicevolution:draconium_ingot> * 64)
    .addOutput(<draconicevolution:draconic_ingot> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld32", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<draconicevolution:draconic_ingot> * 64)
    .addOutput(<tconevo:metal> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld33", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:metal> * 64)
    .addOutput(<tconevo:metal:5> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld34", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:metal:5> * 64)
    .addOutput(<tconevo:metal:10> * 64)
    .build();

RecipeBuilder.newBuilder("mm_ld35", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(10000000000)
    .addInput(<contenttweaker:hypernet_ram_t5> * 64)
    .addInput(<contenttweaker:industrial_circuit_v4> * 64)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<liquid:crystalloid> * 100000000)
    .addInput(<avaritiaio:infinitecapacitor> * 16)
    .addInput(<liquid:infinity_metal> * 14400)
    .addOutput(<contenttweaker:hypernet_ram_max> * 1)
    .build();

RecipeBuilder.newBuilder("mm_ld36", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(10000000000)
    .addInput(<contenttweaker:hypernet_gpu_t3> * 162)
    .addInput(<liquid:infinity_metal> * 14400)
    .addInput(<liquid:crystalloid> * 100000000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 64)
    .addInput(<contenttweaker:antimatter_core> * 64)
    .addInput(<avaritiaio:infinitecapacitor> * 16)
    .addOutput(<contenttweaker:hypernet_gpu_max> * 1)
    .build();

RecipeBuilder.newBuilder("mm_ldx37", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:lava> * 1000000)
    .addOutput(<liquid:nitronite_fluid> * 1000000)
    .build();

RecipeBuilder.newBuilder("mm_ldx38", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:block_resource:1> * 64)
    .addOutput(<contenttweaker:world_energy_core> * 1)
    .build();
RecipeBuilder.newBuilder("mm_ldx39", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:world_energy_core> * 4)
    .addOutput(<contenttweaker:superluminal_core> * 1)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_1", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:14> * 64)
    .addOutput(<extendedcrafting:material:15> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_2", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:15> * 64)
    .addOutput(<extendedcrafting:material:16> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_3", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:16> * 64)
    .addOutput(<extendedcrafting:material:17> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_4", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:17> * 64)
    .addOutput(<extendedcrafting:material:18> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:18> * 64)
    .addOutput(<extendedcrafting:material:19> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_6", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:8> * 64)
    .addOutput(<extendedcrafting:material:9>* 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_7", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:9> * 64)
    .addOutput(<extendedcrafting:material:10> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_8", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:10> * 64)
    .addOutput(<extendedcrafting:material:11> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_9", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:11> * 64)
    .addOutput(<extendedcrafting:material:12> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_10", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:12> * 64)
    .addOutput(<extendedcrafting:material:13> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_11", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:universalalloyt1> * 64)
    .addOutput(<contenttweaker:universalalloyt2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_12", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:universalalloyt2> * 64)
    .addOutput(<contenttweaker:universalalloyt3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_13", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:136> * 64)
    .addOutput(<botania:manaresource> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_14", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<botania:manaresource> * 64)
    .addOutput(<botania:manaresource:7> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_15", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:resource:5> * 512)
    .addOutput(<avaritia:resource:6> * 64)
    .build();
RecipeBuilder.newBuilder("aw_giga_qft_16", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:resource:6> * 64)
    .addOutput(<avaritiatweaks:enhancement_crystal> * 512)
    .build();
RecipeBuilder.newBuilder("giga_qft_timespace_coil_assembly", "giga_qft",1)
        .addPreCheckHandler(function(event as RecipeCheckEvent){    
            event.activeRecipe.maxParallelism = 40960;
        })
        .addInput(<contenttweaker:coil_v5> * 1024)
        .addInput(<contenttweaker:infinite_coil> * 64)
        .addInput(<contenttweaker:fragments_of_the_space_time_continuum> * 16384)
        .addOutput(<contenttweaker:space_time_coil>)
        .addEnergyPerTickInput(8000000000)
        .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_1", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:134> * 64)
    .addOutput(<additions:novaextended-psi_alloy> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_2", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-psi_alloy> * 64)
    .addOutput(<thermalfoundation:material:167> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_3", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:167> * 64)
    .addOutput(<enderutilities:enderpart> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_4", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderutilities:enderpart> * 64)
    .addOutput(<enderutilities:enderpart:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderutilities:enderpart:2> * 64)
    .addOutput(<extendedcrafting:material:36> * 64)
    .build();
    RecipeBuilder.newBuilder("aw_bug_giga_qft_5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<extendedcrafting:material:36> * 64)
    .addOutput(<extendedcrafting:material:48> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_7", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:38> * 64)
    .addOutput(<enderio:item_material:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_8", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:3> * 64)
    .addOutput(<enderio:block_solar_panel> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_9", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel> * 64)
    .addOutput(<enderio:block_solar_panel:1> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_10", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:1> * 64)
    .addOutput(<enderio:block_solar_panel:2> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_11", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:2> * 64)
    .addOutput(<enderio:block_solar_panel:3> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_12", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:3> * 64)
    .addOutput(<enderio:block_solar_panel:4> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_13", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:block_solar_panel:4> * 64)
    .addOutput(<enderio:block_solar_panel:5> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_14", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:material> * 64)
    .addOutput(<tconevo:metal:30> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_15", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:diamond> * 64)
    .addOutput(<ancientspellcraft:astral_diamond_shard> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_16", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:block_resource:1> * 64)
    .addOutput(<minecraft:dirt> * 1073741824)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_17", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:cobblestone> * 1073741824).setChance(0)
    .addOutput(<fluid:fluidedmana> * 40960)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_18", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:dirt> * 64)
    .addOutput(<minecraft:clay> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_19", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconstruct:ingots:1> * 64)
    .addOutput(<tconevo:material> * 64)
    .build();
RecipeBuilder.newBuilder("aw_bug_giga_qft_20", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addEnergyPerTickInput(15000)
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<tconevo:material> * 64)
    .addOutput(<deepmoblearning:polymer_clay> * 512)
    .build();

//感谢开源
RecipeBuilder.newBuilder("giga_qft_xingnengyechanchu", "giga_qft", 300)
    .addInput(<extrabotany:material:3>).setChance(0).setParallelizeUnaffected(true)
    .addFluidPerTickOutput(<liquid:astralsorcery.liquidstarlight> *50)
    .addCatalystInput(<astralsorcery:itemcoloredlens:6>,
        ["注入了星能的彩色透镜拥有将星能汇聚的能力。", "使星能液的产量翻倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0).setParallelizeUnaffected(true)
    .addCatalystInput(<ancientspellcraft:astral_diamond_charged>,
        ["充能后的星芒宝钻蕴含着众多遗灵强大的能量。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]).setChance(0).setParallelizeUnaffected(true)
        
    .addCatalystInput(<avaritia:resource:5>,
        ["一即全，全即一。", "使星能液的产量 §ax3§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 3.0F, 1, false).build(),
        ]).setChance(0).setParallelizeUnaffected(true)

    .addCatalystInput(<additions:novaextended-novaextended_medal2>,
        ["美丽的时钟座。", "使星能液的生产速率 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0).setParallelizeUnaffected(true)

    .addCatalystInput(<ebwizardry:astral_diamond>,
        ["事情的一部分当然是不可缺少的。", "使星能液的产量 §ax2§f。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]).setChance(0).setParallelizeUnaffected(true)
    .addRecipeTooltip(
    "§a英雄徽章§f数量影响并行数",
    "星能矩阵：运行此配方自带6并行"
    ) // 提示信息：描述配方功能
    .setMaxThreads(1)
    .build();

//岩浆产出
RecipeBuilder.newBuilder("xh_netherrack_lava", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<ore:netherrack>).setChance(0).setParallelizeUnaffected(true)
    .addFluidPerTickOutput(<liquid:lava> * 15)
    .setMaxThreads(1)
    .build();

RecipeBuilder.newBuilder("xh_magma_lava", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<ore:blockMagma>).setChance(0).setParallelizeUnaffected(true)
    .addFluidPerTickOutput(<liquid:lava> * 30)
    .setMaxThreads(1)
    .build();

//配方继承（五彩观象台）
RecipeAdapterBuilder.create("giga_qft", "modularmachinery:iridescentobservatory")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01F, 1, false).build())
    .build();

// 新配方：飞龙剑
RecipeBuilder.newBuilder("giga_qft_wyvern_sword", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<redstonerepository:tool.sword_gelid>) // 凝胶斧头
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_sword>) // 输出：飞龙剑
    .build();
    // 新配方：飞龙镐
RecipeBuilder.newBuilder("giga_qft_wyvern_pick", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<redstonerepository:tool.pickaxe_gelid>) // 凝胶镐头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_pick>) // 输出：飞龙镐
    .build();
    // 新配方：飞龙斧
RecipeBuilder.newBuilder("giga_qft_wyvern_axe", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:tool.axe_gelid>) // 凝胶斧头
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>) // 旋律合金 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_axe>) // 输出：飞龙斧
    .build();
    // 新配方：飞龙铲
RecipeBuilder.newBuilder("giga_qft_wyvern_shovel", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonearsenal:tool.excavator_flux>) // 红石铲
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>) // 飞龙核心 x1
    .addItemInput(<mekanism:ingot>) // 强化黑曜石 x1
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_shovel>) // 输出：飞龙铲
    .build();
    // 新配方：飞龙弓
RecipeBuilder.newBuilder("giga_qft_wyvern_bow", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<enderio:item_end_steel_bow>) // 末影钢弓
    .addItemInput(<enderio:item_material:71>*2) // 无尽之杆 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<botania:manaresource:16>*2) // 魔法绳索 x2
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<deepmoblearning:glitch_fragment>) // 故障碎片 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_bow>) // 输出：飞龙弓
    .build();
// 新配方：飞龙头盔
RecipeBuilder.newBuilder("giga_qft_wyvern_helm", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.helmet_gelid>) // 凝胶头盔
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*2) // 旋律合金 x2
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_helm>) // 输出：飞龙头盔
    .build();
    // 新配方：飞龙胸甲
RecipeBuilder.newBuilder("giga_qft_wyvern_chest", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.chestplategelid>) // 凝胶胸甲
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_chest>) // 输出：飞龙胸甲
    .build();
    // 新配方：飞龙护腿
RecipeBuilder.newBuilder("giga_qft_wyvern_legs", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<enderio:item_alloy_endergy_ingot:2>*3) // 旋律合金 x3
    .addItemInput(<draconicevolution:draconium_ingot>*4) // 龙锭 x4
    .addItemInput(<redstonerepository:armor.leggings_gelid>) // 凝胶护腿
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*2) // 强化黑曜石 x2
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_legs>) // 输出：飞龙护腿
    .build();
    // 新配方：飞龙靴子
RecipeBuilder.newBuilder("giga_qft_wyvern_boots", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<draconicevolution:draconium_ingot>*2) // 龙锭 x2
    .addItemInput(<redstonerepository:armor.boots_gelid>) // 凝胶靴子
    .addItemInput(<enderio:item_material:71>*3) // 无尽之杆 x3
    .addItemInput(<draconicevolution:wyvern_core>*2) // 飞龙核心 x2
    .addItemInput(<mekanism:ingot>*3) // 强化黑曜石 x3
    .addItemInput(<extrabotany:material:3>) // 英雄徽章X1
    .addItemInput(<bloodmagic:item_demon_crystal:4>) // 恶魔水晶 x1
    .addItemInput(<contenttweaker:field_generator_v1>) // 场生成器 v1 x1
    .addItemInput(<draconicevolution:wyvern_energy_core>) // 飞龙能量核心 x1
    .addItemOutput(<draconicevolution:wyvern_boots>) // 输出：飞龙靴子
    .build();

      // 新配方：星耀勋章
RecipeBuilder.newBuilder("giga_qft_medal", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 8) // 共振宝石 x8
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<additions:novaextended-terraalloy> * 1) // 泰拉合金 x1
    .addItemInput(<additions:novaextended-ingot8>* 2) // 柳木合金 x2
    
    .addItemOutput(<additions:novaextended-novaextended_medal>) // 输出：星耀勋章
    .build();

// 新配方：星耀勋章1
RecipeBuilder.newBuilder("giga_qft_medal1", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:gold_ore> * 1) // 金矿石 x1
    .addItemInput(<minecraft:iron_ore> * 1) // 铁矿石 x1
    .addItemInput(<minecraft:diamond_ore> * 1) // 钻石矿石 x1
    .addItemInput(<minecraft:emerald_ore> * 1) // 绿宝石矿石 x1
    
    .addItemOutput(<additions:novaextended-novaextended_medal1>) // 输出：星耀勋章1
    .build();

// 新配方：星耀勋章2
RecipeBuilder.newBuilder("giga_qft_medal2", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:clock> * 1) // 时钟 x1
    .addItemInput(<minecraft:redstone> * 1) // 红石粉 x1
    .addItemInput(<minecraft:glowstone_dust> * 1) // 萤石粉 x1
    .addItemInput(<rftools:timer_block> * 1) // RFTools 定时器 x1
    
    .addItemOutput(<additions:novaextended-novaextended_medal2>) // 输出：星耀勋章2
    .build();

// 新配方：星耀勋章3
RecipeBuilder.newBuilder("giga_qft_medal3", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<avaritia:resource:5> * 2) // 极限资源 x2
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:diamond_block> * 1) // 钻石块 x1
    .addItemInput(<minecraft:lapis_block> * 1) // 青金石块 x1
    .addItemInput(<extrabotany:material:3> * 1) // 英雄徽章 x1
    .addItemInput(<jaopca:block_blockwillowalloy> * 1) // 柳木合金块 x1
    .addItemInput(<avaritia:resource:6>* 1) // 无尽锭 x1
    
    .addItemOutput(<additions:novaextended-novaextended_medal3>) // 输出：星耀勋章3
    .build();

// 新配方：星耀勋章4
RecipeBuilder.newBuilder("giga_qft_medal4", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:pumpkin> * 1) // 南瓜 x1
    .addItemInput(<minecraft:melon> * 1) // 西瓜 x1
    .addItemInput(<minecraft:hay_block> * 1) // 干草块 x1
    .addItemInput(<minecraft:wool> * 1) // 羊毛块 x1
    
    .addItemOutput(<additions:novaextended-novaextended_medal4>) // 输出：星耀勋章4
    .build();

// 新配方：星耀勋章5
RecipeBuilder.newBuilder("giga_qft_medal5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })

    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<additions:novaextended-novaextended_medal> * 1) // 星耀勋章
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<minecraft:bone> * 1) // 骨头 x1
    .addItemInput(<minecraft:nether_star> * 1) // 下界之星 x1
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    .addItemInput(<deepmoblearning:glitch_heart> * 1) // 故障核心 x1
    
    .addItemOutput(<additions:novaextended-novaextended_medal5>) // 输出：星耀勋章5
    .build();

    // 新配方：玻璃板转化为玻璃透镜
RecipeBuilder.newBuilder("glass_to_lens_giga_qft", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addItemInput(<minecraft:glass_pane> * 1) // 玻璃板 x1
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:3> * 1) // 输出：玻璃透镜 x1
    .build();

    // 新配方：海蓝宝石 + 萤石粉 制作 辉光粉
RecipeBuilder.newBuilder("giga_qft_glow_dust_giga_qft", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<minecraft:glowstone_dust> * 4) // 萤石粉 x4
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemOutput(<astralsorcery:itemusabledust> * 16) // 输出：辉光粉 x16
    .build();

    // 新配方：海蓝宝石 + 煤炭变种 制作 暗夜粉
RecipeBuilder.newBuilder("giga_qft_dark_dust", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>* 4,               // 普通煤炭
                <minecraft:coal:1>* 4,             // 木炭
                <ore:rawOreGemCoal> * 4 // 未雕琢的煤炭
            ]) // 每种煤炭变种的数量为 4
    )
    
    .addItemOutput(<astralsorcery:itemusabledust:1> * 16) // 输出：暗夜粉 x16
    .build();

    // 新配方：金粒 + 木板 + 大理石块 + 玻璃透镜 制作 光波增幅器
RecipeBuilder.newBuilder("giga_qft_lightwave_amplifier", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addItemInput(<minecraft:gold_nugget> * 2) // 金粒 x2
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:plankWood>*2)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble> * 1,    // 大理石块 元数据 1 x1   
                <astralsorcery:blockmarble:1> * 1,    // 大理石块 元数据 1 x1
                <astralsorcery:blockmarble:2> * 1,    // 大理石块 元数据 2 x1
                <astralsorcery:blockmarble:3> * 1,    // 大理石块 元数据 3 x1
                <astralsorcery:blockmarble:4> * 1,    // 大理石块 元数据 4 x1
                <astralsorcery:blockmarble:5> * 1,    // 大理石块 元数据 5 x1
                <astralsorcery:blockmarble:6> * 1,    // 大理石块 元数据 6 x1
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    
    .addItemOutput(<astralsorcery:blockattunementrelay> * 1) // 输出：光波增幅器 x1
    .build();

// 新配方：辉光粉 + 玻璃透镜 + 光波增幅器 制作 标记光波增幅器
RecipeBuilder.newBuilder("giga_qft_marked_relay", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemusabledust> * 3) // 辉光粉 x3
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockattunementrelay> * 1) // 光波增幅器 x1
    
    .addItemOutput(<packagedastral:marked_relay> * 1) // 输出：标记光波增幅器 x1
    .build();

    // 新配方：羽毛 + 辉光粉 + 星尘 + 羊皮纸 + 煤炭变种 制作 知识共享卷轴
RecipeBuilder.newBuilder("giga_qft_knowledge_share", "giga_qft", 20) // 时间调整为1 tick (0.05秒)，
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:feather> * 1) // 羽毛 x1
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:5> * 1) // 羊皮纸 x1
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>,               // 普通煤炭
                <minecraft:coal:1>,             // 木炭
                <ore:rawOreGemCoal> // 未雕琢的煤炭
            ]) // 煤炭变种 x1
    )
    
    .addItemOutput(<astralsorcery:itemknowledgeshare> * 1) // 输出：知识共享卷轴 x1
    .build();

// 新配方：水晶石 + 星辉锭 + 星尘 + 辉光粉 + 玻璃透镜 + 大理石块 制作 天体星门
RecipeBuilder.newBuilder("giga_qft_celestial_gateway", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 星尘 x4
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    
    .addItemOutput(<astralsorcery:blockcelestialgateway> * 1) // 输出：天体星门 x1
    .build();

// 新配方：海蓝宝石 + 玻璃透镜 + 水晶石 + 金锭 + 大理石块 + 聚星木 制作 透镜
RecipeBuilder.newBuilder("giga_qft_lens", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 3) // 玻璃透镜 x3
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<astralsorcery:blockmarble:6>*2)//大理石X2
    .addItemInput(<astralsorcery:blockinfusedwood:4> * 2) // 聚星木（元数据4）x2
    
    .addItemOutput(<astralsorcery:blocklens> * 1) // 输出：透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_burning", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_powder> * 6) // 烈焰粉 x6
    
    .addItemOutput(<astralsorcery:itemcoloredlens:0>) // 输出：燃烧透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_destruction", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_pickaxe> * 1) // 铁镐 x1
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    
    .addItemOutput(<astralsorcery:itemcoloredlens:1>) // 输出：破坏透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_growth", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:wheat_seeds> * 6) // 小麦种子 x6
    
    .addItemOutput(<astralsorcery:itemcoloredlens:2>) // 输出：生长透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_damage", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:iron_sword> * 2) // 铁剑 x2
    
    .addItemOutput(<astralsorcery:itemcoloredlens:3>) // 输出：伤害透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_regeneration", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:apple> * 1) // 苹果 x1
    .addItemInput(<minecraft:diamond> * 1) // 钻石 x1
    
    .addItemOutput(<astralsorcery:itemcoloredlens:4>) // 输出：再生透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_repulsion", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:piston> * 2) // 活塞 x2
    
    .addItemOutput(<astralsorcery:itemcoloredlens:5>) // 输出：抗拒透镜 x1
    .build();

RecipeBuilder.newBuilder("giga_qft_colored_lens_convergence", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    
    .addItemOutput(<astralsorcery:itemcoloredlens:6>) // 输出：汇聚透镜 x1
    .build();

    // 新配方：树叶（可替代）+ 树苗（可替代）+ 星能液桶 + 大理石块（元数据6）+ 海蓝宝石 制作 烽火树
RecipeBuilder.newBuilder("giga_qft_tree_beacon", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为20 ticks (1秒)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:treeLeaves>*6)
    .addInput(<ore:treeSapling>)
    
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    
    .addItemOutput(<astralsorcery:blocktreebeacon> * 1) // 输出：烽火树 x1
    .build();

    // 新配方：金粒 + 金锭 + 玻璃板 + 玻璃透镜 + 星尘 + 海蓝宝石 制作 效应链接通道 x2
RecipeBuilder.newBuilder("giga_qft_ritual_link", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:gold_nugget> * 4) // 金粒 x4
    .addItemInput(<minecraft:gold_ingot> * 1) // 金锭 x1
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 2) // 玻璃透镜 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    
    .addItemOutput(<astralsorcery:blockrituallink> * 2) // 输出：效应链接通道 x2
    .build();

    // 新配方：星尘 + 海蓝宝石 + 大理石柱（元数据6）+ 星能液桶 + 辉光粉 制作 更替之星
RecipeBuilder.newBuilder("giga_qft_shifting_star", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石柱（元数据6）x4
    
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>* 1) // 输出：更替之星 x1
    .build();

    // 新配方：更替之星 + 原石 + 星尘 + 辉光粉 制作 辐射之星（解离座）
RecipeBuilder.newBuilder("giga_qft_radiation_star_evorsio", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4) // 原石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.evorsio"}}) * 1) // 输出：辐射之星（解离座）x1
    .build();

    // 新配方：更替之星 + 树苗 + 星尘 + 辉光粉 制作 生息座（Aevitas）
RecipeBuilder.newBuilder("giga_qft_life_star_aevitas", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addInput(<ore:treeSapling>*4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.aevitas"}}) * 1) // 输出：生息座（Aevitas）x1
    .build();

    // 新配方：更替之星 + 羽毛 + 星尘 + 辉光粉 制作 虚御座（Vicio）
RecipeBuilder.newBuilder("giga_qft_vicio_star", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:feather> * 4) // 羽毛 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.vicio"}}) * 1) // 输出：虚御座（Vicio）x1
    .build();

    // 新配方：更替之星 + 铁锭 + 星尘 + 辉光粉 制作 遁甲座（Armara）
RecipeBuilder.newBuilder("giga_qft_armara_star", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.armara"}}) * 1) // 输出：遁甲座（Armara）x1
    .build();

    // 新配方：更替之星 + 燧石 + 星尘 + 辉光粉 制作 非攻座（Discidia）
RecipeBuilder.newBuilder("giga_qft_discidia_star", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1) // 更替之星 x1
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8) // 星尘 x8
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.discidia"}}) * 1) // 输出：非攻座（Discidia）x1
    .build();

    // 新配方：木棍 + 原木（可替代）+ 海蓝宝石 制作 链接工具
RecipeBuilder.newBuilder("giga_qft_linking_tool", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:stick> * 2) // 木棍 x2
    .addInput(<ore:logWood>*2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    
    .addItemOutput(<astralsorcery:itemlinkingtool> * 1) // 输出：链接工具 x
    .build();

    // 新配方：水晶石 + 玻璃板 + 玻璃透镜 + 辉光粉 + 更替之星 制作 星座核心
RecipeBuilder.newBuilder("giga_qft_constellation_focus", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:glass_pane> * 4) // 玻璃板 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:itemshiftingstar> * 1) // 更替之星 x1
    .addEnergyPerTickInput(750) // 每 tick 输入 750 单位电力 (总电力消耗 = 750 * 40 = 30000)
    .addItemOutput(<packagedastral:constellation_focus> * 1) // 输出：星座核心 x1
    .build();

// 新配方：大理石 + 金锭 + 星能液桶 + 水晶石 制作 仪式基座
RecipeBuilder.newBuilder("giga_qft_ritual_pedestal", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石（元数据2）x4
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    
    
    .addItemOutput(<astralsorcery:blockritualpedestal> * 1) // 输出：仪式基座 x1
    .build();

    // 新配方：金锭 + 海蓝宝石 + 星能液桶 + 星尘 + 大理石 制作 星能聚合器
RecipeBuilder.newBuilder("giga_qft_starlight_infuser", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:gold_ingot> * 2) // 金锭 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addItemInput(<astralsorcery:blockmarble:5> * 2) // 大理石（元数据5）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 6) // 大理石（元数据2）x6
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石（元数据4）x2
    
    .addItemOutput(<astralsorcery:blockstarlightinfuser> * 1) // 输出：星能聚合器 x1
    .build();

    // 新配方：大理石 + 辉光粉 + 水晶石 + 海蓝宝石 + 星尘 制作 照明星杖
RecipeBuilder.newBuilder("giga_qft_illumination_wand", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 2) // 大理石（元数据6）x2
    .addItemInput(<astralsorcery:itemusabledust> * 1) // 辉光粉 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1) // 海蓝宝石 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    
    .addItemOutput(<astralsorcery:itemilluminationwand>) // 输出：照明星杖 x1
    .build();

    // 新配方：大理石 + 钻石 + 星尘 制作 转位星杖
RecipeBuilder.newBuilder("giga_qft_exchange_wand", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:diamond> * 2) // 钻石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1) // 星尘 x1
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:itemexchangewand> * 1) // 输出：转位星杖 x1
    .build();

// 新配方：大理石 + 末影珍珠 + 紫色燃料（可替代） 制作 冲击星杖
RecipeBuilder.newBuilder("giga_qft_grapple_wand", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 1,         // Botania 紫色染料 x1
                <minecraft:dye:5> * 1,        // Minecraft 紫色染料 x1
                <thermalfoundation:dye:5> * 1 // Thermal Foundation 紫色染料 x1
            ])
    ) // 紫色染料（任意种类）x1
    
    .addItemOutput(<astralsorcery:itemgrapplewand> * 1) // 输出：冲击星杖 x1
    .build();

// 新配方：大理石 + 紫色染料（可替代）+ 星尘 制作 秩序星杖
RecipeBuilder.newBuilder("giga_qft_architect_wand", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3) // 大理石（元数据6）x3
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 2,         // Botania 紫色染料 x2
                <minecraft:dye:5> * 2,        // Minecraft 紫色染料 x2
                <thermalfoundation:dye:5> * 2 // Thermal Foundation 紫色染料 x2
            ])
    ) // 紫色染料（任意种类）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    
    .addItemOutput(<astralsorcery:itemarchitectwand> * 1) // 输出：秩序星杖 x1
    .build();

    // 新配方：大理石块（可替代）+ 海蓝宝石 + 末影珍珠 制作 共振星杖
RecipeBuilder.newBuilder("giga_qft_resonance_wand", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间调整为1 tick (0.05秒)，
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble:0> * 2, // 大理石块（元数据0）x2
                <astralsorcery:blockmarble:1> * 2, // 大理石块（元数据1）x2
                <astralsorcery:blockmarble:2> * 2, // 大理石块（元数据2）x2
                <astralsorcery:blockmarble:3> * 2, // 大理石块（元数据3）x2
                <astralsorcery:blockmarble:4> * 2, // 大理石块（元数据4）x2
                <astralsorcery:blockmarble:5> * 2, // 大理石块（元数据5）x2
                <astralsorcery:blockmarble:6> * 2  // 大理石块（元数据6）x2
            ])
    ) // 大理石块（任意元数据）x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:ender_pearl> * 1) // 末影珍珠 x1
    
    .addItemOutput(<astralsorcery:itemwand> * 1) // 输出：共鸣星杖 x1
    .build();

    RecipeBuilder.newBuilder("giga_qft_resonance_wand_vicio", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<minecraft:feather> * 6) // 羽毛 x6
    .addItemInput(<minecraft:reeds> * 2) // 甘蔗 x2
    .addItemInput(<minecraft:arrow> * 2) // 箭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.vicio"}}) * 1)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .build();

    RecipeBuilder.newBuilder("giga_qft_resonance_wand_evorsio", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:gunpowder> * 4) // 火药 x4
    .addItemInput(<minecraft:cobblestone> * 4) // 原石 x4
    .addItemInput(<minecraft:quartz> * 2) // 石英 x2
    .addItemInput(<minecraft:blaze_powder> * 2) // 烈焰粉 x2
    .addItemInput(<minecraft:flint> * 2) // 燧石 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.evorsio"}}) * 1)
    .build();

    RecipeBuilder.newBuilder("giga_qft_resonance_wand_discidia", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<minecraft:blaze_rod> * 2) // 烈焰棒 x2
    .addItemInput(<minecraft:glowstone_dust> * 2) // 萤石粉 x2
    .addItemInput(<minecraft:flint> * 4) // 燧石 x4
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.discidia"}}) * 1)
    .build();

    RecipeBuilder.newBuilder("giga_qft_resonance_wand_armara", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:iron_ingot> * 4) // 铁锭 x4
    .addItemInput(<minecraft:nether_brick> * 2) // 地狱砖 x2
    .addItemInput(<minecraft:leather> * 2) // 皮革 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1>* 2) // 星辉锭 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.armara"}}) * 1)
    .build();

    RecipeBuilder.newBuilder("giga_qft_resonance_wand_aevitas", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1（无NBT）
    .addItemInput(<minecraft:reeds> * 4) // 甘蔗 x4
    .addInput(<ore:treeSapling>*6)
    .addItemInput(<astralsorcery:itemusabledust> * 2) // 辉光粉 x2
    .addItemInput(<minecraft:prismarine_shard> * 2) // 海晶砂砾 x2
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.aevitas"}}) * 1)
    .build();

    // 新配方：星辉合成台 + 聚星木 + ME 封包组件 + 共鸣星杖 + 大理石块 制作 星辉封包合成器
RecipeBuilder.newBuilder("giga_qft_discovery_crafter", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    }) // 时间1秒
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockaltar> * 1) // 星辉合成台 x1
    .addItemInput(<astralsorcery:blockinfusedwood> * 2) // 聚星木 x2
    .addItemInput(<packagedauto:me_package_component> * 1) // ME 封包组件 x1
    .addItemInput(<astralsorcery:itemwand> * 1) // 共鸣星杖 x1
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块 x4
    
    .addItemOutput(<packagedastral:discovery_crafter> * 1) // 输出：星辉封包合成器 x1
    .build();

    // 新配方：海蓝宝石 + 星辉锭 + 水晶石 + 光波增幅器 + 大理石块 制作 共鸣祭坛
RecipeBuilder.newBuilder("giga_qft_attunement_altar", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 2) // 星辉锭 x2
    .addItemInput(<astralsorcery:blockattunementrelay>* 1) // 光波增幅器 x1
    .addItemInput(<astralsorcery:blockmarble:6> * 4) // 大理石块（元数据6）x4
    .addEnergyPerTickInput(500) // 每 tick 输入 500 单位电力 (总电力消耗 = 500 * 25 = 12500)
    .addItemOutput(<astralsorcery:blockattunementaltar> * 1) // 输出：共鸣祭坛 x1
    .build();

// 新配方：大理石 + 星能液桶 + 大理石 制作 星辉祭坛
RecipeBuilder.newBuilder("giga_qft_starlight_altar", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据2）x4
    
    .addItemOutput(<astralsorcery:blockaltar:1> * 1) // 输出：星辉祭坛 x1
    .build();

    // 新配方：星尘 + 星辉锭 + 海蓝宝石 + 水晶石 + 大理石 制作 天辉祭坛
RecipeBuilder.newBuilder("giga_qft_celestial_altar", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:2>* 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    
    .addItemOutput(<astralsorcery:blockaltar:2> * 1) // 输出：天辉祭坛 x1
    .build();

    // 新配方：大理石 + 玻璃透镜 + 海蓝宝石 + 水晶石 + 熏黑大理石 制作 五彩祭坛
RecipeBuilder.newBuilder("giga_qft_prismatic_altar", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1) // 玻璃透镜 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4) // 海蓝宝石 x4
    .addItemInput(<astralsorcery:blockblackmarble> * 4) // 熏黑大理石 x4
    
    .addItemOutput(<astralsorcery:blockaltar:3> * 1) // 输出：五彩祭坛 x1
    .build();

    // 新配方：星辉封包合成器 + 熏黑大理石 + 星能液桶 + 星尘 + 水晶石 + 大理石 制作 星辉封包合成祭坛
RecipeBuilder.newBuilder("giga_qft_attunement_crafter", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<packagedastral:discovery_crafter> * 1) // 星辉封包合成器 x1
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:blockmarble:4> * 2) // 大理石块（元数据4）x2
    .addItemInput(<astralsorcery:blockmarble:2> * 4) // 大理石块（元数据5）x4
    .addItemOutput(<packagedastral:attunement_crafter> * 1) // 输出：星辉封包合成祭坛 x1
    .build();

    // 新配方：星尘 + 水晶石 + 海蓝宝石 + 共振宝石 + 熏黑大理石 + 大理石 + 红石 + 星辉锭 制作 天辉封包祭坛
RecipeBuilder.newBuilder("giga_qft_constellation_crafter", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2) // 海蓝宝石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 2) // 共振宝石 x2
    .addItemInput(<astralsorcery:blockblackmarble> * 2) // 熏黑大理石 x2
    .addItemInput(<astralsorcery:blockmarble:2> * 2) // 大理石块（元数据2）x2
    .addItemInput(<astralsorcery:blockmarble:4> * 4) // 大理石块（元数据4）x4
    .addItemInput(<minecraft:redstone> * 2) // 红石 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1) // 星辉锭 x1
    
    .addItemOutput(<packagedastral:constellation_crafter> * 1) // 输出：天辉封包祭坛 x1
    .build();

    // 新配方：多种材料 制作 五彩封包祭坛
RecipeBuilder.newBuilder("giga_qft_trait_crafter", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:redstone> * 4) // 红石粉 x4
    .addItemInput(<astralsorcery:itemusabledust> * 4) // 辉光粉 x4
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2) // 星尘 x2
    .addItemInput(<minecraft:ender_pearl> * 2) // 末影珍珠 x2
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4) // 共振宝石 x4
    .addItemInput(<astralsorcery:itemusabledust:1>* 2) // 暗夜粉 x2
    .addItemInput(<astralsorcery:blockblackmarble:4> * 4) // 熏黑大理石 x4
    .addItemInput(<astralsorcery:blockmarble:6> * 8) // 大理石块（元数据6）x8
    .addItemInput(<minecraft:ender_eye> * 2) // 末影之眼 x2
    .addItemInput(<packagedastral:constellation_crafter> * 1) // 天辉封包祭坛 x1
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4) // 玻璃透镜 x4
    .addItemOutput(<packagedastral:trait_crafter> * 1) // 输出：五彩封包祭坛 x1

    .build();
RecipeBuilder.newBuilder("endtech_qft_1", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-star_ingot> * 64)
    .addOutput(<contenttweaker:tyf3> * 128)
    .build();
RecipeBuilder.newBuilder("endtech_qft_2", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 64).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:xprotonfluid> * 10000)
    .addOutput(<liquid:bec> * 5000)
    .build();
RecipeBuilder.newBuilder("endtech_qft_3", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 64).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:bec> * 10000)
    .addOutput(<liquid:higgsfluid> * 5000)
    .build();
RecipeBuilder.newBuilder("endtech_qft_4", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0)
    .addInput(<contenttweaker:octingot> * 4)
    .addOutput(<contenttweaker:nova_ingot> * 64)
    .addRecipeTooltip("§a并行数量由§5时空破碎§9发生器§a数量决定§f")
    .build();
RecipeBuilder.newBuilder("endtech_qft_5", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<mekanism:antimatterpellet> * 16)
    .addOutput(<contenttweaker:antimatter_core>)
    .build();
RecipeBuilder.newBuilder("endtech_qft_6", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<appliedenergistics2:material:5> * 128)
    .addOutput(<enderio:item_material:41> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_7", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:glass> * 64)
    .addOutput(<tconstruct:clear_glass> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_8", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 256).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:aefe> * 16000).setChance(0)
    .addInputs([
        <liquid:zerotempaturefluid> * 10000,
        <liquid:higgsfluid> * 100000,
        <liquid:dimensionbeam> * 10000,
        <contenttweaker:novamatrix>,
        <contenttweaker:tearenginee>,
        <contenttweaker:arcance_ingot>
    ])
    .addOutput(<liquid:aefe> * 64000)
    .build();
RecipeBuilder.newBuilder("endtech_qft_9", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:41> * 64)
    .addOutput(<enderio:item_material:42> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_10", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_material:42> * 64)
    .addOutput(<enderio:item_material:44> * 64)
    .build();

RecipeBuilder.newBuilder("endtech_qft_11", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<minecraft:ender_pearl> * 64)
    .addOutput(<enderio:item_alloy_ingot:5> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_12", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<enderio:item_alloy_ingot:5> * 64)
    .addOutput(<enderio:item_material:14> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_13", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:exponential_level_processor> * 64)
    .addOutput(<contenttweaker:infinity_processor> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_14", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:infinity_processor> * 64)
    .addOutput(<contenttweaker:inactivenanites> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_15", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<modularmachinery:mega_advancedwarmatrix_factory_controller>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:novamatrix>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:inactivenanites> * 64)
    .addOutput(<contenttweaker:nanites> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_16", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<modularmachinery:spacetime_gestalt_factory_controller> * 16).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:novamatrix>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:nanites> * 64)
    .addOutput(<contenttweaker:nanoswarm> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_17", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:superluminal_core>)
    .addOutput(<contenttweaker:lightspeed_overclock_array>)
    .build();
RecipeBuilder.newBuilder("endtech_qft_18", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:hyper_strenth_machine_block>)
    .addOutput(<mekanism:basicblock3> * 1024)
    .build();
RecipeBuilder.newBuilder("endtech_qft_19", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 64).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:nq_alloy> * 64)
    .addInput(<contenttweaker:alloy> * 64)
    .addInput(<contenttweaker:nova_ingot> * 16)
    .addInput(<contenttweaker:starvoidstructure> * 64)
    .addOutput(<contenttweaker:quantum_ingot> * 4)
    .build();
RecipeBuilder.newBuilder("endtech_qft_20", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:quantum_ingot> * 64)
    .addInput(<contenttweaker:spacexmachineblock> * 64)
    .addOutput(<contenttweaker:manipulator> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_21", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:manipulator> * 64)
    .addOutput(<contenttweaker:dimensionally_transcendent_casing> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_22", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ic2:misc_resource:1> * 64)
    .addOutput(<ic2:crafting:4> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_23", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<thermalfoundation:material:129> * 64)
    .addOutput(<ic2:crafting:3> * 64)
    .build();
RecipeBuilder.newBuilder("endtech_qft_24", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<liquid:plasma> * 10000)
    .addOutput(<liquid:base_fuel> * 10000)
    .build();
RecipeBuilder.newBuilder("endtech_qft_25", "giga_qft", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){    
        event.activeRecipe.maxParallelism = 10485760;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val Universe_level = data.getInt("Universe_level",1.0);
        event.factoryRecipeThread.addModifier("increase_product_item",RecipeModifierBuilder.create("modularmachinery:item","output",Universe_level * 64,1,false).build());
        event.factoryRecipeThread.addModifier("increase_product_fluid",RecipeModifierBuilder.create("modularmachinery:fluid","output",Universe_level * 64,1,false).build());
    })
    .addInput(<contenttweaker:etherengine_upgrade> * 8).setChance(0).setParallelizeUnaffected(true)
    .addInput(<astralsorcery:itemcraftingcomponent> * 64)
    .addOutput(<astralsorcery:itemcraftingcomponent:4> * 64)
    .build();
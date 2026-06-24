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
HyperNetHelper.proxyMachineForHyperNet("vaticlaser");
MachineModifier.setMaxThreads("vaticlaser",0);
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("超冷反应单元#1").addRecipe("VATIC_bec").addRecipe("VATIC_steady").addRecipe("VATIC_steady_2").addRecipe("VATIC_weave_neutron"));
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("超冷反应单元#2").addRecipe("VATIC_bec").addRecipe("VATIC_steady").addRecipe("VATIC_steady_2").addRecipe("VATIC_weave_neutron"));
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("超冷反应单元#3").addRecipe("VATIC_bec").addRecipe("VATIC_steady").addRecipe("VATIC_steady_2").addRecipe("VATIC_weave_neutron"));
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("超冷反应单元#4").addRecipe("VATIC_bec").addRecipe("VATIC_steady").addRecipe("VATIC_steady_2").addRecipe("VATIC_weave_neutron"));
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("多模态液体反应单元").addRecipe("VATIC_crystalloid_create"));
MachineModifier.addCoreThread("vaticlaser",FactoryRecipeThread.createCoreThread("自然魔力反应单元").addRecipe("VATIC_mana_create"));
MMEvents.onStructureFormed("vaticlaser" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var modeblock1 = ctrl.getBlocksInPattern(<contenttweaker:atomcoolingblock>);
    var modeblock2 = ctrl.getBlocksInPattern(<contenttweaker:supermanablock>);
    var modeblock3 = ctrl.getBlocksInPattern(<contenttweaker:superinstanceblock>);
    var glass1 = ctrl.getBlocksInPattern(<minecraft:stained_glass:11>);
    var glass2 = ctrl.getBlocksInPattern(<minecraft:stained_glass:9>);
    var glass3 = ctrl.getBlocksInPattern(<minecraft:stained_glass:10>);
    if(modeblock1 == 98 && glass1 == 272){
      map["mode"]=1;
      ctrl.customData = data;
    }
    if(modeblock2 == 98 && glass2 == 272){
      map["mode"]=2;
      ctrl.customData = data;
    }
    if(modeblock3 == 98 && glass3 == 272){
      map["mode"]=3;
      ctrl.customData = data;
    }
});
RecipeBuilder.newBuilder("VATIC_bec", "vaticlaser", 20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 1){
      event.setFailed("超低温逆熵运行核心离线");
   }
    event.activeRecipe.maxParallelism = 64;
    event.activeRecipe.parallelism = 64;
 })
    .addEnergyPerTickInput(80000000000)
    .addFluidInput(<liquid:superfluid_he> * 1000)
    .addFluidInput(<liquid:higgsfluid> * 100)
    .addFluidInput(<liquid:xprotonfluid> * 100)
    .addFluidOutput(<liquid:bec> * 500)
    .requireComputationPoint(4000.0F)
    .addRecipeTooltip("制造一种同步的原子流体")
    .addRecipeTooltip("该配方的并行上限为64")
    .addRecipeTooltip("需要§9超低温逆熵运行核心")
    .build();

RecipeBuilder.newBuilder("VATIC_steady", "vaticlaser", 20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 1){
      event.setFailed("超低温逆熵运行核心离线");
   }
    event.activeRecipe.maxParallelism = 1024;
    event.activeRecipe.parallelism = 1024;
 })
    .addEnergyPerTickInput(40000000000)
    .addFluidInputs([
        <liquid:neutronium>*10,
        <liquid:xprotonfluid>*4000,
        <liquid:crystalloidneutron>*10
    ])
    .addFluidOutput(<liquid:steady_ultra_dense_atomic_matter>*4000)
    .requireComputationPoint(100.0F)
    .addRecipeTooltip("制造一种稳定的高密度工业流体")
    .addRecipeTooltip("该配方的并行上限为1024")
    .addRecipeTooltip("需要§9超低温逆熵运行核心")
    .build();
   
RecipeBuilder.newBuilder("VATIC_steady_2", "vaticlaser", 20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 1){
      event.setFailed("超低温逆熵运行核心离线");
   }
    event.activeRecipe.maxParallelism = 1024;
    event.activeRecipe.parallelism = 1024;
 })
    .addEnergyPerTickInput(40000000000)
    .addFluidInputs([
        <liquid:infinity_metal>*2,
        <liquid:xprotonfluid>*4000,
        <liquid:crystalloidneutron>*10
    ])
    .addFluidOutput(<liquid:steady_ultra_dense_atomic_matter>*40000)
    .requireComputationPoint(1000.0F)
    .addRecipeTooltip("制造一种稳定的高密度工业流体")
    .addRecipeTooltip("无尽涌流极大的催化了产出")
    .addRecipeTooltip("该配方的并行上限为1024")
    .addRecipeTooltip("需要§9超低温逆熵运行核心")
    .build();

RecipeBuilder.newBuilder("VATIC_weave_neutron", "vaticlaser", 20,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 1){
      event.setFailed("超低温逆熵运行核心离线");
   }
    event.activeRecipe.maxParallelism = 2048;
    event.activeRecipe.parallelism = 2048;
 })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
      <liquid:neutronium>*1
    ])
    .addInput(<avaritia:resource:2>)
    .addFluidOutput(<liquid:neutron>*1000)
    .requireComputationPoint(100.0F)
    .addRecipeTooltip("快速制造流体中子")
    .addRecipeTooltip("该配方的并行上限为2048")
    .addRecipeTooltip("需要§9超低温逆熵运行核心")
    .build();

RecipeBuilder.newBuilder("VATIC_crystalloid_create", "vaticlaser", 40,2)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 3){
      event.setFailed("多模态液体自增殖核心离线");
   }
    event.activeRecipe.maxParallelism = 8;
    event.activeRecipe.parallelism = 8;
 })
    .addEnergyPerTickInput(4000000)
    .addInputs([
      <eternalsingularity:eternal_singularity>*1
    ]).setChance(0.1)
    .addCatalystInput(<contenttweaker:etherengine_upgrade>,
        ["使用破碎单元影响局部时空", "使紫晶素产量翻8倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 8.0F, 1, false).build(),
        ]
    ).setChance(0.01)
        .addCatalystInput(<contenttweaker:uu_crystal_1>,
        ["使用先进工业加工原始材料", "使紫晶素产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0.1)
        .addCatalystInput(<contenttweaker:uu_crystal_2>,
        ["使用先进工业加工原始材料", "使紫晶素产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0.1)
        .addCatalystInput(<contenttweaker:uu_crystal_3>,
        ["使用先进工业加工原始材料", "使紫晶素产量翻8倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 8.0F, 1, false).build(),
        ]
    ).setChance(0.1)
    .addFluidInput(<liquid:water>*12238)
    .addFluidOutput(<liquid:crystalloid>*12238)
    .requireComputationPoint(500.0F)
    .addRecipeTooltip("稳定使用永恒奇点催化紫晶素的生成")
    .addRecipeTooltip("该配方的并行上限为8")
    .addRecipeTooltip("需要§d多模态液体自增殖核心")
    .build();

RecipeBuilder.newBuilder("VATIC_mana_create", "vaticlaser", 40,3)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val mode = data.getInt("mode",0);
   if(mode != 2){
      event.setFailed("超能魔力聚合核心离线");
   }
    event.activeRecipe.maxParallelism = 8;
    event.activeRecipe.parallelism = 8;
 })
    .addEnergyPerTickInput(4000000)
    .addInputs([
      <extrabotany:manaliquefaction>
    ]).setChance(0)
    .addCatalystInput(<contenttweaker:etherengine_upgrade>,
        ["使用破碎单元影响局部时空", "使液态魔力产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0.01)
        .addCatalystInput(<contenttweaker:mana_crystal_1>,
        ["使用先进工业加工原始材料", "使液态魔力产量翻1倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0.1)
        .addCatalystInput(<contenttweaker:mana_crystal_2>,
        ["使用先进工业加工原始材料", "使液态魔力产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0.1)
        .addCatalystInput(<contenttweaker:mana_crystal_3>,
        ["使用先进工业加工原始材料", "使液态魔力产翻8倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 8.0F, 1, false).build(),
        ]
    ).setChance(0.1)
        .addCatalystInput(<botania:specialflower>.withTag({type: "asgardandelion"})*16,
        ["使用无尽催化液态魔力产出", "使液态魔力产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addFluidOutput(<liquid:fluidedmana>*12238)
    .requireComputationPoint(500.0F)
    .addRecipeTooltip("吸收转化自然中存储的巨量魔力")
    .addRecipeTooltip("该配方的并行上限为8")
    .addRecipeTooltip("需要§b超能魔力聚合核心在线")
    .build();
MMEvents.onControllerGUIRender("vaticlaser", function(event as ControllerGUIRenderEvent) {
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val mode = data.getInt("mode",0);
    var info as string[] = [];
   info += "§1//////////// §eVATIC§c熵控§b核心 §1////////////";
        if(mode == 1){
         info += "§9超低温逆熵运行核心在线";
        }
        if(mode == 2){
         info += "§b超能魔力聚合核心在线";
        }
        if(mode == 3){
         info += "§d多模态液体自增殖核心在线";
        } 

    event.extraInfo = info;
});
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

HyperNetHelper.proxyMachineForHyperNet("atomicprocessequipx");
MachineModifier.setMaxThreads("atomicprocessequipx", 15);
MachineModifier.addCoreThread("atomicprocessequipx",FactoryRecipeThread.createCoreThread("升级组件装配").addRecipe("atmoicprocess_upgrade"));
RecipeBuilder.newBuilder("atomicprocessequipx_factory_controllerMAKE","workshop",3600)
    .addEnergyPerTickInput(500000000)
    .addFluidInputs([
        <liquid:plasma>*1000000,
        <liquid:crystalloid>*10000,
    ])
    .addItemInputs([
        <modularmachinery:acar_factory_controller>*16,
        <modularmachinery:assembly_line_factory_controller>*16,
        <modularmachinery:ion_generator_controller>*32,
        <contenttweaker:industrial_circuit_v1>*128,
        <contenttweaker:industrial_circuit_v2>*64,
        <contenttweaker:industrial_circuit_v3>*32,
        <contenttweaker:field_generator_v2>*16,
    ])
    .addOutputs([
        <modularmachinery:atomicprocessequipx_factory_controller>
    ])
    .requireResearch("atomicprocess")
    .build();

//装配线
RecipeAdapterBuilder.create("atomicprocessequipx", "modularmachinery:acar")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_upgrade = data.getInt("is_upgrade",0);
    if(is_upgrade == 0)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build());
    else if(is_upgrade == 1)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
  })
    .build();
//集成车间
RecipeAdapterBuilder.create("atomicprocessequipx", "modularmachinery:workshop")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_upgrade = data.getInt("is_upgrade",0);
    if(is_upgrade == 0)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build());
    else if(is_upgrade == 1)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
  })
    .build();
//机械臂
RecipeAdapterBuilder.create("atomicprocessequipx", "modularmachinery:machine_arm")
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
  .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_upgrade = data.getInt("is_upgrade",0);
    if(is_upgrade == 0)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build());
    else if(is_upgrade == 1)event.factoryRecipeThread.addModifier("decrease_time",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
  })
    .build();

# 特殊合成
# 恒星机械外壳
// 恒星机械外壳
RecipeBuilder.newBuilder("planetmachineblockCraft","workshop",300)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
  .addEnergyPerTickInput(1000000)
  .addInputs([
    <contenttweaker:skydust>*1024,
    <enderio:item_alloy_ingot:6>*64,
    <modularmachinery:blockcasing:4>*64,
    <enderio:item_material:20>*256,
    <appliedenergistics2:material:45>*128,
  ])
  .addOutputs(<contenttweaker:starmachineblock>*64)
  .requireComputationPoint(200.0)
  .build();

// 卡西米尔效应阵列
RecipeBuilder.newBuilder("casmireffectseq","atomicprocessequipx",450)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(8000000000)
    .addItemInputs([
        <moreplates:infinity_plate>*4,
        <contenttweaker:carbon_nanotube>*64,
        <contenttweaker:industrial_circuit_v4>*32,
        <contenttweaker:sensor_v4>*4,
        <contenttweaker:field_generator_v2>*8,
        <ic2:crafting:4>*128,
        <ic2:crafting:3>*128,
    ])
    .addOutputs([
        <contenttweaker:casmir_effect_seq>
    ])
    .requireComputationPoint(2000.0)
    .build();

// 微型约束磁流体智控加速器
RecipeBuilder.newBuilder("micrommf","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(8000000000)
    .addItemInputs([
        <contenttweaker:energized_fuel_v4>,
        <additions:novaextended-extremecircuit>*64,
        <mets:super_iridium_compress_plate>*32,
        <contenttweaker:sensor_v4>*8,
        <contenttweaker:field_generator_v3>*1,
        <ic2:crafting:4>*128,
        <ic2:crafting:3>*128,
        <contenttweaker:hypernet_gpu_t3>*1
    ])
    .addOutputs([
        <contenttweaker:micro_mmf_accelerator>*4,
        <contenttweaker:energized_fuel_container_v4>*8
    ])
    .requireComputationPoint(2000.0)
    .build();

// 时空稳定框架
RecipeBuilder.newBuilder("spacetimeframeworkCraft","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(8000000000)
    .addItemInputs([
        <ic2:crafting:3>*256,
        <contenttweaker:carbon_nanotube>*128,
        <mets:super_iridium_compress_plate>*32,
        <contenttweaker:reflectcore>*1,
        <contenttweaker:shieldcase>*2,
        <ic2:crafting:4>*128,
    ])
    .addOutputs([
        <contenttweaker:spacetimeframework>
    ])
    .requireComputationPoint(2000.0)
    .build();

// 屏蔽罩
RecipeBuilder.newBuilder("shieldcaseCraft","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addItemInputs([
        <contenttweaker:field_generator_v1>*8,
        <additions:novaextended-fallen_star_alloy>*64,
    ])
    .addOutputs([
        <contenttweaker:shieldcase>
    ])
    .requireComputationPoint(4000.0)
    .build();

// 反射力场稳定单元
RecipeBuilder.newBuilder("coreCraft","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addItemInputs([
        <threng:material:6>*328,
        <moreplates:neutronium_plate>*100,
        <contenttweaker:field_generator_v1>*8,
        <contenttweaker:field_generator_v2>*8,
        <contenttweaker:field_generator_v3>*8,
    ])
    .addOutputs([
        <contenttweaker:reflectcore>
    ])
    .requireComputationPoint(800.0)
    .build();

// 引力场源稳定核心
RecipeBuilder.newBuilder("gravitycoreCraft","atomicprocessequipx",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(6000000)
    .addItemInputs([
        <avaritia:resource:4>*10,
        <contenttweaker:skydust>*100,
        <contenttweaker:charging_crystal_block>*8
    ])
    .requireComputationPoint(1000.0)
    .addOutputs(<contenttweaker:fieldofgravitycore>)
    .build();

// 碳纤维复合材料
RecipeBuilder.newBuilder("cfcm_create","atomicprocessequipx",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(8000000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*16,
        <moreplates:neutronium_plate>,
        <contenttweaker:degenerationmatter>*16
    ])
    .addFluidInput(<liquid:steady_ultra_dense_atomic_matter>*500)
    .requireComputationPoint(100.0)
    .addOutput(<contenttweaker:cfcm>)
    .build();

// M-CRYSTAL集成系统芯片
RecipeBuilder.newBuilder("crystalchip_create","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(10000000000)
    .addFluidInput(<liquid:ic2coolant>*10000)
    .addInputs([
        <avaritia:resource:1>*128,
        <mets:advanced_heat_vent>*8,
        <mets:advanced_oc_heat_vent>*16,
        <contenttweaker:industrial_circuit_v2>*8,
        <contenttweaker:sensor_v2>*16,
        <actuallyadditions:item_misc:7>*32
    ])
    .requireComputationPoint(100.0)
    .addOutput(<contenttweaker:crystalchip>)
    .build();

// F-UNIVERSAL集成系统芯片
RecipeBuilder.newBuilder("universalchip_create","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(20000000000)
    .addFluidInput(<liquid:crystalloid>*10000)
    .addInputs([
        <contenttweaker:crystalchip>*8,
        <additions:novaextended-fallen_star_alloy>*128,
        <contenttweaker:field_generator_v2>*16,
        <contenttweaker:sensor_v3>*16,
        <actuallyadditions:item_misc:8>*256,
        <mets:nano_living_metal>*64
    ])
    .requireComputationPoint(400.0)
    .addOutput(<contenttweaker:universalalloychip>)
    .build();

//余烬-虚空力场控制器
RecipeBuilder.newBuilder("dust_forcefieldcontrolblock","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(20000000)
    .addFluidInputs([
        <liquid:unsteady_plasma>*100000,
        <liquid:pyrotheum>*1000000
    ])
    .addInputs([
        <contenttweaker:neutrondustingot>*128,
        <contenttweaker:voidmatter>*56,
        <contenttweaker:coil_v5>*128,
        <contenttweaker:starmachineblock>*64,
        <contenttweaker:planetstructure>*64,
        <contenttweaker:infinity_wire>*8,
        <contenttweaker:spacematrix_ingot>*4,
        <contenttweaker:neutronchip>*8,
    ])
    .requireComputationPoint(20000.0)
    .addOutput(<contenttweaker:dustmatrix>)
    .build();

//余烬热能单元
RecipeBuilder.newBuilder("dust_heater","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addInputs([
        <contenttweaker:dust>*4,
        <contenttweaker:geocentric_quartz_crystal_charged>*64,
        <contenttweaker:electric_motor_v4>*1,
        <contenttweaker:sensor_v4>*1,
        <contenttweaker:field_generator_v3>*4,
        <avaritia:block_resource>*16,
        <contenttweaker:starmachineblock>*8,
    ])
    .addOutput(<contenttweaker:heatmatrix>)
    .requireComputationPoint(1000.0)
    .build();

//中子系统芯片
RecipeBuilder.newBuilder("neutronchip","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(8000000)
    .addFluidInputs([
        <liquid:neutronium>*18888,
        <liquid:steady_ultra_dense_atomic_matter>*8888
    ])
    .addInputs([
        <contenttweaker:universalalloychip>*8,
        <contenttweaker:degenerationmatter>*256,
        <mets:neutron_plate>*48,
        <contenttweaker:cfcm>*16,
        <avaritia:resource:4>*128,
        <contenttweaker:forcecontainer>*1,
    ])
    .addOutput(<contenttweaker:neutronchip>)
    .requireComputationPoint(1000.0)
    .build();

//无尽系统芯片
RecipeBuilder.newBuilder("avartiachip","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(120000000)
    .addFluidInputs([
        <liquid:t1000>*4000,
        <liquid:crystalloid>*5625,
        <liquid:crystalloidneutron>*8762
    ])
    .addInputs([
        <contenttweaker:neutronchip>*8,
        <avaritiatweaks:enhancement_crystal>*2,
        <contenttweaker:becmemory>*1,
        <contenttweaker:beccomputer>*2,
        <contenttweaker:casmir_effect_seq>*3,
        <contenttweaker:sensor_v4>*3,
    ])
    .addOutput(<contenttweaker:infinitychip>)
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("arkchip","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(200000000)
    .addFluidInputs([
        <liquid:bec>*10000,
        <liquid:dimensionbeam>*10000,
        <liquid:higgsfluid>*10000,
        <liquid:oslash_matter>*10000,
    ])
    .addInputs([
        <contenttweaker:infinitychip>*8,
        <contenttweaker:nanites>*64,
        <contenttweaker:recoilengine>,
        <contenttweaker:octingot>*8,
        <contenttweaker:spacematrix_ingot>*24,
        <contenttweaker:antimatter_core>,
        <contenttweaker:world_energy_core>*2,
        <additions:novaextended-star_ingot>*276,
        <contenttweaker:spacetimeframework>*12
    ])
    .addOutput(<contenttweaker:arkchip>)
    .requireComputationPoint(60000.0)  // 原600000.0 -> 60000.0
    .build();

//微型撕裂引擎
RecipeBuilder.newBuilder("tear_engine","atomicprocessequipx",1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addFluidInputs([
        <liquid:t1000>*10000
    ])
    .addInputs([
        <contenttweaker:neutronchip>,
        <contenttweaker:gama_tialcoil>*256,
        <contenttweaker:cfcm>*128,
        <contenttweaker:wisecore>,
        <contenttweaker:world_energy_core>
    ])
    .addOutputs([
        <contenttweaker:tearenginee>
    ])
    .requireComputationPoint(20000.0)
    .requireResearch("theory_reap_spacetime")
    .build();

//非格式塔蜂群
RecipeBuilder.newBuilder("nanoswarm_create1","atomicprocessequipx",2000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addFluidInputs([
        <liquid:crystalloid>*100000,
        <liquid:crystalloidneutron>*100000,
        <liquid:chaotic_metal>*10000,
    ])
    .addInputs([
        <contenttweaker:nanites>*4,
        <contenttweaker:hypernet_gpu_t1> *4,
        <contenttweaker:hypernet_gpu_t2>*4,
        <contenttweaker:hypernet_gpu_t3>*2,
        <contenttweaker:starmachineblock>*512,
        <contenttweaker:asteroidcontrolblock>*16,
        <moreplates:infinity_gear>*4,
        <contenttweaker:antimatter_core>*2,
    ])
    .addOutputs([
        <contenttweaker:nanoswarm>
    ])
    .requireResearch("theory_nano_swarm")
    .requireComputationPoint(16000.0)
    .build();

//集成智慧核心
RecipeBuilder.newBuilder("wisecore","atomicprocessequipx",800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addFluidInputs([
        <liquid:higgsfluid>*10000,
        <liquid:phi_matter>*10000,
        <liquid:oslash_matter>*10000,
    ])
    .addInputs([
        <contenttweaker:industrial_circuit_v1>*32,
        <contenttweaker:industrial_circuit_v2>*32,
        <contenttweaker:industrial_circuit_v3>*32,
        <contenttweaker:hypernet_cpu_t1>*4,
        <contenttweaker:hypernet_cpu_t2>*4,
        <contenttweaker:hypernet_cpu_t3>*4,
        <contenttweaker:hypernet_cpu_t4>*4,
        <contenttweaker:data_model_card>*16,
    ])
    .addOutputs([
        <contenttweaker:wisecore>
    ])
    .requireComputationPoint(50000.0)  // 原500000.0 -> 50000.0
    .build();

//去相干抑制粒子井
RecipeBuilder.newBuilder("particle_well","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(80000000)
    .addInputs([
        <contenttweaker:ljgz>*968,
        <contenttweaker:crystalred>*8,
        <contenttweaker:crystalpurple>*8,
        <contenttweaker:crystalgreen>*8,
        <contenttweaker:coil_v5>*32,
        <extendedcrafting:material:32>*16,
        <contenttweaker:spacetimeframework>*2
    ])
    .addOutputs([
        <contenttweaker:forcemanucontainer>
    ])
    .requireComputationPoint(5000.0)
    .build();

RecipeBuilder.newBuilder("assemblycore","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(80000000)
    .addFluidInputs([
        <liquid:t1000>*10000,
    ])
    .addInputs([
        <contenttweaker:additional_component_3>,
        <contenttweaker:field_generator_v3>*4,
        <contenttweaker:sensor_v4>*4,
        <contenttweaker:fieldofgravitycore>*16,
        <contenttweaker:universalalloychip>*8,
    ])
    .addOutputs([
        <contenttweaker:assemblycore>
    ])
    .requireComputationPoint(50000.0)  // 原500000.0 -> 50000.0
    .build();

RecipeBuilder.newBuilder("lightplatform","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(80000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
        <liquid:liquidethene>*100000,
    ])
    .addInputs([
        <additions:novaextended-extremecircuit>*32,
        <appliedenergistics2:material:22>*64,
        <contenttweaker:exponential_level_processor>*64,
        <appliedenergistics2:material:23>*64,
        <contenttweaker:charging_crystal_block>*128,
        <appliedenergistics2:material:24>*64,
        <contenttweaker:energized_fuel_container_v3>*16,
        <contenttweaker:hypernet_gpu_t3>
    ])
    .addOutputs([
        <contenttweaker:lightplatform>
    ])
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("planet_structure_block","atomicprocessequipx",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:coal>*10000,
        <liquid:nether_brick>*10000,
    ])
    .addInputs([
        <enderio:item_alloy_ingot>*256,
        <enderio:item_alloy_ingot:6>*256,
        <thermalfoundation:material:160>*256,
        <enderio:item_material:20>*2048,
        <contenttweaker:degenerationmatter>*96,
        <avaritia:resource:2>*999
    ])
    .addOutputs([
        <contenttweaker:planetstructure>*4
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("darkmatter_structure","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:coal>*10000000,
        <liquid:nether_brick>*1000000,
    ])
    .addInputs([
        <contenttweaker:darkmatters>,
        <mets:neutron_plate>*188,
        <contenttweaker:degenerationmatter>*487,
        <contenttweaker:skydust>*1024,
        <contenttweaker:hypernet_cpu_t4>,
        <contenttweaker:sensor_v4>*4
    ])
    .addOutputs([
        <contenttweaker:darkmatterblock>*16
    ])
    .addRecipeTooltip("模拟暗物质的结构进行数据建模制造的拟似材料")
    .requireComputationPoint(20000.0)
    .build();

RecipeBuilder.newBuilder("similardarkmatter_structure","atomicprocessequipx",800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:coal>*10000000,
        <liquid:nether_brick>*1000000,
    ])
    .addInputs([
        <contenttweaker:similardarkmatter>,
        <mets:neutron_plate>*376,
        <contenttweaker:degenerationmatter>*999,
        <contenttweaker:skydust>*2048,
        <contenttweaker:hypernet_cpu_t4>*4,
        <contenttweaker:sensor_v4>*16
    ])
    .addOutputs([
        <contenttweaker:darkmatterblock>*1
    ])
    .addRecipeTooltip("模拟暗物质的结构进行数据建模制造的拟似材料")
    .addRecipeTooltip("拟合粒子将会消耗更多的算力与时间进行建模")
    .requireComputationPoint(40000.0)
    .build();

RecipeBuilder.newBuilder("high_energy_structure","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:dimensionbeam>*1000,
        <liquid:t1000>*1000,
        <liquid:crystalloid>*1000,
        <liquid:liquid_energy>*10000
    ])
    .addInputs([
        <contenttweaker:coil_v5>*32,
        <modularmachinery:blockcasing:4>*512,
        <contenttweaker:spacematrix_ingot>*1,
    ])
    .addOutputs([
        <contenttweaker:stablestructure>
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("space_framework","atomicprocessequipx",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:crystal_matrix>*1000,
        <liquid:steady_ultra_dense_atomic_matter>*1000,
        <liquid:neutronium>*1000
    ])
    .addInputs([
        <rftools:dimensional_shard>*600,
        <avaritia:resource:4>*148,
        <extrabotany:material:8>*16,
        <extrabotany:material:5>*16,
        <mets:niobium_titanium_ingot>*18,
        <mets:super_iridium_alloy>*16,
    ])
    .addOutputs([
        <contenttweaker:space_engblock>
    ])
    .requireComputationPoint(500.0)
    .build();

RecipeBuilder.newBuilder("dimension_twisting","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:tachyonfluid>*50,
        <liquid:spaceframefluid>*50,
    ])
    .addInputs([
        <contenttweaker:universalforcefieldcontrolblock>,
        <contenttweaker:neutronchip>*1,
        <contenttweaker:spacetimeframework>*8,
    ])
    .addOutputs([
        <contenttweaker:dimensiontwistblock>
    ])
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("dimension_computer","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:gelid_enderium>*100000,
    ])
    .addInputs([
        <contenttweaker:wisecore>,
        <contenttweaker:universalalloychip>*4,
        <contenttweaker:industrial_circuit_v3>*8,
        <contenttweaker:sensor_v3>*16,
        <environmentaltech:aethium_crystal>*76,
        <environmentaltech:ionite_crystal>*124,
        <environmentaltech:pladium_crystal>*180,
        <contenttweaker:ljgz>*999
    ])
    .addOutputs([
        <contenttweaker:caldevice>*16
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .build();

RecipeBuilder.newBuilder("anti_structure","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:t1000>*5000,
    ])
    .addInputs([
        <contenttweaker:crystalred>*8,
        <contenttweaker:crystalpurple>*8,
        <contenttweaker:crystalgreen>*8,
        <contenttweaker:cfcm>*32,
        <contenttweaker:field_generator_v3>*8,
        <contenttweaker:shieldcase>*6
    ])
    .addOutputs([
        <contenttweaker:asteroidcontrolblock>
    ])
    .requireComputationPoint(4000.0)
    .build();

RecipeBuilder.newBuilder("laseri_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:aurorium_fluid>*100000
    ])
    .addInputs([
        <minecraft:nether_star>*456,
        <deepmoblearning:pristine_matter_wither>*704,
        <contenttweaker:gama_tialcoil>*128,
        <contenttweaker:ljgz>*789,
    ])
    .addOutputs([
        <contenttweaker:upgradelaser1>
    ])
    .requireComputationPoint(20000.0)
    .build();

RecipeBuilder.newBuilder("laserii_make","atomicprocessequipx",2400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(50000000)
    .addFluidInputs([
        <liquid:zerotempaturefluid>*100000,
        <liquid:tachyonfluid>*1000,
        <liquid:spaceframefluid>*1000,
    ])
    .addInputs([
        <contenttweaker:upgradelaser1>*8,
        <contenttweaker:infinitychip>*1,
        <contenttweaker:field_generator_v4>*3,
        <additions:novaextended-ark_circuit>*4
    ])
    .addOutputs([
        <contenttweaker:ultminingdevice>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .build();

RecipeBuilder.newBuilder("nanities_make","atomicprocessequipx",1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(800000000)
    .addFluidInputs([
        <liquid:t1000>*1000,
    ])
    .addInputs([
        <threng:material:6>*32,
        <contenttweaker:infinity_processor>*4,
        <contenttweaker:exponential_level_processor>*16,
        <contenttweaker:lifesense_processor>*16,
        <appliedenergistics2:material:24>*64,
        <appliedenergistics2:material:22>*64,
        <appliedenergistics2:material:23>*64,
        <contenttweaker:cfcm>*32,
        <contenttweaker:carbon_nanotube>*64,
    ])
    .addOutputs([
        <contenttweaker:inactivenanites>*4,
    ])
    .requireComputationPoint(4000.0)
    .build();

RecipeBuilder.newBuilder("optics_component","atomicprocessequipx",1000)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addFluidInputs([
        <liquid:sic_vapor>*100000,
    ])
    .addInputs([
        <astralsorcery:itemcraftingcomponent:1>*486,
        <astralsorcery:itemcraftingcomponent:4>*177,
        <astralsorcery:itemcoloredlens>,
        <astralsorcery:itemcoloredlens:1>,
        <astralsorcery:itemcoloredlens:2>,
        <astralsorcery:itemcoloredlens:3>,
        <astralsorcery:itemcoloredlens:4>,
        <astralsorcery:itemcoloredlens:5>,
        <astralsorcery:itemcoloredlens:6>,
        <contenttweaker:sensor_v4>*2,
    ])
    .addOutputs([
        <contenttweaker:opticsunit>,
    ])
    .requireComputationPoint(8000.0)
    .build();

RecipeBuilder.newBuilder("atomicclock_make","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:bec>*10000,
        <liquid:tachyonfluid>*1000,
    ])
    .addInputs([
        <additions:novaextended-novaextended_medal>,
        <appliedenergistics2:material:1>*512,
        <additions:novaextended-crystal4>*3,
        <appliedenergistics2:material:47>*256,
        <contenttweaker:sensor_v3>*4,
    ])
    .addOutputs([
        <contenttweaker:atomicclock>,
    ])
    .requireComputationPoint(8000.0)
    .build();

RecipeBuilder.newBuilder("spacetime_lens","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:dimensionbeam>*100000,
    ])
    .addInputs([
        <contenttweaker:opticsunit>*16,
        <contenttweaker:octingot>*8,
        <contenttweaker:nanites>*16,
        <contenttweaker:infinitychip>*1,
    ])
    .addOutputs([
        <contenttweaker:spacetime_lens>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .build();

RecipeBuilder.newBuilder("LHC_MAKE","atomicprocessequipx",2400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:plasma>*2008910
    ])
    .addInputs([
        <modularmachinery:laseraccelerator_factory_controller>*4,
        <contenttweaker:micro_mmf_accelerator>*16,
        <contenttweaker:sensor_v4>*18,
        <contenttweaker:electric_motor_v4>*18,
        <contenttweaker:industrial_circuit_v3>*24,
        <contenttweaker:robot_arm_v4>*16,
        <contenttweaker:superconidiosome>*96,
    ])
    .addOutputs([
        <modularmachinery:lhcparticle_factory_controller>,
    ])
    .requireComputationPoint(40000.0)
    .requireResearch("new_age_is_upon_us")
    .build();

RecipeBuilder.newBuilder("mk1computer_make","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
        <liquid:redstone>*100000,
        <liquid:ic2coolant>*100000,
    ])
    .addInputs([
        <contenttweaker:sensor_v3>*16,
        <tconevo:metal:8>*32,
        <advancedrocketry:misc>*4,
        <contenttweaker:hypernet_ram_t4>*8,
    ])
    .addOutputs([
        <contenttweaker:comhostmk1>*1
    ])
    .requireComputationPoint(40000.0)
    .build();

RecipeBuilder.newBuilder("mk1computer2_make","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
        <liquid:redstone>*100000,
        <liquid:ic2coolant>*100000,
    ])
    .addInputs([
        <contenttweaker:comhostmk1>*4,
        <contenttweaker:hypernet_gpu_t3>*4,
        <contenttweaker:sensor_v4>*16,
        <contenttweaker:infinity_processor>*16,
        <appliedenergistics2:material:41>*1206,
        <contenttweaker:neutrondustingot>*134,
    ])
    .addOutputs([
        <contenttweaker:comhostmk2>
    ])
    .requireComputationPoint(40000.0)
    .build();

RecipeBuilder.newBuilder("mk1computer3_make","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
      <liquid:dimensionbeam>*100000,
      <liquid:tachyonfluid>*10000,
      <liquid:spaceframefluid>*10000,
    ])
    .addInputs([
        <contenttweaker:comhostmk2>*4,
        <contenttweaker:octingot>*18,
        <contenttweaker:neutronchip>*8,
        <contenttweaker:atomicclock>*4,
        <contenttweaker:recoilengine>,
        <contenttweaker:beccomputer>*3,
        <contenttweaker:becmemory>
    ])
    .addOutputs([
        <contenttweaker:comhostmk3>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .build();

RecipeBuilder.newBuilder("bec_computer_make","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
        <liquid:bec>*100000,
    ])
    .addInputs([
        <contenttweaker:neutronchip>*8,
        <contenttweaker:hypernet_gpu_t3>*1,
        <contenttweaker:sensor_v4>*16,
        <contenttweaker:field_generator_v3>*8,
        <contenttweaker:antimatter_core>*1
    ])
    .addOutputs([
        <contenttweaker:beccomputer>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .requireResearch("theory_bec")
    .build();

RecipeBuilder.newBuilder("bec_memory_make","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
        <liquid:bec>*100000,
    ])
    .addInputs([
        <novaeng_core:ecalculator_cell_16384m>*8,
        <contenttweaker:hypernet_ram_t5>*4,
        <avaritiaio:infinitecapacitor>*4,
        <contenttweaker:industrial_circuit_v4>*4,
    ])
    .addOutputs([
        <contenttweaker:becmemory>
    ])
    .requireComputationPoint(40000.0)  // 原400000.0 -> 40000.0
    .requireResearch("theory_bec")
    .build();

RecipeBuilder.newBuilder("energy_cube_1_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000
    ])
    .addInputs([
        <contenttweaker:charging_crystal_block>*64,
        <tconevo:metal:35>*926,
        <appliedenergistics2:material:43>*4
    ])
    .addOutputs([
        <contenttweaker:energycube_mk1>*4
    ])
    .requireComputationPoint(4000.0)
    .requireResearch("theory_energy")
    .build();

RecipeBuilder.newBuilder("energy_cube_2_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*20000
    ])
    .addInputs([
        <contenttweaker:geocentric_quartz_crystal_charged>*256,
        <additions:novaextended-extremecircuit>*4,
        <contenttweaker:energycube_mk1>*2,
    ])
    .addOutputs([
        <contenttweaker:energycube_mk2>*4
    ])
    .requireComputationPoint(8000.0)
    .requireResearch("theory_energy")
    .build();

RecipeBuilder.newBuilder("energy_cube_3_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000
    ])
    .addInputs([
        <contenttweaker:energycube_mk2>*2,
        <additions:novaextended-ark_circuit>*2,
        <contenttweaker:arkforcefieldcontrolblock>,
        <contenttweaker:neutronchip>*4,
    ])
    .addOutputs([
        <contenttweaker:energycube_mk3>*4
    ])
    .requireComputationPoint(12000.0)
    .requireResearch("theory_energy")
    .build();

RecipeBuilder.newBuilder("coldest_block_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:zerotempaturefluid>*1000,
        <liquid:cryotheum>*1000,
        <liquid:gelid_enderium>*1000,
    ])
    .addInputs([
        <contenttweaker:arkmachineblock>,
        <mekanism:atomicalloy>*256,
        <appliedenergistics2:material:47>*926,
        <additions:novaextended-ark_circuit>*2
    ])
    .addOutputs([
        <contenttweaker:atomcoolingblock>
    ])
    .requireComputationPoint(10000.0)
    .requireResearch("theory_bec")
    .build();

RecipeBuilder.newBuilder("mana_block_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
      <liquid:fluidedmana>*10000,
      <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <contenttweaker:arkmachineblock>,
        <botania:manaresource>*768,
        <botania:manaresource:1>*768,
        <botania:manaresource:2>*768,
        <extrabotany:material:1>*256,
        <appliedenergistics2:material:47>*926,
        <additions:novaextended-ark_circuit>*2
    ])
    .addOutputs([
        <contenttweaker:supermanablock>
    ])
    .requireComputationPoint(10000.0)
    .requireResearch("theory_bec")
    .build();

RecipeBuilder.newBuilder("uu_block_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
      <liquid:ic2uu_matter>*100000,
      <liquid:crystalloid>*10000,
    ])
    .addInputs([
        <contenttweaker:arkmachineblock>,
        <botania:manaresource>*968,
        <appliedenergistics2:material:47>*926,
        <additions:novaextended-ark_circuit>*2
    ])
    .addOutputs([
        <contenttweaker:superinstanceblock>
    ])
    .requireComputationPoint(10000.0)
    .requireResearch("theory_bec")
    .build();
RecipeBuilder.newBuilder("VATIC_controller_MAKE","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:higgsfluid>*100000,
        <liquid:crystalloid>*100000,
    ])
    .addInputs([
        <modularmachinery:coolingindustry_factory_controller>*2,
        <modularmachinery:zero_factor_converter_controller>*16,
        <contenttweaker:sensor_v4>*18,
        <contenttweaker:nanoswarm>*4,
        <contenttweaker:industrial_circuit_v4>*8,
        <contenttweaker:neutronchip>*8,
    ])
    .addOutputs([
        <modularmachinery:vaticlaser_factory_controller>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .requireResearch("theory_bec")
    .build();

RecipeBuilder.newBuilder("lightpressure_controller_MAKE","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addFluidInputs([
        <liquid:plasma>*1000000,
        <liquid:unsteady_plasma>*100000,
        <liquid:steady_ultra_dense_atomic_matter>*100000,
        <liquid:neutronium>*100000,
    ])
    .addInputs([
        <modularmachinery:dyson_ball_management_center_factory_controller>,
        <modularmachinery:orbital_framework_launch_site_factory_controller>,
        <modularmachinery:transition_orbit_emitter_factory_controller>,
        <contenttweaker:ljgz>*114514,
        <eternalsingularity:eternal_singularity>*16,
        <additions:novaextended-phocore_2>*128,
    ])
    .addOutputs([
        <modularmachinery:lightpressurelaunchunit_factory_controller>
    ])
    .requireComputationPoint(100000.0)  // 原1000000.0 -> 100000.0
    .requireResearch("theory_reap_spacetime")
    .build();

RecipeBuilder.newBuilder("recoilengine_MAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addFluidInputs([
        <liquid:bec>*100000,
        <liquid:unsteady_plasma>*100000,
        <liquid:steady_ultra_dense_atomic_matter>*100000,
        <liquid:neutronium>*100000,
    ])
    .addInputs([
        <contenttweaker:tearenginee>*16,
        <additions:novaextended-ark_circuit>*128,
        <contenttweaker:infinitychip>*8,
        <contenttweaker:hypernet_gpu_max>,
        <contenttweaker:hypernet_ram_max>,
    ])
    .addOutputs([
        <contenttweaker:recoilengine>
    ])
    .requireComputationPoint(40000.0)  // 原400000.0 -> 40000.0
    .requireResearch("theory_reap_spacetime_ii")
    .build();

RecipeBuilder.newBuilder("terminal_exchange_1","atomicprocessequipx",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <contenttweaker:zbk>,
        <minecraft:iron_ingot>,
    ])
    .addOutputs([
        <contenttweaker:scan_terminal_spacestation>
    ])
    .build();

RecipeBuilder.newBuilder("terminal_exchange_2","atomicprocessequipx",1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <contenttweaker:zbk>,
        <minecraft:gold_ingot>,
    ])
    .addOutputs([
        <contenttweaker:scan_terminal_elevator>
    ])
    .build();

RecipeBuilder.newBuilder("laseraccelerator_controllerMAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addFluidInputs([
        <liquid:ancient_debris>*10000,
        <liquid:phi_matter>*10000,
        <liquid:oslash_matter>*10000,
        <liquid:unsteady_plasma>*100000,
    ])
    .addInputs([
        <modularmachinery:mk2_factory_controller>*2,
        <contenttweaker:sensor_v3>*16,
        <contenttweaker:industrial_circuit_v3>*32,
        <contenttweaker:electric_motor_v3>*16,
        <contenttweaker:field_generator_v3>*8,
    ])
    .addOutputs([
        <modularmachinery:laseraccelerator_factory_controller>
    ])
    .requireComputationPoint(40000.0)
    .requireResearch("theory_energy")
    .build();

RecipeBuilder.newBuilder("irisx_00147_controllerMAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:pyrotheum>*1000000,
        <liquid:plasma>*1000000,
    ])
    .addInputs([
        <modularmachinery:molten_casting_factory_controller>*16,
        <modularmachinery:covalent_overloader_controller>*32,
        <modularmachinery:phaselense_controller>*16,
        <enderio:block_enhanced_alloy_smelter>*256,
        <contenttweaker:neutrondustingot>*512,
        <contenttweaker:sensor_v4>*16,
        <contenttweaker:electric_motor_v4>*16,
        <contenttweaker:field_generator_v3>*8,
        <mekanismmultiblockmachine:high_frequency_fusion_molding_module>*16,
        <contenttweaker:awakened_draconium_plasma_nozzle>*36,
        <contenttweaker:chaostic_draconium_resonant_tube>*8,
    ])
    .addOutputs([
        <modularmachinery:irisx_00147_factory_controller>,
        <modularmachinery:irisx_00147_mode1_factory_controller>,
        <modularmachinery:irisx_00147_mode2_factory_controller>
    ])
    .requireComputationPoint(20000.0)  // 原200000.0 -> 20000.0
    .requireResearch("theory_emeber")
    .build();

// 注意：这里有两个 irisx_00146_controllerMAKE 配方，处理第一个
RecipeBuilder.newBuilder("irisx_00146_controllerMAKE","atomicprocessequipx",2400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:fluidedmana>*10000,
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
      <modularmachinery:bot_crafter_factory_controller>*4,
      <botania:runealtar>*16,
      <extrabotany:manaliquefaction>*64,
      <contenttweaker:sensor_v3>*8,
      <contenttweaker:infinity_processor>*8,
      <extrabotany:material:1>*4
    ])
    .addOutputs([
        <modularmachinery:test_irisx_factory_controller>
    ])
    .requireComputationPoint(2000.0)  // 原20000.0 -> 2000.0
    .requireResearch("theory_emeber")
    .build();

RecipeBuilder.newBuilder("void_energy_controllerMAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:higgsfluid>*100000,
        <liquid:bec>*10000,
    ])
    .addInputs([
        <modularmachinery:ultra_zero_point_vacuum_displacer_core_controller>,
        <modularmachinery:ultra_zero_point_vacuum_displacer_casing_controller>,
        <modularmachinery:ultra_zero_point_vacuum_displacer_controller>,
        <contenttweaker:industrial_circuit_v4>*16,
        <contenttweaker:field_generator_v4>*16,
        <contenttweaker:crystalred>*168,
        <contenttweaker:crystalgreen>*168,
        <contenttweaker:crystalpurple>*168,
        <additions:novaextended-crystal4>*4,
        <contenttweaker:voidmatter>*168,
    ])
    .addOutputs([
        <modularmachinery:zeromatrix_factory_controller>
    ])
    .requireComputationPoint(40000.0)
    .requireResearch("theory_void_energy")
    .build();

RecipeBuilder.newBuilder("prometheus_controllerMAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:higgsfluid>*100000,
        <liquid:bec>*10000,
        <liquid:crystalloid>*100000
    ])
    .addInputs([
        <modularmachinery:eco-t7_controller>*4,
        <modularmachinery:neutron_particle_crystal_controller>*4,
        <modularmachinery:eco_y7_factory_controller>*4,
        <modularmachinery:eco_y6_controller>*4,
        <contenttweaker:mana_crystal_3>*128,
        <contenttweaker:uu_crystal_3>*128,
        <contenttweaker:charging_crystal_block>*512,
        <contenttweaker:tyf2>*64
    ])
    .addOutputs([
        <modularmachinery:prometheus_factory_controller>
    ])
    .requireComputationPoint(16000.0)  // 原160000.0 -> 16000.0
    .requireResearch("theory_recession_pl")
    .build();

RecipeBuilder.newBuilder("mass_abnormal_controllerMAKE","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:crystalloid>*100000,
        <liquid:dimensionbeam>*10000,
    ])
    .addInputs([
        <modularmachinery:space_generator_factory_controller>*4,
        <modularmachinery:mineral_dissolver_factory_controller>*16,
        <contenttweaker:sensor_v3>*128,
        <contenttweaker:electric_motor_v4>*128,
        <contenttweaker:robot_arm_v4>*128,
        <contenttweaker:industrial_circuit_v3>*64,
        <contenttweaker:hypernet_gpu_t3>*16,
        <contenttweaker:hypernet_ram_t4>*16,
    ])
    .addOutputs([
        <modularmachinery:massanomaldevice_factory_controller>
    ])
    .requireComputationPoint(480.0)  // 原4800.0 -> 480.0
    .requireResearch("theory_mass_abnormal")
    .build();

RecipeBuilder.newBuilder("milkway_computer_controllerMAKE","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:bec>*180000,
    ])
    .addInputs([
        <contenttweaker:infinity_processor>*16,
        <modularmachinery:data_processor_t4_factory_controller>*8,
        <contenttweaker:hypernet_ram_t5>*16,
        <contenttweaker:hypernet_gpu_t3>*16,
        <contenttweaker:industrial_circuit_v4>*8,
    ])
    .addOutputs([
        <modularmachinery:starcomputer_factory_controller>
    ])
    .requireComputationPoint(48000.0)  // 原480000.0 -> 48000.0
    .requireResearch("theory_mass_abnormal")
    .build();

RecipeBuilder.newBuilder("milkway_center_controllerMAKE","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:bec>*180000,
    ])
    .addInputs([
        <contenttweaker:infinity_processor>*16,
        <modularmachinery:computation_center_t3_factory_controller>*8,
        <contenttweaker:hypernet_ram_t5>*16,
        <contenttweaker:hypernet_gpu_t3>*16,
        <contenttweaker:industrial_circuit_v4>*8,
    ])
    .addOutputs([
        <modularmachinery:acdcenter_factory_controller>
    ])
    .requireComputationPoint(48000.0)  // 原480000.0 -> 48000.0
    .requireResearch("theory_computer_milkway")
    .build();

RecipeBuilder.newBuilder("observer_center_controllerMAKE","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:cryotheum>*180000,
    ])
    .addInputs([
        <additions:novaextended-novaextended_medal5>,
        <additions:novaextended-novaextended_medal>,
        <additions:novaextended-novaextended_medal1>,
        <additions:novaextended-novaextended_medal2>,
        <additions:novaextended-novaextended_medal4>,
        <contenttweaker:unknownplanet>*256,
        <modularmachinery:iridescentobservatory_controller>*4,
        <modularmachinery:bootes_ritual_controller>*4,
        <modularmachinery:mineralis_ritual_controller>*4,
        <contenttweaker:horologium_star_map>*4
    ])
    .addOutputs([
        <modularmachinery:planetobserver_factory_controller>
    ])
    .requireComputationPoint(4000.0)
    .requireResearch("planet_observe")
    .build();

RecipeBuilder.newBuilder("starvoid_controllerMAKE","atomicprocessequipx",1800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:higgsfluid>*180000,
    ])
    .addInputs([
        <contenttweaker:casmir_effect_seq>*8,
        <additions:novaextended-ark_circuit>*4,
        <contenttweaker:atomicclock>*4,
        <contenttweaker:asteroidcontrolblock>*32,
    ])
    .addOutputs([
        <contenttweaker:starvoidstructure>
    ])
    .requireComputationPoint(40000.0)
    .requireResearch("theory_void_energy")
    .build();

RecipeBuilder.newBuilder("matrix_core_makeI","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:bec>*180000,
    ])
    .addInputs([
        <contenttweaker:lockednormalplanet>*16,
        <contenttweaker:lockedhellplanet>*16,
        <contenttweaker:lockedenderplanet>*16,
        <contenttweaker:kjcl>*128,
        <contenttweaker:kjzj>*32
    ])
    .addOutputs([
        <contenttweaker:superspace_star_controlmatrix>
    ])
    .requireComputationPoint(40000.0)
    .requireResearch("theory_void_energy")
    .build();

RecipeBuilder.newBuilder("energy_glass_1","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass:9>
    ])
    .addOutputs([
        <contenttweaker:superglasscyan>
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("energy_glass_2","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*100000,
    ])
    .addInputs([
        <minecraft:stained_glass:11>
    ])
    .addOutputs([
        <contenttweaker:superglassbluex>
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("energy_glass_3","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
    ])
    .addInputs([
        <minecraft:stained_glass>
    ])
    .addOutputs([
        <contenttweaker:superglasswhite>
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("energy_glass_max","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000000)
    .addFluidInputs([
        <liquid:liquid_energy>*10000,
        <liquid:bec>*10000
    ])
    .addInputs([
        <contenttweaker:superglassbluex>*256,
        <contenttweaker:superglasscyan>*256,
        <contenttweaker:superglasswhite>*256,
        <contenttweaker:arkchip>
    ])
    .addOutputs([
        <contenttweaker:basicglass>*16
    ])
    .requireComputationPoint(80000.0)  // 原800000.0 -> 80000.0
    .build();

RecipeBuilder.newBuilder("milkway_structure_MAKE","atomicprocessequipx",2400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(400000000)
    .addFluidInputs([
        <liquid:bec>*10000
    ])
    .addInputs([
        <contenttweaker:octingot>*1,
        <additions:novaextended-ark_circuit>*4,
        <contenttweaker:beccomputer>,
        <contenttweaker:asteroidcontrolblock>*16,
        <contenttweaker:nanoglassmetal>*2,
    ])
    .addOutputs([
        <contenttweaker:milkmachineblock>
    ])
    .requireComputationPoint(16000.0)
    .requireResearch("theory_computer_milkway")
    .build();

RecipeBuilder.newBuilder("upgrade_1_MAKE","atomicprocessequipx",800)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addInputs([
        <avaritiaio:infinitecapacitor>*4,
        <additions:novaextended-extremecircuit>*8,
        <contenttweaker:additional_component_raw_ore>*4,
        <contenttweaker:additional_component_1>*4,
        <contenttweaker:additional_component_0>*16,
        <contenttweaker:additional_component_2>*8,
        <contenttweaker:additional_component_3>*2
    ])
    .addOutputs([
        <contenttweaker:thorupgrade1>
    ])
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("neutronismstructure_MAKE","atomicprocessequipx",400)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addInputs([
        <contenttweaker:starmachineblock>*128,
        <eternalsingularity:eternal_singularity>*16,
        <contenttweaker:infinity_processor>*4,
        <contenttweaker:exponential_level_processor>*16
    ])
    .addOutputs([
        <contenttweaker:neutronismblock>
    ])
    .requireComputationPoint(1000.0)
    .build();

RecipeBuilder.newBuilder("cmp_1_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <thermalfoundation:material:134>*9,
        <extendedcrafting:material:2>*5,
        <extendedcrafting:material:15>*4
    ])
    .addOutputs([
        <extendedcrafting:material:16>*6
    ])
    .build();

RecipeBuilder.newBuilder("cmp_2_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <enderio:item_alloy_ingot:2>*13,
        <enderio:item_alloy_ingot:6>*7,
        <extendedcrafting:material:2>*5,
        <extendedcrafting:material:16>*4
    ])
    .addOutputs([
        <extendedcrafting:material:17>*4
    ])
    .build();

RecipeBuilder.newBuilder("dustupgrade_make","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000)
    .addFluidInputs([
        <liquid:aurorium_fluid>*100000
    ])
    .addInputs([
        <contenttweaker:thorupgrade1>*4,
        <contenttweaker:dustmatrix>,
        <contenttweaker:neutrondustingot>*128,
        <contenttweaker:dust>*768,
        <contenttweaker:neutronchip>,
        <contenttweaker:planetoflight>,
    ])
    .addOutputs([
        <contenttweaker:dustupgrade>
    ])
    .build();

RecipeBuilder.newBuilder("reinforced_block_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000)
    .addInputs([
        <ic2:resource:13>,
        <additions:novaextended-ingot8>*4,
        <mekanism:ingot>*4,
        <extendedcrafting:material:2>*4,
        <modularmachinery:blockcasing>*8
    ])
    .addOutputs([
        <modularmachinery:blockcasing:4>*8
    ])
    .build();

RecipeBuilder.newBuilder("bcs_make","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(4000000)
    .addInputs([
        <modularmachinery:different_world_factory_controller>*16,
        <contenttweaker:sensor_v3>*16,
        <contenttweaker:industrial_circuit_v3>*16,
        <contenttweaker:electric_motor_v4>*8,
        <contenttweaker:robot_arm_v4>*8,
        <contenttweaker:hypernet_gpu_t3>*2,
        <contenttweaker:additional_component_3>
    ])
    .addOutputs([
        <modularmachinery:asteroidbcs_factory_controller>
    ])
    .build();

RecipeBuilder.newBuilder("cmp_3_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <extendedcrafting:material:17>*7,
        <extendedcrafting:material:2>*9,
        <extendedcrafting:material:24>*13,
    ])
    .addOutputs([
        <extendedcrafting:material:18>*4
    ])
    .build();

RecipeBuilder.newBuilder("cmp_4_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <extendedcrafting:material:18>*16,
        <extendedcrafting:material:2>*9,
        <extendedcrafting:material:32>*15
    ])
    .addOutputs([
        <extendedcrafting:material:19>*16
    ])
    .build();

RecipeBuilder.newBuilder("cmp_5_atomic","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addInputs([
        <extendedcrafting:material:19>*12,
        <contenttweaker:universalalloyt1>*8,
        <mets:neutron_plate>*4,
        <avaritia:resource:4>*4,
        <contenttweaker:universalalloyt2>,
        <additions:novaextended-fallen_star_alloy>*2,
        <additions:novaextended-terraalloy>*2
    ])
    .addOutputs([
        <extendedcrafting:material:13>*16
    ])
    .build();

RecipeBuilder.newBuilder("licsac_make","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addInputs([
        <modularmachinery:assembly_line_factory_controller>*8,
        <modularmachinery:acar_factory_controller>*8,
        <avaritiaio:infinitecapacitor>*1,
        <contenttweaker:industrial_circuit_v3>*16,
        <contenttweaker:sensor_v3>*16,
        <contenttweaker:electric_motor_v4>*8,
        <contenttweaker:hypernet_cpu_t3>*4,
        <contenttweaker:hypernet_cpu_t4>*4,
        <contenttweaker:hypernet_gpu_t2>*4,
        <contenttweaker:hypernet_gpu_t3>*4,
        <contenttweaker:hypernet_ram_t3>*4,
        <contenttweaker:hypernet_ram_t4>*4,
    ])
    .addOutputs([
        <modularmachinery:licsac_factory_controller>
    ])
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("universal_matter","atomicprocessequipx",1200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(40000000)
    .addInputs([
        <ic2:crafting:24>*4096,
        <avaritia:resource:5>*4,
        <contenttweaker:uu_crystal_3>*4,
    ])
    .addOutput(<mekanism:cosmicmatter>)
    .addRecipeTooltip("POWERRRRRRR")
    .requireComputationPoint(10000.0)
    .build();

RecipeBuilder.newBuilder("warmatrix","atomicprocessequipx",3600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
      event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val is_upgrade = data.getInt("is_upgrade",0);
      if(is_upgrade == 1){
        val thread = event.factoryRecipeThread;
        thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
      }
    })
    .addEnergyPerTickInput(5000000000)
    .addInputs([
        <modularmachinery:biogenic_simulation_computer_factory_controller>*4,
        <deepmoblearning:simulation_chamber>*32,
        <deepmoblearning:extraction_chamber>*32,
        <deepmoblearning:glitch_heart>*256,
        <threng:material:6>*128,
        <threng:material:14>*128,
    ])
    .requireResearch("theory_warmatrix")
    .addOutput(<modularmachinery:warmatrix_factory_controller>)
    .build();

// arblock_MAKE 配方已经按照要求添加了 FactoryStartHandler
RecipeBuilder.newBuilder("arblock_MAKE","atomicprocessequipx",200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(8000000000)
    .addInputs([
        <contenttweaker:milkmachineblock> * 16,
        <contenttweaker:darkmatterblock> * 2,
        <contenttweaker:field_generator_v4> * 4,
        <contenttweaker:gama_tialcoil> * 256,
        <moreplates:infinity_gear> * 64,
        <contenttweaker:spacexmachineblock> * 4,
        <contenttweaker:arcance_ingot> * 2
    ])
    .addOutput(<contenttweaker:arcancemachineblock>*64)
    .requireComputationPoint(80000.0)  // 原800000.0 -> 80000.0
    .requireResearch("Giga-ShroudAssemblyFactory")
    .build();

// atmoicprocess_upgrade 配方保持不变，因为它有自己的 FactoryFinishHandler
RecipeBuilder.newBuilder("atmoicprocess_upgrade","atomicprocessequipx",200)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            event.setFailed("已装载升级组件");
        }
    })
    .addEnergyPerTickInput(800000000)
    .addInputs([
        <contenttweaker:spacetime_lens>*16,
        <contenttweaker:atomicclock>*32,
        <contenttweaker:superspace_star_controlmatrix>*4
    ])
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        map["is_upgrade"]=1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("§9为设备装载时空升级,将减少所有配方99%的运行时间")
    .build();

RecipeBuilder.newBuilder("dragon_injector_1","atomicprocessequipx",40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(6400)
    .addInputs([
      <draconicevolution:crafting_injector>,
      <draconicevolution:draconium_block>,
      <draconicevolution:wyvern_core>,
      <minecraft:diamond>*4,
      <draconicevolution:draconic_core>*2
    ])
    .addOutput(<draconicevolution:crafting_injector:1>)
    .requireComputationPoint(400.0)
    .build();

RecipeBuilder.newBuilder("dragon_injector_2","atomicprocessequipx",40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(44800)
    .addInputs([
      <draconicevolution:crafting_injector:1>,
      <draconicevolution:wyvern_core>*2,
      <draconicevolution:draconic_block>,
      <minecraft:diamond>*4
    ])
    .addOutput(<draconicevolution:crafting_injector:2>)
    .requireComputationPoint(500.0)
    .build();

RecipeBuilder.newBuilder("dragon_injector_3","atomicprocessequipx",40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(1200000)
    .addInputs([
      <draconicevolution:crafting_injector:2>,
      <minecraft:diamond>*4,
      <draconicevolution:chaotic_core>,
      <minecraft:dragon_egg>
    ])
    .addOutput(<draconicevolution:crafting_injector:3>)
    .requireComputationPoint(600.0)
    .build();

RecipeBuilder.newBuilder("anti_matter_atomic","atomicprocessequipx",40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(1200000)
    .addInputs([
      <contenttweaker:nuclear_well>,
      <liquid:anti_electron>*1000,
      <liquid:anti_protron>*1000,
      <liquid:anti_neutron>*1000
    ])
    .addOutput(<mekanism:antimatterpellet>)
    .build();

RecipeBuilder.newBuilder("nuclear_well_atomic","atomicprocessequipx",40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(1200000)
    .addInputs([
      <contenttweaker:energized_fuel_container_v2>*3,
      <additions:novaextended-psi_alloy>*2,
      <appliedenergistics2:material:47>
    ])
    .addOutput(<contenttweaker:nuclear_well>)
    .build();


RecipeBuilder.newBuilder("break_space_atomic","atomicprocessequipx",600)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(120000000)
    .addInputs([
      <contenttweaker:arkchip>,
      <mekanism:antimatterpellet>*16,
      <contenttweaker:voidmatter>*32,
      <contenttweaker:mripcb>*128,
      <liquid:tachyonfluid>*1000,
      <liquid:spaceframefluid>*1000,
    ])
    .addOutput(<contenttweaker:etherengine_upgrade>*8)
    .build();

RecipeBuilder.newBuilder("yihejinwaike_atomicprocess","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
      <thermalfoundation:material:135>*8,
      <contenttweaker:starmachineblock>
    ])
    .addOutput(<contenttweaker:iridium_alloy_mechanical_housing>)
    .build();

RecipeBuilder.newBuilder("wuxiashuijing_atomicprocessequipx","atomicprocessequipx",20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val is_upgrade = data.getInt("is_upgrade",0);
        if(is_upgrade == 1){
            val thread = event.factoryRecipeThread;
            thread.addPermanentModifier("decrease_II",RecipeModifierBuilder.create("modularmachinery:duration","input",0.01,1,false).build());
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
      <avaritia:resource:4>*16,
      <avaritia:resource:1>*12,
      <avaritia:resource:5>*5
    ])
    .addOutput(<avaritiatweaks:enhancement_crystal>)
    .build();
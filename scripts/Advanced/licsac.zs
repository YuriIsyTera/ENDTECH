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
HyperNetHelper.proxyMachineForHyperNet("licsac");
MachineModifier.setMaxThreads("licsac",20);
RecipeBuilder.newBuilder("gpu_t2_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism = 128;
  })
  .addEnergyPerTickInput(3200000)
  .addInputs([
    <contenttweaker:lifesense_processor>,
    <contenttweaker:hypernet_cpu_t3>,
    <contenttweaker:hypernet_ram_t3>,
    <mets:advanced_oc_heat_vent>,
    <mets:advanced_heat_vent>,
  ])
  .addOutput(<contenttweaker:hypernet_gpu_t2>)
  .requireComputationPoint(100.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有128并行")
  .build();

RecipeBuilder.newBuilder("gpu_t3_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
       event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism = 64;
  })
  .addEnergyPerTickInput(5120000)
  .addInputs([
    <contenttweaker:infinity_processor>,
    <appliedenergistics2:material:47>,
    <contenttweaker:sensor_v4>
  ])
  .addOutput(<contenttweaker:hypernet_gpu_t3>)
    .addRecipeTooltip("快速制造算力元件")
    .requireComputationPoint(2000.0)
  .addRecipeTooltip("该配方最高有64并行")
  .build();

RecipeBuilder.newBuilder("gpu_t4_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 32;
    event.activeRecipe.maxParallelism = 32;
  })
  .addEnergyPerTickInput(500000000)
     .addFluidInput(<liquid:crystalloid>*100000000)
  .addFluidInput(<liquid:infinity_metal>*14400)
  .addInputs([
    <contenttweaker:hypernet_gpu_t3>*192,
    <contenttweaker:industrial_circuit_v4>*64,
    <contenttweaker:antimatter_core>*64,
    <avaritiaio:infinitecapacitor>*16
  ])
  .addOutput(<contenttweaker:hypernet_gpu_max>)
  .addRecipeTooltip("快速制造最顶级的算力元件")
  .addRecipeTooltip("该配方最高有32并行")
  .build();

RecipeBuilder.newBuilder("cpu_t3_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism = 64;
  })
  .addEnergyPerTickInput(16000000)
  .addGasInput(<gas:nutrientsolution>*20000)
  .addInputs([
    <contenttweaker:lifesense_processor>,
    <draconicevolution:mob_soul>,
    <enderio:item_material:42>,
    <ic2:advanced_heat_vent>
  ])
  .addInput(<deepmoblearning:data_model_zombie>).setChance(0)
  .addOutput(<contenttweaker:hypernet_cpu_t3>)
  .requireComputationPoint(50.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有64并行")
  .build();

  RecipeBuilder.newBuilder("cpu_t4_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 32;
    event.activeRecipe.maxParallelism = 32;
  })
  .addEnergyPerTickInput(128000000)
  .addFluidInput(<liquid:solarium_fluid>*432)
  .addInputs([
    <contenttweaker:exponential_level_processor>,
    <astralsorcery:itemusabledust>,
    <contenttweaker:sensor_v3>,
    <mets:advanced_heat_vent>
  ])
  .addOutput(<contenttweaker:hypernet_cpu_t4>)
  .requireComputationPoint(750.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有32并行")
  .build();

  RecipeBuilder.newBuilder("ram_t3_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism = 128;
  })
  .addEnergyPerTickInput(160000000)
  .addFluidInput(<liquid:gold>*4320)
  .addInputs([
    <contenttweaker:exponential_level_processor>,
    <appliedenergistics2:material:22>,
    <ic2:advanced_heat_vent>
  ])
  .addOutput(<contenttweaker:hypernet_ram_t3>)
  .requireComputationPoint(50.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有128并行")
  .build();

  RecipeBuilder.newBuilder("ram_t4_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 64;
    event.activeRecipe.maxParallelism = 64;
  })
  .addEnergyPerTickInput(1280000000)
  .addFluidInput(<liquid:gold>*8640)
  .addInputs([
    <contenttweaker:exponential_level_processor>,
    <appliedenergistics2:material:22>,
    <mets:advanced_heat_vent>
  ])
  .addOutput(<contenttweaker:hypernet_ram_t4>)
  .requireComputationPoint(750.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有64并行")
  .build();

  
  RecipeBuilder.newBuilder("ram_t5_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
       event.activeRecipe.parallelism = 32;
    event.activeRecipe.maxParallelism = 32;
  })
  .addEnergyPerTickInput(5120000000)
  .addFluidInput(<liquid:gold>*34560)
  .addInputs([
    <contenttweaker:infinity_processor>,
    <appliedenergistics2:material:22>,
    <mets:advanced_heat_vent>
  ])
  .addOutput(<contenttweaker:hypernet_ram_t5>)
  .requireComputationPoint(1500.0)
  .addRecipeTooltip("快速制造算力元件")
  .addRecipeTooltip("该配方最高有32并行")
  .build();

    
  RecipeBuilder.newBuilder("ram_max_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 16;
    event.activeRecipe.maxParallelism = 16;
  })
  .addEnergyPerTickInput(5000000000000)
  .addFluidInput(<liquid:crystalloid>*100000000)
  .addFluidInput(<liquid:infinity_metal>*14400)
  .addInputs([
    <contenttweaker:hypernet_ram_t5>*80,
    <contenttweaker:industrial_circuit_v4>*64,
    <contenttweaker:antimatter_core>*64,
    <avaritiaio:infinitecapacitor>*16,
  ])
  .addOutput(<contenttweaker:hypernet_ram_max>)
  .requireComputationPoint(1500.0)
  .addRecipeTooltip("快速制造最高级的算力元件")
  .addRecipeTooltip("该配方最高有16并行")
  .build();

  RecipeBuilder.newBuilder("bec_com_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
       event.activeRecipe.parallelism = 4;
    event.activeRecipe.maxParallelism = 4;
  })
  .addEnergyPerTickInput(40000000000)
  .addFluidInput(<liquid:bec>*100000)
  .addInputs([
    <contenttweaker:neutronchip>*8,
    <contenttweaker:hypernet_gpu_t3>,
    <contenttweaker:sensor_v4>*16,
    <contenttweaker:field_generator_v3>*8,
    <contenttweaker:antimatter_core>
  ])
  .addOutput(<contenttweaker:beccomputer>)
  .requireComputationPoint(100000.0)
  .addRecipeTooltip("快速制造BEC算力元件")
  .addRecipeTooltip("该配方最高有4并行")
  .build();

  RecipeBuilder.newBuilder("bec_ram_licsac","licsac",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4;
    event.activeRecipe.maxParallelism = 4;
  })
  .addEnergyPerTickInput(40000000000)
  .addFluidInput(<liquid:bec>*100000)
  .addInputs([
    <novaeng_core:ecalculator_cell_16384m>*8,
    <contenttweaker:hypernet_ram_t5>*4,
    <avaritiaio:infinitecapacitor>*4,
    <contenttweaker:industrial_circuit_v4>*4
  ])
  .addOutput(<contenttweaker:becmemory>)
  .requireComputationPoint(400000.0)
  .addRecipeTooltip("快速制造BEC算力元件")
  .addRecipeTooltip("该配方最高有4并行")
  .build();

  RecipeBuilder.newBuilder("rapid_sys","licsac",40,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 512;
    event.activeRecipe.maxParallelism = 512;
  })
  .addEnergyPerTickInput(10000)
  .addInputs([
    <contenttweaker:mripcb>*1,
    <enderio:item_material:41>*4
  ])
  .addOutputs([
    <contenttweaker:synthesischip>*16,
  ])
  .addRecipeTooltip("利用磁共振电路快速蚀刻集成系统芯片")
  .addRecipeTooltip("该配方最高有512并行")
  .requireComputationPoint(100.0)
  .build();


  RecipeBuilder.newBuilder("rapid_crystal","licsac",40,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 256;
    event.activeRecipe.maxParallelism = 256;
  })
  .addEnergyPerTickInput(100000)
  .addInputs([
    <contenttweaker:mripcb>*4,
    <avaritia:resource:1>*8,
    <contenttweaker:industrial_circuit_v2>*2
  ])
  .addOutputs([
    <contenttweaker:crystalchip>*16,
  ])
  .addRecipeTooltip("利用磁共振电路快速蚀刻集成系统芯片")
  .addRecipeTooltip("该配方最高有256并行")
  .requireComputationPoint(400.0)
  .build();

  RecipeBuilder.newBuilder("rapid_universal","licsac",40,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
       event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism = 128;
  })
  .addEnergyPerTickInput(100000)
  .addInputs([
    <contenttweaker:mripcb>*8,
    <contenttweaker:sensor_v3>*4,
    <mets:nano_living_metal>*4
  ])
  .addOutputs([
    <contenttweaker:universalalloychip>*16,
  ])
  .addRecipeTooltip("利用磁共振电路快速蚀刻集成系统芯片")
  .addRecipeTooltip("该配方最高有128并行")
  .requireComputationPoint(800.0)
  .build();

    RecipeBuilder.newBuilder("rapid_neutron","licsac",40,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 128;
    event.activeRecipe.maxParallelism = 128;
  })
  .addEnergyPerTickInput(1000000)
  .addFluidInputs([<liquid:neutronium>*1888])
  .addInputs([
    <contenttweaker:mripcb>*16,
    <avaritia:resource:4>*8,
    <contenttweaker:forcecontainer>,
  ])
  .addOutputs([
    <contenttweaker:neutronchip>*16,
  ])
  .addRecipeTooltip("利用磁共振电路快速蚀刻集成系统芯片")
  .addRecipeTooltip("该配方最高有128并行")
  .requireComputationPoint(1000.0)
  .build();

      RecipeBuilder.newBuilder("rapid_ae_1_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <appliedenergistics2:material:20>,
    <minecraft:redstone>,
    <appliedenergistics2:material:10>
  ])
  .addOutputs([
    <appliedenergistics2:material:23>
  ])
  .addRecipeTooltip("快速压印处理器")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_ae_2_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <minecraft:redstone>,
    <minecraft:gold_ingot>,
    <appliedenergistics2:material:20>
  ])
  .addOutputs([
    <appliedenergistics2:material:22>
  ])
  .addRecipeTooltip("快速压印处理器")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

          RecipeBuilder.newBuilder("rapid_ae_3_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <appliedenergistics2:material:20>,
    <minecraft:redstone>,
    <minecraft:diamond>
  ])
  .addOutputs([
    <appliedenergistics2:material:24>
  ])
  .addRecipeTooltip("快速压印处理器")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_base_1_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <appliedenergistics2:quartz_block>
  ])
  .addOutputs([
    <appliedenergistics2:material:16>*64
  ])
  .addRecipeTooltip("采用高级蚀刻压印工艺")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_base_2_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <minecraft:coal_block>
  ])
  .addOutputs([
    <appliedenergistics2:material:20>*64
  ])
  .addRecipeTooltip("一个神奇配方")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_base_3_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <minecraft:diamond_block>
  ])
  .addOutputs([
    <appliedenergistics2:material:17>*64
  ])
  .addRecipeTooltip("采用高级蚀刻压印工艺")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_base_4_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <minecraft:gold_block>
  ])
  .addOutputs([
    <appliedenergistics2:material:18>*64
  ])
  .addRecipeTooltip("采用高级蚀刻压印工艺")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

        RecipeBuilder.newBuilder("rapid_base_5_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <threng:material:13>,
    <minecraft:redstone>,
    <appliedenergistics2:material:20>
  ])
  .addOutputs([
    <threng:material:14>
  ])
   .addRecipeTooltip("快速压印处理器")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

          RecipeBuilder.newBuilder("rapid_base_6_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <threng:material:5>,
    <minecraft:redstone>,
    <appliedenergistics2:material:20>
  ])
  .addOutputs([
    <threng:material:6>
  ])
   .addRecipeTooltip("快速压印处理器")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();


          RecipeBuilder.newBuilder("planet_dianrong_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <contenttweaker:crystalchip>,
    <enderio:item_alloy_endergy_ingot:3>*512,
    <enderio:item_basic_capacitor>*512
  ])
  .addOutputs([
    <enderio:item_capacitor_stellar>*512
  ])
   .addRecipeTooltip("快速制造恒星电容")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();

            RecipeBuilder.newBuilder("wujin_dianrong_licsac","licsac",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.parallelism = 4096;
    event.activeRecipe.maxParallelism = 4096;
  })
  .addEnergyPerTickInput(1000)
  .addInputs([
    <contenttweaker:infinitychip>,
    <avaritia:resource:5>*16,
    <avaritia:block_resource:2>*64,
    <avaritia:block_resource>*64,
  ])
  .addOutputs([
    <avaritiaio:infinitecapacitor>*16
  ])
   .addRecipeTooltip("快速制造无尽电容")
  .addRecipeTooltip("该配方最高有4096并行")
  .requireComputationPoint(0.1f)
  .build();
#priority 50
#loader crafttweaker reloadable

import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.IngredientArrayBuilder;
import novaeng.hypernet.HyperNetHelper;
MachineModifier.setMaxThreads("starcontrolx",0);
RecipeBuilder.newBuilder("starcontrolx_controller_MAKE","atomicprocessequipx",3600)
  .addEnergyPerTickInput(40000000)
  .addFluidInputs([
    <liquid:pyrotheum>*10000000,
    <liquid:plasma>*10000000,
  ])
  .addInputs([
   <modularmachinery:high_temp_melting_factory_controller>*32,
   <thermalexpansion:augment:304>*1280,
   <modularmachinery:blockparallelcontroller:3>*4,
   <contenttweaker:fixed_star_alloys_coil>*456,
   <contenttweaker:sensor_v3>*64,
   <contenttweaker:electric_motor_v4>*64,
   <contenttweaker:field_generator_v2>*32,
   <contenttweaker:industrial_circuit_v3>*46
  ])
  .addOutputs([
   <modularmachinery:starcontrolx_factory_controller>
  ])
  .requireComputationPoint(40000.0)
  .requireResearch("theory_hellplanet")
  .build();
for i in 1 to 8{
        MachineModifier.addCoreThread("starcontrolx", FactoryRecipeThread.createCoreThread("熔化区" + i));
} 
RecipeAdapterBuilder.create("starcontrolx", "nuclearcraft:melter")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.012, 1, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
            event.activeRecipe.maxParallelism = 65536;
    })
    .build();

RecipeBuilder.newBuilder("t1000","starcontrolx",40,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism = 65536;
    event.activeRecipe.maxParallelism = 65536;
  })
.addEnergyPerTickInput(160000)
 .addFluidInputs([
   <liquid:solarium_fluid>*1000,
   <liquid:iox_fluid>*1000,
   <liquid:proxii_fluid>*1000,
   <liquid:tritonite_fluid>*1000,
   <liquid:dyonite_fluid>*1000,
   <liquid:adamant_fluid>*1000,
   <liquid:nihilite_fluid>*1000,
   <liquid:starmetal>*1000,
 ])
 .addInputs([
    <contenttweaker:exponential_level_processor>*16
 ])
 .addFluidOutputs([
    <liquid:t1000>*2000
 ])
 .addRecipeTooltip("制造一种神奇的智慧液态金属")
 .addRecipeTooltip("该配方最高拥有65536的并行")
 .build();
 RecipeBuilder.newBuilder("star_fusing","starcontrolx",5,1)
 .addEnergyPerTickInput(40)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.parallelism = 65536;
    event.activeRecipe.maxParallelism = 65536;
  })
  .addInputs(<astralsorcery:itemcraftingcomponent:2>)
  .addFluidOutput(<liquid:starmetal>*192)
  .build();
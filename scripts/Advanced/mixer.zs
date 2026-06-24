import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.MMEvents;
import novaeng.hypernet.HyperNetHelper;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.RecipeFinishEvent;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.DataProcessorType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;
MachineModifier.setMaxThreads("huge_mixer",32);
RecipeBuilder.newBuilder("huge_mixer_controller","machine_arm",1200)
 .addEnergyPerTickInput(100000)
 .addInputs([
   <contenttweaker:robot_arm_v2>*8,
   <contenttweaker:sensor_v1>*8,
   <contenttweaker:industrial_circuit_v1>*16,
   <nuclearcraft:crystallizer>*32,
   <mets:super_iridium_rotor>*16
 ])
 .addOutput(<modularmachinery:huge_mixer_factory_controller>)
 .build();
RecipeBuilder.newBuilder("nutritionalpaste_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInputs([
    <liquid:water>*25600,
    <liquid:oxygen>*5000,
    <minecraft:sugar>*16,
    <mekanism:biofuel>*4
 ])
.addGasOutput(<gas:nutrientsolution>*25600)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();

RecipeBuilder.newBuilder("IC2coolant_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInputs([
    <liquid:water>*25526,
    <enderio:item_material:32>*8
 ])
.addOutput(<liquid:ic2coolant>*25526)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();


RecipeBuilder.newBuilder("hnox_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInputs([
    <liquid:lava>*25526,
    <taiga:osram_ingot>*8
 ])
.addOutput(<liquid:nitronite_fluid>*25526)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();
RecipeBuilder.newBuilder("sul2_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInputs([
   <thermalfoundation:material:771> * 4,
   <liquid:oxygen> * 4800,
   <liquid:water> * 3200,
 ])
.addOutput(<liquid:sulfuric_acid>*8000)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();

RecipeBuilder.newBuilder("c2h4_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInputs([
   <mekanism:biofuel> * 4,
   <liquid:hydrogen> * 25600,
   <liquid:water> * 25600,
 ])
.addOutput(<gas:ethene>*12800)
.addOutput(<liquid:liquidethene>*12800)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();

RecipeBuilder.newBuilder("plastic_output","huge_mixer",40,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    event.activeRecipe.maxParallelism = 4096;
    event.activeRecipe.parallelism = 4096;
 })
 .addEnergyPerTickInput(10000)
 .addInput(<mekanism:substrate>).setChance(0)
 .addInputs([
   <liquid:water> * 2560,
   <liquid:oxygen> * 2560,
   <liquid:liquidethene>*12800,
   <gas:ethene>*12800
 ])
 .addOutput(<mekanism:hdpe_pellet>*1024)
.addRecipeTooltip("该配方最高拥有4096并行")
.build();
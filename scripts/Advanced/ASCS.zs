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
MMEvents.onStructureFormed("advanced_field_facility" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var crystal = ctrl.getBlocksInPattern(<contenttweaker:crystalmatrixforcefieldcontrolblock>);
    var neutron = ctrl.getBlocksInPattern(<contenttweaker:neutronforcefieldcontrolblock>);
    var fallen = ctrl.getBlocksInPattern(<contenttweaker:fallenstarforcefieldcontrolblock>);
    var universal = ctrl.getBlocksInPattern(<contenttweaker:universalforcefieldcontrolblock>);
    var ark = ctrl.getBlocksInPattern(<contenttweaker:arkforcefieldcontrolblock>);
    var dust = ctrl.getBlocksInPattern(<contenttweaker:dustmatrix>);
    if(crystal == 24){
      map["para"]=32768;
      ctrl.customData = data;
    }
    if(neutron == 24){
      map["para"]=65536;
      ctrl.customData = data;
    }
    if(fallen == 24){
      map["para"]=131072;
      ctrl.customData = data;
    }
    if(universal == 24){
      map["para"]=262144;
      map["time"]=1;
      ctrl.customData = data;
    }
    if(ark == 24){
      map["para"]=524288;
      map["time"]=1;
      ctrl.customData = data;
    }
    if(dust == 24){
      map["para"]=1048576;
      map["time"]=1;
      ctrl.customData = data;
    }
    ctrl.customData = data;
});
MachineModifier.setMaxThreads("advanced_field_facility",0);
RecipeBuilder.newBuilder("ascs","workshop",1800)
 .addEnergyPerTickInput(1000000)
 .addInputs([
   <modularmachinery:numerical_control_machine_controller>*16,
   <contenttweaker:field_generator_v2>*16,
   <contenttweaker:industrial_circuit_v3>*8,
   <contenttweaker:carbon_nanotube>*128,
   <contenttweaker:synthesischip>*36,
   <extendedcrafting:compressor>*8
 ])
 .addOutput(<modularmachinery:advanced_field_facility_factory_controller>)
 .build();
for i in 1 to 11{
    MachineModifier.addCoreThread("advanced_field_facility",FactoryRecipeThread.createCoreThread("场构单元"+i));
}
RecipeAdapterBuilder.create("advanced_field_facility", "nuclearcraft:pressurizer")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01f, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 10,    1, false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism=16384;
        event.activeRecipe.parallelism=16384;
    })
    .build();
RecipeBuilder.newBuilder("alloy_1_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ic2:ingot>
 ])
 .addOutput(<ic2:crafting:3>)
 .build();

RecipeBuilder.newBuilder("carbonxxx_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
    <liquid:steady_ultra_dense_atomic_matter>*500,
    <minecraft:coal_block>*2,
    <avaritia:resource:2>*9,
    <contenttweaker:degenerationmatter>*16
 ])
 .addOutput(<contenttweaker:cfcm>)
 .build();

RecipeBuilder.newBuilder("tie_pian_gck","advanced_field_facility",200,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <minecraft:iron_block>*56250
 ])
 .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "libvulpes:productsheet", Damage: 1 as short, Req: 0 as long}, t: "i"}))
 .addRecipeTooltip("起飞")
 .build();

RecipeBuilder.newBuilder("carbon_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
    <liquid:coal>*1000
 ])
 .addOutput(<contenttweaker:carbon_nanotube>)
 .build();

RecipeBuilder.newBuilder("nitaihejinban_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
    <mets:niobium_titanium_ingot>
 ])
 .addOutput(<mets:niobium_titanium_plate>)
 .build();

RecipeBuilder.newBuilder("namihuotijinshuban_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
    <mets:nano_living_metal>
 ])
 .addOutput(<mets:neutron_plate>)
 .build();

RecipeBuilder.newBuilder("qianghuayiban_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
    <ic2:crafting:3>*4,
    <ic2:misc_resource:1>*4
 ])
 .addOutput(<ic2:crafting:4>)
 .build();

RecipeBuilder.newBuilder("chaojiyihejinding_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ic2:crafting:4>*9,
   <mets:niobium_titanium_plate>*18
 ])
 .addOutput(<mets:super_iridium_compress_plate>)
 .build();

RecipeBuilder.newBuilder("qingjinshiban_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <actuallyadditions:item_crystal_empowered:1>
 ])
 .addOutput(<moreplates:empowered_palis_plate>)
 .build();

RecipeBuilder.newBuilder("qianghuayingshi_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <liquid:osmium>*72,
   <minecraft:glowstone_dust>
 ])
 .addOutput(<mekanism:ingot:3>)
 .build();

RecipeBuilder.newBuilder("uumatter_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <liquid:ic2uu_matter>*1000
 ])
 .addOutput(<ic2:misc_resource:3>)
 .build();

RecipeBuilder.newBuilder("arkcoil_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <additions:novaextended-star_ingot>
 ])
 .addOutput(<contenttweaker:coil_v5>*3)
 .build();

RecipeBuilder.newBuilder("copperplate_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ore:blockCopper>
 ])
 .addOutput(<ic2:casing:1>*18)
 .build();

RecipeBuilder.newBuilder("tinplate_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ore:blockTin>
 ])
 .addOutput(<ic2:casing:6>*18)
 .build();

RecipeBuilder.newBuilder("bronzeplate_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ore:blockBronze>
 ])
 .addOutput(<ic2:casing>*18)
 .build();

RecipeBuilder.newBuilder("ironplate_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ore:blockIron>
 ])
 .addOutput(<ic2:casing:3>*18)
 .build();

RecipeBuilder.newBuilder("energycrystal_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <ic2:dust:6>*9
 ])
 .addOutput(<ic2:energy_crystal>.withTag({}) )
 .build();

RecipeBuilder.newBuilder("titaniumframework_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <mets:titanium_block>
 ])
 .addOutput(<mets:titanium_casing>*18)
 .build();

RecipeBuilder.newBuilder("neutron_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <liquid:neutron>*1000
 ])
 .addOutput(<super_solar_panels:crafting:28>)
 .build();

RecipeBuilder.newBuilder("proton_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <liquid:xprotonfluid>*1000
 ])
 .addOutput(<super_solar_panels:crafting:27>)
 .build();

RecipeBuilder.newBuilder("reinforcedobsidian_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <minecraft:obsidian>*18,
   <minecraft:diamond_block>*2,
   <mekanism:basicblock>
 ])
 .addOutput(<mekanism:ingot>*18)
 .build();

RecipeBuilder.newBuilder("chongnenglvbaoshi_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val time = data.getInt("time",0);
   if(time == 1){
      val xthread = event.factoryRecipeThread;
      xthread.addModifier("time_decrease",RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01f, 1, false).build());
   }
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <actuallyadditions:item_crystal_empowered:4>
 ])
 .addOutput(<moreplates:empowered_emeradic_plate>)
 .build();

 RecipeBuilder.newBuilder("tciplate_ascs","advanced_field_facility",5,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   var para = data.getInt("para",16384);
   event.activeRecipe.maxParallelism = para;
   event.activeRecipe.parallelism = para;
 })
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val time = data.getInt("time",0);
   if(time == 1){
      val xthread = event.factoryRecipeThread;
      xthread.addModifier("time_decrease",RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01f, 1, false).build());
   }
 })
 .addEnergyPerTickInput(1000)
 .addInputs([
   <contenttweaker:tci>
 ])
 .addOutput(<ic2:crafting:3>*8)
 .build();
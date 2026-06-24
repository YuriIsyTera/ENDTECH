import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.RecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.RecipeTickEvent;
import mods.modularmachinery.RecipeEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.MachineStructureUpdateEvent;
import crafttweaker.block.IBlock;
import novaeng.hypernet.HyperNetHelper;
import crafttweaker.item.IItemStack;
import crafttweaker.util.Math;
import crafttweaker.world.IBlockPos;
import crafttweaker.event.BlockBreakEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.RecipeModifier;
import crafttweaker.item.IIngredient;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeFinishEvent;
import crafttweaker.world.IFacing;
import mods.modularmachinery.Sync;
import mods.modularmachinery.MachineController;
import crafttweaker.liquid.ILiquidStack;

import crafttweaker.data.IData;
import mods.zenutils.DataUpdateOperation.MERGE;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
MachineModifier.setMaxThreads("dustcollector",10);
RecipeBuilder.newBuilder("collect","dustcollector",20);
RecipeBuilder.newBuilder("dustcollector_MAKE","workshop",3600)
    .addEnergyPerTickInput(2000000)
    .addFluidInputs([
       <liquid:neutronium>*100000
    ])
    .addItemInputs([
      <avaritia:block_resource>*56,
      <ic2:plate:14>*256,
      <ic2:plate:15>*256,
      <ic2:plate:16>*256,
      <ic2:plate:17>*256,
      <contenttweaker:industrial_circuit_v2>*24,
      <contenttweaker:robot_arm_v3>*16,
    ])
    .addOutputs([
        <modularmachinery:dustcollector_controller>
    ])
    .requireResearch("neutron_accretion_plate")
    .build();
  //集成控制器制造
  RecipeBuilder.newBuilder("dustcollector_factory_MAKE","workshop",3600)
    .addEnergyPerTickInput(80000000)
    .addFluidInputs([
       <liquid:neutronium>*100000
    ])
    .addItemInputs([
      <avaritia:block_resource>*556,
      <modularmachinery:neutron_accretion_plate_factory_controller>*16,
      <moreplates:infinity_gear>*4,
      <contenttweaker:lockednormalplanet>*2,
    ])
    .addOutputs([
        <modularmachinery:dustcollector_factory_controller>
    ])
    .requireResearch("neutron_accretion_plate")
    .build();
    
RecipeBuilder.newBuilder("product","dustcollector",40,1)
 .addOutputs([
    <appliedenergistics2:material:45>*256,
    <contenttweaker:skydust>*96,
    <enderio:item_material:20>*128,
    <avaritia:resource:2>*512,
    <avaritia:resource:3>*64,
    <avaritia:resource:4>*4,
    <contenttweaker:degenerationmatter>*160
 ])
 .addOutput(<contenttweaker:voidmatter>).setChance(0.05)
 .addRecipeTooltip("捕获太空中游离的§7尘埃物质")
 .build();
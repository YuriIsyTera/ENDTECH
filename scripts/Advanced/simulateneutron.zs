import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;

import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
MachineModifier.setMaxThreads("simulateneutronstarpointx", 32);
RecipeBuilder.newBuilder("neutron_accretion", "simulateneutronstarpointx", 20)
    .addFluidOutputs([
        <liquid:dimensionbeam>*18186,
        <liquid:zerotempaturefluid>*26265,
        <liquid:helium_3>*68789,
    ])
    .addOutputs([
        <contenttweaker:skydust>*5126,
        <contenttweaker:degenerationmatter>*1024,
        <appliedenergistics2:sky_stone_block>*334,
        <avaritia:resource:2>*20480,
        <taiga:obsidiorite_block>*746,
        <avaritia:resource:4>*4096,
        <avaritia:block_resource>*512
    ])
    .addRecipeTooltip("吞噬一切")
    .build();
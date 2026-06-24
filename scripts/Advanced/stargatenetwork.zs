#priority 1000
#reloadable

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

RecipeBuilder.newBuilder("yuriisydoll","stargate_centralx",48000)
 .addEnergyPerTickInput(100000000000000)
 .addInputs([
    <contenttweaker:etherengine_upgrade>*496,
    <contenttweaker:darkmatters>*51200,
    <contenttweaker:thor_blueprint>*4,
    <contenttweaker:harc_blueprint>*4,
    <contenttweaker:perihelion_blueprint>*4,
    <contenttweaker:zero_pressure_blueprint>*4,
    <contenttweaker:neutron_similar_blueprint>*4,
    <contenttweaker:collapse_blueprint>*16,
    <contenttweaker:spacestation_ii_blueprint>*4,
    <contenttweaker:voidmatter>*81964,
    <contenttweaker:arkchip>*256,
    <liquid:t1000>*10000000,
    <liquid:tachyonfluid>*368880,
    <liquid:spaceframefluid>*368880,
    <contenttweaker:superluminal_core>*512,
    <contenttweaker:lockednormalplanet>*256,
    <contenttweaker:lockedhellplanet>*256,
    <contenttweaker:lockedenderplanet>*256,
 ])
 .addOutput(<contenttweaker:yuriisydoll>)
 .addRecipeTooltip("§9§l抵达终末之中点")
 .addRecipeTooltip("§b未来将至?")
 .build();
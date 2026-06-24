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
GeoMachineModel.registerGeoMachineModel("dimensioncarver_ring",
    "modularmachinery:geo/mega_dimensioncarver_ring.geo.json",
    "modularmachinery:textures/mega_dimensioncarver_ring.png",
    "modularmachinery:animations/ring.animation.json"
);

GeoMachineModel.registerGeoMachineModel("singularity_core_sp",
    "modularmachinery:geo/singularity_core_sp.geo.json",
    "modularmachinery:textures/singularity_core_sp.png",
    "modularmachinery:animations/singularity_core_sp.animation.json"
);

MachineModifier.setMachineGeoModel("mega_hyperspacestabiliser", "dimensioncarver_ring");
MachineModifier.setMachineGeoModel("giga_singularitycore", "singularity_core_sp");

// RecipeBuilder.newBuilder("test","mega_hyperspacestabiliser",200,1)
//  .addRecipeTooltip("这是一个测试配方")
//  .build();
MMEvents.onControllerModelAnimation("mega_hyperspacestabiliser", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("ringroll",true);
});
MMEvents.onControllerModelAnimation("giga_singularitycore", function(event as ControllerModelAnimationEvent) {
    event.addAnimation("run_all_01", true);
});

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
RecipeBuilder.newBuilder("zdfgr_controllerMAKE","machine_arm",1800)
    .addEnergyPerTickInput(5000000)
    .addItemInputs([
        <modularmachinery:fluix_factory_controller>*4,
        <modularmachinery:covalent_overloader_controller>*8,
        <contenttweaker:industrial_circuit_v2>*12,
        <contenttweaker:robot_arm_v3>*8,
        <contenttweaker:sensor_v2>*6
    ])
    .addOutputs([
        <modularmachinery:zerogravity_fieldguidereactor_factory_controller>
    ])
    .build();
MachineModifier.setMaxThreads("zerogravity_fieldguidereactor",0);
for i in 1 to 15{
        MachineModifier.addCoreThread("zerogravity_fieldguidereactor", FactoryRecipeThread.createCoreThread("固液反应单元" + i));
}
        RecipeAdapterBuilder.create("zerogravity_fieldguidereactor","modularmachinery:fluix")
        .addModifier(RecipeModifierBuilder.create("modularmachinery:duration","input",0.1,1,false).build())
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .build();

RecipeAdapterBuilder.create("zerogravity_fieldguidereactor", "nuclearcraft:infuser")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.01, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 1000, 1, false).build())
        .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4096;
    })
    .build();
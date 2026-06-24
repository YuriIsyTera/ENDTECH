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
MachineModifier.setMaxThreads("wizard_drill",8);
RecipeBuilder.newBuilder("wizard_controller_MAKE","machine_arm",1200)
 .addEnergyPerTickInput(5000)
 .addInputs([
    <modularmachinery:small_ore_drill_factory_controller>*4,
    <modularmachinery:mineral_extractor_factory_controller>,
    <contenttweaker:sensor_v1>*8,
    <contenttweaker:electric_motor_v2>*8,
    <contenttweaker:robot_arm_v2>*16,
    <contenttweaker:industrial_circuit_v1>*32,
    <modularmachinery:blockcasing>*32
 ])
 .addOutput(<modularmachinery:wizard_drill_factory_controller>)
 .build();
RecipeBuilder.newBuilder("wizard_out","wizard_drill",40,1)
 .addEnergyPerTickInput(1000)
 .addFluidInput(<liquid:fluidedmana>*10)
     .addCatalystInput(<contenttweaker:additional_component_0>,
        ["优化采集策略", "使产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_1>,
        ["优化采集策略", "使产量翻2倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_raw_ore>,
        ["优化采集策略", "使产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output", 4.0F, 1, false).build(),
        ]
    ).setChance(0)
        .addCatalystInput(<contenttweaker:additional_component_2>,
        ["优化采集策略", "使产量翻4倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output",4.0F, 1, false).build(),
        ]
    ).setChance(0)
            .addCatalystInput(<contenttweaker:additional_component_3>,
        ["解放寰宇之力", "使产量翻8倍。"],
        [
            RecipeModifierBuilder.create("modularmachinery:item", "output",8.0F, 1, false).build(),
        ]
    ).setChance(0)
 .addOutput(<ebwizardry:magic_crystal>*32)
 .addOutput(<ebwizardry:magic_crystal:1>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:2>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:3>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:4>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:5>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:6>*16).setChance(0.686)
 .addOutput(<ebwizardry:magic_crystal:7>*16).setChance(0.686)
 .addOutput(<ebwizardry:astral_diamond>*16).setChance(0.214)
 .addOutput(<ebwizardry:grand_crystal>*16).setChance(0.214)
 .addRecipeTooltip("利用魔力注能采掘巫术水晶")
 .build();
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

events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent){
    val block = event.block;
    val pos = event.position;
    val item = event.item;
    val player = event.player;
    if(!event.world.remote && <contenttweaker:zp_upgrade>.matches(item)){
        if(block.definition.id != "modularmachinery:eco_y7_factory_controller" && block.definition.id != "modularmachinery:dream_energy_core_factory_controller" && block.definition.id != "modularmachinery:dyson_ball_management_center_factory_controller" && block.definition.id != "modularmachinery:space_generator_factory_controller" && block.definition.id != "modularmachinery:massanomaldevice_factory_controller" && block.definition.id != "modularmachinery:lhcparticle_factory_controller" && block.definition.id != "modularmachinery:dimensionreaper_factory_controller" && block.definition.id != "modularmachinery:lightpressurelaunchunit_factory_controller" && block.definition.id != "modularmachinery:groundzero_factory_controller" && block.definition.id != "modularmachinery:mega_spaceelevator_factory_controller" && block.definition.id != "modularmachinery:giga_negativephasecollector_factory_controller" && block.definition.id != "modularmachinery:speedlightsite_factory_controller" && block.definition.id != "modularmachinery:giga_condenseddarkplasmaturbine_factory_controller" && block.definition.id != "modularmachinery:giga_qft_factory_controller" && block.definition.id != "modularmachinery:mega_spaceelevatorminemodule_factory_controller" && block.definition.id != "modularmachinery:mega_shroudneedle_factory_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            if(block.definition.id == "modularmachinery:solar_panel_0_controller" || block.definition.id == "modularmachinery:solar_panel_1_controller" || block.definition.id =="modularmachinery:gas_generator_controller" || block.definition.id == "modularmachinery:hybrid_generator_factory_controller" || block.definition.id =="modularmachinery:biogas_generator_controller" || block.definition.id == "modularmachinery:weather_generator_controller" || block.definition.id == "modularmachinery:reactor_ic2_2_factory_controller" || block.definition.id == "modularmachinery:stellargenerator_controller" || block.definition.id == "modularmachinery:di_ci_controller" || block.definition.id == "modularmachinery:tidal_generator_controller" || block.definition.id == "modularmachinery:draconic_reactor_factory_controller" || block.definition.id == "modularmachinery:alppm_controller" || block.definition.id == "modularmachinery:ark_auxiliary_warehouse_controller" || block.definition.id == "modularmachinery:dyson_cloud_energy_receiver_controller" || block.definition.id == "modularmachinery:energy_releaser_controller" || block.definition.id == "modularmachinery:advanced_energy_releaser_controller" || block.definition.id == "modularmachinery:energy_crystal_controller" || block.definition.id == "modularmachinery:energy_crystal_2_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_core_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_casing_controller" || block.definition.id == "modularmachinery:ultra_zero_point_vacuum_displacer_controller" || block.definition.id == "modularmachinery:starburst_reactor_controller" || block.definition.id == "modularmachinery:xihe_star_creation_device_controller" || block.definition.id == "modularmachinery:orionengine_factory_controller" || block.definition.id == "modularmachinery:asteroid_reactor_factory_controller" || block.definition.id == "modularmachinery:zeromatrix_factory_controller" || block.definition.id == "modularmachinery:mega_psionicsiphonmatrix_factory_controller"){
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("ZPUGE",RecipeModifierBuilder.create("modularmachinery:energy","output",4,1,false).build());
                player.sendMessage("§9已部署局部时空重塑发生器");
            }else{
                item.mutable().shrink(1);
                ctrl.addPermanentModifier("ZPUG",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0625,1,false).build());
                player.sendMessage("§9已部署局部时空重塑发生器");
            }
           
        }
        if(block.definition.id == "novaeng_core:geocentric_drill_controller"){
            val ctrl = MachineController.getControllerAt(event.world,pos);
            item.mutable().shrink(1);
            ctrl.addPermanentModifier("ZPUG",RecipeModifierBuilder.create("modularmachinery:duration","input",0.0625,1,false).build());
            player.sendMessage("§9已部署局部时空重塑发生器");
        }
        if(block.definition.id == "modularmachinery:eco_y7_factory_controller" || block.definition.id == "modularmachinery:dream_energy_core_factory_controller" || block.definition.id == "modularmachinery:dyson_ball_management_center_factory_controller" || block.definition.id == "modularmachinery:space_generator_factory_controller" || block.definition.id == "modularmachinery:massanomaldevice_factory_controller" || block.definition.id == "modularmachinery:lhcparticle_factory_controller" || block.definition.id == "modularmachinery:dimensionreaper_factory_controller" || block.definition.id == "modularmachinery:lightpressurelaunchunit_factory_controller" || block.definition.id == "modularmachinery:groundzero_factory_controller" || block.definition.id == "modularmachinery:mega_spaceelevator_factory_controller" || block.definition.id == "modularmachinery:giga_negativephasecollector_factory_controller" || block.definition.id == "modularmachinery:speedlightsite_factory_controller" || block.definition.id == "modularmachinery:giga_condenseddarkplasmaturbine_factory_controller" || block.definition.id == "modularmachinery:giga_qft_factory_controller" || block.definition.id == "modularmachinery:mega_spaceelevatorminemodule_factory_controller" || block.definition.id == "modularmachinery:mega_shroudneedle_factory_controller"){
            player.sendMessage("§4此类机器不支持该插件导入");
        }
        event.cancel();
    }
});

<contenttweaker:zp_upgrade>.addTooltip("§9在稳定的时空中制造时空回旋,加速机器运行与能量产出");
<contenttweaker:zp_upgrade>.addTooltip("手持该模块右键右键为机器安装");
<contenttweaker:zp_upgrade>.addTooltip("可以为部分机器提供 §e16x §a速度加成§f");
<contenttweaker:zp_upgrade>.addTooltip("可以为部分发电机器提供 §e4x §c发电加成§f");
<contenttweaker:zp_upgrade>.addTooltip("§4注意:安装多个模块是无效的!§f");
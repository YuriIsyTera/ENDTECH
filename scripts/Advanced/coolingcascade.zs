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
MachineModifier.setMaxThreads("coolingindustry", 10);
RecipeBuilder.newBuilder("coolingindustry_MAKE","workshop",3600)

    .addEnergyPerTickInput(4000000)
    .addFluidInputs([
        <liquid:cryotheum>*100000
    ])
    .addItemInputs([
        <modularmachinery:advanced_liquid_conversion_machine_controller>*8,
        <modularmachinery:beng_controller>*16,
        <modularmachinery:neutron_activator_controller>*4,
        <contenttweaker:electric_motor_v4>*18,
        <contenttweaker:sensor_v3>*18,
        <nuclearcraft:water_source_dense>*128,
        <super_solar_panels:max_heat_storage>*56,
        <gravisuite:crafting:2>*56
    ])
    .addOutputs([
        <modularmachinery:coolingindustry_factory_controller>
    ])
    .requireResearch("coolingcasade")
    .build();
//超流氦
RecipeBuilder.newBuilder("superfluidhe","coolingindustry",20,1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 128;
   event.activeRecipe.parallelism = 128;
})
    .addFluidInput(<liquid:helium_3>*1000)
    .addEnergyPerTickInput(256000)
    .addFluidOutput(<liquid:superfluid_he>*1000)
    .addRecipeTooltip("执行的液氦减压冷却")
    .addRecipeTooltip("该配方拥有128并行上限")
    .build();
//IO端口和水
RecipeBuilder.newBuilder("supercyro","coolingindustry",5,3)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 128;
   event.activeRecipe.parallelism = 128;
})
   .addInputs(<appliedenergistics2:io_port>).setChance(0)
   .addEnergyPerTickInput(256000)
   .addInputs(<extendedae:infinity_cell>.withTag({r: {FluidName: "water", Craft: 0 as byte, Cnt: 1 as long, Count: 0 as byte, Req: 0 as long}, t: "f"})).setChance(0)
   .addFluidOutput(<liquid:cryotheum>*10000)
   .addRecipeTooltip("§9?")
   .addRecipeTooltip("该配方拥有128并行上限")
   .build();
//极寒末影
RecipeBuilder.newBuilder("coldenderpearl","coolingindustry",60,4)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 128;
   event.activeRecipe.parallelism = 128;
})
   .addFluidInput(<liquid:ender>*10000)
   .addEnergyPerTickInput(256000)
   .addFluidOutputs(<liquid:gelid_enderium>*10000)
   .addRecipeTooltip("冻结末影珍珠")
   .addRecipeTooltip("该配方拥有128并行上限")
   .build();
//IC2冷却液
RecipeBuilder.newBuilder("ic2coolant_coolingcasade","coolingindustry",2,4)
.addPreCheckHandler(function(event as RecipeCheckEvent){
   event.activeRecipe.maxParallelism = 128;
   event.activeRecipe.parallelism = 128;
})
 .addFluidInput(<liquid:water>*25600)
 .addInputs(<enderio:item_material:32>*8)
 .addOutputs(<liquid:ic2coolant>*25600)
 .addRecipeTooltip("制造IC2冷却液")
 .addRecipeTooltip("该配方拥有128并行上限")
 .build();
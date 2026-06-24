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
RecipeBuilder.newBuilder("hdd_controllerMAKE","machine_arm",1200)
  .addEnergyPerTickInput(256000)
  .addInputs([
    <modularmachinery:ion_generator_controller>*4,
    <contenttweaker:sensor_v3>*16,
    <contenttweaker:robot_arm_v4>*8,
    <contenttweaker:industrial_circuit_v2>*4,
    <super_solar_panels:crafting>*16,
    <appliedenergistics2:material:47>*64
  ])
  .addOutput(<modularmachinery:huge_disscociation_device_factory_controller>)
  .build();
MachineModifier.setMaxThreads("huge_disscociation_device",0);
for i in 1 to 32{
        MachineModifier.addCoreThread("huge_disscociation_device", FactoryRecipeThread.createCoreThread("解离单元" + i));
}

// <ore:charcoal> : <minecraft:coal>
RecipeBuilder.newBuilder("recipe_charcoal","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:charcoal>])
.addOutput(<minecraft:coal>)
.build();

// <ore:enderpearl> : <minecraft:ender_eye>
RecipeBuilder.newBuilder("recipe_enderpearl","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:enderpearl>])
.addOutput(<minecraft:ender_eye>)
.build();

// <ore:ingotTin> : <thermalfoundation:material:130>
RecipeBuilder.newBuilder("recipe_ingotTin","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:ingotTin>])
.addOutput(<thermalfoundation:material:130>)
.build();

// <ore:woolYellow> : <minecraft:glowstone>
RecipeBuilder.newBuilder("recipe_woolYellow","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:woolYellow>])
.addOutput(<minecraft:glowstone>)
.build();

// <ore:gemQuartz> : <appliedenergistics2:material>
RecipeBuilder.newBuilder("recipe_gemQuartz","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:gemQuartz>])
.addOutput(<appliedenergistics2:material>)
.build();

// <ore:ingotSteel> : <mets:titanium_ingot>
RecipeBuilder.newBuilder("recipe_ingotSteel","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:ingotSteel>])
.addOutput(<mets:titanium_ingot>)
.build();

// <ore:woolRed> : <minecraft:redstone_block>
RecipeBuilder.newBuilder("recipe_woolRed","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:woolRed>])
.addOutput(<minecraft:redstone_block>)
.build();

// <ore:woolBlue> : <minecraft:lapis_block>
RecipeBuilder.newBuilder("recipe_woolBlue","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:woolBlue>])
.addOutput(<minecraft:lapis_block>)
.build();

// <ore:ingotCopper> : <thermalfoundation:material:133>
RecipeBuilder.newBuilder("recipe_ingotCopper","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:ingotCopper>])
.addOutput(<thermalfoundation:material:133>)
.build();

// <ic2:crafting:19> : <minecraft:diamond>
RecipeBuilder.newBuilder("recipe_ic2_crafting19","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ic2:crafting:19>])
.addOutput(<minecraft:diamond>)
.build();

// <ore:dustBlaze> : <thermalfoundation:material:1024>
RecipeBuilder.newBuilder("recipe_dustBlaze","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:dustBlaze>])
.addOutput(<thermalfoundation:material:1024>)
.build();

// <ore:dustObsidian> : <thermalfoundation:material:1027>
RecipeBuilder.newBuilder("recipe_dustObsidian","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:dustObsidian>])
.addOutput(<thermalfoundation:material:1027>)
.build();

// <ore:dustGlowstone> : <super_solar_panels:crafting:2>
RecipeBuilder.newBuilder("recipe_dustGlowstone","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:dustGlowstone>])
.addOutput(<super_solar_panels:crafting:2>)
.build();

// <ore:ingotGold> : <thermalfoundation:material:134>
RecipeBuilder.newBuilder("recipe_ingotGold","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:ingotGold>])
.addOutput(<thermalfoundation:material:134>)
.build();

// <minecraft:snowball> : <thermalfoundation:material:1025>
RecipeBuilder.newBuilder("recipe_snowball","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<minecraft:snowball>])
.addOutput(<thermalfoundation:material:1025>)
.build();

// <ore:coal> : <ic2:crafting:19>
RecipeBuilder.newBuilder("recipe_ore_coal","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:coal>])
.addOutput(<ic2:crafting:19>)
.build();

// <minecraft:glowstone> : <super_solar_panels:crafting:1>
RecipeBuilder.newBuilder("recipe_glowstone","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<minecraft:glowstone>])
.addOutput(<super_solar_panels:crafting:1>)
.build();

// <ore:ingotIron> : <ic2:misc_resource:1>
RecipeBuilder.newBuilder("recipe_ingotIron","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:ingotIron>])
.addOutput(<ic2:misc_resource:1>)
.build();

// <super_solar_panels:crafting:0> : <super_solar_panels:crafting:52>
RecipeBuilder.newBuilder("recipe_ssp_crafting0","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<super_solar_panels:crafting:0>])
.addOutput(<super_solar_panels:crafting:52>)
.build();

// <minecraft:skull:1> : <minecraft:nether_star>
RecipeBuilder.newBuilder("recipe_skull1","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<minecraft:skull:1>])
.addOutput(<minecraft:nether_star>)
.build();

// <contenttweaker:field_generator_v1> : <avaritia:endest_pearl>
RecipeBuilder.newBuilder("recipe_field_generator","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<contenttweaker:field_generator_v1>])
.addOutput(<avaritia:endest_pearl>)
.build();

// <minecraft:skull:0> : <minecraft:skull:1>
RecipeBuilder.newBuilder("recipe_skull0","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<minecraft:skull:0>])
.addOutput(<minecraft:skull:1>)
.build();

// <ore:dirt> : <minecraft:clay>
RecipeBuilder.newBuilder("recipe_dirt","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:dirt>])
.addOutput(<minecraft:clay>)
.build();

// <minecraft:netherrack> : <minecraft:gunpowder>*2
RecipeBuilder.newBuilder("recipe_netherrack","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<minecraft:netherrack>])
.addOutput(<minecraft:gunpowder> * 2)
.build();

// <ore:blockRedstone> : <actuallyadditions:block_crystal>
RecipeBuilder.newBuilder("recipe_blockRedstone","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockRedstone>])
.addOutput(<actuallyadditions:block_crystal>)
.build();

// <ore:blockLapis> : <actuallyadditions:block_crystal:1>
RecipeBuilder.newBuilder("recipe_blockLapis","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockLapis>])
.addOutput(<actuallyadditions:block_crystal:1>)
.build();

// <ore:blockDiamond> : <actuallyadditions:block_crystal:2>
RecipeBuilder.newBuilder("recipe_blockDiamond","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockDiamond>])
.addOutput(<actuallyadditions:block_crystal:2>)
.build();

// <ore:blockCoal> : <actuallyadditions:block_crystal:3>
RecipeBuilder.newBuilder("recipe_blockCoal","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockCoal>])
.addOutput(<actuallyadditions:block_crystal:3>)
.build();

// <ore:blockEmerald> : <actuallyadditions:block_crystal:4>
RecipeBuilder.newBuilder("recipe_blockEmerald","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockEmerald>])
.addOutput(<actuallyadditions:block_crystal:4>)
.build();

// <ore:blockIron> : <actuallyadditions:block_crystal:5>
RecipeBuilder.newBuilder("recipe_blockIron","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<ore:blockIron>])
.addOutput(<actuallyadditions:block_crystal:5>)
.build();

// <actuallyadditions:block_crystal> : <actuallyadditions:block_crystal_empowered>
RecipeBuilder.newBuilder("recipe_crystal","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal>])
.addOutput(<actuallyadditions:block_crystal_empowered>)
.build();

// <actuallyadditions:block_crystal:1> : <actuallyadditions:block_crystal_empowered:1>
RecipeBuilder.newBuilder("recipe_crystal1","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal:1>])
.addOutput(<actuallyadditions:block_crystal_empowered:1>)
.build();

// <actuallyadditions:block_crystal:2> : <actuallyadditions:block_crystal_empowered:2>
RecipeBuilder.newBuilder("recipe_crystal2","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal:2>])
.addOutput(<actuallyadditions:block_crystal_empowered:2>)
.build();

// <actuallyadditions:block_crystal:3> : <actuallyadditions:block_crystal_empowered:3>
RecipeBuilder.newBuilder("recipe_crystal3","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal:3>])
.addOutput(<actuallyadditions:block_crystal_empowered:3>)
.build();

// <actuallyadditions:block_crystal:4> : <actuallyadditions:block_crystal_empowered:4>
RecipeBuilder.newBuilder("recipe_crystal4","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal:4>])
.addOutput(<actuallyadditions:block_crystal_empowered:4>)
.build();

// <actuallyadditions:block_crystal:5> : <actuallyadditions:block_crystal_empowered:5>
RecipeBuilder.newBuilder("recipe_crystal5","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<actuallyadditions:block_crystal:5>])
.addOutput(<actuallyadditions:block_crystal_empowered:5>)
.build();

// <botania:manaresource:4> : <mets:nano_living_metal>
RecipeBuilder.newBuilder("recipe_manaresource","huge_disscociation_device",1)
.addPreCheckHandler(function(event as RecipeCheckEvent){
 event.activeRecipe.maxParallelism = 1613471;
 event.activeRecipe.parallelism = 1613471;
})
.addEnergyPerTickInput(100)
.addInputs([<botania:manaresource:4>])
.addOutput(<mets:nano_living_metal>)
.build();
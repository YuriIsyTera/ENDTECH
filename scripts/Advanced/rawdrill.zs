import crafttweaker.util.Math;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.MMEvents;
import mods.modularmachinery.ControllerGUIRenderEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.RecipeStartEvent;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineController;
import novaeng.hypernet.HyperNetHelper;
MachineModifier.setMaxThreads("rawdrill",0);
for i in 0 to 8 {
    MachineModifier.addCoreThread("rawdrill", 
        FactoryRecipeThread.createCoreThread("采集线程#"+i)
    );
}

recipes.addShaped(<modularmachinery:rawdrill_factory_controller>, [
    [<minecraft:stone>, <minecraft:iron_block>, <minecraft:stone>],
    [<minecraft:iron_block>, <minecraft:iron_pickaxe>, <minecraft:iron_block>],
    [<minecraft:grass>, <minecraft:grass>, <minecraft:grass>]
]);
// 第 1 组（output_1，circuit 0，线程 #0）
RecipeBuilder.newBuilder("output_1","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_0>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_gem_lapis>*16,
    <novaeng_core:raw_ore_gem_coal>*16,
    <novaeng_core:raw_ore_lithium>*16,
    <novaeng_core:raw_ore_platinum>*16,
    <novaeng_core:raw_ore_nickel>*16,
    <novaeng_core:raw_ore_silver>*16,
    <novaeng_core:raw_ore_iridium>*16,
    <novaeng_core:raw_ore_gold>*16,
 ])
 .setThreadName("采集线程#0")
 .build();

// 第 2 组（output_2，circuit a，线程 #1）
RecipeBuilder.newBuilder("output_2","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_a>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_osmium>*16,
    <novaeng_core:raw_ore_iron>*16,
    <novaeng_core:raw_ore_boron>*16,
    <novaeng_core:raw_ore_karmesine>*16,
    <novaeng_core:raw_ore_vibranium>*16,
    <novaeng_core:raw_ore_copper>*16,
    <novaeng_core:raw_ore_tin>*16,
    <novaeng_core:raw_ore_lead>*16,
 ])
 .setThreadName("采集线程#1")
 .build();

// 第 3 组（output_3，circuit b，线程 #2）
RecipeBuilder.newBuilder("output_3","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_b>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_redstone>*16,
    <novaeng_core:raw_ore_astral_starmetal>*16,
    <novaeng_core:raw_ore_gem_charged_certus_quartz>*16,
    <novaeng_core:raw_ore_gem_certus_quartz>*16,
    <novaeng_core:raw_ore_dilithium>*16,
    <novaeng_core:raw_ore_ovium>*16,
    <novaeng_core:raw_ore_jauxum>*16,
    <novaeng_core:raw_ore_titanium>*16,
 ])
 .setThreadName("采集线程#2")
 .build();

// 第 4 组（output_4，circuit c，线程 #3）
RecipeBuilder.newBuilder("output_4","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_c>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_thorium>*16,
    <novaeng_core:raw_ore_uranium>*16,
    <novaeng_core:raw_ore_magnesium>*16,
    <novaeng_core:raw_ore_gem_diamond>*16,
    <novaeng_core:raw_ore_aluminium>*16,
    <novaeng_core:raw_ore_gem_aquamarine>*16,
    <novaeng_core:raw_ore_gem_amethyst>*16,
    <novaeng_core:raw_ore_gem_emerald>*16,
 ])
 .setThreadName("采集线程#3")
 .build();

// 第 5 组（output_5，circuit d，线程 #4）
RecipeBuilder.newBuilder("output_5","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_d>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_gem_ruby>*16,
    <novaeng_core:raw_ore_gem_amber>*16,
    <novaeng_core:raw_ore_gem_peridot>*16,
    <novaeng_core:raw_ore_gem_sapphire>*16,
    <novaeng_core:raw_ore_gem_malachite>*16,
    <novaeng_core:raw_ore_gem_tanzanite>*16,
    <novaeng_core:raw_ore_gem_topaz>*16,
    <novaeng_core:raw_ore_gem_fluorite>*16,
 ])
 .setThreadName("采集线程#4")
 .build();

// 第 6 组（output_6，circuit e，线程 #5）
RecipeBuilder.newBuilder("output_6","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_e>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_gem_dimensional_shard>*16,
    <novaeng_core:raw_ore_gem_quartz_black>*16,
    <novaeng_core:raw_ore_willowalloy>*16,
    <novaeng_core:raw_ore_tiberium>*16,
    <novaeng_core:raw_ore_prometheum>*16,
    <novaeng_core:raw_ore_gem_quartz>*16,
    <novaeng_core:raw_ore_valyrium>*16,
    <novaeng_core:raw_ore_cobalt>*16,
 ])
 .setThreadName("采集线程#5")
 .build();

// 第 7 组（output_7，circuit f，线程 #6）
RecipeBuilder.newBuilder("output_7","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addInputs(<contenttweaker:programming_circuit_f>).setChance(0)
 .addOutputs([
    <novaeng_core:raw_ore_ardite>*16,
    <novaeng_core:raw_ore_ancient_debris>*16,
    <novaeng_core:raw_ore_osram>*16,
    <novaeng_core:raw_ore_palladium>*16,
    <novaeng_core:raw_ore_uru>*16,
    <novaeng_core:raw_ore_abyssum>*16,
    <novaeng_core:raw_ore_aurorium>*16,
    <novaeng_core:raw_ore_duranite>*16,
 ])
 .setThreadName("采集线程#6")
 .build();

RecipeBuilder.newBuilder("output_dust_rrr","rawdrill",20,1)
 .addEnergyPerTickInput(100)
 .addOutputs(<enderio:item_material:20>*16)
 .addOutputs(<draconicevolution:draconium_dust>*16)
 .setThreadName("采集线程#7")
 .build();
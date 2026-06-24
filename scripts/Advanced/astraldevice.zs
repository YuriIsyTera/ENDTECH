#loader crafttweaker reloadable
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
import crafttweaker.block.IBlockState;
import native.com.meteor.extrabotany.api.ExtraBotanyAPI;
import native.vazkii.botania.api.BotaniaAPI;
import native.vazkii.botania.api.recipe.RecipeManaInfusion;
RecipeBuilder.newBuilder("astraldevice_controller_MAKE","machine_arm",900)
 .addEnergyPerTickInput(1000000)
 .addInputs([
    <packagedastral:trait_crafter>,
    <astralsorcery:itemcraftingcomponent:4>*128,
    <liquid:astralsorcery.liquidstarlight>*10000,
    <modularmachinery:blockcasing:4>*16,
    <astralsorcery:itemcraftingcomponent:3>*4,
    <astralsorcery:itemcraftingcomponent:1>*8,
    <astralsorcery:itemusabledust>*32,
    <astralsorcery:itemperkseal>*4
 ])
 .addOutput(<modularmachinery:astral_combine_device_factory_controller>)
 .build();
MachineModifier.setMaxThreads("astral_combine_device",0);
MachineModifier.addCoreThread("astral_combine_device",FactoryRecipeThread.createCoreThread("星能汇聚").addRecipe("starlight_output_astraldevice"));
for i in 1 to 15{
        MachineModifier.addCoreThread("astral_combine_device", FactoryRecipeThread.createCoreThread("引光核心" + i));
}
RecipeBuilder.newBuilder("starlight_output_astraldevice","astral_combine_device",40,1)
     .addCatalystInput(<contenttweaker:corvus_star_map>,
        ["汇聚乌鸦座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
     .addCatalystInput(<contenttweaker:thunderbolt_star_map>,
        ["汇聚天雷座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
     .addCatalystInput(<contenttweaker:monoceros_star_map>,
        ["汇聚麒麟座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
     .addCatalystInput(<contenttweaker:lyra_star_map>,
        ["汇聚天琴座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
     .addCatalystInput(<contenttweaker:bootes_star_map>,
        ["汇聚牧夫座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
     .addCatalystInput(<contenttweaker:fornax_star_map>,
        ["汇聚天炉座的力量,使星能液产出翻倍"],
        [
            RecipeModifierBuilder.create("modularmachinery:fluid", "output", 2.0F, 1, false).build(),
        ]
    ).setChance(0)
    .addOutput(<liquid:astralsorcery.liquidstarlight>*1000)
    .addRecipeTooltip("收集无尽的星光")
    .setThreadName("星能汇聚")
    .build();
// 配方类型：玻璃板转透镜
RecipeBuilder.newBuilder("glass_to_lens_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:glass_pane> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .build();

// 配方类型：辉光粉
RecipeBuilder.newBuilder("hs_glow_dust_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1)
    .addItemInput(<minecraft:glowstone_dust> * 4)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemusabledust> * 16)
    .build();

// 配方类型：暗夜粉
RecipeBuilder.newBuilder("hs_dark_dust_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>* 4,
                <minecraft:coal:1>* 4,
            ])
    )
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemusabledust:1> * 16)
    .build();

// 配方类型：光波增幅器
RecipeBuilder.newBuilder("hs_lightwave_amplifier_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:gold_nugget> * 2)
    .addInput(<ore:plankWood>*2)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble> * 1,
                <astralsorcery:blockmarble:1> * 1,
                <astralsorcery:blockmarble:2> * 1,
                <astralsorcery:blockmarble:3> * 1,
                <astralsorcery:blockmarble:4> * 1,
                <astralsorcery:blockmarble:5> * 1,
                <astralsorcery:blockmarble:6> * 1,
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blockattunementrelay> * 1)
    .build();

// 配方类型：标记光波增幅器
RecipeBuilder.newBuilder("hs_marked_relay_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemusabledust> * 3)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:blockattunementrelay> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<packagedastral:marked_relay> * 1)
    .build();

// 配方类型：知识共享卷轴
RecipeBuilder.newBuilder("hs_knowledge_share_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:feather> * 1)
    .addItemInput(<astralsorcery:itemusabledust> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:5> * 1)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:coal>,
                <minecraft:coal:1>,
            ])
    )
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemknowledgeshare> * 1)
    .build();

// 配方类型：天体星门
RecipeBuilder.newBuilder("hs_celestial_gateway_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:blockmarble:6>*2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blockcelestialgateway> * 1)
    .build();

// 配方类型：透镜
RecipeBuilder.newBuilder("hs_lens_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 3)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<minecraft:gold_ingot> * 1)
    .addItemInput(<astralsorcery:blockmarble:6>*2)
    .addItemInput(<astralsorcery:blockinfusedwood:4> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blocklens> * 1)
    .build();

// 配方类型：燃烧透镜
RecipeBuilder.newBuilder("hs_colored_lens_burning_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:blaze_powder> * 6)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:0>)
    .build();

// 配方类型：破坏透镜
RecipeBuilder.newBuilder("hs_colored_lens_destruction_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:iron_pickaxe> * 1)
    .addItemInput(<minecraft:gold_ingot> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:1>)
    .build();

// 配方类型：生长透镜
RecipeBuilder.newBuilder("hs_colored_lens_growth_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:wheat_seeds> * 6)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:2>)
    .build();

// 配方类型：伤害透镜
RecipeBuilder.newBuilder("hs_colored_lens_damage_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:iron_sword> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:3>)
    .build();

// 配方类型：再生透镜
RecipeBuilder.newBuilder("hs_colored_lens_regeneration_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:apple> * 1)
    .addItemInput(<minecraft:diamond> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:4>)
    .build();

// 配方类型：抗拒透镜
RecipeBuilder.newBuilder("hs_colored_lens_repulsion_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:piston> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:5>)
    .build();

// 配方类型：汇聚透镜
RecipeBuilder.newBuilder("hs_colored_lens_convergence_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<astralsorcery:itemusabledust> * 4)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemcoloredlens:6>)
    .build();

// 配方类型：烽火树
RecipeBuilder.newBuilder("hs_tree_beacon_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<ore:treeLeaves>*6)
    .addInput(<ore:treeSapling>)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000)
    .addItemInput(<astralsorcery:blockmarble:6> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blocktreebeacon> * 1)
    .build();

// 配方类型：效应链接通道
RecipeBuilder.newBuilder("hs_ritual_link_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:gold_nugget> * 4)
    .addItemInput(<minecraft:gold_ingot> * 1)
    .addItemInput(<minecraft:glass_pane> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blockrituallink> * 2)
    .build();

// 配方类型：更替之星
RecipeBuilder.newBuilder("hs_shifting_star_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4)
    .addItemInput(<astralsorcery:blockmarble:6> * 4)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemshiftingstar>* 1)
    .build();

// 配方类型：辐射之星（解离座）
RecipeBuilder.newBuilder("hs_radiation_star_evorsio_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.evorsio"}}) * 1)
    .addRecipeTooltip("蕴含解离座的力量")
    .build();

// 配方类型：生息座（Aevitas）
RecipeBuilder.newBuilder("hs_life_star_aevitas_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1)
    .addInput(<ore:treeSapling>*4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.aevitas"}}) * 1)
    .addRecipeTooltip("蕴含生息座的力量")
    .build();

// 配方类型：虚御座（Vicio）
RecipeBuilder.newBuilder("hs_vicio_star_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1)
    .addItemInput(<minecraft:feather> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.vicio"}}) * 1)
    .addRecipeTooltip("蕴含虚御座的力量")
    .build();

// 配方类型：遁甲座（Armara）
RecipeBuilder.newBuilder("hs_armara_star_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1)
    .addItemInput(<minecraft:iron_ingot> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.armara"}}) * 1)
    .addRecipeTooltip("蕴含遁甲座的力量")
    .build();

// 配方类型：非攻座（Discidia）
RecipeBuilder.newBuilder("hs_discidia_star_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemshiftingstar>* 1)
    .addItemInput(<minecraft:flint> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 8)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:itemshiftingstar>.withTag({astralsorcery: {starAttunement: "astralsorcery.constellation.discidia"}}) * 1)
    .addRecipeTooltip("蕴含非攻座的力量")
    .build();

// 配方类型：链接工具
RecipeBuilder.newBuilder("hs_linking_tool_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:stick> * 2)
    .addInput(<ore:logWood>*2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemlinkingtool> * 1)
    .build();

// 配方类型：星座核心
RecipeBuilder.newBuilder("hs_constellation_focus_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 12)
    .addItemInput(<minecraft:glass_pane> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4)
    .addItemInput(<astralsorcery:itemusabledust> * 4)
    .addItemInput(<astralsorcery:itemusabledust:1>* 2)
    .addItemInput(<astralsorcery:itemshiftingstar> * 1)
    .addEnergyPerTickInput(750)
    .addItemOutput(<packagedastral:constellation_focus> * 1)
    .build();

// 配方类型：仪式基座
RecipeBuilder.newBuilder("hs_ritual_pedestal_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3)
    .addItemInput(<astralsorcery:blockmarble:2> * 4)
    .addItemInput(<astralsorcery:blockmarble:4> * 2)
    .addItemInput(<minecraft:gold_ingot> * 2)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:blockritualpedestal> * 1)
    .build();

// 配方类型：星能聚合器
RecipeBuilder.newBuilder("hs_starlight_infuser_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:gold_ingot> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addInput(<liquid:astralsorcery.liquidstarlight>* 1000)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1)
    .addItemInput(<astralsorcery:blockmarble:5> * 2)
    .addItemInput(<astralsorcery:blockmarble:2> * 6)
    .addItemInput(<astralsorcery:blockmarble:4> * 2)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:blockstarlightinfuser> * 1)
    .build();

// 配方类型：照明星杖
RecipeBuilder.newBuilder("hs_illumination_wand_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 2)
    .addItemInput(<astralsorcery:itemusabledust> * 1)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemilluminationwand>)
    .build();

// 配方类型：转位星杖
RecipeBuilder.newBuilder("hs_exchange_wand_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3)
    .addItemInput(<minecraft:diamond> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemexchangewand> * 1)
    .build();

// 配方类型：冲击星杖
RecipeBuilder.newBuilder("hs_grapple_wand_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3)
    .addItemInput(<minecraft:ender_pearl> * 2)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 1,
                <minecraft:dye:5> * 1,
                <thermalfoundation:dye:5> * 1
            ])
    )
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemgrapplewand> * 1)
    .build();

// 配方类型：秩序星杖
RecipeBuilder.newBuilder("hs_architect_wand_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 3)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <botania:dye:10> * 2,
                <minecraft:dye:5> * 2,
                <thermalfoundation:dye:5> * 2
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemarchitectwand> * 1)
    .build();

// 配方类型：共鸣星杖
RecipeBuilder.newBuilder("hs_resonance_wand_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:blockmarble:0> * 2,
                <astralsorcery:blockmarble:1> * 2,
                <astralsorcery:blockmarble:2> * 2,
                <astralsorcery:blockmarble:3> * 2,
                <astralsorcery:blockmarble:4> * 2,
                <astralsorcery:blockmarble:5> * 2,
                <astralsorcery:blockmarble:6> * 2
            ])
    )
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:ender_pearl> * 1)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand> * 1)
    .build();

// 配方类型：共鸣星杖（虚御座）
RecipeBuilder.newBuilder("hs_resonance_wand_vicio_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4)
    .addItemInput(<minecraft:feather> * 6)
    .addItemInput(<minecraft:reeds> * 2)
    .addItemInput(<minecraft:arrow> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.vicio"}}) * 1)
    .build();

// 配方类型：共鸣星杖（解离座）
RecipeBuilder.newBuilder("hs_resonance_wand_evorsio_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<minecraft:gunpowder> * 4)
    .addItemInput(<minecraft:cobblestone> * 4)
    .addItemInput(<minecraft:quartz> * 2)
    .addItemInput(<minecraft:blaze_powder> * 2)
    .addItemInput(<minecraft:flint> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.evorsio"}}) * 1)
    .build();

// 配方类型：共鸣星杖（非攻座）
RecipeBuilder.newBuilder("hs_resonance_wand_discidia_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<astralsorcery:itemusabledust> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<minecraft:blaze_rod> * 2)
    .addItemInput(<minecraft:glowstone_dust> * 2)
    .addItemInput(<minecraft:flint> * 4)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.discidia"}}) * 1)
    .build();

// 配方类型：共鸣星杖（遁甲座）
RecipeBuilder.newBuilder("hs_resonance_wand_armara_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<minecraft:iron_ingot> * 4)
    .addItemInput(<minecraft:nether_brick> * 2)
    .addItemInput(<minecraft:leather> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1>* 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.armara"}}) * 1)
    .build();

// 配方类型：共鸣星杖（生息座）
RecipeBuilder.newBuilder("hs_resonance_wand_aevitas_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<minecraft:reeds> * 4)
    .addInput(<ore:treeSapling>*6)
    .addItemInput(<astralsorcery:itemusabledust> * 2)
    .addItemInput(<minecraft:prismarine_shard> * 2)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:itemwand>.withTag({astralsorcery: {AugmentName: "astralsorcery.constellation.aevitas"}}) * 1)
    .build();

// 配方类型：星辉封包合成器
RecipeBuilder.newBuilder("hs_discovery_crafter_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockaltar> * 1)
    .addItemInput(<astralsorcery:blockinfusedwood> * 2)
    .addItemInput(<packagedauto:me_package_component> * 1)
    .addItemInput(<astralsorcery:itemwand> * 1)
    .addItemInput(<astralsorcery:blockmarble:4> * 4)
    .addEnergyPerTickInput(600)
    .addItemOutput(<packagedastral:discovery_crafter> * 1)
    .build();

// 配方类型：共鸣祭坛
RecipeBuilder.newBuilder("hs_attunement_altar_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 2)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:blockattunementrelay> * 1)
    .addItemInput(<astralsorcery:blockmarble:6> * 4)
    .addEnergyPerTickInput(500)
    .addItemOutput(<astralsorcery:blockattunementaltar> * 1)
    .build();

// 配方类型：星辉祭坛
RecipeBuilder.newBuilder("hs_starlight_altar_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:4> * 2)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 1000)
    .addItemInput(<astralsorcery:blockmarble:2> * 4)
    .addEnergyPerTickInput(600)
    .addItemOutput(<astralsorcery:blockaltar:1> * 1)
    .build();

// 配方类型：天辉祭坛
RecipeBuilder.newBuilder("hs_celestial_altar_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:blockmarble:4> * 4)
    .addItemInput(<astralsorcery:blockmarble:2> * 2)
    .addEnergyPerTickInput(700)
    .addItemOutput(<astralsorcery:blockaltar:2> * 1)
    .build();

// 配方类型：五彩祭坛
RecipeBuilder.newBuilder("hs_prismatic_altar_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:blockmarble:6> * 8)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 4)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:blockblackmarble> * 4)
    .addEnergyPerTickInput(800)
    .addItemOutput(<astralsorcery:blockaltar:3> * 1)
    .build();

// 配方类型：星辉封包合成祭坛
RecipeBuilder.newBuilder("hs_attunement_crafter_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<packagedastral:discovery_crafter> * 1)
    .addItemInput(<astralsorcery:blockblackmarble> * 2)
    .addInput(<liquid:astralsorcery.liquidstarlight> * 1000)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:blockmarble:4> * 2)
    .addItemInput(<astralsorcery:blockmarble:2> * 4)
    .addEnergyPerTickInput(900)
    .addItemOutput(<packagedastral:attunement_crafter> * 1)
    .build();

// 配方类型：天辉封包祭坛
RecipeBuilder.newBuilder("hs_constellation_crafter_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 2)
    .addItemInput(<astralsorcery:blockblackmarble> * 2)
    .addItemInput(<astralsorcery:blockmarble:2> * 2)
    .addItemInput(<astralsorcery:blockmarble:4> * 4)
    .addItemInput(<minecraft:redstone> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:1> * 1)
    .addEnergyPerTickInput(800)
    .addItemOutput(<packagedastral:constellation_crafter> * 1)
    .build();

// 配方类型：五彩封包祭坛
RecipeBuilder.newBuilder("hs_trait_crafter_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<minecraft:redstone> * 4)
    .addItemInput(<astralsorcery:itemusabledust> * 4)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 2)
    .addItemInput(<minecraft:ender_pearl> * 2)
    .addItemInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addItemInput(<astralsorcery:itemusabledust:1> * 2)
    .addItemInput(<astralsorcery:blockblackmarble:4> * 4)
    .addItemInput(<astralsorcery:blockmarble:6> * 8)
    .addItemInput(<minecraft:ender_eye> * 2)
    .addItemInput(<packagedastral:constellation_focus> * 1)
    .addItemInput(<packagedastral:constellation_crafter> * 1)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 4)
    .addItemInput(<astralsorcery:itemrockcrystalsimple> * 1)
    .addEnergyPerTickInput(1000)
    .addItemOutput(<packagedastral:trait_crafter> * 1)
    .build();

// 配方类型：封闭印章
RecipeBuilder.newBuilder("itemperkseal_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addItemInput(<astralsorcery:itemusabledust:1> * 192)
    .addItemInput(<astralsorcery:itemcraftingcomponent:3> * 64)
    .addItemInput(<astralsorcery:itemcraftingcomponent:2> * 64)
    .addEnergyPerTickInput(10000)
    .addItemOutput(<astralsorcery:itemperkseal> * 64)
    .build();

RecipeBuilder.newBuilder("mana_dust_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:dye>,
                <ore:gunpowder>,
                <ore:dustGlowstone>,
                <ore:dustRedstone>,
                <ore:listAllsugar>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput(<botania:manaresource:23>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("mana_diamond_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:gemDiamond>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput(<botania:manaresource:2>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("mana_string_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:string>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .addItemOutput(<botania:manaresource:16>)
    .build();

RecipeBuilder.newBuilder("mana_ingot_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:ingotIron>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput(<botania:manaresource>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("mana_pearl_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <minecraft:ender_pearl>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput(<botania:manaresource:1>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();
    
RecipeBuilder.newBuilder("mana_glass_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <ore:blockGlass>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput(<botania:managlass>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();
    
RecipeBuilder.newBuilder("dimension_pearl_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:diamond>
            ])
    ).setTag("right")
    .addEnergyPerTickInput(500)
    .addItemOutput(<minecraft:ender_pearl>)
    .addRecipeTooltip("在控制器右侧仓室执行")
    .build();
    
RecipeBuilder.newBuilder("dimension_blaze_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:blaze_rod>
            ])
    ).setTag("right")
    .addEnergyPerTickInput(500)
    .addItemOutput(<minecraft:blaze_rod>*2)
    .addRecipeTooltip("在控制器右侧仓室执行")
    .build();

RecipeBuilder.newBuilder("ender_eye_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:ender_pearl>
            ])
    ).setTag("right")
    .addEnergyPerTickInput(500)
    .addItemOutput(<minecraft:ender_eye>)
    .addRecipeTooltip("在控制器右侧仓室执行")
    .build();

// 注意：重复的ender_eye配方已删除，保留上面一个

RecipeBuilder.newBuilder("yingshi_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:gunpowder>
            ])
    ).setTag("right")
    .addEnergyPerTickInput(500)
    .addItemOutput(<minecraft:glowstone_dust>)
    .addRecipeTooltip("在控制器右侧仓室执行")
    .build();

RecipeBuilder.newBuilder("gunpowder_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:redstone>
            ])
    ).setTag("right")
    .addEnergyPerTickInput(500)
    .addItemOutput( <minecraft:gunpowder>)
    .addRecipeTooltip("在控制器右侧仓室执行")
    .build();

RecipeBuilder.newBuilder("blaze_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:blaze_rod>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput( <minecraft:blaze_powder>*4)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("lieyangao_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:slime_ball>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput( <minecraft:magma_cream>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("goldcarrot_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:carrot>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput( <minecraft:golden_carrot>)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();

RecipeBuilder.newBuilder("gufen_astraldevice", "astral_combine_device", 40)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
               <minecraft:bone>
            ])
    ).setTag("left")
    .addEnergyPerTickInput(500)
    .addItemOutput( <minecraft:dye:15>*4)
    .addRecipeTooltip("在控制器左侧仓室执行")
    .build();
    
RecipeBuilder.newBuilder("mineralis_ritual_astraldevice", "astral_combine_device", 100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <ore:ingotTerraAlloy> * 2,
        <ore:ingotPsiAlloy> * 2,
        <botania:bifrostperm> * 1,
        <additions:novaextended-novaextended_medal1> * 1,
        <futuremc:netherite_pickaxe> * 1,
        <modularmachinery:blockcasing> * 6,
        <astralsorcery:blockrituallink> * 2,
        <astralsorcery:blockmarble:2> * 6,
        <astralsorcery:blockritualpedestal> * 1,
        <ore:oreIron> * 1,
        <ore:oreGold> * 1,
        <ore:oreCoal> * 1,
        <ore:oreLapis> * 1,
        <ore:oreDiamond> * 1,
        <ore:oreEmerald> * 1,
        <ore:oreRedstone> * 1,
        <ore:oreAncientDebris> * 1
    ])
    .addEnergyPerTickInput(6500)
    .addItemOutput(<modularmachinery:mineralis_ritual_controller> * 1)
    .build();

// 配方类型：牧夫座仪式
RecipeBuilder.newBuilder("bootes_ritual_astraldevice", "astral_combine_device", 100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <astralsorcery:itemcraftingcomponent:4> * 2,
        <astralsorcery:blocktreebeacon> * 1,
        <extrabotany:material:1> * 2,
        <ore:dirt> * 2,
        <additions:novaextended-novaextended_medal4> * 1,
        <nuclearcraft:spaxelhoe_boron_nitride> * 1,
        <futuremc:lantern> * 2,
        <modularmachinery:blockcasing> * 2,
        <astralsorcery:blockrituallink> * 2,
        <astralsorcery:blockinfusedwood:2> * 2,
        <astralsorcery:blockmarble:2> * 5,
        <astralsorcery:blockritualpedestal> * 1,
        <ore:seedWheat> * 1,
        <ore:cropPotato> * 1,
        <ore:cropCarrot> * 1,
        <ore:blockWool> * 1,
        <ore:leather> * 1,
        <minecraft:sapling> * 1,
        <harvestcraft:apple_sapling> * 1,
        <ore:blockCactus> * 1
    ])
    .addEnergyPerTickInput(5800)
    .addItemOutput(<modularmachinery:bootes_ritual_controller> * 1)
    .build();

// 配方类型：唤生座仪式
RecipeBuilder.newBuilder("pelotrio_ritual_astraldevice", "astral_combine_device", 100)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInputs([
        <deepmoblearning:living_matter_overworldian> * 1,
        <additions:novaextended-novaextended_medal5> * 1,
        <deepmoblearning:living_matter_hellish> * 1,
        <deepmoblearning:polymer_clay> * 2,
        <astralsorcery:blockblackmarble:5> * 1,
        <astralsorcery:itemcraftingcomponent:4> * 1,
        <deepmoblearning:living_matter_extraterrestrial> * 1,
        <astralsorcery:itemcraftingcomponent> * 1,
        <astralsorcery:blockmarble:6> * 2,
        <additions:novaextended-chaotic_medal1> * 2,
        <astralsorcery:blockrituallink> * 2,
        <astralsorcery:blockblackmarble:2> * 2,
        <astralsorcery:blockblackmarble:6> * 2,
        <deepmoblearning:glitch_heart> * 1,
        <futuremc:soul_fire_lantern> * 2,
        <astralsorcery:blockritualpedestal> * 1,
        <deepmoblearning:pristine_matter_creeper> * 1,
        <deepmoblearning:pristine_matter_slime> * 1,
        <deepmoblearning:pristine_matter_wither_skeleton> * 1,
        <deepmoblearning:pristine_matter_blaze> * 1,
        <deepmoblearning:pristine_matter_wither> * 1,
        <deepmoblearning:pristine_matter_enderman> * 1,
        <deepmoblearning:pristine_matter_shulker> * 1,
        <deepmoblearning:pristine_matter_dragon> * 1,
        <draconicevolution:dragon_heart> * 1
    ])
    .addEnergyPerTickInput(7100)
    .addItemOutput(<modularmachinery:pelotrio_ritual_controller> * 1)
    .build();

RecipeBuilder.newBuilder("marble_astraldevice", "astral_combine_device", 1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <ore:cobblestone>*64,
                <ore:stone>*64
            ])
    )
    .addEnergyPerTickInput(1)
    .addItemOutput(<astralsorcery:blockmarble>*64)
    .build();

RecipeBuilder.newBuilder("crystal_astraldevice", "astral_combine_device", 1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addIngredientArrayInput(
        IngredientArrayBuilder.newBuilder()
            .addIngredients([
                <astralsorcery:itemcraftingcomponent>*64
            ])
    )
    .addEnergyPerTickInput(1)
    .addItemOutput(<astralsorcery:itemcraftingcomponent:4>*64)
    .build();

// 配方：星耀勋章
RecipeBuilder.newBuilder("giga_qft_medal_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_0>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 8)
    .addInput(<extrabotany:material:3> * 1)
    .addInput(<additions:novaextended-terraalloy> * 1)
    .addInput(<additions:novaextended-ingot8> * 2)
    .addItemOutput(<additions:novaextended-novaextended_medal>)
    .build();

// 配方：星耀勋章1
RecipeBuilder.newBuilder("giga_qft_medal1_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 1)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addInput(<minecraft:gold_ore> * 1)
    .addInput(<minecraft:iron_ore> * 1)
    .addInput(<minecraft:diamond_ore> * 1)
    .addInput(<minecraft:emerald_ore> * 1)
    .addItemOutput(<additions:novaextended-novaextended_medal1>)
    .build();

// 配方：星耀勋章2
RecipeBuilder.newBuilder("giga_qft_medal2_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_c>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 1)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addInput(<minecraft:clock> * 1)
    .addInput(<minecraft:redstone> * 1)
    .addInput(<minecraft:glowstone_dust> * 1)
    .addInput(<rftools:timer_block> * 1)
    .addItemOutput(<additions:novaextended-novaextended_medal2>)
    .build();

// 配方：星耀勋章3
RecipeBuilder.newBuilder("giga_qft_medal3_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_d>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<avaritia:resource:5> * 2)
    .addInput(<additions:novaextended-novaextended_medal> * 1)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addInput(<minecraft:diamond_block> * 1)
    .addInput(<minecraft:lapis_block> * 1)
    .addInput(<extrabotany:material:3> * 1)
    .addInput(<jaopca:block_blockwillowalloy> * 1)
    .addInput(<avaritia:resource:6> * 1)
    .addItemOutput(<additions:novaextended-novaextended_medal3>)
    .build();

// 配方：星耀勋章4
RecipeBuilder.newBuilder("giga_qft_medal4_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 1)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addInput(<minecraft:pumpkin> * 1)
    .addInput(<minecraft:melon> * 1)
    .addInput(<minecraft:hay_block> * 1)
    .addInput(<minecraft:wool> * 1)
    .addItemOutput(<additions:novaextended-novaextended_medal4>)
    .build();

// 配方：星耀勋章5
RecipeBuilder.newBuilder("giga_qft_medal5_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_f>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<contenttweaker:programming_circuit_e>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 1)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 4)
    .addInput(<minecraft:bone> * 1)
    .addInput(<minecraft:nether_star> * 1)
    .addInput(<minecraft:ender_pearl> * 1)
    .addInput(<deepmoblearning:glitch_heart> * 1)
    .addItemOutput(<additions:novaextended-novaextended_medal5>)
    .build();

RecipeBuilder.newBuilder("anti_giga_qft_medal5_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_a>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 3)
    .addInput(<jaopca:item_platedensewillowalloy> * 16)
    .addInput(<enderutilities:storage_0:6> * 32)
    .addItemOutput(<additions:novaextended-chaotic_medal> * 2)
    .build();

RecipeBuilder.newBuilder("anti_giga_qft_medal6_astraldevice", "astral_combine_device", 20)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 16384;
        event.activeRecipe.parallelism = 16384;
    })
    .addInput(<contenttweaker:programming_circuit_b>).setChance(0).setParallelizeUnaffected(true)
    .addInput(<additions:novaextended-novaextended_medal> * 3)
    .addInput(<astralsorcery:itemcraftingcomponent:4> * 64)
    .addInput(<deepmoblearning:glitch_infused_ingot> * 32)
    .addItemOutput(<additions:novaextended-chaotic_medal1> * 2)
    .build();
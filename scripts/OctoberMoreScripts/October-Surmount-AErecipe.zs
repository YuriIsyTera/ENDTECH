//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
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
import crafttweaker.event.BlockBreakEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.block.IBlock;
import crafttweaker.player.IPlayer;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerInteractBlockEvent;

import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

HyperNetHelper.proxyMachineForHyperNet("Surmount-AE");

HyperNetHelper.proxyMachineForHyperNet("Starmagn-pro");

HyperNetHelper.proxyMachineForHyperNet("Surmount-UTS");

HyperNetHelper.proxyMachineForHyperNet("wallcreation");

MachineModifier.setMaxParallelism("Surmount-AE", 12000);
MachineModifier.setMaxThreads("Surmount-AE",32);

MachineModifier.setInternalParallelism("Surmount-AE", 12000);
MachineModifier.addCoreThread("Surmount-AE", FactoryRecipeThread.createCoreThread("混沌多阶共聚"));

var recipeCounter = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//==================================超能聚演控制器==============================
//超能聚演_集成控制器
RecipeBuilder.newBuilder("surmount_AE_factory_controller", "workshop", 1000)
    .addEnergyPerTickInput(300000)
    .addInput(<contenttweaker:industrial_circuit_v4> * 6)
    .addInput(<contenttweaker:engineering_battery_v4> * 6)
    .addInput(<draconicadditions:chaotic_energy_core> * 12)
    .addInput(<additions:novaextended-crystal4> * 64)
    .addInput(<tconevo:metal_block:2> * 128)
    .addInput(<contenttweaker:coil_v5> * 12)
    .addInput(<modularmachinery:transition_orbit_emitter_factory_controller> * 6)
    .addInput(<modularmachinery:starburst_reactor_controller> * 1)
    .addOutput(<modularmachinery:surmount-ae_factory_controller>)
    .requireComputationPoint(10000.0F)
    .requireResearch("Surmount-AE")
    .build();

//混沌碎片（廉价生产）    
RecipeBuilder.newBuilder("surmount_AE_1", "Surmount-AE", 20)
    .addEnergyPerTickInput(3000)
    .addInput(<deepmoblearning:data_model_chaosguardian>.withTag({tier: 4})).setChance(0)
    .addOutput(<draconicevolution:chaos_shard> * 4096)
    .requireResearch("Surmount-AE")
    .addRecipeTooltip("§6我喜欢这种生产效率！")
    .build();

//超光速核心（简略升级）    
RecipeBuilder.newBuilder("surmount_AE_2", "Surmount-AE", 100)
    .addEnergyPerTickInput(3000)
    .addInput(<contenttweaker:ymysq>)
    .addInput(<draconicadditions:chaotic_energy_core>)
    .addInput(<contenttweaker:world_energy_core>)
    .addOutput(<contenttweaker:superluminal_core> * 6)
    .requireResearch("Surmount-AE")
    .addRecipeTooltip("§6伟力如此，有何顾虑？")
    .build();

//无尽之锭（限定升级）    
RecipeBuilder.newBuilder("surmount_AE_3", "Surmount-AE", 40)
    .addEnergyPerTickInput(5120000)
    .addInput(<avaritia:resource:1> * 1)
    .addOutput(<avaritia:resource:6> * 1).setChance(0.5)
    .addCatalystInput(<contenttweaker:superluminal_core>,
                ["超光速核心之力！","现在将不再消耗配方材料,并且以2倍速度进行工作"],
                [RecipeModifierBuilder.create("modularmachinery:duration", "input",0.5,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "input",0,1,true).build()]).setChance(0)
    .addCatalystInput(<modularmachinery:starburst_reactor_controller>,
                ["天上的星星仿佛触手可及","提高900％的产出和产出概率"],
                [RecipeModifierBuilder.create("modularmachinery:item", "output",10,1,true).build()]).setChance(0)
    .addCatalystInput(<modularmachinery:light-speed_material_accelerator_factory_controller>,
                ["这一切奇迹的起点，它将造就无限的进步！","运行产出翻倍,耗电极端降低"],
                [RecipeModifierBuilder.create("modularmachinery:energy", "input",0.01,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "output",2,1,false).build()]).setChance(0)
    .requireResearch("Surmount-AE-002")
    .addRecipeTooltip("§3我们都需要多一些确定...")
    .build();

//方舟之锭（限定升级）    
RecipeBuilder.newBuilder("surmount_AE_4", "Surmount-AE", 80)
    .addEnergyPerTickInput(10240000)
    .addInput(<avaritia:resource:6> * 1)
    .addOutput(<additions:novaextended-star_ingot> * 1).setChance(0.2)
    .addCatalystInput(<contenttweaker:superluminal_core>,
                ["超光速核心之力！","现在将不再消耗配方材料,并且以4倍速度进行工作"],
                [RecipeModifierBuilder.create("modularmachinery:duration", "input",0.25,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "input",0,1,true).build()]).setChance(0)
    .addCatalystInput(<modularmachinery:starburst_reactor_controller>,
                ["繁星啊，正闪耀于此！","提高900％的产出和产出概率"],
                [RecipeModifierBuilder.create("modularmachinery:item", "output",10,1,true).build()]).setChance(0)
    .addCatalystInput(<modularmachinery:light-speed_material_accelerator_factory_controller>,
                ["请再一次与我同行！","运行产出翻倍,耗电极端降低"],
                [RecipeModifierBuilder.create("modularmachinery:energy", "input",0.01,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "output",2,1,false).build()]).setChance(0)
    .requireResearch("Surmount-AE-002")
    .addRecipeTooltip("§3即使连银河都握于手中")
    .build();

//三种异端（升级）    
RecipeBuilder.newBuilder("surmount_AE_cry", "Surmount-AE", 40)
    .addEnergyPerTickInput(100)
    .addInput(<contenttweaker:life_regeneration_core>).setChance(0)
    .addOutput(<contenttweaker:crystalpurple> * 48)
    .addOutput(<contenttweaker:crystalgreen> * 48)
    .addOutput(<contenttweaker:crystalred> * 48)
    .addOutput(<contenttweaker:level_infinity_orb> * 1)
    .addCatalystInput(<contenttweaker:superluminal_core>,
                ["超光速核心之力！","现在将不再消耗配方材料,并且以4倍速度进行工作"],
                [RecipeModifierBuilder.create("modularmachinery:duration", "input",0.25,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "input",0,1,true).build()]).setChance(0)
    .addCatalystInput(<deepmoblearning:data_model_inf7yentr60py>,
                ["§4我会为你开辟道路。","运行产出翻十倍！"],
                [RecipeModifierBuilder.create("modularmachinery:item", "output",10,1,false).build()]).setChance(0)
    .addCatalystInput(<contenttweaker:world_energy_core>,
                ["§1以此致敬万千寰宇。","运行产出翻倍,耗电极端降低"],
                [RecipeModifierBuilder.create("modularmachinery:energy", "input",0.01,1, false).build(),RecipeModifierBuilder.create("modularmachinery:item", "output",2,1,false).build()]).setChance(0)
    .requireResearch("Surmount-AE-003")
    .addRecipeTooltip("§6哪怕是这一点星光...")
    .build();

//光子的普及计划    
RecipeBuilder.newBuilder("surmount_AE_solarsuper", "Surmount-AE", 20)
    .addEnergyPerTickInput(1024)
    .addInput(<super_solar_panels:crafting:34>).setChance(0)
    .addOutput(<super_solar_panels:machines:8> * 4096)
    .addRecipeTooltip("§2这现实，如你所愿")
    .build();
//==================================星磁延变控制器==============================
//星磁延对_控制器
RecipeBuilder.newBuilder("starmagn-pro_factory_controller", "workshop", 600)
    .addEnergyPerTickInput(30000)
    .addInput(<liquid:plasma> * 20000)
    .addInput(<contenttweaker:infinite_coil> * 32)
    .addInput(<modularmachinery:di_ci_controller> * 10)
    .addInput(<contenttweaker:fixed_star_alloys_coil> * 480)
    .addInput(<avaritiaio:infinitecapacitor> * 20)
    .addInput(<contenttweaker:universalforcefieldcontrolblock> * 8)
    .addOutput(<modularmachinery:starmagn-pro_factory_controller>)
    .requireComputationPoint(50.0F)
    .requireResearch("Surmount-pro-001")
    .addRecipeTooltip("§6我来组成...")
    .build();

//星体磁令
RecipeBuilder.newBuilder("planet_ff-1", "starmagn-pro", 300)
    .addEnergyPerTickInput(10000000)
    .addItemInputs([
        <contenttweaker:gama_tialalloy> * 64,
        <contenttweaker:voidmatter> * 400,
        <contenttweaker:darkmatters>,
        <contenttweaker:arkchip>,
    ])
    .addOutput(<contenttweaker:planet_ff>)
    .addRecipeTooltip("§4星球力量的号召。")
    .addRecipeTooltip("§2超级材料的利用。")
    .addRecipeTooltip("§4以宇宙创生之力作极，即便是超越维度的力量，也必将被掌握于你我手中。")
    .addRecipeTooltip("§4这铸就星神的道路，我会走上前去。")
    .build();

//三种ECO第九阶级存储元件
RecipeBuilder.newBuilder("planet_ff-2", "starmagn-pro", 3000)
    .addEnergyPerTickInput(10000000)
    .addItemInputs([
        <contenttweaker:superluminal_core> * 64,
    ])
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "novaeng_core:estorage_cell_item_256m", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "novaeng_core:estorage_cell_fluid_256m", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "novaeng_core:estorage_cell_gas_256m", Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addRecipeTooltip("§4星之力量的极致。")
    .addRecipeTooltip("§4请在一旁看着吧，我的科技...")
    .build();
//==================================寰宇变阶控制器==============================
//寰宇变阶_控制器
RecipeBuilder.newBuilder("surmount-uts_factory_controller", "workshop", 600)
    .addEnergyPerTickInput(300000000)
    .addInput(<avaritia:endest_pearl> * 180)
    .addInput(<moreplates:infinity_gear> * 90)
    .addInput(<modularmachinery:atomic_reconstructor_factory_controller> * 3)
    .addInput(<modularmachinery:starburst_reactor_controller> * 1)
    .addOutput(<modularmachinery:surmount-uts_factory_controller>)
    .requireComputationPoint(50.0F)
    .requireResearch("Surmount-UTS-001")
    .addRecipeTooltip("§6星河灿烂...")
    .build();

//无限星辉块   
RecipeBuilder.newBuilder("surmount_UTS_1", "Surmount-UTS", 10, recipeCounter, false)
    .addInput(<liquid:starmetal> * 1000)
    .addInput(<extendedae:infinity_cell>.withTag({r: {FluidName: "lava", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"})).setChance(0)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "jaopca:block_blockastralstarmetal", Damage: 0 as short, Req: 0 as long}, t: "i"}) * 1)
    .requireResearch("Surmount-UTS-001")
    .addRecipeTooltip("§5星辉不灭...")
    .build();
recipeCounter += 1;

//主世界
RecipeBuilder.newBuilder("surmount_UTS_2", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:water> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:log> * 64)
    .addInput(<minecraft:grass> * 64)
    .addInput(<minecraft:sapling> * 64)
    .addInput(<deepmoblearning:living_matter_overworldian> * 1280)
    .addOutput(<contenttweaker:overworld_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§2这片大地，我的家园...")
    .build();
recipeCounter += 1;

//下界
RecipeBuilder.newBuilder("surmount_UTS_3", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:lava> * 1000)
    .addInput(<contenttweaker:arkchip>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:glowstone_dust> * 64)
    .addInput(<minecraft:netherrack> * 64)
    .addInput(<minecraft:quartz> * 64)
    .addInput(<minecraft:skull:1> * 64)
    .addInput(<minecraft:nether_wart> * 64)
    .addInput(<minecraft:magma_cream> * 64)
    .addInput(<deepmoblearning:living_matter_hellish> * 1280)
    .addOutput(<contenttweaker:neb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§4火焰，烧吧...就这样，永远躁动下去...")
    .build();
recipeCounter += 1;

//末地
RecipeBuilder.newBuilder("surmount_UTS_4", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:enderium> * 1000)
    .addInput(<contenttweaker:arkchip>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:end_stone> * 64)
    .addInput(<minecraft:ender_pearl> * 64)
    .addInput(<minecraft:ender_eye> * 64)
    .addInput(<minecraft:end_rod> * 64)
    .addInput(<deepmoblearning:data_model_dragon>.withTag({tier: 4}) * 1)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 1280)
    .addInput(<minecraft:dragon_egg> * 1)
    .addOutput(<contenttweaker:edb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§e记得那片梦里的天域吗...")
    .build();
recipeCounter += 1;

//月球
RecipeBuilder.newBuilder("surmount_UTS_5", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:brine> * 100000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<advancedrocketry:moonturf> * 64)
    .addInput(<advancedrocketry:moonturf_dark> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 25600)
    .addOutput(<contenttweaker:moonb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§8我们如今想的是，如何把天文的力量紧握在自己手中...")
    .build();
recipeCounter += 1;

//水星
RecipeBuilder.newBuilder("surmount_UTS_6", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:iron> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:packed_ice> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 2560)
    .addOutput(<contenttweaker:meb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§8哇哦...你敢相信吗，它是冰做的？")
    .build();
recipeCounter += 1;

//火星
RecipeBuilder.newBuilder("surmount_UTS_7", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:carbon_dioxide> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<ic2:dust:13> * 64)
    .addInput(<advancedrocketry:hotturf> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 2560)
    .addOutput(<contenttweaker:mab_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§5才做到这里，你是火星时间？")
    .build();
recipeCounter += 1;

# 化工复合 氧化铁砂
RecipeBuilder.newBuilder("hotturf111", "chemical_complex", 30)
    .addEnergyPerTickInput(100000)
    .addInputs([
        <minecraft:iron_nugget> * 64,
        <minecraft:gravel> * 10
    ])
    .addInput(<liquid:oxygen> * 100)
    .addInput(<liquid:water> * 1000).setChance(0)
    .addOutputs([
        <advancedrocketry:hotturf> * 10,
    ])
    .build();

//金星
RecipeBuilder.newBuilder("surmount_UTS_8", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:carbon_dioxide> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<taiga:basalt_block> * 64)
    .addInput(<ic2:resource:4> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 2560)
    .addOutput(<contenttweaker:veb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§6别傻了喔！这儿可没多少金子！")
    .build();
recipeCounter += 1;

//冥王星
RecipeBuilder.newBuilder("surmount_UTS_9", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:nitrogen> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<biomesoplenty:hard_ice> * 64)
    .addInput(<minecraft:diamond_ore> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 2560)
    .addOutput(<contenttweaker:plb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§3我是相信的，这里还真有钻石！")
    .build();
recipeCounter += 1;

//硬化冰块
recipes.addShaped( 
    <biomesoplenty:hard_ice> * 8, // 输出物品
    [[<minecraft:gravel>, <minecraft:gravel>, <minecraft:gravel>],
    [<minecraft:gravel>, <minecraft:packed_ice>, <minecraft:gravel>],
    [<minecraft:gravel>, <minecraft:gravel>, <minecraft:gravel>]]
);

//谷神星
RecipeBuilder.newBuilder("surmount_UTS_10", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:oxygen> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<biomesoplenty:hard_ice> * 64)
    .addInput(<mekanism:saltblock> * 64)
    .addInput(<minecraft:stone> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 5120)
    .addOutput(<contenttweaker:ceb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§3平凡的星球，也许会得到一些意料之外的收获。")
    .build();
recipeCounter += 1;

//鸟神星
RecipeBuilder.newBuilder("surmount_UTS_11", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:hydrofluoric_acid> * 1000)
    .addInput(<liquid:fluoromethane> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<thermalfoundation:rockwool:7> * 64)
    .addInput(<mekanism:saltblock> * 64)
    .addInput(<biomesoplenty:hard_ice> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 5120)
    .addOutput(<contenttweaker:mmb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§6啊啦~它真神秘！")
    .build();
recipeCounter += 1;

//妊神星
RecipeBuilder.newBuilder("surmount_UTS_12", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:electrum> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<nuclearcraft:gem:6> * 64)
    .addInput(<minecraft:nether_star> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 5120)
    .addOutput(<contenttweaker:hab_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§8也许，我们还能走的更远。")
    .build();
recipeCounter += 1;

//奈佩里
RecipeBuilder.newBuilder("surmount_UTS_13", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:water> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<tconstruct:slime_grass> * 64)
    .addInput(<minecraft:stone> * 64)
    .addInput(<libvulpes:ore0> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 5120)
    .addOutput(<contenttweaker:npb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§2郁郁葱葱，胶胶黏黏？（）")
    .build();
recipeCounter += 1;

//阿努比斯
RecipeBuilder.newBuilder("surmount_UTS_14", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<environmentalmaterials:basalt> * 64)
    .addInput(<environmentaltech:aethium> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 10240)
    .addOutput(<contenttweaker:anb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§4荒凉，可不也是一种另类的天堂？")
    .build();
recipeCounter += 1;

//马赫斯
RecipeBuilder.newBuilder("surmount_UTS_15", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:magma_fluid> * 1000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<botania:petalblock:14> * 64)
    .addInput(<minecraft:redstone_ore> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 10240)
    .addOutput(<contenttweaker:mhb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§9有些正要死去的色彩，我已将它扶起。")
    .build();
recipeCounter += 1;

//荷鲁斯
RecipeBuilder.newBuilder("surmount_UTS_16", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:obsidian> * 100000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:obsidian> * 64)
    .addInput(<avaritia:block_resource> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 10240)
    .addOutput(<contenttweaker:hob_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§5神秘，奇幻之世界，宇宙顶端之重量。")
    .build();
recipeCounter += 1;

//赛特
RecipeBuilder.newBuilder("surmount_UTS_17", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<liquid:ice> * 100000)
    .addInput(<contenttweaker:planet_ff>)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:snow> * 64)
    .addInput(<futuremc:blue_ice> * 64)
    .addInput(<thermalfoundation:storage:6> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 10240)
    .addOutput(<contenttweaker:seb_block> * 1)
    .requireResearch("Surmount-UTS-002")
    .addRecipeTooltip("§1想与我一起堆个雪人吗？")
    .build();
recipeCounter += 1;

//暮色森林
RecipeBuilder.newBuilder("surmount_UTS_18", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:grass> * 12)
    .addInput(<minecraft:yellow_flower> * 12)
    .addInput(<minecraft:water_bucket> * 2)
    .addInput(<minecraft:diamond> * 1)
    .addOutput(<contenttweaker:tfb_block> * 1)
    .requireResearch("Surmount-UTS-003")
    .addRecipeTooltip("§7好像做了个，名为§8暮色森林§7的梦...")
    .build();
recipeCounter += 1;

//漆黑世界
RecipeBuilder.newBuilder("surmount_UTS_19", "Surmount-UTS", 300, recipeCounter, false)
    .addInput(<liquid:starmetal> * 100000)
    .addInput(<botania:tinyplanetblock>)
    .addInput(<minecraft:concrete:15> * 64)
    .addInput(<mekanism:plasticblock> * 64)
    .addInput(<psi:psi_decorative:7> * 64)
    .addInput(<minecraft:wool:15> * 64)
    .addInput(<botania:petalblock:15> * 64)
    .addInput(<minecraft:stained_glass:15> * 64)
    .addInput(<minecraft:stained_hardened_clay:15> * 64)
    .addInput(<thermalfoundation:rockwool> * 64)
    .addInput(<deepmoblearning:living_matter_extraterrestrial> * 64000)
    .addOutput(<contenttweaker:ddb_block> * 1)
    .requireResearch("Surmount-UTS-004")
    .addRecipeTooltip("§0别怕，不过是...沉于永久黑暗中的世界。")
    .build();
recipeCounter += 1;


//刷怪笼
recipes.addShaped(<minecraft:mob_spawner>, [
    [<minecraft:iron_nugget>, <minecraft:iron_bars>, <minecraft:iron_nugget>],
    [<minecraft:iron_bars>, <minecraft:iron_nugget>, <minecraft:iron_bars>],
    [<minecraft:iron_nugget>, <minecraft:iron_bars>, <minecraft:iron_nugget>]
]);

//凋零骷髅刷怪蛋
recipes.addShaped(<minecraft:spawn_egg>.withTag({EntityTag: {id: "minecraft:wither_skeleton"}}), [
    [<minecraft:coal>, <minecraft:bone>, <minecraft:coal>],
    [<minecraft:bone>, <minecraft:egg>, <minecraft:bone>],
    [<minecraft:coal>, <minecraft:bone>, <minecraft:coal>]
]);

//压缩超光速核心
RecipeBuilder.newBuilder("surmount_UTS_ssss", "Surmount-UTS", 10, recipeCounter, false)
    .addInput(<contenttweaker:superluminal_core> * 10000)
    .addOutput(<contenttweaker:sssssscore> * 1)
    .addRecipeTooltip("§4没错...就是那颗究极之星！")
    .addRecipeTooltip("§4“将一切上升者尽数聚合，我已死守前进的风口。”")
    .addRecipeTooltip("§4嗯————我将来了。")
    .build();
recipeCounter += 1;

//October534897玩偶
RecipeBuilder.newBuilder("surmount_UTS_oct", "Surmount-UTS", 1000, recipeCounter, false)
    .addInput(<contenttweaker:sssssscore>)
    .addInput(<modularmachinery:surmount-ae_factory_controller>)
    .addInput(<modularmachinery:starmagn-pro_factory_controller>)
    .addInput(<modularmachinery:surmount-uts_factory_controller>)
    .addInput(<modularmachinery:wallcreation_factory_controller>)
    .addInput(<modularmachinery:light-speed_material_accelerator_factory_controller>)
    .addInput(<contenttweaker:overworld_block>)
    .addInput(<contenttweaker:neb_block>)
    .addInput(<contenttweaker:edb_block>)
    .addInput(<contenttweaker:moonb_block>)
    .addInput(<contenttweaker:meb_block>)
    .addInput(<contenttweaker:mab_block>)
    .addInput(<contenttweaker:veb_block>)
    .addInput(<contenttweaker:plb_block>)
    .addInput(<contenttweaker:ceb_block>)
    .addInput(<contenttweaker:mmb_block>)
    .addInput(<contenttweaker:hab_block>)
    .addInput(<contenttweaker:npb_block>)
    .addInput(<contenttweaker:anb_block>)
    .addInput(<contenttweaker:mhb_block>)
    .addInput(<contenttweaker:hob_block>)
    .addInput(<contenttweaker:seb_block>)
    .addInput(<contenttweaker:ddb_block>)
    .addOutput(<contenttweaker:octoberdoll> * 1)
    .addRecipeTooltip("#00ffd8-0097ea-001dff水金地火木土天海")
    .addRecipeTooltip("#00ffd8-0097ea-001dff浩瀚宇宙星辰万千！")
    .addRecipeTooltip(" ")
    .addRecipeTooltip("#b9702c-eaa000-ff002b嗯，好，我赐你力量。")
    .build();
recipeCounter += 1;


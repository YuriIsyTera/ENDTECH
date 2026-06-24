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

MachineModifier.setMaxThreads("irisx_00147",0);
MachineModifier.setMaxThreads("irisx_00147_mode1",0);
MachineModifier.setMaxThreads("irisx_00147_mode2",0);
MachineModifier.addCoreThread("irisx_00147", FactoryRecipeThread.createCoreThread("堆芯升级"));
for i in 1 to 15{
        MachineModifier.addCoreThread("irisx_00147", FactoryRecipeThread.createCoreThread("熔炼环带" + i));
}
for i in 1 to 15{
        MachineModifier.addCoreThread("irisx_00147_mode1", FactoryRecipeThread.createCoreThread("熔炼环带" + i));
}
for i in 1 to 15{
        MachineModifier.addCoreThread("irisx_00147_mode2", FactoryRecipeThread.createCoreThread("熔炼环带" + i));
}
MMEvents.onStructureFormed("irisx_00147" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    val world = ctrl.world;
    val pos = ctrl.pos;
    val ifacing = ctrl.facing;
    val imode1pos = ctrl.pos.createPosByFacing(ctrl.facing,-7,0,7);
    val imode2pos = ctrl.pos.createPosByFacing(ctrl.facing,7,0,7);
    val mode1_controller = MachineController.getControllerAt(world,imode1pos);
    val mode2_controller = MachineController.getControllerAt(world,imode2pos);
    val mode1data = mode1_controller.customData;
    val mode2data = mode2_controller.customData;
    val map1 = mode1data.asMap();
    val map2 = mode2data.asMap();
    map["is_formed"]=1;
    map1["is_formed"]=1;
    map2["is_formed"]=1;
    mode1_controller.customData = mode1data;
    mode2_controller.customData = mode2data;
    ctrl.customData = data;
});
RecipeBuilder.newBuilder("level_up_iris00147","irisx_00147",10,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
   val ctrl = event.controller;
   val data = ctrl.customData;
   val bx = data.getInt("bx",0);
   event.activeRecipe.maxParallelism = 32;
   event.activeRecipe.parallelism = 32;
   if(bx >= 2000000000){
      event.setFailed("你怎么做到的?");
   }
 })
 .addEnergyPerTickInput(10000000)
 .addFluidInputs([
    <liquid:plasma>*10000,
 ])
 .addInputs([
    <contenttweaker:neutronchip>,
    <contenttweaker:neutrondustingot>*8,
    <contenttweaker:energized_fuel_v4>
 ])
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var bx = data.getLong("bx",512);
    if(bx + 100 > 2000000000){
      map["bx"]=2000000000;
    }
    var bxcount = event.activeRecipe.parallelism;
    var temp = bxcount*100;
    bx+=temp;
    map["bx"]=bx;
    ctrl.customData = data;
 })
 .addRecipeTooltip("永久升级熔炼堆芯的等级")
 .addRecipeTooltip("每完成一次升级,并行数增加100")
 .addRecipeTooltip("上限为20亿")
 .addRecipeTooltip("该配方并行上限为32")
 .setThreadName("堆芯升级")
 .build();

function molten_recipe(input as IIngredient[],output as IIngredient,counter as int,name as string){
   RecipeBuilder.newBuilder("molten_casting_recipe"+name,"irisx_00147_mode2",20,counter)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
      val mode2_controller = event.controller;
      val mode2ifacing = mode2_controller.facing;
      val world = mode2_controller.world;
      val mainpos = mode2_controller.pos.createPosByFacing(mode2ifacing,-7,0,7);
      val main_controller = MachineController.getControllerAt(world,mainpos);
      val main_data = main_controller.customData;
      val bx = main_data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
   .addEnergyPerTickInput(10)
   .addInputs(input)
   .addOutputs(output)
   .addRecipeTooltip("执行高温合金熔铸枢纽的配方")
   .addRecipeTooltip("初始为512并行")
   .build();
}
function furnace_recipe(input as IIngredient[],output as IIngredient,counter as int,name as string){
   RecipeBuilder.newBuilder("furnance_recipe"+name,"irisx_00147_mode1",20,counter)
   .addPreCheckHandler(function(event as RecipeEvent){
      val mode1_controller = event.controller;
      val mode1ifacing = mode1_controller.facing;
      val world = mode1_controller.world;
      val mainpos = mode1_controller.pos.createPosByFacing(mode1ifacing,7,0,7);
      val main_controller = MachineController.getControllerAt(world,mainpos);
      val main_data = main_controller.customData;
      val bx = main_data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
   .addEnergyPerTickInput(10)
   .addInputs(input)
   .addOutputs(output)
   .addRecipeTooltip("执行合金炉的配方")
   .addRecipeTooltip("初始为512并行")
   .build();
}
function unique_recipe(input as IIngredient[],output as IIngredient,counter as int,name as string){
      RecipeBuilder.newBuilder("unique_recipe"+name,"irisx_00147",20,counter)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val bx = data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
   .addEnergyPerTickInput(10)
   .addInputs(input)
   .addOutputs(output).setTag("main")
   .addRecipeTooltip("合成特殊合金")
   .addRecipeTooltip("初始为512并行")
   .build();
}

function unique_recipe_with_research(input as IIngredient[],output as IIngredient,counter as int,research_name as string,require_cp as int){
   RecipeBuilder.newBuilder("unique_recipe"+counter,"irisx_00147",20,counter)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
      val ctrl = event.controller;
      val data = ctrl.customData;
      val bx = data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
   .addEnergyPerTickInput(10)
   .addInputs(input)
   .addOutputs(output).setTag("main")
   .addRecipeTooltip("合成特殊合金")
   .addRecipeTooltip("初始为512并行")
   .addRecipeTooltip("在右仓室执行配方")
   .requireResearch(research_name)
   .requireComputationPoint(require_cp)
   .build();
}
var counter = 2;
molten_recipe([<taiga:eezo_ingot> * 2,<taiga:abyssum_ingot> * 2,<taiga:osram_ingot> * 2,<taiga:obsidiorite_ingot> * 9],<taiga:iox_ingot>,counter,"lijin");counter += 1;//离金锭
molten_recipe([<taiga:eezo_ingot> * 4,<taiga:abyssum_ingot> * 4,<taiga:osram_ingot> * 4,<ore:obsidian> * 9,<taiga:meteorite_ingot> * 18],<taiga:iox_ingot>,counter,"lijin");counter += 1;//离金锭
molten_recipe([<taiga:prometheum_ingot> * 3, <taiga:palladium_ingot> * 3,<taiga:eezo_ingot>], <taiga:proxii_ingot> * 3, counter,"proxiiingot"); counter += 1; // 普罗克希锭
molten_recipe([<taiga:terrax_ingot> * 3, <taiga:aurorium_ingot> * 2], <taiga:astrium_ingot> * 2,  counter,"astriumingot"); counter += 1; // 曜金锭
molten_recipe([<taiga:proxii_ingot> * 3, <taiga:abyssum_ingot>, <taiga:osram_ingot>], <taiga:nucleum_ingot> * 3, counter,"nucleumingot"); counter += 1; // 辐光合金锭
molten_recipe([<taiga:imperomite_ingot> * 3, <taiga:osram_ingot>, <taiga:eezo_ingot>], <taiga:nucleum_ingot> * 3.0, counter,"nucleumingot"); counter += 1; // 辐光合金锭
molten_recipe([<taiga:niob_ingot> * 3, <taiga:eezo_ingot>, <taiga:abyssum_ingot>], <taiga:nucleum_ingot> * 3,  counter,"nucleumingot"); counter += 1; // 辐光合金锭
molten_recipe([<taiga:tiberium_ingot> * 5, <taiga:basalt_ingot>], <taiga:triberium_ingot>,  counter,"triberiumingot"); counter += 1; // 泰伯利安
molten_recipe([<taiga:tiberium_ingot> * 5, <taiga:dilithium_ingot> * 2], <taiga:triberium_ingot>,  counter,"triberiumingotx"); counter += 1; // 泰伯利安
molten_recipe([<tconstruct:ingots:1> * 2, <taiga:terrax_ingot> * 2, <taiga:osram_ingot>], <taiga:ignitz_ingot> * 2,  counter,"ignitzingot"); counter += 1; // 焰晶锭
molten_recipe([<taiga:karmesine_ingot>, <taiga:ovium_ingot>, <taiga:jauxum_ingot>], <taiga:terrax_ingot> * 2,  counter,"terraxingot"); counter += 1; // 地母锭
molten_recipe([<taiga:duranite_ingot> * 3, <taiga:prometheum_ingot>, <taiga:abyssum_ingot>], <taiga:imperomite_ingot> * 2,  counter,"imperomiteingot"); counter += 1; // 帝金锭
molten_recipe([<taiga:iox_ingot> * 3, <taiga:solarium_ingot>, <taiga:vibranium_ingot>], <taiga:adamant_ingot> * 3,  counter,"adamantingot"); counter += 1; // 铿金锭
molten_recipe([<taiga:iox_ingot> * 3, <taiga:nihilite_ingot> * 2], <taiga:adamant_ingot> * 3,  counter,"adamantingot"); counter += 1; // 铿金锭
molten_recipe([<taiga:palladium_ingot>, <taiga:terrax_ingot>], <taiga:lumix_ingot>,  counter,"lumixingot"); counter += 1; // 流光合金锭
molten_recipe([<taiga:palladium_ingot> * 3, <taiga:duranite_ingot>, <taiga:osram_ingot>], <taiga:niob_ingot> * 3,  counter,"niobingot"); counter += 1; // 铌锭
molten_recipe([<taiga:triberium_ingot> * 6, <ore:obsidian> * 3, <taiga:abyssum_ingot> * 2], <taiga:fractum_ingot> * 4,  counter,"fractumingot"); counter += 1; // 碎金锭
molten_recipe([<taiga:valyrium_ingot> * 2, <taiga:uru_ingot> * 2, <taiga:nucleum_ingot> * 1], <taiga:solarium_ingot> * 2,  counter,"solariumingot"); counter += 1; // 阳光合金锭
molten_recipe([<tconstruct:ingots> * 3, <taiga:terrax_ingot> * 2], <taiga:tritonite_ingot> * 2,  counter,"tritoniteingot"); counter += 1; // 漩金锭
molten_recipe([<taiga:triberium_ingot> * 3, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  counter,"dyoniteingot"); counter += 1; // 烈金锭
molten_recipe([<taiga:tiberium_ingot> * 12, <taiga:fractum_ingot>, <taiga:seismum_ingot>, <taiga:osram_ingot>], <taiga:dyonite_ingot> * 3,  counter,"dyoniteingotx"); counter += 1; // 烈金锭
molten_recipe([<ore:obsidian> * 2, <taiga:triberium_ingot> * 2, <taiga:eezo_ingot>], <taiga:seismum_ingot> * 4,  counter,"seismumingot"); counter += 1; // 地动合金锭
molten_recipe([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:osram_ingot>], <taiga:yrdeen_ingot> * 3,  counter,"yrdeeningot"); counter += 1; // 原金锭
molten_recipe([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:eezo_ingot>], <taiga:yrdeen_ingot> * 3,  counter,"yrdeeningot"); counter += 1; // 原金锭
molten_recipe([<taiga:uru_ingot> * 3, <taiga:valyrium_ingot> * 3, <taiga:abyssum_ingot>], <taiga:yrdeen_ingot> * 3,  counter,"yrdeeningot"); counter += 1; // 原金锭
molten_recipe([<taiga:aurorium_ingot> * 3, <tconstruct:ingots:1> * 2], <taiga:violium_ingot> * 2,  counter,"violiumingot"); counter += 1; // 瑟蓝锭
molten_recipe([<taiga:vibranium_ingot>, <taiga:solarium_ingot>,<minecraft:diamond>], <taiga:nihilite_ingot>*2,  counter,"nihiliteingot"); counter += 1; // 虚金
molten_recipe([<tconevo:material>, <liquid:ic2uu_matter> * 72], <tconevo:metal:40>,  counter,"uumetal"); counter += 1; // UU金属
molten_recipe([<tconevo:material> * 16, <ic2:dust:6> * 48], <tconevo:metal:35> * 16,  counter,"energiumingot"); counter += 1; // 能量锭
molten_recipe([<ore:ingotManasteel> * 2,<ore:ingotDraconium> * 2,<ore:ingotCrystallineAlloy> * 6,<ore:ingotOsmium>,<ore:ingotGold>,<ore:ingotIron>,<ore:ingotCopper>,<ore:ingotTin>], <contenttweaker:universalalloyt1> * 2,  counter,"universalalloyt1"); counter += 1; // 基础通用合金
molten_recipe([<ore:ingotAlloyT1>,<ore:ingotCrystallineAlloy> * 8,<thermalfoundation:material:134> * 12],<additions:novaextended-blue_alloy_ingot> * 6,  counter,"bluealloyingot"); counter += 1; // 蓝晶合金
molten_recipe([<ore:ingotTinSilver> * 4,<ore:dustRedstone> * 8,<ore:ingotBoron> * 2],<modularmachinery:itemmodularium> * 6,  counter,"modularium"); counter += 1; // 模块化合金
molten_recipe([<ore:dustCoal>,<ore:dustFluix>,<ore:ingotIron>],<threng:material>,  counter,"fluixsteel"); counter += 1;//福鲁伊克斯钢
molten_recipe([<tconevo:material>,<draconicevolution:wyvern_core>,<ore:blockRedstone>,<ore:gemDiamond>*2],<tconevo:metal>,counter,"dracosmium");counter += 1;
molten_recipe([<tconevo:material>,<draconicevolution:awakened_core>,<draconicevolution:wyvern_energy_core>,<minecraft:nether_star>*2],<tconevo:metal:5>,counter,"awakeneddracosmium");counter += 1;
molten_recipe([<tconevo:material>,<ore:ingotOrichalcos>,<ore:ingotTerrasteel>],<additions:novaextended-terraalloy>,counter,"terraalloy");counter += 1;
molten_recipe([<additions:novaextended-terraalloy>,<additions:novaextended-blue_alloy_ingot>,<additions:novaextended-psi_alloy>,<draconicevolution:chaos_shard:1>*2,<appliedenergistics2:material:45>*4],<additions:novaextended-fallen_star_alloy>,counter,"fallenstaralloy");counter += 1;
molten_recipe([<tconevo:material>,<draconicevolution:chaotic_core>,<draconicevolution:draconic_energy_core>,<minecraft:dragon_egg>*2],<tconevo:metal:10>,counter,"chaoticdracosmium");counter += 1;
molten_recipe([<draconicevolution:draconium_block> * 4,<draconicevolution:dragon_heart>,<draconicevolution:draconic_core>*6,<liquid:liquid_energy>*2],<draconicevolution:draconic_block>*4,counter,"draconicblock");counter += 1;
molten_recipe([<mets:titanium_ingot>,<psi:material:3>*4,<psi:material:4>,<contenttweaker:universalalloyt1>,<contenttweaker:degenerationmatter>*4,<contenttweaker:skydust>*16],<contenttweaker:gama_tialalloy>,counter,"gamatitalalloy");counter +=1;
unique_recipe([<avaritia:resource:4>*16,<contenttweaker:dust>*64,<contenttweaker:gama_tialalloy>*8,<contenttweaker:degenerationmatter>*256],<contenttweaker:neutrondustingot>,counter,"neutrondustingot");counter +=1;
unique_recipe([<avaritia:resource:6>,<minecraft:nether_star>*100,<extendedcrafting:material>*768,<contenttweaker:degenerationmatter>*968,<avaritia:resource:4>*16],<contenttweaker:spacematrix_ingot>,counter,"spacematrixingot");counter+=1;
unique_recipe([<additions:novaextended-star_ingot>*78,<contenttweaker:spacematrix_ingot>*64,<contenttweaker:nanoswarm>*16,<contenttweaker:mana_crystal_3>*128],<contenttweaker:octingot>,counter,"octingot");counter+=1;
// unique_recipe([<ore:ingotAlloyT1> * 4,<ore:ingotSignalum>,<ore:ingotLumium>,<ore:ingotEnderium>,<ore:ingotWillowalloy>,<ore:ingotPsiAlloy>,<ore:ingotNetherite>,<ore:ingotStellarAlloy>,<ore:ingotUUMatter>,<ore:ingotEnergium>,<additions:novaextended-blue_alloy_ingot>],<contenttweaker:universalalloyt2>,counter);
unique_recipe([<psi:material:1>,<minecraft:coal>*8],<psi:material:3>,counter,"psiblack");counter+=1;
unique_recipe([<psi:material:1>,<minecraft:quartz>*8],<psi:material:4>,counter,"psidust");counter+=1;
molten_recipe([<botania:manaresource>,<botania:manaresource:1>,<botania:manaresource:2>,<liquid:fluidedmana>*500],<botania:manaresource:4>,counter,"terrasteel");counter+=1;
unique_recipe([<contenttweaker:carbon_nanotube>*96,<ic2:crafting:3>*128,<mets:niobium_titanium_ingot>,<gravisuite:crafting:1>*108,<mets:superconducting_cable>*54],<contenttweaker:superconidiosome>,counter,"superconidiosome");counter+=1;
unique_recipe([<tconevo:metal:13>,<contenttweaker:cfcm>*128,<contenttweaker:nanoswarm>],<contenttweaker:nanoglassmetal>,counter,"nanoglassmetal");counter+=1;
unique_recipe([<contenttweaker:neutrondustingot>*16,<contenttweaker:spacematrix_ingot>*16,<contenttweaker:crystalred>*32,<contenttweaker:crystalpurple>*32,<contenttweaker:crystalgreen>*32],<contenttweaker:planetoflight>,counter,"planetoflight");counter+=1;
unique_recipe([<thermalfoundation:material:128>*4,<thermalfoundation:material:129>*4,<minecraft:iron_ingot>*4,<contenttweaker:skydust>*8,<contenttweaker:degenerationmatter>*4],<contenttweaker:tci>,counter,"tci");counter+=1;
RecipeAdapterBuilder.create("irisx_00147_mode1", "nuclearcraft:alloy_furnace")
    .addModifier(RecipeModifierBuilder.create("modularmachinery:duration", "input", 0.025, 1, false).build())
    .addModifier(RecipeModifierBuilder.create("modularmachinery:energy",   "input", 2.0f, 1, false).build())
   .addPreCheckHandler(function(event as RecipeEvent){
      val mode1_controller = event.controller;
      val mode1ifacing = mode1_controller.facing;
      val world = mode1_controller.world;
      val mainpos = mode1_controller.pos.createPosByFacing(mode1ifacing,7,0,7);
      val main_controller = MachineController.getControllerAt(world,mainpos);
      val main_data = main_controller.customData;
      val bx = main_data.getLong("bx",512);
      event.activeRecipe.maxParallelism = bx;
   })
.build();
// furnace_recipe([<nuclearcraft:ingot:8>*2,<minecraft:diamond>],<nuclearcraft:alloy:2>*2,counter,"hardcarbon");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>,<thermalfoundation:material:768>,<minecraft:obsidian>],<enderio:item_alloy_ingot:6>,counter,"darksteel");counter+=1;
// furnace_recipe([<enderio:item_alloy_ingot:6>,<nuclearcraft:compound:9>*2],<enderio:item_alloy_ingot:8>,counter,"enderingot");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>,<minecraft:coal>*4],<thermalfoundation:material:160>,counter,"steel");counter+=1;
// furnace_recipe([<nuclearcraft:alloy:8>*4,<minecraft:redstone>*8,<nuclearcraft:ingot:5>*2],<modularmachinery:itemmodularium>*6,counter,"modulariron");counter+=1;
// furnace_recipe([<nuclearcraft:alloy:6>,<nuclearcraft:ingot:6>],<nuclearcraft:alloy:1>*2,counter,"ferroboron");counter+=1;
// furnace_recipe([<nuclearcraft:ingot:7>,<nuclearcraft:ingot:5>*2],<nuclearcraft:alloy:3>*3,counter,"erpenghuamei");counter+=1;
// furnace_recipe([<nuclearcraft:ingot:15>,<nuclearcraft:ingot:6>],<nuclearcraft:alloy:4>*2,counter,"lieryanghuameng");counter+=1;
// furnace_recipe([<thermalfoundation:material:131>*2,<minecraft:iron_ingot>],<enderio:item_alloy_ingot:9>*3,counter,"tiehejinding");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>,<taiga:obsidiorite_ingot>],<extendedcrafting:material>,counter,"heitieding");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>*2,<thermalfoundation:material:133>],<thermalfoundation:material:162>,counter,"yingangding");counter+=1;
// furnace_recipe([<thermalfoundation:material:160>,<nuclearcraft:gem:6>],<enderio:item_alloy_ingot>,counter,"cigangding");counter+=1;
// furnace_recipe([<thermalfoundation:material:160>,<appliedenergistics2:material:5>],<enderio:item_alloy_ingot>,counter,"cigangdingii");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>,<minecraft:redstone>],<enderio:item_alloy_ingot:4>,counter,"daodiantieding");counter+=1;
// furnace_recipe([<minecraft:iron_ingot>,<minecraft:ender_pearl>],<enderio:item_alloy_ingot:5>,counter,"chongnengtieding");counter+=1;
// furnace_recipe([<extendedcrafting:material:48>,<deepmoblearning:pristine_matter_enderman>],<enderutilities:enderpart:2>,counter,"moyinghejingaoji");counter+=1;
// furnace_recipe([<enderio:item_alloy_ingot:2>,<enderio:item_material:36>],<enderutilities:enderpart>,counter,"moyinghejinjichu");counter+=1;
// furnace_recipe([<enderio:item_alloy_ingot:1>,<minecraft:ender_pearl>],<enderio:item_alloy_ingot:2>,counter,"maichonghejinding");counter+=1;
// furnace_recipe([<enderio:item_alloy_ingot:8>,<minecraft:chorus_fruit_popped>],<enderio:item_alloy_endergy_ingot:2>,counter,"xuanlvhejinding");counter+=1;
// furnace_recipe([<minecraft:redstone>,<appliedenergistics2:material:5>],<enderio:item_alloy_ingot:3>,counter,"hongshihejinding");counter+=1;
// furnace_recipe([<minecraft:redstone>,<nuclearcraft:gem:6>],<enderio:item_alloy_ingot:3>,counter,"hongshihejindingii");counter+=1;
// furnace_recipe([<minecraft:gold_ingot>,<enderio:item_material:36>],<enderio:item_alloy_endergy_ingot:1>,counter,"jinghuahejinding");counter+=1;
// furnace_recipe([<nuclearcraft:alloy:1>,<nuclearcraft:alloy:2>],<nuclearcraft:alloy:10>,counter,"jixianhejinding");counter+=1;
// furnace_recipe([<nuclearcraft:alloy:10>,<nuclearcraft:gem:5>],<nuclearcraft:alloy:11>*2,counter,"daorehejinding");counter+=1;
furnace_recipe([<deepmoblearning:glitch_fragment>*8,<minecraft:gold_ingot>*8,<minecraft:dye:4>*8],<deepmoblearning:glitch_infused_ingot>*8,counter,"guzhangguanzhuding");counter+=1;
furnace_recipe([<minecraft:diamond>,<minecraft:iron_ingot>*8,<minecraft:dye:4>],<extendedcrafting:material:24>,counter,"jingsuding");counter+=1;
// furnace_recipe([<tconstruct:ingots>,<tconstruct:ingots:1>],<tconstruct:ingots:2>,counter,"mayulingding");counter+=1;
// furnace_recipe([<minecraft:gold_ingot>,<thermalfoundation:material:130>],<thermalfoundation:material:161>*2,counter,"hupojinding");counter+=1;
// furnace_recipe([<minecraft:gold_ingot>,<nuclearcraft:compound:2>*2],<enderio:item_alloy_ingot:1>,counter,"darksteelii");counter+=1;
// furnace_recipe([<minecraft:gold_ingot>,<minecraft:soul_sand>],<enderio:item_alloy_ingot:7>,counter,"hunjinding");counter+=1;
// furnace_recipe([<minecraft:glowstone_dust>,<minecraft:clay_ball>],<enderio:item_material:76>*2,counter,"niantuyingshifen");counter+=1;
// furnace_recipe([<tconstruct:ingots:2>,<minecraft:glowstone_dust>*2,<minecraft:redstone>*2,<minecraft:slime_ball>],<tconevo:material>,counter,"juhejuzhen");counter+=1;
// furnace_recipe([<enderio:item_alloy_endergy_ingot:2>,<minecraft:nether_star>],<enderio:item_alloy_endergy_ingot:3>*2,counter,"hengxinghejinding");counter+=1;
// furnace_recipe([<thermalfoundation:material:128>,<thermalfoundation:material:133>],<thermalfoundation:material:164>*2,counter,"kangtongding");counter+=1;
// furnace_recipe([<thermalfoundation:material:167>,<jaopca:item_dustwillowalloy>],<enderutilities:enderpart:1>,counter,"moyinghejinzengqiang");counter+=1;
// furnace_recipe([<thermalfoundation:material:128>*3,<thermalfoundation:material:129>],<thermalfoundation:material:163>*4,counter,"qingtongding");counter+=1;
// furnace_recipe([<thermalfoundation:material:130>,<nuclearcraft:compound:2>*2],<enderio:item_alloy_endergy_ingot:5>,counter,"chongnengyinding");counter+=1;
// furnace_recipe([<enderio:item_alloy_endergy_ingot:5>,<minecraft:ender_pearl>],<enderio:item_alloy_endergy_ingot:6>,counter,"shengdonghejinding");counter+=1;
// furnace_recipe([<enderutilities:enderpart:1>*2,<deepmoblearning:living_matter_extraterrestrial>],<extendedcrafting:material:36>,counter,"moyingding");counter+=1;
//<enderio:item_alloy_endergy_ingot:2>
MMEvents.onControllerGUIRender("irisx_00147",function(event as ControllerGUIRenderEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val bx = data.getLong("bx",512);
    var info as string[] = [];
    info += "§c/////§4IRISX-00147-FUSING-CORE§c/////";
    info += "§4当前熔炼并行§c:"+bx;
    event.extraInfo = info;
});



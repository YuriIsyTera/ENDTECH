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
import novaeng.NovaEngUtils;
import mods.modularmachinery.Sync;

RecipeBuilder.newBuilder("thor_blueprint_create","aerospacefactory",1000,1)
   .addEnergyPerTickInput(1000000000)
   .addInputs([
      <modularmachinery:different_world_factory_controller>,
      <modularmachinery:orichalcos_drill_factory_controller>,
      <novaeng_core:geocentric_drill_controller>,
     <contenttweaker:dust>*624,
     <contenttweaker:spacematrix_ingot>*48,
     <contenttweaker:nanoglassmetal>*8,
     <contenttweaker:industrial_circuit_v4>*16,
     <contenttweaker:robot_arm_v4>*128,
     <contenttweaker:sensor_v4>*96,
     <contenttweaker:cfcm>*256
   ])
   .addOutput(<contenttweaker:thor_blueprint>)
   .addRecipeTooltip("合成§c行星解构机§f的§b工程蓝图")
   .requireResearch("theory_destroyer")
   .setThreadName("工程蓝图结构")
   .requireComputationPoint(400000.0)
   .build();
   
RecipeBuilder.newBuilder("harc_blueprint_create","aerospacefactory",1000,1)
   .addEnergyPerTickInput(500000000)
   .addInputs([
      <modularmachinery:tokmak_reactor_controller>,
      <modularmachinery:mk2_factory_controller>,
    <contenttweaker:charging_crystal_block>*128,
    <contenttweaker:universalalloyt2>*256,
    <avaritia:resource:6>*4,
    <contenttweaker:robot_arm_v3>*48,
    <contenttweaker:industrial_circuit_v3>*32,
    <contenttweaker:cfcm>*64,
    <contenttweaker:sensor_v3>*16,
    <contenttweaker:electric_motor_v4>*18,

   ])
    .addOutput(<contenttweaker:harc_blueprint>)
   .addRecipeTooltip("合成§4热域行星反应堆§f的§b工程蓝图")
   .requireResearch("theory_hellplanet")
   .setThreadName("工程蓝图结构")
   .requireComputationPoint(100000.0)
   .build();

RecipeBuilder.newBuilder("perihelion_blueprint_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:spaceframefluid>*10000,
      <liquid:tachyonfluid>*10000,
      <liquid:t1000>*10000
   ])
   .addInputs([
      <avaritiaio:infinitecapacitor>*16,
      <contenttweaker:assemblycore>*256,
      <contenttweaker:spacetime_lens>*4,
      <contenttweaker:atomicclock>*64,
      <contenttweaker:tyf3>*36,
      <contenttweaker:antimatter_core>*16,

   ])
    .addOutput(<contenttweaker:perihelion_blueprint>)
   .addRecipeTooltip("合成§d环星§b阵列§f的§b工程蓝图")
   .requireResearch("theory_destroyer_ii")
   .setThreadName("工程蓝图结构")
   .requireComputationPoint(2000000.0)
   .build();

RecipeBuilder.newBuilder("zeropressure_blueprint_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:steady_ultra_dense_atomic_matter>*1000000
   ])
   .addInputs([
      <contenttweaker:wisecore>*2,
      <contenttweaker:atomicclock>*4,
      <contenttweaker:darkmatters>,
      <additions:novaextended-ark_circuit>*8,
      <contenttweaker:spacetimeframework>*18,
      <contenttweaker:assemblycore>*32,
      <contenttweaker:neutronchip>*8,
   ])
    .addOutput(<contenttweaker:zero_pressure_blueprint>)
   .addRecipeTooltip("合成§7基态§e零§a点§b压§7操纵机的§8工程蓝图 ")
   .requireResearch("theory_basic_zero_pressure")
   .setThreadName("工程蓝图结构")
   .requireComputationPoint(600000.0)
   .build();

RecipeBuilder.newBuilder("axis_blueprint_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:steady_ultra_dense_atomic_matter>*1000000,
      <liquid:bec>*100000,
   ])
   .addInputs([
    <contenttweaker:thor_blueprint>,
    <contenttweaker:harc_blueprint>,
    <contenttweaker:perihelion_blueprint>,
    <contenttweaker:zero_pressure_blueprint>,
    <contenttweaker:arkchip>*16,
    <contenttweaker:octingot>*128,
    <contenttweaker:nanites>*968,
   ])
    .addOutput(<contenttweaker:axis_blueprint>)
   .addRecipeTooltip("合成§9AXIS-逆轴线星门中枢节点的§8工程蓝图 ")
   .setThreadName("工程蓝图结构")
   .requireComputationPoint(5000000.0)
   .build();

RecipeBuilder.newBuilder("neutron_similar_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:neutronium>*10000000
   ])
   .addInputs([
      <avaritia:block_resource>*114514,
      <modularmachinery:neutron_accretion_plate_factory_controller>*32,
      <modularmachinery:neutron_accretion_plate_controller>*32,
      <contenttweaker:infinitychip>*4,
      <contenttweaker:neutronchip>*64,
      <draconicadditions:chaotic_energy_core>*128,
   ])
    .addOutput(<contenttweaker:neutron_similar_blueprint>)
   .addRecipeTooltip("合成§9中子星压吸积焦点的§b工程蓝图 ")
   .requireComputationPoint(200000.0)
   .setThreadName("工程蓝图结构")
   .build();

RecipeBuilder.newBuilder("spacestation_i_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(5000000)
   .addFluidInputs([
      <liquid:plasma>*1000000
   ])
   .addInputs([
      <modularmachinery:dyson_cloud_energy_receiver_controller>*16,
      <contenttweaker:kjcl>*128,
      <contenttweaker:kjzj>*64,
      <contenttweaker:sensor_v3>*76,
      <contenttweaker:robot_arm_v4>*32,

   ])
    .addOutput(<contenttweaker:spacestation_i_blueprint>)
   .addRecipeTooltip("合成§2探险者§b空间站的§b工程蓝图 ")
   .requireComputationPoint(100000.0)
   .setThreadName("工程蓝图结构")
   .build();

RecipeBuilder.newBuilder("spacestation_ii_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:steady_ultra_dense_atomic_matter>*1000000,
      <liquid:dimensionbeam>*100000,
   ])
   .addInputs([
      <modularmachinery:dyson_ball_management_center_factory_controller>*16,
      <contenttweaker:neutronchip>*8,
      <contenttweaker:geocentric_quartz_crystal_charged>*256,
      <contenttweaker:sensor_v4>*64,
      <contenttweaker:industrial_circuit_v4>*16,
      <contenttweaker:electric_motor_v4>*16,
      <contenttweaker:robot_arm_v5>*4,
      <contenttweaker:charging_crystal_block>*256
   ])
    .addOutput(<contenttweaker:spacestation_ii_blueprint>)
   .addRecipeTooltip("合成§b远视者§e空间站§f的§b工程蓝图 ")
   .requireComputationPoint(500000.0)
   .setThreadName("工程蓝图结构")
   .build();

   RecipeBuilder.newBuilder("collapse_generator_create","aerospacefactory",4000,1)
   .addEnergyPerTickInput(500000000)
   .addFluidInputs([
      <liquid:dimensionbeam>*100000,
   ])
   .addInputs([
      <modularmachinery:star_collapser_controller>,
      <contenttweaker:industrial_circuit_v4>*8,
      <contenttweaker:electric_motor_v5>*8,
      <contenttweaker:robot_arm_v4>*8,
      <contenttweaker:sensor_v4>*16,
      <contenttweaker:neutronchip>*8,
   ])
    .addOutput(<contenttweaker:collapse_blueprint>)
   .addRecipeTooltip("合成§8局部坍缩装置§f的§b工程蓝图 ")
   .requireComputationPoint(500000.0)
   .setThreadName("工程蓝图结构")
   .build();

 RecipeBuilder.newBuilder("space_elevator_blueprint","aerospacefactory",4000,1)
  .addEnergyPerTickInput(5000000000)
  .addInputs([
<contenttweaker:programming_circuit_0>,
<contenttweaker:nanoglassmetal> * 1024,
<contenttweaker:cfcm> * 1024,
<contenttweaker:nova_ingot> * 32,
<contenttweaker:dust> * 8192,
<contenttweaker:arkchip>
  ])
  .addOutput(<contenttweaker:se_blueprint>)
  .addRecipeTooltip("合成§b太空电梯§f的§9工程蓝图")
  .requireResearch("Mega-SpaceElevator-Stage2")
  .requireComputationPoint(10000000.0)
  .setThreadName("工程蓝图结构")
  .build();

 RecipeBuilder.newBuilder("sn_blueprint","aerospacefactory",4000,1)
  .addEnergyPerTickInput(5000000000)
  .addInputs([
<contenttweaker:programming_circuit_a>,
<contenttweaker:nanoglassmetal> * 1024,
<contenttweaker:cfcm> * 1024,
<contenttweaker:nova_ingot> * 32,
<contenttweaker:dust> * 8192,
<contenttweaker:arkchip>
  ])
  .addOutput(<contenttweaker:sn_blueprint>)
  .addRecipeTooltip("合成§5虚境§e观测站§f的§6工程蓝图")
  .requireResearch("Mega-ShroudNeedle")
  .requireComputationPoint(10000000.0)
  .setThreadName("工程蓝图结构")
  .build();

   RecipeBuilder.newBuilder("psm_blueprint","aerospacefactory",4000,1)
  .addEnergyPerTickInput(5000000000)
  .addInputs([
<contenttweaker:programming_circuit_b>,
<contenttweaker:nanoglassmetal> * 1024,
<contenttweaker:cfcm> * 1024,
<contenttweaker:nova_ingot> * 32,
<contenttweaker:dust> * 8192,
<contenttweaker:arkchip>
  ])
  .addOutput(<contenttweaker:psm_blueprint>)
  .addRecipeTooltip("合成§d灵能§e虹吸站c矩阵§f的§d工程蓝图")
  .requireResearch("Mega-ShroudChunckGenerator")
  .requireComputationPoint(10000000.0)
  .setThreadName("工程蓝图结构")
  .build();

RecipeBuilder.newBuilder("aal_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(5000000000)
 .addInputs([
   <contenttweaker:programming_circuit_c>,
<contenttweaker:nanoglassmetal> * 1024,
<contenttweaker:cfcm> * 1024,
<contenttweaker:arcance_ingot> * 64,
<contenttweaker:dust> * 8192,
<contenttweaker:arkchip>
 ])
 .addOutput(<contenttweaker:aal_blueprint>)
 .addRecipeTooltip("合成§d奥术§b装配线§f的§e工程蓝图")
 .requireResearch("Giga-ShroudAssemblyFactory")
 .requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();


RecipeBuilder.newBuilder("dfea_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(5000000000)
 .addInputs([
<contenttweaker:programming_circuit_d>,
<contenttweaker:nanoglassmetal> * 1024,
<contenttweaker:cfcm> * 1024,
<contenttweaker:arcance_ingot> * 64,
<contenttweaker:dust> * 8192,
<contenttweaker:arkchip> * 8
 ])
 .addOutput(<contenttweaker:dfea_blueprint>)
 .addRecipeTooltip("合成§1超维度§9激光蚀刻§e矩阵§f的§b工程蓝图")
 .requireResearch("Giga-DimensionFocusEngraving")
.requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();


RecipeBuilder.newBuilder("cosmiccasket_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(5000000000)
 .addInputs([
<contenttweaker:programming_circuit_e>,
<contenttweaker:hyperdimensional_blueprint>,
<contenttweaker:hyperdimensional_computer>,
<contenttweaker:cosmic_data> * 128
 ])
 .addOutput(<contenttweaker:cosmiccasket_blueprint>)
 .addRecipeTooltip("合成§7熵能§5奇点§e演算阵列§f的§3工程蓝图")
 .requireResearch("Giga-CosmicCasket")
.requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();

RecipeBuilder.newBuilder("timespacesingularity_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(5000000000)
 .addInputs([
<contenttweaker:programming_circuit_f>,
<contenttweaker:hyperdimensional_blueprint>,
<contenttweaker:hyperdimensional_computer>,
<contenttweaker:cosmic_data> * 128
 ])
 .addOutput(<contenttweaker:timespacesingularity_blueprint>)
 .addRecipeTooltip("合成§8时空§9奇点§e稳定器§f的§3工程蓝图")
 .requireResearch("Giga-TimeSpaceSingularity")
.requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();

RecipeBuilder.newBuilder("ceas_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(500000000)
 .addInputs([
   <contenttweaker:lockedhellplanet>*16,
   <contenttweaker:harc_blueprint>*2,
   <contenttweaker:charged_fuel_v5>*128,
   <contenttweaker:neutrondustingot>*256,
   <contenttweaker:superspace_star_controlmatrix>*4,
   <contenttweaker:degenerationmatter>*968,
   <contenttweaker:infinitychip>*4
 ])
 .addOutput(<contenttweaker:ceas_blueprint>)
 .addRecipeTooltip("合成§4C.E.A.S-§c余烬§0淬灭引擎§f的§4工程蓝图")
.requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();

RecipeBuilder.newBuilder("omhd_blueprint","aerospacefactory",4000,1)
 .addEnergyPerTickInput(500000000)
 .addInputs([
   <modularmachinery:huge_mixer_factory_controller>*64,
   <contenttweaker:nanoglassmetal>*128,
   <contenttweaker:voidmatter>*128,
   <contenttweaker:industrial_circuit_v4>*32,
   <contenttweaker:field_generator_v4>*16,
   <contenttweaker:infinitychip>*4
 ])
 .addOutput(<contenttweaker:omhd_blueprint>)
 .addRecipeTooltip("合成§bO.M.H.D-§9轨道§7磁流体§9动力系统§f的§b工程蓝图")
.requireComputationPoint(10000000.0)
   .setThreadName("工程蓝图结构")
  .build();
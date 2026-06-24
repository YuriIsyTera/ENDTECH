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
RecipeBuilder.newBuilder("invasion_device_controllerMAKE","atomicprocessequipx",1800)
    .addEnergyPerTickInput(400000000)
    .addItemInputs([
        <modularmachinery:atomic_reconstructor_factory_controller>,
        <contenttweaker:infinityplanet>,
        <contenttweaker:neutronchip>*8,
        <contenttweaker:voidmatter>*16,
        <contenttweaker:casmir_effect_seq>*4,
        <contenttweaker:spacetimeframework>*32,
        <contenttweaker:fieldofgravitycore>*32
    ])
    .addOutputs([
        <modularmachinery:invasion_device_factory_controller>
    ])
    .requireComputationPoint(10000.0)
    .build();
MachineModifier.setMaxThreads("invasion_device",0);
MachineModifier.addCoreThread("invasion_device",FactoryRecipeThread.createCoreThread("侵入演算"));
for i in 1 to 15{
        MachineModifier.addCoreThread("invasion_device", FactoryRecipeThread.createCoreThread("扩大化稳定装置" + i));
}
RecipeBuilder.newBuilder("invasion_device_start","invasion_device",1800,1)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_start = data.getInt("is_start",0);
    if(is_start == 1){
        event.setFailed("异界已打开");
    }
 })
 .addEnergyPerTickInput(1000000000)
 .addInputs([
    <contenttweaker:tearenginee>,
    <contenttweaker:darkmatters>*16,
    <additions:novaextended-crystal4>*8
 ])
 .addFluidPerTickInput(<liquid:dimensionbeam>*100)
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["is_start"]=1;
    ctrl.customData = data;
 })
 .addRecipeTooltip("利用§c撕裂引擎§f,对浸泡在§7时空束流§f中的§e异世界水晶§f进行异界隧道建模演算")
 .setThreadName("侵入演算")
 .build();
 RecipeBuilder.newBuilder("invasion_device_output","invasion_device",20,2)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_start = data.getInt("is_start",0);
    if(is_start == 0){
        event.setFailed("未检测到异界隧道");
    }else{
        event.activeRecipe.parallelism = 16;
        event.activeRecipe.maxParallelism = 16;
    }
  })
  .addFluidInputs([
    <liquid:ic2uu_matter>*10,
    <liquid:fluidedmana>*10
  ])
  .addEnergyPerTickInput(1000000)
  .addOutputs([
    <contenttweaker:crystalpurple>*32,
    <contenttweaker:crystalred>*32,
    <contenttweaker:crystalgreen>*32
  ])
  .addOutput(<additions:novaextended-crystal4>).setChance(0.6)
  .addRecipeTooltip("使用§duu物质§f与§b液态魔力§f维持异界隧道")
  .addRecipeTooltip("在§7时空束流§f浸泡下的§e异世界水晶§f与§duu物质§f发生了反应")
  .addRecipeTooltip("产出大量异端碎片")
  .addRecipeTooltip("该配方的并行上限为16")
  .build();
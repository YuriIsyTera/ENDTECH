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
MachineModifier.setMaxThreads("asteroidlockdevice",0);
MachineModifier.addCoreThread("asteroidlockdevice",FactoryRecipeThread.createCoreThread("链接器维护"));
MachineModifier.addCoreThread("asteroidlockdevice",FactoryRecipeThread.createCoreThread("轨道封锁"));
RecipeBuilder.newBuilder("asteroidlockdevice_factory_controllerMAKE","atomicprocessequipx",3600)
    .addEnergyPerTickInput(500000000)
    .addFluidInputs([
        <liquid:zerotempaturefluid>*100000,
        <liquid:superfluid_he>*100000,
        <liquid:dimensionbeam>*10000,
    ])
    .addItemInputs([
        <contenttweaker:atomicclock>*16,
        <contenttweaker:gama_tialcoil>*256,
        <contenttweaker:assemblycore>*14,
        <contenttweaker:superconidiosome>*64,
        <contenttweaker:neutronchip>,
        <contenttweaker:sensor_v4>*16,
        <contenttweaker:robot_arm_v4>*16,
        <contenttweaker:electric_motor_v4>*16,
        <contenttweaker:field_generator_v3>*16
    ])
    .addOutputs([
        <modularmachinery:asteroidlockdevice_factory_controller>
    ])
    .requireResearch("theory_locked_planet")
    .requireComputationPoint(20000.0)
    .build();
RecipeBuilder.newBuilder("ald_check_connect","asteroidlockdevice",100,1)
  .addInput(<contenttweaker:zbk>).setChance(0)
  .setNBTChecker(function(ctrl as IMachineController, item as IItemStack){
        val x = item.tag.getInt("x",0);
        val y = item.tag.getInt("y",0);
        val z = item.tag.getInt("z",0);
        val dim = item.tag.getInt("dim", 0);
        val data = ctrl.customData;
        data.asMap()["lx"] = x;
        data.asMap()["ly"] = y;
        data.asMap()["lz"] = z;
        data.asMap()["ldim"] = dim;
        ctrl.customData = data;
        return true;
    })
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        if(!world.remote){
            if(isNull(zsctrl)){
                event.setFailed("未找到通信中枢,区块可能被卸载");
                return ;
            }else{
                val controllerId = zsctrl.blockState.block.definition.id;
                if(isNull(controllerId)||controllerId != "modularmachinery:communication_center_factory_controller"){
                    event.setFailed("绑定控制器错误,请绑定中枢控制器");
                    return ;
                }else{
                    if(!zsctrl.isWorking){
                        event.setFailed("中枢未处于工作状态");
                        return ;
                    }
                }
            }
        }
    })
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        val ctrl=event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        map["active_admit"]=1;
        ctrl.customData = data;
    })
    .addRecipeTooltip("检查与近地通信中枢的链接")
    .addRecipeTooltip("链接§a稳定§f时可工作")
    .setThreadName("链接器维护")
    .build();
function asteroid_lock(t1 as IItemStack,t2 as IItemStack,time as int){
    RecipeBuilder.newBuilder("lock"+t1.name,"asteroidlockdevice",time,1)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        event.activeRecipe.maxParallelism = 4;
        event.activeRecipe.parallelism = 4;
        val ctrl = event.controller;
        val data = ctrl.customData;
        val mode = data.getInt("mode");
        val map = data.asMap();
        val lx = data.getInt("lx",0);
        val ly = data.getInt("ly",0);
        val lz = data.getInt("lz",0);
        val ldim = data.getInt("ldim",0);
        val world = IWorld.getFromID(ldim);
        val zsctrl = MachineController.getControllerAt(world,lx,ly,lz);
        val collectMatrix = zsctrl.customData.getInt("collectMatrix",0);
        val carryMatrix = zsctrl.customData.getInt("carryMatrix",0);
        val maintainMatrix = zsctrl.customData.getInt("maintainMatrix",0);
        val observeMatrix = zsctrl.customData.getInt("observeMatrix",0);
        val active_admit = data.getInt("active_admit",0);
        if(isNull(ctrl.recipeThreadList[0].activeRecipe)||active_admit == 0){
            event.setFailed("链接器离线");
        }
    })
    .addInputs([
        t1,
        <contenttweaker:constructunit>*128,
        <contenttweaker:forcecontainer>*16,
        <contenttweaker:kjcl>*24,
        <contenttweaker:kjzj>*16,
        <moreplates:infinity_plate>*4
    ])
    .addOutputs(t2)
    .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
        
    })
    .addRecipeTooltip("通过自动展开模组对§9行星§f进行§4全面轨道封锁")
    .addRecipeTooltip("需要§6T2采集阵列§f,§aT2运载阵列§f,§bT2维护阵列§f,§cT2观测阵列")
    .setThreadName("轨道封锁")
    .build();
}
asteroid_lock(<contenttweaker:normalplanet>,<contenttweaker:lockednormalplanet>,600);
asteroid_lock(<contenttweaker:hellplanet>,<contenttweaker:lockedhellplanet>,600);
asteroid_lock(<contenttweaker:enderplanet>,<contenttweaker:lockedenderplanet>,600);



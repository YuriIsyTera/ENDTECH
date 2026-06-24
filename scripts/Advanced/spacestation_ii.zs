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
MachineModifier.setMaxThreads("spacestation_ii",0);
MachineModifier.addCoreThread("spacestation_ii",FactoryRecipeThread.createCoreThread("地对空上行链路维护单元"));
MachineModifier.addCoreThread("spacestation_ii",FactoryRecipeThread.createCoreThread("链接器维护"));
MachineModifier.addCoreThread("spacestation_ii",FactoryRecipeThread.createCoreThread("巨构装配体"));

RecipeBuilder.newBuilder("maintainance_ii","spacestation_ii",100,1)
 .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["is_connect"]=1;
    map["spacestation_level"]=2;
    ctrl.customData = data;
 })
 .addEnergyPerTickInput(1000000000)
 .addInputs([
    <liquid:crystalloid>*10000
 ])
 .addRecipeTooltip("维系§9远航空间站§f与§a近地轨道§f的§e通信链路畅通")
 .setThreadName("地对空上行链路维护单元")
 .build();
//上行链路失效
RecipeBuilder.newBuilder("failed_ii","spacestation_ii",1,4)
 .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val is_connect = data.getInt("is_connect",0);
    if(is_connect == 0){
        event.setFailed("尚未建立上行链路");
    }
 })
 .addFactoryFinishHandler(function(event as FactoryRecipeFinishEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    map["is_connect"]=0;
    map["spacestation_level"]=0;
    ctrl.customData = data;
 })
 .addRecipeTooltip("当维护单元启动时需§e持续维护")
 .addRecipeTooltip("输入的维护材料不足时,空间站将§4丧失功能")
 .setThreadName("地对空上行链路维护单元")
 .build();
RecipeBuilder.newBuilder("communication_connection_ii","spacestation_ii",100,1)
  .addPreCheckHandler(function(event as RecipeCheckEvent){
    val ctrl = event.controller;
    if(isNull(ctrl.recipeThreadList[0].activeRecipe)){
        event.setFailed("上行链路维护失效");
    }
  })
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
                    if(!zsctrl.isWorking||zsctrl.customData.getInt("loftstormsite_online")==0){
                        event.setFailed("中枢未处于工作状态,或尚未连接至基座");
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
        val carrylevel = zsctrl.customData.getInt("carryMatrix",0);
        val maintainlevel = zsctrl.customData.getInt("maintainMatrix",0);
        val observelevel = zsctrl.customData.getInt("observeMatrix",0);
        val collectlevel = zsctrl.customData.getInt("collectMatrix",0);
        map["carrylevel"]=carrylevel;
        map["maintainlevel"]=maintainlevel;
        map["observelevel"]=observelevel;
        map["collectlevel"]=observelevel;
        ctrl.customData = data;
    })
    .addRecipeTooltip("检查与近地通信中枢的链接")
    .addRecipeTooltip("当中枢-基座系统链接稳定时,可执行深空巨构装配")
    .setThreadName("链接器维护")
    .build();



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
MachineModifier.setMaxThreads("ssps",0);
MachineModifier.addCoreThread("ssps",FactoryRecipeThread.createCoreThread("天基链路读取"));
MachineModifier.addCoreThread("ssps",FactoryRecipeThread.createCoreThread("微波能量转换阵列"));
MachineModifier.setMaxThreads("ssps_universesite",0);
MachineModifier.addCoreThread("ssps_universesite",FactoryRecipeThread.createCoreThread("太阳能接收阵列装配"));
//接收控制器
RecipeBuilder.newBuilder("ssps_controllerMAKE","workshop",1800)
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <modularmachinery:solar_panel_1_controller>*4,
    <contenttweaker:sensor_v3>*8,
    <super_solar_panels:crafting:31>*8,
    <mets:geomagnetic_antenna>*16,
    <contenttweaker:exponential_level_processor>*24,
    <appliedenergistics2:material:47>*32,
    <contenttweaker:stellar_alloy_wire>*8
 ])
 .addOutput(<modularmachinery:ssps_factory_controller>)
 .requireResearch("theory_ssps")
 .build();

//太阳能基站
RecipeBuilder.newBuilder("ssps_universesite_controllerMAKE","workshop",1800)
 .addEnergyPerTickInput(100000000)
 .addInputs([
    <contenttweaker:industrial_circuit_v2>*16,
    <additions:novaextended-fallen_star_alloy>*8,
    <contenttweaker:sensor_v3>*16,
    <ic2:crafting:3>*128,
    <actuallyadditions:block_furnace_solar>*32,
    <mekanismgenerators:solarpanel>*16
     ])
     .addOutput(<modularmachinery:ssps_universesite_factory_controller>)
     .requireResearch("theory_ssps")
     .build();

//终端合成
// 等级 1
RecipeBuilder.newBuilder("upgrade_1_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*4,
        <enderio:item_capacitor_stellar>*2,
        <appliedenergistics2:material:47>*1,
        <super_solar_panels:machines:1>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a1",
            ],
        },
        level: 1
    }))
    .addRecipeTooltip("装载1级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 2
RecipeBuilder.newBuilder("upgrade_2_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*8,
        <enderio:item_capacitor_stellar>*4,
        <appliedenergistics2:material:47>*2,
        <super_solar_panels:machines:2>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a2",
            ],
        },
        level: 2
    }))
    .addRecipeTooltip("装载2级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 3
RecipeBuilder.newBuilder("upgrade_3_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*16,
        <enderio:item_capacitor_stellar>*8,
        <appliedenergistics2:material:47>*4,
        <super_solar_panels:machines:3>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a3",
            ],
        },
        level: 3
    }))
    .addRecipeTooltip("装载3级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 4
RecipeBuilder.newBuilder("upgrade_4_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*32,
        <enderio:item_capacitor_stellar>*16,
        <appliedenergistics2:material:47>*8,
        <super_solar_panels:machines:4>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a4",
            ],
        },
        level: 4
    }))
    .addRecipeTooltip("装载4级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 5
RecipeBuilder.newBuilder("upgrade_5_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*64,
        <enderio:item_capacitor_stellar>*32,
        <appliedenergistics2:material:47>*16,
        <super_solar_panels:machines:5>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a5",
            ],
        },
        level: 5
    }))
    .addRecipeTooltip("装载5级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 6
RecipeBuilder.newBuilder("upgrade_6_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*128,
        <enderio:item_capacitor_stellar>*64,
        <appliedenergistics2:material:47>*32,
        <super_solar_panels:machines:6>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a6",
            ],
        },
        level: 6
    }))
    .addRecipeTooltip("装载6级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 7
RecipeBuilder.newBuilder("upgrade_7_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*256,
        <enderio:item_capacitor_stellar>*128,
        <appliedenergistics2:material:47>*64,
        <super_solar_panels:machines:7>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a7",
            ],
        },
        level: 7
    }))
    .addRecipeTooltip("装载7级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 8
RecipeBuilder.newBuilder("upgrade_8_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*512,
        <enderio:item_capacitor_stellar>*256,
        <appliedenergistics2:material:47>*128,
        <super_solar_panels:machines:8>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a8",
            ],
        },
        level: 8
    }))
    .addRecipeTooltip("装载8级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 9
RecipeBuilder.newBuilder("upgrade_9_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*1024,
        <enderio:item_capacitor_stellar>*512,
        <appliedenergistics2:material:47>*256,
        <super_solar_panels:machines:9>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a9",
            ],
        },
        level: 9
    }))
    .addRecipeTooltip("装载9级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

// 等级 10
RecipeBuilder.newBuilder("upgrade_10_ssps","ssps_universesite",100)
    .addPreCheckHandler(function(event as RecipeCheckEvent) {
        val ctrl = event.controller;
        val world = ctrl.world;
        if (!matchesSpaceStationDim(world)) {
            event.setFailed("只能在空间站维度工作！");
        }
    })
    .addEnergyPerTickInput(1000)
    .addInputs([
        <contenttweaker:carbon_nanotube>*2048,
        <enderio:item_capacitor_stellar>*1024,
        <appliedenergistics2:material:47>*512,
        <super_solar_panels:machines:11>*4
    ])
    .addOutput(<contenttweaker:ssps_terminal>.withTag({
        display: {
            Lore: [
                "§9太阳能阵列等级：§a10",
            ],
        },
        level: 10
    }))
    .addRecipeTooltip("装载10级太阳能阵列")
    .addRecipeTooltip("§c只能在空间站维度工作")
    .setThreadName("太阳能接收阵列装配")
    .build();

//输入卡
// 等级 1
RecipeBuilder.newBuilder("data_input_ssps_1","ssps",20)
    .addInput(<contenttweaker:ssps_terminal>)
    .setNBTChecker(function(ctrl as IMachineController, item as IItemStack) {
        val data = ctrl.customData;
        val level = item.tag.getInt("level", 0);
        val map = data.asMap();
        map["level"] = level;
        ctrl.customData = data;
        return true;
    })
    .addOutput(<contenttweaker:ssps_terminal>).addItemModifier(function(ctrl as IMachineController, item as IItemStack) {
        val data = ctrl.customData;
        val map = data.asMap();
        val level = data.getInt("level", 0);
        return item.withTag({
            display: {
                Lore: [
                    "§9太阳能阵列等级：§a" + level,
                ],
            },
            level: level
        });
    })
    .addRecipeTooltip("§9读取终端数据,链接太阳能基站")
    .addRecipeTooltip("§c链接后终端会被输出,保留相关等级")
    .setThreadName("天基链路读取")
    .build();
RecipeBuilder.newBuilder("energy_out_ssps","ssps",20)
    .addPostCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val level = data.getInt("level",0);
        if(level == 0){
            event.setFailed("没有找到相应的太阳能阵列");
        }
    })
    .addFactoryStartHandler(function(event as FactoryRecipeStartEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val map = data.asMap();
        val level = data.getInt("level",0);
        val thread = event.factoryRecipeThread;
        val prod = pow(2,level);
        thread.addModifier("energyMultiple", RecipeModifierBuilder.create("modularmachinery:energy", "output",prod, 1, false).build());
        thread.addModifier("itemMultiple", RecipeModifierBuilder.create("modularmachinery:item", "output",prod, 0, false).build());
    })
    .addEnergyPerTickOutput(2000000000)
    .addOutput(<contenttweaker:ljgz>*268)
    .setThreadName("微波能量转换阵列")
    .addRecipeTooltip("接收太阳能空间站转化的微波能量")
    .addRecipeTooltip("每提升§91§f级太阳能阵列等级,能量产出§ax2§f,物质产出加倍")
    .build();
function matchesSpaceStationDim(world as IWorld) as bool {
    return world.provider.dimensionID == -2;
}
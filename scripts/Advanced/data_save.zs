#loader crafttweaker reloadable

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.event.PlayerInteractBlockEvent;
import mods.modularmachinery.MachineController;
import mods.modularmachinery.IMachineController;
import novaeng.hypernet.Database;
import novaeng.hypernet.NetNodeCache;
import novaeng.hypernet.RegistryHyperNet;

<contenttweaker:small_upgrade_data>.addTooltip("§e用于保存数据库中的研究数据");
<contenttweaker:small_upgrade_data>.addTooltip("§e右键非空数据库§6读取§e数据，右键空数据库§6写入§e数据");
<contenttweaker:small_upgrade_data>.addTooltip("§4使用前请确保数据库为空,否则无法读入数据");
<contenttweaker:small_upgrade_data>.addTooltip("§2可在工作台合成以清除NBT");
events.onPlayerRightClickBlock(function(event as PlayerInteractBlockEvent) {
    val item = event.item;
    val block = event.block.data;
    if (!event.world.remote && !isNull(item) &&
        item.definition.id == "contenttweaker:small_upgrade_data" &&
        event.block.definition.id == "modularmachinery:database_t1_factory_controller") {
        var researchs = block.customData.storedResearchCognition;
        if (!isNull(item.tag.stored) && item.tag.stored == true) {
            var cacheResearchs = item.tag.customData.storedResearchCognition;
            if (researchs.length == 0) {
                researchs = cacheResearchs;
                item.mutable().withEmptyTag();
            } else {
                event.player.sendMessage("§c暂不支持转移研究数据到非空数据库！");
                return;
            }
            event.world.setBlockState(
                event.world.getBlockState(event.position),
                {customData: {storedResearchCognition: researchs}},
                event.position
            );
            val ctrl = MachineController.getControllerAt(event.world, event.position);
            val database = NetNodeCache.getDatabase(ctrl);
            database.readNBT();
            event.player.sendMessage("§a成功写入§e" + researchs.length + "§a条研究数据到数据库！");
            event.cancel();
        } else {
            item.mutable().updateTag({
                stored: true,
                display: {Lore: ["§a当前已存储§e" + researchs.length + "§a个研究数据"]},
                customData: {storedResearchCognition: researchs}
            });
            event.player.sendMessage("§a成功读取§e" + researchs.length + "§a条研究数据到数据卡！");
            event.cancel();
        }
    }
});
recipes.addShapeless("removedata", <contenttweaker:small_upgrade_data>, [<contenttweaker:small_upgrade_data>]);
recipes.addShaped(<contenttweaker:small_upgrade_data>, [
    [<thermalfoundation:material:352>, <thermalfoundation:material:352>, <thermalfoundation:material:352>],
    [<appliedenergistics2:material:24>, <appliedenergistics2:material:47>, <appliedenergistics2:material:24>],
    [<thermalfoundation:material:352>, <appliedenergistics2:material:37>, <thermalfoundation:material:352>]
]);
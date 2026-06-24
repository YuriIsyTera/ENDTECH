#loader crafttweaker
#sideonly client
#reloadable

import mods.jei.JEI;
import mods.zenutils.I18n;
import mods.zenutils.DataUpdateOperation.APPEND;

import crafttweaker.data.IData;
import crafttweaker.item.IItemStack;
import crafttweaker.event.ClientTickEvent;
import crafttweaker.event.PlayerLoggedInEvent;

import mods.modularmachinery.MachineModifier;

import native.java.util.Random;
// events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent){
//     val player = event.player;
//     val world = event.entity.world;
//     if(!isNull(player.data.PlayerPersisted)){
//         if(isNull(player.data.PlayerPersisted.gotguidebook)){
//             player.update({PlayerPersisted : {gotguidebook : false}});
//             player.sendMessage("成功识别员工" + player.name + "!");
//             player.sendMessage("您被分配到的世界名字为:"+ player.world.worldInfo.worldName +",id为:" + player.world.worldInfo.seed);
//             player.sendMessage("§b§o开拓，研究，创造，一次又一次地突破自身，在这颗庞大又未知的星球上不断寻找科技的真理，直至终点。——Hikari_Nova");
//         }else{
//             var list as int[] = [];
//             val length = sentences.length;
//             val random = Random();
//             val randomInt = random.nextInt(4) + 1;
//             for i in 0 to randomInt{
//                 var number = random.nextInt(length);
//                 if(!(list has number)){
//                     player.sendMessage(sentences[number]);
//                     list += number;
//                 }
//             }
//             player.sendMessage("§c真理之路无限而永恒，向前的开拓也永不会停止");
//             player.sendMessage("§c我们从不因伟大的成功而止步，更不为可怕的失败而顿足");
//             player.sendMessage("§c欢迎您在这场旅途迈出自己的一步！");
//             // player.sendMessage("§b感谢您为实验室做出的所有贡献，实验室将永远铭记您为科技发展所做出的一切努力！");
//         }
//     }
// });
events.onPlayerLoggedIn(function(event as PlayerLoggedInEvent){
    val player = event.player;
    val world = event.entity.world;
    if(!isNull(player.data.PlayerPersisted)){
        if(isNull(player.data.PlayerPersisted.isfirst)){
        player.update({PlayerPersisted:{ isfirst : false }});
        player.sendMessage("§9ENDTECH §bMODULE §eDETECTED!");
        player.sendMessage("§aINITIALIZED SETTINGS");
        player.sendMessage("§9SYSTEM-§bSAUVAL §ev1.3 §aONLINE");
        player.sendMessage("§9USER ID:§b"+player.name);
        player.sendMessage("§b系统启动,§e引导矩阵§b上线");
        player.sendMessage("§9项目代号:§4PROJECT-§cENDTECH");
        player.sendMessage("§9锚点世界:§e"+player.world.worldInfo.worldName);
        player.sendMessage("§aGET §2PROJECT INFORMATION §aSUCCESSFULLY!");
        player.sendMessage("§9欢迎您加入§4终末工程§9项目!");   
        }else{
            player.sendMessage("§aSTANDBY TERMINATED");
        player.sendMessage("§2MAIN MODULE §aONLINE");
        player.sendMessage("§9ALL HIERARCHICAL MODULES RESTORED");
        player.sendMessage("§9负责人ID:§b"+player.name+"§f,§e欢迎您回到项目工程当中!");
        }
    }
});
//CoT ZS By Hikari_Nova.
//ALL RIGHTS RESERVED
//在未经过原作者的允许下,你不能应用于任何服务器,以及任何更改。
//Under the permission of the author, you cannot be applied to any server, as well as any changes.
#priority 1000

#loader contenttweaker

import mods.contenttweaker.Block;
import mods.contenttweaker.CreativeTab;
import mods.contenttweaker.VanillaFactory;

//主世界方块
val OWBT0 as Block = VanillaFactory.createBlock("overworld_block", <blockmaterial:iron>);
OWBT0.fullBlock = true;
OWBT0.setLightOpacity(255);
OWBT0.translucent = true;
OWBT0.setLightValue(0);
OWBT0.setBlockHardness(7.5);
OWBT0.setBlockResistance(100.0);
OWBT0.setToolClass("pickaxe");
OWBT0.setToolLevel(3);
OWBT0.setBlockSoundType(<soundtype:metal>);
OWBT0.register();

//下界星球方块
val NEBT0 as Block = VanillaFactory.createBlock("neb_block", <blockmaterial:iron>);
NEBT0.fullBlock = true;
NEBT0.setLightOpacity(255);
NEBT0.translucent = true;
NEBT0.setLightValue(0);
NEBT0.setBlockHardness(7.5);
NEBT0.setBlockResistance(100.0);
NEBT0.setToolClass("pickaxe");
NEBT0.setToolLevel(3);
NEBT0.setBlockSoundType(<soundtype:metal>);
NEBT0.register();

//末地星球方块
val EDBT0 as Block = VanillaFactory.createBlock("edb_block", <blockmaterial:iron>);
EDBT0.fullBlock = true;
EDBT0.setLightOpacity(255);
EDBT0.translucent = true;
EDBT0.setLightValue(0);
EDBT0.setBlockHardness(7.5);
EDBT0.setBlockResistance(100.0);
EDBT0.setToolClass("pickaxe");
EDBT0.setToolLevel(3);
EDBT0.setBlockSoundType(<soundtype:metal>);
EDBT0.register();

//月球方块
val MOBT1 as Block = VanillaFactory.createBlock("moonb_block", <blockmaterial:iron>);
MOBT1.fullBlock = true;
MOBT1.setLightOpacity(255);
MOBT1.translucent = true;
MOBT1.setLightValue(0);
MOBT1.setBlockHardness(7.5);
MOBT1.setBlockResistance(100.0);
MOBT1.setToolClass("pickaxe");
MOBT1.setToolLevel(3);
MOBT1.setBlockSoundType(<soundtype:metal>);
MOBT1.register();

//水星方块
val MEBT4 as Block = VanillaFactory.createBlock("meb_block", <blockmaterial:iron>);
MEBT4.fullBlock = true;
MEBT4.setLightOpacity(255);
MEBT4.translucent = true;
MEBT4.setLightValue(0);
MEBT4.setBlockHardness(7.5);
MEBT4.setBlockResistance(100.0);
MEBT4.setToolClass("pickaxe");
MEBT4.setToolLevel(3);
MEBT4.setBlockSoundType(<soundtype:metal>);
MEBT4.register();

//火星方块
val MABT2 as Block = VanillaFactory.createBlock("mab_block", <blockmaterial:iron>);
MABT2.fullBlock = true;
MABT2.setLightOpacity(255);
MABT2.translucent = true;
MABT2.setLightValue(0);
MABT2.setBlockHardness(7.5);
MABT2.setBlockResistance(100.0);
MABT2.setToolClass("pickaxe");
MABT2.setToolLevel(3);
MABT2.setBlockSoundType(<soundtype:metal>);
MABT2.register();

//金星方块
val VEBT4 as Block = VanillaFactory.createBlock("veb_block", <blockmaterial:iron>);
VEBT4.fullBlock = true;
VEBT4.setLightOpacity(255);
VEBT4.translucent = true;
VEBT4.setLightValue(0);
VEBT4.setBlockHardness(7.5);
VEBT4.setBlockResistance(100.0);
VEBT4.setToolClass("pickaxe");
VEBT4.setToolLevel(3);
VEBT4.setBlockSoundType(<soundtype:metal>);
VEBT4.register();

//冥王星方块
val PLBT7 as Block = VanillaFactory.createBlock("plb_block", <blockmaterial:iron>);
PLBT7.fullBlock = true;
PLBT7.setLightOpacity(255);
PLBT7.translucent = true;
PLBT7.setLightValue(0);
PLBT7.setBlockHardness(7.5);
PLBT7.setBlockResistance(100.0);
PLBT7.setToolClass("pickaxe");
PLBT7.setToolLevel(3);
PLBT7.setBlockSoundType(<soundtype:metal>);
PLBT7.register();

//谷神星方块
val CEBT3 as Block = VanillaFactory.createBlock("ceb_block", <blockmaterial:iron>);
CEBT3.fullBlock = true;
CEBT3.setLightOpacity(255);
CEBT3.translucent = true;
CEBT3.setLightValue(0);
CEBT3.setBlockHardness(7.5);
CEBT3.setBlockResistance(100.0);
CEBT3.setToolClass("pickaxe");
CEBT3.setToolLevel(3);
CEBT3.setBlockSoundType(<soundtype:metal>);
CEBT3.register();

//鸟神星方块
val MMBT7 as Block = VanillaFactory.createBlock("mmb_block", <blockmaterial:iron>);
MMBT7.fullBlock = true;
MMBT7.setLightOpacity(255);
MMBT7.translucent = true;
MMBT7.setLightValue(0);
MMBT7.setBlockHardness(7.5);
MMBT7.setBlockResistance(100.0);
MMBT7.setToolClass("pickaxe");
MMBT7.setToolLevel(3);
MMBT7.setBlockSoundType(<soundtype:metal>);
MMBT7.register();

//妊神星方块
val HABT7 as Block = VanillaFactory.createBlock("hab_block", <blockmaterial:iron>);
HABT7.fullBlock = true;
HABT7.setLightOpacity(255);
HABT7.translucent = true;
HABT7.setLightValue(0);
HABT7.setBlockHardness(7.5);
HABT7.setBlockResistance(100.0);
HABT7.setToolClass("pickaxe");
HABT7.setToolLevel(3);
HABT7.setBlockSoundType(<soundtype:metal>);
HABT7.register();

//奈佩里星方块
val NPBT9 as Block = VanillaFactory.createBlock("npb_block", <blockmaterial:iron>);
NPBT9.fullBlock = true;
NPBT9.setLightOpacity(255);
NPBT9.translucent = true;
NPBT9.setLightValue(0);
NPBT9.setBlockHardness(7.5);
NPBT9.setBlockResistance(100.0);
NPBT9.setToolClass("pickaxe");
NPBT9.setToolLevel(3);
NPBT9.setBlockSoundType(<soundtype:metal>);
NPBT9.register();

//阿努比斯星方块
val ANBT9 as Block = VanillaFactory.createBlock("anb_block", <blockmaterial:iron>);
ANBT9.fullBlock = true;
ANBT9.setLightOpacity(255);
ANBT9.translucent = true;
ANBT9.setLightValue(0);
ANBT9.setBlockHardness(7.5);
ANBT9.setBlockResistance(100.0);
ANBT9.setToolClass("pickaxe");
ANBT9.setToolLevel(3);
ANBT9.setBlockSoundType(<soundtype:metal>);
ANBT9.register();

//马赫斯星方块
val MHBT9 as Block = VanillaFactory.createBlock("mhb_block", <blockmaterial:iron>);
MHBT9.fullBlock = true;
MHBT9.setLightOpacity(255);
MHBT9.translucent = true;
MHBT9.setLightValue(0);
MHBT9.setBlockHardness(7.5);
MHBT9.setBlockResistance(100.0);
MHBT9.setToolClass("pickaxe");
MHBT9.setToolLevel(3);
MHBT9.setBlockSoundType(<soundtype:metal>);
MHBT9.register();

//荷鲁斯星方块
val HOBT9 as Block = VanillaFactory.createBlock("hob_block", <blockmaterial:iron>);
HOBT9.fullBlock = true;
HOBT9.setLightOpacity(255);
HOBT9.translucent = true;
HOBT9.setLightValue(0);
HOBT9.setBlockHardness(7.5);
HOBT9.setBlockResistance(100.0);
HOBT9.setToolClass("pickaxe");
HOBT9.setToolLevel(3);
HOBT9.setBlockSoundType(<soundtype:metal>);
HOBT9.register();

//赛特星方块
val SEBT9 as Block = VanillaFactory.createBlock("seb_block", <blockmaterial:iron>);
SEBT9.fullBlock = true;
SEBT9.setLightOpacity(255);
SEBT9.translucent = true;
SEBT9.setLightValue(0);
SEBT9.setBlockHardness(7.5);
SEBT9.setBlockResistance(100.0);
SEBT9.setToolClass("pickaxe");
SEBT9.setToolLevel(3);
SEBT9.setBlockSoundType(<soundtype:metal>);
SEBT9.register();

//暮色森林方块
val TFBT0 as Block = VanillaFactory.createBlock("tfb_block", <blockmaterial:iron>);
TFBT0.fullBlock = true;
TFBT0.setLightOpacity(255);
TFBT0.translucent = true;
TFBT0.setLightValue(0);
TFBT0.setBlockHardness(7.5);
TFBT0.setBlockResistance(100.0);
TFBT0.setToolClass("pickaxe");
TFBT0.setToolLevel(3);
TFBT0.setBlockSoundType(<soundtype:metal>);
TFBT0.register();

//漆黑世界方块
val DDBT10 as Block = VanillaFactory.createBlock("ddb_block", <blockmaterial:iron>);
DDBT10.fullBlock = true;
DDBT10.setLightOpacity(255);
DDBT10.translucent = true;
DDBT10.setLightValue(0);
DDBT10.setBlockHardness(7.5);
DDBT10.setBlockResistance(100.0);
DDBT10.setToolClass("pickaxe");
DDBT10.setToolLevel(3);
DDBT10.setBlockSoundType(<soundtype:metal>);
DDBT10.register();
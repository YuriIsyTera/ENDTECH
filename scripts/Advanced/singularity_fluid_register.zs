#loader contenttweaker
import mods.contenttweaker.MaterialSystem;
import mods.contenttweaker.Part;
 
function singularityFluidregister(name as string , Color as string) {
    val singularityFluidMaterialPart as Part[] = [MaterialSystem.getPartBuilder().setName("singularity_fluid_base").setPartType(MaterialSystem.getPartType("fluid")).setHasOverlay(false).setOreDictName("singularityfluid").build()];
 
    MaterialSystem.getMaterialBuilder().setName(name).setColor(Color).build().registerParts(singularityFluidMaterialPart);
}

singularityFluidregister("Gold" , 0xffff00);//金
singularityFluidregister("Iron" , 0xe0e0e0);//铁
singularityFluidregister("Lapis", 0x000099);//青金石
singularityFluidregister("Redstone", 0xcc0000);//红石
singularityFluidregister("Quartz", 0xebe2cf);//下界石英
singularityFluidregister("Copper", 0xc66a0e);//铜
singularityFluidregister("Tin",0x7cb5ce);//锡
singularityFluidregister("Lead",0x0b1b50);//铅
singularityFluidregister("Silver",0xf7f7f7);//银
singularityFluidregister("Nickel",0xffffcc);//镍
singularityFluidregister("Diamond",0x07dcdc);//钻石
singularityFluidregister("Emerald",0x0adc0a);//绿宝石
singularityFluidregister("Platinum",0x66dcff);//铂
singularityFluidregister("Iridium",0xffffff);//铱
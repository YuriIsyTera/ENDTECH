//ALL RIGHTS RESERVED
//也许你可以对私货进行更改。

#priority 10
#loader crafttweaker reloadable

import mods.modularmachinery.MMEvents;
import mods.modularmachinery.RecipePrimer;
import mods.modularmachinery.RecipeBuilder;
import mods.modularmachinery.IngredientArrayBuilder;
import mods.modularmachinery.MachineBuilder;
import mods.modularmachinery.MachineModifier;
import mods.modularmachinery.FactoryRecipeThread;
import mods.modularmachinery.IMachineController;
import mods.modularmachinery.RecipeAdapterBuilder;
import mods.modularmachinery.RecipeModifierBuilder;
import mods.modularmachinery.RecipeCheckEvent;
import mods.modularmachinery.FactoryRecipeStartEvent;
import mods.modularmachinery.FactoryRecipeTickEvent;
import mods.modularmachinery.FactoryRecipeFinishEvent;
import mods.modularmachinery.MachineTickEvent;
import mods.modularmachinery.SmartInterfaceType;
import mods.modularmachinery.Sync;

import crafttweaker.world.IBlockPos;
import crafttweaker.world.IWorld;
import crafttweaker.item.IItemStack;
import crafttweaker.data.IData;
import crafttweaker.item.IIngredient;
import crafttweaker.oredict.IOreDictEntry;
import crafttweaker.liquid.ILiquidStack;
import crafttweaker.item.WeightedItemStack;
import mod.mekanism.gas.IGasStack;
import mods.astralsorcery.Altar;
import crafttweaker.item.IWeightedIngredient;
import crafttweaker.event.BlockBreakEvent;
import crafttweaker.event.IEventCancelable;
import crafttweaker.block.IBlock;
import crafttweaker.player.IPlayer;
import crafttweaker.event.PlayerRightClickItemEvent;
import crafttweaker.event.PlayerInteractBlockEvent;
import mods.modularmachinery.MachineStructureFormedEvent;
import novaeng.NovaEngUtils;
import novaeng.hypernet.HyperNetHelper;
import novaeng.hypernet.RegistryHyperNet;
import novaeng.hypernet.ComputationCenter;
import novaeng.hypernet.ComputationCenterType;
import novaeng.hypernet.ComputationCenterCache;

import novaeng.hypernet.upgrade.type.ProcessorModuleCPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleGPUType;
import novaeng.hypernet.upgrade.type.ProcessorModuleRAMType;

MachineModifier.setMaxThreads("wallcreation",0);
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("主世界创生").addRecipe("wallcrea-1"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("下界创生").addRecipe("wallcrea-2"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("末地创生").addRecipe("wallcrea-3"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("月球创生").addRecipe("wallcrea-4"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("水星创生").addRecipe("wallcrea-5"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("火星创生").addRecipe("wallcrea-6"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("金星创生").addRecipe("wallcrea-7"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("冥王星创生").addRecipe("wallcrea-8"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("谷神星创生").addRecipe("wallcrea-9"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("鸟神星创生").addRecipe("wallcrea-10"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("妊神星创生").addRecipe("wallcrea-11"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("奈佩里创生").addRecipe("wallcrea-12"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("阿努比斯创生").addRecipe("wallcrea-13"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("马赫斯创生").addRecipe("wallcrea-14"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("荷鲁斯创生").addRecipe("wallcrea-15"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("赛特创生").addRecipe("wallcrea-16"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("漆黑世界创生").addRecipe("wallcrea-18"));
MachineModifier.addCoreThread("wallcreation",FactoryRecipeThread.createCoreThread("十月之创生").addRecipe("wallcrea-oct"));
var recipeCounter = 0;

// val modifier = MultiblockModifierBuilder.newBuilder("modifier_name")
//     .setBlockArray(BlockArrayBuilder.newBuilder()
//         .addBlock(0, 0, 0, <avaritia:block_resource:1>)
//         .getBlockArray())
//     .setDescriptiveStack(<avaritia:block_resource:1>)
//     .build();
// MachineBuilder.getBuilder("machine_name")
//     .addMultiBlockModifier(modifier);

//==================================超能聚演控制器==============================
//终位造化之壁
mods.extendedcrafting.TableCrafting.addShaped(<modularmachinery:wallcreation_factory_controller>, [
	[<contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:nova_ingot>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>], 
	[<contenttweaker:nova_ingot>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <ore:blockInfinity>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:nova_ingot>], 
	[<contenttweaker:nova_ingot>, <contenttweaker:superluminal_core>, <contenttweaker:octingot>, <contenttweaker:world_energy_core>, <contenttweaker:world_energy_core>, <contenttweaker:world_energy_core>, <contenttweaker:octingot>, <contenttweaker:superluminal_core>, <contenttweaker:nova_ingot>], 
	[<minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:superluminal_core>, <contenttweaker:world_energy_core>, <contenttweaker:mana_core>, <contenttweaker:forgotten_core>, <contenttweaker:element_core>, <contenttweaker:world_energy_core>, <contenttweaker:superluminal_core>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}})], 
	[<contenttweaker:nova_ingot>, <ore:blockInfinity>, <contenttweaker:world_energy_core>, <contenttweaker:forgotten_core>, <contenttweaker:forcecontainer>, <contenttweaker:forgotten_core>, <contenttweaker:world_energy_core>, <ore:blockInfinity>, <contenttweaker:nova_ingot>], 
	[<minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:superluminal_core>, <contenttweaker:world_energy_core>, <contenttweaker:eclipse_core>, <contenttweaker:forgotten_core>, <contenttweaker:soul_core>, <contenttweaker:world_energy_core>, <contenttweaker:superluminal_core>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}})], 
	[<contenttweaker:nova_ingot>, <contenttweaker:superluminal_core>, <contenttweaker:octingot>, <contenttweaker:world_energy_core>, <contenttweaker:world_energy_core>, <contenttweaker:world_energy_core>, <contenttweaker:octingot>, <contenttweaker:superluminal_core>, <contenttweaker:nova_ingot>], 
	[<contenttweaker:nova_ingot>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <ore:blockInfinity>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:superluminal_core>, <contenttweaker:nova_ingot>], 
	[<contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:nova_ingot>, <minecraft:skull:3>.withTag({SkullOwner: {Id: "92396ca4-e643-44e8-b3dc-61d35fc0127d", Properties: {textures: [{Signature: "QGS5qfCsxdUMTHPIJ9W9PBJkP0bu26NwlK1OmjiyN17kmPDHDd+j0Ao+SbIpv/pxGaItBfRq52ETsOwbTe3mnnNWv3JooQN8YlEHVaZrZK/32i01Y53MUDZ3JtVJPEiIb3EOkhIciGUMeRpNTa9CVv5skOn+rye0f/eetQRUFAZKRSdgW7Gz1MnqzAPOCct69RHcHCCnwny/DSGnNsnfz+AJKOyubdRHBZbX/+Ug+8AMa2ava/rrMFV5h8oTT57awpBsnKsWac1Mijk/8wmpci6bA8b8xiIBBmLV//tGj/iU1eusfx+zkanYDdPoLOmxf00vkblyf/Rt4oNbp/h9f3d7+SnnwPCzvUvKm2GzngVmS35epIZGshU3/cuvBOmvGNLZux5x2ykxCwECsJhEVy7lvzpYMC5iNH1i3hZVqKGLOcBSOFBSz0vlAyMAkJnmlCW2TBaXbx/O5LdC/czLCqGpRfmlUjBz8RA27WVQ/HvCG/ys0s3JBJGYHD/xVcGwMFuIQPR4GCCAIEUxLO/o23c+4mSowugj5phZ7WUEl7A6O8m3cAcx3kyj8k4SmMsBo1pf7Khmq4KRznMrv9JZnkIOGXOpqjzCccj7C9B0S5v/Viz1/9K1jaPxdkcm4qk6XVFCru5yvKGb5Jc9H+W4KuvHGi1WbbSBNU2ftZ7GojY=", Value: "ewogICJ0aW1lc3RhbXAiIDogMTY4NTYxNzM1ODE1OSwKICAicHJvZmlsZUlkIiA6ICI5MjM5NmNhNGU2NDM0NGU4YjNkYzYxZDM1ZmMwMTI3ZCIsCiAgInByb2ZpbGVOYW1lIiA6ICJLYXN1bWlfTm92YSIsCiAgInNpZ25hdHVyZVJlcXVpcmVkIiA6IHRydWUsCiAgInRleHR1cmVzIiA6IHsKICAgICJTS0lOIiA6IHsKICAgICAgInVybCIgOiAiaHR0cDovL3RleHR1cmVzLm1pbmVjcmFmdC5uZXQvdGV4dHVyZS81ODQ1OWU5ZmQ1YzQxZTlhZWYxMzVjYzdjYzUwMWM2MTBjMDA2Y2UzYzQxNzYwYTUwYTA5MmZhYzJmZDYxYzNkIiwKICAgICAgIm1ldGFkYXRhIiA6IHsKICAgICAgICAibW9kZWwiIDogInNsaW0iCiAgICAgIH0KICAgIH0KICB9Cn0="}]}, Name: "Kasumi_Nova"}, display: {Name: "Kasumi_Nova的头"}}), <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>, <contenttweaker:nova_ingot>]
]);
MMEvents.onStructureFormed("wallcreation" , function(event as MachineStructureFormedEvent){
    val ctrl = event.controller;
    val data = ctrl.customData;
    val map = data.asMap();
    var overworld = ctrl.getBlocksInPattern(<contenttweaker:overworld_block>);
    var neb = ctrl.getBlocksInPattern(<contenttweaker:neb_block>);
    var edb = ctrl.getBlocksInPattern(<contenttweaker:edb_block>);
    var moob = ctrl.getBlocksInPattern(<contenttweaker:moonb_block>);
    var meb = ctrl.getBlocksInPattern(<contenttweaker:meb_block>);
    var mab = ctrl.getBlocksInPattern(<contenttweaker:mab_block>);
    var veb = ctrl.getBlocksInPattern(<contenttweaker:veb_block>);
    var plb = ctrl.getBlocksInPattern(<contenttweaker:plb_block>);
    var ceb = ctrl.getBlocksInPattern(<contenttweaker:ceb_block>);
    var mmb = ctrl.getBlocksInPattern(<contenttweaker:mmb_block>);
    var hab = ctrl.getBlocksInPattern(<contenttweaker:hab_block>);
    var npb = ctrl.getBlocksInPattern(<contenttweaker:npb_block>);
    var anb = ctrl.getBlocksInPattern(<contenttweaker:anb_block>);
    var mhb = ctrl.getBlocksInPattern(<contenttweaker:mhb_block>);
    var seb = ctrl.getBlocksInPattern(<contenttweaker:seb_block>);
    var ddb = ctrl.getBlocksInPattern(<contenttweaker:ddb_block>);
    var hob = ctrl.getBlocksInPattern(<contenttweaker:hob_block>);
    var oct = ctrl.getBlocksInPattern(<contenttweaker:octoberdoll>);
    map["overworld"]=overworld;
    map["neb"]=neb;
    map["edb"]=edb;
    map["moob"]=moob;
    map["meb"]=meb;
    map["mab"]=mab;
    map["veb"]=veb;
    map["plb"]=plb;
    map["ceb"]=ceb;
    map["mmb"]=mmb;
    map["hab"]=hab;
    map["npb"]=npb;
    map["anb"]=anb;
    map["mhb"]=mhb;
    map["seb"]=seb;
    map["ddb"]=ddb;
    map["hob"]=hob;
    map["oct"]=oct;
    ctrl.customData = data;
});
//主世界
RecipeBuilder.newBuilder("wallcrea-1", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val overworld = data.getInt("overworld",0);
        if(overworld == 0){
            event.setFailed("未找到主世界星球");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_a>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:grass", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:stone", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 20, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:bedrock", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sand", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:log", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:dirt", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:dirt", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:dirt", Damage: 2, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:stone", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:stone", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:stone", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:clay", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sandstone", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sponge", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:prismarine", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:prismarine", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:prismarine", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:prismarine_shard", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sea_lantern", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:prismarine_crystals", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:sapling", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "deepmoblearning:living_matter_overworldian", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 4 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:reeds", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "jaopca:block_blockwillowalloy", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .setThreadName("主世界创生")
    .addRecipeTooltip("§7主世界之力")
    .addRecipeTooltip("§2超乎奇迹的造化！")
    .addRecipeTooltip("§2捏造自然，创造世界。")
    .build();
recipeCounter += 1;

//地狱
RecipeBuilder.newBuilder("wallcrea-2", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val neb = data.getInt("neb",0);
        if(neb == 0){
            event.setFailed("未找到下界星球");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_b>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:netherrack", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:soul_sand", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:glowstone", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:glowstone_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:blaze_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:blaze_powder", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:nether_wart", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 1, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:nether_star", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:wither_rose", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:fire_charge", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:ghast_tear", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:magma_cream", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:nether_brick", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:nether_wart_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:netherbrick", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:quartz", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:ancient_debris", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:netherite_scrap", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:netherite_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "futuremc:netherite_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:red_nether_brick", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:gold_nugget", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:quartz_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:quartz_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:magma", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "deepmoblearning:living_matter_hellish", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§4地狱之力")
    .addRecipeTooltip("§4遗忘之地。")
    .addRecipeTooltip("§4苦火长焚之地，磨难无穷无尽。")
    .setThreadName("下界创生")
    .addRecipeTooltip("§4欲伸和平于世间，纵他千万重炼狱，我亦往矣！")
    .build();
recipeCounter += 1;

//末地
RecipeBuilder.newBuilder("wallcrea-3", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val edb = data.getInt("edb",0);
        if(edb == 0){
            event.setFailed("未找到末地星球");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_c>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:obsidian", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "jaopca:block_blockdimensionalshard", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:end_stone", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:purpur_block", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:ender_pearl", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:ender_eye", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:end_crystal", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:end_rod", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:end_portal_frame", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:block_enderman_skull", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:ender_chest", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage_alloy", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_misc", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:block_alloy", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "betterendforge:ender_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:block_misc", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:storage", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:storage", Damage: 6 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:storage", Damage: 7 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:storage", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 66 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 39 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 167 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_alloy_ingot", Damage: 8 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderutilities:enderpart", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderutilities:enderpart", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderutilities:enderpart", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:material", Damage: 36 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:material", Damage: 48, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:material", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "biomesoplenty:gem", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "appliedenergistics2:material", Damage: 46 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 28 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "betterendforge:ender_dust", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 37, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 103 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "redstonerepository:material", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "actuallyadditions:item_misc", Damage: 19 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "extendedcrafting:material", Damage: 40 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "botania:manaresource", Damage: 15 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 43 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 44 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "enderio:item_material", Damage: 58 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 359 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:material", Damage: 295 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "deepmoblearning:data_model_dragon", tag: {tier: 4, totalkillCount: 0, dataCount: 0}, Count: 1, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "deepmoblearning:data_model_enderman", Count: 1, tag: {tier: 4, totalkillCount: 0, dataCount: 0}, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:skull", Damage: 5 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:dragon_breath", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "minecraft:dragon_egg", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:dragon_heart", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicadditions:chaos_heart", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconium_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconic_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconium_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconium_block", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconic_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "tconevo:metal_block", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:infused_obsidian", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:crafting_injector", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:crafting_injector", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:crafting_injector", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:crafting_injector", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconium_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicadditions:chaos_stabilizer_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconic_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:wyvern_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:awakened_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:chaotic_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:wyvern_energy_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:draconic_energy_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicadditions:chaotic_energy_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:chaos_shard", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "draconicevolution:fusion_crafting_core", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:wyvern_upgrade_device", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:draconic_upgrade_device", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:chaotic_upgrade_device", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:draconic_conversion_device", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:chaotic_conversion_device", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:awakened_draconium_plasma_nozzle", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "contenttweaker:chaostic_draconium_resonant_tube", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "draconicadditions:chaos_crystal_stable", Count: 1, Damage: 0 as short, Req: 0 as long, isStable: 1}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, id: "deepmoblearning:data_model_chaosguardian", Count: 1, tag: {tier: 4, totalkillCount: 0, dataCount: 0}, Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "deepmoblearning:living_matter_extraterrestrial", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§5末地之力")
    .addRecipeTooltip("§5将始之末。")
    .addRecipeTooltip("§5将尽之梦。")
    .setThreadName("末地创生")
    .addRecipeTooltip("§5要面对的一切，都向我而来吧。")
    .addRecipeTooltip("§5战斗至今，我所背负的，一切...")
    .build();
recipeCounter += 1;

//月球
RecipeBuilder.newBuilder("wallcrea-4", "wallcreation", 1000, recipeCounter, false)
    .addPreCheckHandler(function(event as RecipeCheckEvent){
        val ctrl = event.controller;
        val data = ctrl.customData;
        val moob = data.getInt("moob",0);
        if(moob == 0){
            event.setFailed("未找到月球");
        }
    })
    .addInput(<contenttweaker:programming_circuit_0> * 1)
    .addInput(<contenttweaker:advanced_programming_circuit_d>)
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:moonturf", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:moonturf_dark", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {FluidName: "helium_3", Craft: 0, Cnt: 1, Count: 0, Req: 0}, t: "f"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mets:titanium_ore", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mets:titanium_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mets:titanium_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "mets:titanium_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "libvulpes:coil0", Damage: 7, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:productingot", Damage: 0, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:productingot", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:productdust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:productdust", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:metal0", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "advancedrocketry:metal0", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:meteorite_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:obsidiorite_ingot", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:meteorite_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:obsidiorite_dust", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "taiga:meteorite_block", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ore", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:dust", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:ingot_block", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:fission_dust", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:pellet_thorium", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:pellet_thorium", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:fuel_thorium", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:fuel_thorium", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:fuel_thorium", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:fuel_thorium", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:depleted_fuel_thorium", Damage: 0 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:depleted_fuel_thorium", Damage: 1 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:depleted_fuel_thorium", Damage: 2 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "nuclearcraft:depleted_fuel_thorium", Damage: 3 as short, Req: 0 as long}, t: "i"}))
    .addOutput(<extendedae:infinity_cell>.withTag({r: {Craft: 0 as byte, Cnt: 1 as long, Count: 1, id: "thermalfoundation:storage", Damage: 2, Req: 0 as long}, t: "i"}))
    .requireResearch("wall-c-1")
    .addRecipeTooltip("§7月球之力")
    .addRecipeTooltip("§7纯粹，闪亮。")
    .setThreadName("月球创生")
    .addRecipeTooltip("§7数百万年以来，我们所属星球的唯一盟友！")
    .addRecipeTooltip("§7窗前明月，也护佑我超乎梦想！")
    .addRecipeTooltip("§7尽管日渐遥远啊，也请站在高处，吟咏吧！")
    .build();
recipeCounter += 1;
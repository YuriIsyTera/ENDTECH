#priority 10000

#loader contenttweaker

import mods.contenttweaker.VanillaFactory;
import mods.contenttweaker.Item;
import mods.contenttweaker.Fluid;
import mods.contenttweaker.Color;

function regItem(name as string) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.register();
}

function regItemWithStackSize(name as string, maxStackSize as int) {
    val item as Item = VanillaFactory.createItem(name);
    item.creativeTab = <creativetab:misc>;
    item.maxStackSize = maxStackSize;
    item.register();
}

function regFluid(regName as string, color as int, temperature as int) {
    var fluid = VanillaFactory.createFluid(regName, color);
    fluid.colorize = true;
    fluid.temperature = temperature;
    fluid.stillLocation = "base:fluids/liquid";
    fluid.flowingLocation = "base:fluids/liquid_flow";
    fluid.register();
}
var aefe = VanillaFactory.createFluid("aefe", Color.fromHex("000000").getIntColor());
aefe.flowingLocation = "contenttweaker:fluids/aefe";
aefe.stillLocation = "contenttweaker:fluids/aefe";
aefe.luminosity = 1;
aefe.colorize = false;
aefe.viscosity = 3000;
aefe.register();
var FNA = VanillaFactory.createFluid("fluid_nova_alloy", Color.fromHex("000000").getIntColor());
FNA.flowingLocation = "contenttweaker:fluids/fluid_nova_alloy";
FNA.stillLocation = "contenttweaker:fluids/fluid_nova_alloy";
FNA.luminosity = 1;
FNA.colorize = false;
FNA.viscosity = 3000;
FNA.register();
var HDF = VanillaFactory.createFluid("hyperdimensionalfuel", Color.fromHex("000000").getIntColor());
HDF.flowingLocation = "contenttweaker:fluids/hyperdimensionalfuel";
HDF.stillLocation = "contenttweaker:fluids/hyperdimensionalfuel";
HDF.luminosity = 1;
HDF.colorize = false;
HDF.viscosity = 3000;
HDF.register();
var NQF = VanillaFactory.createFluid("nq_fuel", Color.fromHex("000000").getIntColor());
NQF.flowingLocation = "contenttweaker:fluids/nq_fuel";
NQF.stillLocation = "contenttweaker:fluids/nq_fuel";
NQF.luminosity = 10;
NQF.colorize = false;
NQF.viscosity = 3000;
NQF.register();
var NQFF = VanillaFactory.createFluid("nq_scrap", Color.fromHex("000000").getIntColor());
NQFF.flowingLocation = "contenttweaker:fluids/nq_fuel";
NQFF.stillLocation = "contenttweaker:fluids/nq_fuel";
NQFF.luminosity = 10;
NQFF.colorize = false;
NQFF.viscosity = 3000;
NQFF.register();
var FBD = VanillaFactory.createFluid("anti_quarkgluon", Color.fromHex("000000").getIntColor());
FBD.flowingLocation = "contenttweaker:fluids/anti_quarkgluon";
FBD.stillLocation = "contenttweaker:fluids/anti_quarkgluon";
FBD.luminosity = 10;
FBD.colorize = false;
FBD.viscosity = 3000;
FBD.register();
var FWD = VanillaFactory.createFluid("quarkgluon", Color.fromHex("000000").getIntColor());
FWD.flowingLocation = "contenttweaker:fluids/quarkgluon";
FWD.stillLocation = "contenttweaker:fluids/quarkgluon";
FWD.luminosity = 10;
FWD.colorize = false;
FWD.viscosity = 3000;
FWD.register();
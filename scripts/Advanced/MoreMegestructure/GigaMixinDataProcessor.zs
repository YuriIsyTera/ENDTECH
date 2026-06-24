//部分(其实是所有)代码来源于NPE私货合集
#loader mixin

import mixin.CallbackInfo;
import native.java.text.NumberFormat;

#mixin {targets:"github.kasuminova.novaeng.common.hypernet.old.DataProcessor"}
zenClass MixinDataProcessor{
    #mixin Shadow
    val maxGeneration as double;
    #mixin ModifyArg{method:"onMachineTick",at:{value:"INVOKE",target:"Lgithub/kasuminova/novaeng/common/hypernet/old/DataProcessor;getComputationPointProvision(D)D"},index:0}
    function modifyMaxGeneration(original as double) as double{
        return 9223372036854775807.0d;
    }
    #mixin Inject{method:"doHeatGeneration",at:{value:"HEAD"},cancellable:true}
    function doHeatGeneration(ci as CallbackInfo) as void{
        if(maxGeneration >= 8192000.0d){
            ci.cancel();
        }
    }
}

#mixin {targets:"github.kasuminova.novaeng.common.crafttweaker.util.NovaEngUtils"}
zenClass MixinNovaEngUtils{
        #mixin Static
        #mixin Overwrite
        function formatFLOPS(value as double)as string {
        val num_format as NumberFormat = NumberFormat.getNumberInstance();
        num_format.setMaximumFractionDigits(1);
        if (value < 1000.0d) {
            return num_format.format(value) + "T FloPS";
        } else if (value < 1000000.0d) {
            return num_format.format(value / 1000.0d) + "P FloPS";
        } else if (value < 1000000000.0d) {
            return num_format.format(value / 1000000.0d) + "E FloPS";
        } else if (value < 1000000000000.0d) {
            return num_format.format(value / 1000000000.0d) + "Z FloPS";
        }
        return num_format.format(value / 1000000000000.0d) + "Y FloPS"; 
    }
}
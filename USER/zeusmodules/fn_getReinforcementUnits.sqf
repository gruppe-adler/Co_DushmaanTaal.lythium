params ["_type"];


private _units = switch (_type) do { 
    case "squad" : { 
    [
        "rhsusf_army_ocp_arb_squadleader",
        "rhsusf_army_ocp_arb_teamleader",
        "rhsusf_army_ocp_arb_machinegunner",
        "rhsusf_army_ocp_arb_machinegunnera",
        "rhsusf_army_ocp_arb_maaws",
        "rhsusf_army_ocp_arb_engineer",
        "rhsusf_army_ocp_arb_rifleman",
        "rhsusf_army_ocp_arb_riflemanat"
    ] 
    }; 
    case "fireteam" : { 
    [
        "rhsusf_army_ocp_arb_teamleader",
        "rhsusf_army_ocp_arb_machinegunner",
        "rhsusf_army_ocp_arb_machinegunnera",
        "rhsusf_army_ocp_arb_riflemanat"
    ] 
    }; 
    case "specialteam" : { 
    [
       "rhsusf_army_ocp_arb_teamleader",
       "rhsusf_army_ocp_arb_machinegunner"
    ] 
    }; 
    case "heavy" : { 
    [
        "rhsusf_army_ocp_arb_teamleader",
        "rhsusf_army_ocp_arb_machinegunner",
        "rhsusf_army_ocp_arb_machinegunnera",
        "rhsusf_army_ocp_arb_machinegunner",
        "rhsusf_army_ocp_arb_machinegunnera",
        "rhsusf_army_ocp_arb_machinegunner",
        "rhsusf_army_ocp_arb_maaws"
    ]
    };
    default {[]}; 
};

_units
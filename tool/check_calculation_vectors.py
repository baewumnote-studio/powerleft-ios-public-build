from pathlib import Path
import json
import math
import sys

ROOT=Path(__file__).resolve().parents[1]
preset=json.loads((ROOT/"assets/config/preset_values.json").read_text(encoding="utf-8"))
vectors=json.loads((ROOT/"qa/CALCULATION_TEST_VECTORS.json").read_text(encoding="utf-8"))
usage=preset["usagePatterns"]
tol=float(vectors["tolerance"])
errors=[]

def avg(d):
    factor=d.get("usageFactor", usage[d.get("usagePattern","alwaysOn")])
    return float(d["watts"])*float(factor)

def eff(conn,profile,custom=None):
    if custom is None:
        return float(preset["profiles"][conn][profile]["efficiency"])
    custom=max(.50,min(.99,float(custom)))
    if profile=="conservative": return max(.50,min(.99,custom-.06))
    if profile=="best": return max(.50,min(.99,custom+.05))
    return custom

def reserve(conn,profile,custom=None):
    if custom is None:
        return float(preset["profiles"][conn][profile]["reserveFloorPercent"])
    r=max(0,min(50,float(custom)))
    if profile=="conservative": return max(0,min(50,r+5))
    if profile=="best": return max(0,min(50,r-5))
    return r

def close(case_id,key,actual,expected):
    if isinstance(expected,bool):
        if actual is not expected:
            errors.append(f"{case_id}/{key}: {actual} != {expected}")
    elif not math.isclose(float(actual),float(expected),rel_tol=tol,abs_tol=tol):
        errors.append(f"{case_id}/{key}: {actual} != {expected}")

for case in vectors["cases"]:
    cid=case["id"]
    devices=case["devices"]
    default=case["connection"]
    expected=case["expected"]

    if case["mode"]=="runtime":
        custom_eff=case.get("customTypicalEfficiency")
        custom_res=case.get("customReserveFloorPercent")
        results={}
        for profile in ["conservative","typical","best"]:
            usable=max(float(case["chargePercent"])-reserve(default,profile,custom_res),0)/100
            equivalent=sum(
                avg(d)/eff(d.get("connectionOverride") or default,profile,custom_eff)
                for d in devices
            )
            results[profile]=0 if equivalent<=0 else float(case["capacityWh"])*usable/equivalent
        results["totalAverageLoadW"]=sum(avg(d) for d in devices)
        results["totalRatedLoadW"]=sum(float(d["watts"]) for d in devices)
        results["hasNoUsableEnergy"]=(
            max(float(case["chargePercent"])-reserve(default,"typical",custom_res),0)<=0
        )
    else:
        total=sum(avg(d) for d in devices)
        demand=total*float(case["desiredRuntimeHours"])
        results={"energyDemandWh":demand,"totalAverageLoadW":total}
        for label,profile,res in [
            ("minimumWh","best",0),
            ("recommendedWh","typical",10),
            ("comfortableWh","conservative",20),
        ]:
            equivalent=sum(
                avg(d)/eff(d.get("connectionOverride") or default,profile)
                for d in devices
            )
            adjusted=demand*(equivalent/total)
            results[label]=adjusted/((100-res)/100)

    for key,value in expected.items():
        close(cid,key,results[key],value)

if errors:
    print("CALCULATION VECTOR CHECK FAILED")
    for error in errors: print("ERROR:",error)
    sys.exit(1)

print("CALCULATION VECTOR CHECK PASSED")
print("Cases:",len(vectors["cases"]))
print("Runtime cases:",sum(c["mode"]=="runtime" for c in vectors["cases"]))
print("Battery-needed cases:",sum(c["mode"]=="batteryNeeded" for c in vectors["cases"]))

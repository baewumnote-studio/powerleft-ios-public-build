# PowerLeft Calculation Invariants

These invariants are encoded as automated tests and must remain true after any
calculation-engine change.

1. Runtime range ordering:
   `conservative <= typical <= best`.
2. Battery-sizing ordering:
   `minimum <= recommended <= comfortable`.
3. Increasing battery Wh with the same charge/load increases runtime.
4. Increasing charge with the same battery/load increases runtime.
5. Increasing average load with the same battery decreases runtime.
6. Increasing desired runtime increases required capacity linearly.
7. With current generic defaults, DC/USB-C typical efficiency is not worse than
   AC for the same battery/load.
8. Custom assumptions must still produce an ordered range.
9. Runtime is zero when the current charge is at/below the reserve floor.
10. Mixed-connection devices use per-device conversion efficiency.
11. Max-output warnings use combined rated load, not duty-cycle average load.
12. Startup-surge flags and medical-device flags propagate into result warnings.

These are behavioral constraints, not manufacturer guarantees.

# That the built TLC holds what holds and refuses what does not, by its exit status
# (tlc2.output.EC.ExitStatus): a bounded counter that reaches its bound under weak fairness holds its invariant and
# its liveness property (0); an invariant some state breaks is a safety violation (12); the same liveness property
# without fairness is a liveness violation (13), because the counter may stop.
{ runCommand, tlaplus }:
let
  check = name: cfg: expected:
    runCommand "tlc-${name}" { nativeBuildInputs = [ tlaplus ]; } ''
      cp ${./Counter.tla} Counter.tla
      cp ${cfg} model.cfg
      status=0
      tlc -workers 1 -metadir "$TMPDIR/states" -config model.cfg Counter.tla || status=$?
      if [ "$status" != ${toString expected} ]; then
        echo "tlc exited $status; expected ${toString expected}" >&2
        exit 1
      fi
      touch $out
    '';
in
{
  holds = check "holds" ./holds.cfg 0;
  refuses-safety = check "refuses-safety" ./unsafe.cfg 12;
  refuses-liveness = check "refuses-liveness" ./unfair.cfg 13;
}

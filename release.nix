# The TLA+ tools commit this flake builds: a commit of the 1.8.0 pre-release, pinned by its hash, because the
# `v1.8.0` tag upstream moves with each nightly.
{
  version = "1.8.0-pre.2026-11-06";
  rev = "d8fb231de4e4b5d02c1b2ed1ac759c086f694021";
  hash = "sha256-d2m367AiF0cBe2Q6f5toYiRMFB+DMtQZArcNGcMBa9I=";
  # `git rev-list --count <rev>`: TLC reads it from its manifest as a number, and prints it with its version.
  # The nightly's own tag at this commit, written into the manifest as its build tag.
  nightly = "2026.11.06.222357";
  commitsCount = 9088;
  # The commit's time (seconds since the epoch): the build's timestamp, from which TLC prints its version
  # (2026.11.06.…), as a nightly of this commit would.
  committed = 1794002934;
}

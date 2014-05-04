{ stdenv, fetchurl, fetchgit, go, lib }:
let
  version = "v0.3.1";
  goDeps = [
    {
      dir     = "github.com/gorilla";
      name    = "mux";
      rev     = "270c42505a11c779b5a5aaecfa5ec717adac996e";
      sha256  = "9e56df7f9c0b1cc5958a29f07c66b872e7a3293e75cc5e55f03e72f95995535d";
      fetcher = git;
    }
    {
      dir     = "github.com/gorilla";
      name    = "context";
      rev     = "1be7a086a5fd6440ef16fe96baeda0c78282b980";
      sha256  = "82632290c6cd3d5734c8db884edd966c7e8ab1428591b6f83af34ec005350159";
      fetcher = git;
    }
    {
      dir     = "github.com/shipyard";
      name    = "shipyard-agent";
      rev     = "0348b82b21c88e90aac5056e5786884bbaf6446d";
      sha256  = "7305e42037942543768a1ea7e710b7b89b61a917ae378d2ac40af97e6ec61a11";
      fetcher = git;
    }
  ];
  git = desc: fetchgit { url = "https://${desc.dir}/${desc.name}";
                         inherit (desc) rev sha256; };
  #hg = desc: fetchhg { url = "https://${desc.dir}/${desc.name}";
  #                     tag = desc.rev;
  #                     inherit (desc) sha256; };
  createGoPathCmds =
    lib.concatStrings
      (map (desc:
            let fetched = desc.fetcher desc; in ''
              mkdir -p $GOPATH/src/${desc.dir}
              ln -s ${fetched} $GOPATH/src/${desc.dir}/${desc.name}
            '') goDeps);
in
stdenv.mkDerivation rec {
  name = "shipyard-agent-${version}";

  src = fetchurl {
    url = "https://github.com/shipyard/shipyard-agent/archive/${version}.tar.gz";
    sha256 = "15s005sv565apxdbzlwj1088cc7kjxanfj9dbw3r3pb6g6rdw8fs";
    #url = "https://github.com/shipyard/shipyard-agent/releases/download/${version}/shipyard-agent";
    #sha256 = "0hrzp027bwrnhbzx9ii09qdbx1pcw62n3r2hx5drbj08avhrk5zw";
  };

  buildInputs = [ go ];

  installTargets = "all";

  preBuild = ''
    mkdir $TMPDIR/go
    export GOPATH=$TMPDIR/go
    ${createGoPathCmds}
  '';

  #preInstall = ''
  #  ensureDir $out/bin
  #  cp shipyard-agent $out/bin
  #'';

  preInstall = ''
    ensureDir $out/bin
    cp ./shipyard-agent $out/bin
    chmod +x $out/bin/shipyard-agent
  '';

  meta = {
    homepage = "https://github.com/shipyard/shipyard-agent";
    description = "Gathers Docker information (containers, images, etc.) from the local Docker and pushes it to a Shipyard instance.";
    license = "MPL";
    maintainers = [ stdenv.lib.maintainers.chexxor ];
    platforms = with stdenv.lib.platforms; linux;
  };
}

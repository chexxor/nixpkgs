{ cabal, mtl }:

cabal.mkDerivation (self: {
  pname = "tagshare";
  version = "0.0";
  sha256 = "1q3chp1rmwmxa8rxv7548wsvbqbng6grrnv1587p08385sp4ncfj";
  buildDepends = [ mtl ];
  meta = {
    description = "TagShare - explicit sharing with tags";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})

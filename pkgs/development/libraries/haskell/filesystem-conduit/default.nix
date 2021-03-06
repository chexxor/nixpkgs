{ cabal, blazeBuilder, conduit, hspec, QuickCheck, systemFileio
, systemFilepath, text, transformers
}:

cabal.mkDerivation (self: {
  pname = "filesystem-conduit";
  version = "1.0.0.2";
  sha256 = "05dsl3bgyjciq6sgmba0hki7imilrjq3ddp9ip5gxl9884j1f4a1";
  buildDepends = [
    conduit systemFileio systemFilepath text transformers
  ];
  testDepends = [
    blazeBuilder conduit hspec QuickCheck text transformers
  ];
  meta = {
    homepage = "http://github.com/snoyberg/conduit";
    description = "Use system-filepath data types with conduits. (deprecated)";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})

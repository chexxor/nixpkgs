{ cabal, network, transformers }:

cabal.mkDerivation (self: {
  pname = "socket-activation";
  version = "0.1.0.1";
  sha256 = "109zxc16zlp98ggc99ap7wbzaa40yg34v3abn2nfs0w49dvh1zma";
  buildDepends = [ network transformers ];
  meta = {
    homepage = "https://github.com/sakana/haskell-socket-activation";
    description = "systemd socket activation library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.ocharles ];
  };
})

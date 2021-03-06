{ cabal, HUnit, parsec, testFramework, testFrameworkHunit
, testFrameworkQuickcheck2
}:

cabal.mkDerivation (self: {
  pname = "network";
  version = "2.5.0.0";
  sha256 = "1x90fdzfigqq2vbjqg73p4vyy7p1z0apj79cpl7i9v9amxa6y5mj";
  buildDepends = [ parsec ];
  testDepends = [
    HUnit testFramework testFrameworkHunit testFrameworkQuickcheck2
  ];
  meta = {
    homepage = "https://github.com/haskell/network";
    description = "Low-level networking interface";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})

{ cabal, QuickCheck, tasty, tastyQuickcheck, tastyTh, text, textIcu
}:

cabal.mkDerivation (self: {
  pname = "stringprep";
  version = "1.0.0";
  sha256 = "0ha4cvzdppd514xh9315v3nvrn1q4xd74gifdqpszw98hj2mw0b0";
  buildDepends = [ text textIcu ];
  testDepends = [
    QuickCheck tasty tastyQuickcheck tastyTh text textIcu
  ];
  meta = {
    description = "Implements the \"StringPrep\" algorithm";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})

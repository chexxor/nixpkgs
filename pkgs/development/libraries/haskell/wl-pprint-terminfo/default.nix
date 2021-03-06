{ cabal, nats, semigroups, terminfo, text, transformers
, wlPprintExtras
}:

cabal.mkDerivation (self: {
  pname = "wl-pprint-terminfo";
  version = "3.7.1";
  sha256 = "04220hgrjjsz0ir65s6ynrjgdmqlfcw49fb158w7wgxxh69kc7h6";
  buildDepends = [
    nats semigroups terminfo text transformers wlPprintExtras
  ];
  jailbreak = true;
  meta = {
    homepage = "http://github.com/ekmett/wl-pprint-terminfo/";
    description = "A color pretty printer with terminfo support";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})

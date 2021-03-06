{ cabal, aeson, aesonPretty, attoparsec, filepath, hexpat
, hsBibutils, HTTP, mtl, network, pandoc, pandocTypes, parsec
, rfc5051, split, syb, tagsoup, temporary, texmath, text, time
, vector, yaml
}:

cabal.mkDerivation (self: {
  pname = "pandoc-citeproc";
  version = "0.3.1";
  sha256 = "06ck5qfajzwdsmcqvkcs85andxxrifvsfsybf14m7jd6r8y4bg26";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson aesonPretty attoparsec filepath hexpat hsBibutils HTTP mtl
    network pandoc pandocTypes parsec rfc5051 split syb tagsoup
    temporary texmath text time vector yaml
  ];
  testDepends = [
    aeson filepath pandoc pandocTypes temporary text yaml
  ];
  doCheck = false;
  meta = {
    description = "Supports using pandoc with citeproc";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})

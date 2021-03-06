{ cabal, blazeHtml, blazeMarkup, clientsession, cmdargs
, conduitExtra, dataDefault, filepath, hamlet, hjsmin, hledger
, hledgerLib, hspec, httpClient, httpConduit, HUnit, json
, networkConduit, parsec, regexpr, safe, shakespeare
, shakespeareText, text, time, transformers, wai, waiExtra
, waiHandlerLaunch, warp, yaml, yesod, yesodCore, yesodStatic
, yesodTest
}:

cabal.mkDerivation (self: {
  pname = "hledger-web";
  version = "0.23.2";
  sha256 = "1n4n2zj6nqwvwmb6cxr16x2fnmzs7v21snjhq2nnvlik613rnnq7";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    blazeHtml blazeMarkup clientsession cmdargs conduitExtra
    dataDefault filepath hamlet hjsmin hledger hledgerLib httpClient
    httpConduit HUnit json networkConduit parsec regexpr safe
    shakespeare shakespeareText text time transformers wai waiExtra
    waiHandlerLaunch warp yaml yesod yesodCore yesodStatic
  ];
  testDepends = [ hspec yesod yesodTest ];
  jailbreak = true;
  doCheck = false;
  meta = {
    homepage = "http://hledger.org";
    description = "A web interface for the hledger accounting tool";
    license = "GPL";
    platforms = self.ghc.meta.platforms;
  };
})

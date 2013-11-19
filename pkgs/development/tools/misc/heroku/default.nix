{ stdenv, fetchurl, ruby }:

stdenv.mkDerivation rec {
  name = "heroku-client";
  
  src = fetchurl {
    # Tarball link fetched from here: https://github.com/heroku/heroku
    url = "http://assets.heroku.com/heroku-client/heroku-client.tgz";
    sha256 = "00zqj9jwcklfyq5k3v81dwlzrrjm8axkgx7mixcb1kghjjlsdzv2";
  };

  # The "heroku" command is a Ruby script, so we must include Ruby.
  #nativeBuildInputs = [ ruby ];
  #propagatedBuildInputs = [ gem ];

  installPhase = " mkdir -p $out; mv ./* $out; ";
  postInstall = "patchShebangs $out;";

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  meta = {
    homepage = https://github.com/heroku/heroku;
    description = "The Heroku CLI is used to manage Heroku apps from the command line.";
    longDescription = ''
      The Heroku CLI is used to manage Heroku apps from the command line.
    '';
    license = "bsd";
    maintainers = [ "chexxor <chexxor@gmail.com>" ];
    platforms = stdenv.lib.platforms.linux;
  };
}

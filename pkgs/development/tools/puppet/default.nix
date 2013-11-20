{ stdenv, fetchurl, ruby
}:

stdenv.mkDerivation rec {

  name = "facter";

  src = fetchurl {
    # Tarball link fetched from here: http://downloads.puppetlabs.com/facter/
    url = "http://downloads.puppetlabs.com/facter/facter-1.7.3.tar.gz";
    sha256 = "1iyy3km4zbf5gnjh7l094703429yk6iw3q244p6ch5x5ssaamyri";
  };

  buildInputs = [ ruby ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    #mkdir -p $out

    ruby install.rb --destdir=$out #--sitelibdir=$out/lib --bindir=$out/bin

    #mv ./* $out
  '';

  meta = {
    homepage = http://puppetlabs.com/;
    description = ''
      An automated administrative engine for your Linux, Unix, and
      Windows systems.
    '';
    longDescription = ''
      An automated administrative engine for your Linux, Unix, and Windows systems,
      performs administrative tasks (such as adding users, installing packages,
      and updating server configurations) based on a centralized specification.
    '';
    license = stdenv.lib.licenses.asl20;
    maintainers = [ "chexxor <chexxor@gmail.com>" ];
    platforms = stdenv.lib.platforms.linux;
  };

}

{ stdenv, fetchurl, rubygems, gcc, git, libvirt, mysql,
  postgresql, openssl, libxml2, sqlite, libxslt, zlib, readline
}:

stdenv.mkDerivation rec {

  name = "foreman";

  src = fetchurl {
    # Tarball link fetched from here: http://projects.theforeman.org/projects/foreman/files
    url = "http://projects.theforeman.org/attachments/download/642/foreman-1.3.1.tar.bz2";
    sha256 = "0jq48nswwgx7lk79cpdm2zmn40rxf1jjnng63qmam09m4pbypj3r";
  };

  buildInputs = [ rubygems gcc git libvirt mysql
  postgresql openssl libxml2 sqlite libxslt zlib readline ];

  phases = [ "unpackPhase" "installPhase" "fixupPhase" ];

  installPhase = ''
    mkdir -p $out

    cp config/settings.yaml.example config/settings.yaml
    cp config/database.yml.example config/database.yml
    export GEM_HOME=`pwd`/__gems__
    unset http_proxy # libxml2 sets this, but Rubygems fails if proxy is set.
    unset ftp_proxy
    gem install bundler --install-dir ./__gems__ --no-ri --no-rdoc
    # depending on database configured in yml file you can skip others
    # (we are assuming sqlite to be configured)
    ln `pwd`/__gems__/gems/bundler-1.3.5/bin/bundle bundle
    # Add build options to address build issues for specific gems.
    ./bundle config build.ruby-libvirt --with-libvirt-include=${libvirt}/include/ \
      --with-libvirt-lib=${libvirt}/lib/
    ./bundle install --standalone --without mysql mysql2 pg test --path vendor
    # set up database schema, precompile assets and locales
    RAILS_ENV=production ./bundle exec rake db:migrate
    rm bundle

    mv ./* $out
  '';

  meta = {
    homepage = https://github.com/ddollar/foreman;
    description = "Manage an app's constituent processes as a whole using a Procfile.";
    longDescription = ''
      Declare an application's constituent processes in a Procfile
      to easily start and stop the application.
    '';
    license = "bsd";
    maintainers = [ "chexxor <chexxor@gmail.com>" ];
    platforms = stdenv.lib.platforms.linux;
  };
}

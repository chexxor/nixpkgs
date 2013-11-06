{ config, pkgs, ... }:

with pkgs.lib;

let


  mainCfg = config.security.ssl.genSSLCert;


  /*
  # Commands which should generate single files.
  genPrivateKey = { keyOutPath }:
    ''
      # Generate private key 
      openssl genrsa -out ${toString keyOutPath} 1024
    '';
  
  genCsr = { keyPath, csrOutPath }:
    ''
      # Generate CSR
      openssl req -new -key ${toString keyPath} -subj "/C=TW/ST=Taiwan/L=Taipei/O=/CN=localhost" -out ${toString csrOutPath}
    '';
  
  genSelfSignedKey = { csrInPath, keyPath, crtOutPath}:
    ''
      # Generate Self Signed Key
      openssl x509 -req -days 365 -in ${toString csrInPath} -signkey ${toString keyPath} -out ${toString crtOutPath}
    '';
  */
  
  
  genKeyAndCrt = { doSelfSign, keyOutPath, crtOutPath, password ? "" }:
    ''
      # Generate Key and Cert
      if [[ ! -f ${toString crtOutPath} ]] && [[ ! -f ${toString keyOutPath} ]]; then
        ${pkgs.openssl}/bin/openssl req -new -newkey rsa:4096 -days 365 ${if password == "" then "-nodes" else ""} ${if doSelfSign == true then "-x509" else ""} -subj "/C=TW/ST=Taiwan/L=Taipei/O=/CN=localhost" -keyout ${toString keyOutPath} -out ${toString mainCfg.crtOutFile}
      fi
    '';


in

{

  ###### interface

  options = {
  
    security.ssl.genSSLCert = {
    
	enable = mkOption {
	  default = false;
	  example = true;
	  description = "Generate a self-signed SSL certificate at the path specified by the crtOutFile option.";
	};
	
	selfSignedCrt = mkOption {
	  default = false;
	  example = true;
	  description = "Specify whether to self-sign the SSL certificate.";
	};
      
	crtOutFile = mkOption {
	  default = /etc/ssl/host.crt;
	  example = /var/host.crt;
	  type = types.path;
	  description = "Desired path of CRT file.";
	};
	
	keyOutFile = mkOption {
	  default = "/etc/ssl/host.key";
	  example = "/var/host.key";
	  type = types.path;
	  description = "Desired path of key file.";
	};
	
	csrOutFile = mkOption {
	  default = /etc/ssl/host.csr;
	  example = /var/host.csr;
	  type = types.path;
	  description = "Desired path of CSR file.";
	};
	
	keyPassword = mkOption {
	  default = "";
	  example = "myKeyPassword";
	  description = "Password for the SSL key. If blank, the key file will not be encrypted.";
	};
      
    };
  
  };
  
  
  
  ###### implementation
  
  config = mkIf config.security.ssl.genSSLCert.enable {

    # Todo:
    # Generate only key if only key is missing, and vice versa.
    #   http://wiki.centos.org/HowTos/Https
    # Accept password as input. (maybe nobody wants this)
    #   http://stackoverflow.com/questions/4294689/how-to-generate-a-key-with-passphrase-from-the-command-line
    
    ### Generate self-signed SSL certification, non-interactive.
    # http://www.openssl.org/docs/apps/req.html
    # -x509 means self-signed certificate.
    # -nodes means non-encrypted key.
    # rsa:4096 means 4096-bit RSA key.
    #
    # e.g. openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=TW/ST=Taiwan/L=Taipei/O=/CN=localhost" -keyout /var/host.key.insecure -out /var/host.crt
    #
    # Could also try pkgs.runCommand, which creates and returns store path.
    /*
    system.activationScripts.sslCertAndKey = ''
        if [ ! -f ${toString mainCfg.crtOutFile} ]; then
            ${pkgs.openssl}/bin/openssl req -new -newkey rsa:4096 -days 365 ${if mainCfg.keyPassword == "" then "-nodes" else ""} ${if mainCfg.selfSignedCrt == true then "-x509" else ""} -subj "/C=TW/ST=Taiwan/L=Taipei/O=/CN=localhost" -keyout ${toString mainCfg.keyOutFile} -out ${toString mainCfg.crtOutFile}
        fi
      '';
      */
      
    system.activationScripts.sslCertAndKey = genKeyAndCrt {
      doSelfSign = mainCfg.selfSignedCrt;
      keyOutPath = mainCfg.keyOutFile;
      crtOutPath = mainCfg.crtOutFile;
      password   = mainCfg.keyPassword;
    };
    
  };

}

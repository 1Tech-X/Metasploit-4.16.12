#!/data/data/com.termux/files/usr/bin/bash
echo "##############################################"
echo " SUBSCRIBE MY CHANNEL Tech-X "
echo "##############################################"

echo "WAIT UNTIL INSTALLING............" 

echo "####################################"
 pkg install autoconf bison clang coreutils curl findutils git apr apr-util libffi-dev libgmp-dev libpcap-dev \
    postgresql-dev readline-dev libsqlite-dev openssl-dev libtool libxml2-dev libxslt-dev ncurses-dev pkg-config \
    postgresql-contrib wget make ruby-dev libgrpc-dev termux-tools ncurses ncurses-utils libsodium-dev -y
echo "####################################"
echo "Downloading & Extracting....."

curl -L https://github.com/rapid7/metasploit-framework/archive/4.16.2.tar.gz | tar xz


cd metasploit-framework-4.16.2

sed 's|git ls-files|find -type f|' -i metasploit-framework.gemspec




sed 's/rb-readline  (0.5.5)/rb-readline /g' -i Gemfile.lock
sed 's/rb-readline/rb-readline (= 0.5.5)/g' -i Gemfile.lock 

gem unpack rbnacl-libsodium -v'1.0.13'
cd rbnacl-libsodium-1.0.13
termux-fix-shebang ./vendor/libsodium/configure ./vendor/libsodium/build-aux/*
sed 's|">= 3.0.1"|"~> 3.0", ">= 3.0.1"|g' -i rbnacl-libsodium.gemspec
sed 's|">= 10"|"~> 10"|g' -i rbnacl-libsodium.gemspec
#Install bundler
echo "Bundler is installing"
gem install bundler


gem unpack rbnacl-libsodium -v'1.0.13'
cd rbnacl-libsodium-1.0.13
termux-fix-shebang ./vendor/libsodium/configure ./vendor/libsodium/build-aux/*
sed 's|">= 3.0.1"|"~> 3.0", ">= 3.0.1"|g' -i rbnacl-libsodium.gemspec
sed 's|">= 10"|"~> 10"|g' -i rbnacl-libsodium.gemspec

curl -LO https://Auxilus.github.io/configure.patch
patch ./vendor/libsodium/configure < configure.patch

gem build rbnacl-libsodium.gemspec
gem install rbnacl-libsodium-1.0.13.gem
cd .. 
rm -rf rbnacl-libsodium-1.0.13
sed 's|nokogiri (*|nokogiri (1.8.0)|g' -i Gemfile.lock  
gem install nokogiri -v'1.8.0' -- --use-system-libraries
#Install Network-Interface

sed 's|grpc (.*|grpc (1.4.1)|g' -i $HOME/metasploit-framework/Gemfile.lock
gem unpack grpc -v 1.4.1
cd grpc-1.4.1
curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
curl -L https://wiki.termux.com/images/b/bf/Grpc_extconf.patch -o extconf.patch
patch -p1 < extconf.patch
gem build grpc.gemspec
gem install grpc-1.4.1.gem
cd ..
rm -r grpc-1.4.1


#Install gems
gem unpack grpc -v 1.4.1
cd grpc-1.4.1
curl -LO https://raw.githubusercontent.com/grpc/grpc/v1.4.1/grpc.gemspec
curl -L https://wiki.termux.com/images/b/bf/Grpc_extconf.patch -o extconf.patch
patch -p1 < extconf.patch
gem build grpc.gemspec
echo "grpc is installing"
gem install grpc-1.4.1.gem
cd ..
rm -r grpc-1.4.1

#Bundle Install
echo "bundle and all other dependencies are installing......"
bundle install -j5

#Fixing Shebang
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;

cd metasploit-framework-4.16.2

echo "###############################"
echo "Thanx  To  Vishalbiswani"
echo "###############################"

echo "###############################################"
echo "Subscribe  My  Channel  To  Motivate  My  Work"
echo "###############################################"
echo "###############################"
echo "For  More. Tricks. Visit  At  Tech-X "
echo "###############################"
echo "####################################"
echo " NOW YOU CAN LAUNCH METASPLOIT BY JUST EXECUTE THE COMMAND :=>  ./msfconsole"
echo "####################################"
exec bash

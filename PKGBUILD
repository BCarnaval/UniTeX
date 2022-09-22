# Maintainer: Dimitri Bonanni-Surprenant <bond2102@usherbrooke.ca>
pkgname=unitex
pkgver=1.0.0
pkgrel=1
pkgdesc="A collection of scientific oriented and minimalistic LaTeX templates suitable for many assignment types"
arch=("x86_64")
url="https://github.com/BCarnaval/UniTeX"
license=('MIT')
groups=()
depends=("rsync")
makedepends=()
optdepends=()
provides=()
conflicts=()
replaces=()
backup=()
options=()
install=
changelog=
source=($pkgname-$pkgver.tar.gz)
noextract=()
sha256sums=('14eb7b9461c5eb1328c2eb48f44e459825484802bea4f6f52e770c93d02e4e23')

build() {
	echo "$PWD"
	cd "UniTeX"

	chmod +x install.sh
	./install.sh
}

package() {
	cd "UniTeX"

	make DESTDIR="$pkgdir" install
}

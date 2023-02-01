# Maintainer: Dimitri Bonanni-Surprenant <bond2102@usherbrooke.ca>
pkgname=UniTeX
pkgver=1.0.2
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
sha256sums=('8f5b6f9e47411376fc4962a9191532e2fab8c614e9d476f122ab61bee702f3ad')

build() {
	echo "$PWD"
	cd "$pkgname-$pkgver"

	chmod +x install.sh
	./install.sh
}

package() {
	cd "$pkgname-$pkgver"

	make DESTDIR="$pkgdir" install
}

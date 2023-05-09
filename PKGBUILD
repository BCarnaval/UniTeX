# Maintainer: Dimitri Bonanni-Surprenant <bond2102@usherbrooke.ca>
pkgname=UniTeX
pkgver=1.0.3
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
sha256sums=('5c40dd325b9cb7cc1ff9e7ed663bb6805fe1308cd5bb011af01e30bdce644016')

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

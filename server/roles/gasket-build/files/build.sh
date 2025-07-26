set -e

# from: github.com/teamspatzenhirn/gasket-driver
# (updated fork of github.com/google/gasket-driver)
GASKET_DRIVER_VERSION=81307e6f54eea101c20f3baf7828fa1eb48ac177

apt-get update
apt-get install -y git
apt-get install -y devscripts dh-dkms debhelper dkms
git clone https://github.com/teamspatzenhirn/gasket-driver.git /tmp/coral-pcie/gasket-driver
git -C /tmp/coral-pcie/gasket-driver checkout $GASKET_DRIVER_VERSION
cd /tmp/coral-pcie/gasket-driver
debuild -us -uc -tc -b
apt-get install -y /tmp/coral-pcie/gasket-dkms_1.0-18_all.deb

cp /tmp/coral-pcie/gasket-dkms_1.0-18_all.deb /coral/
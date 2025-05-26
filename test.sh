source "./apps/packages.conf"

for package in "${PACKAGES[@]}"; do
  echo $package
done

source ./yay.sh

echo "${PACKAGES[@]}"
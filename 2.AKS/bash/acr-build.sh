. ./podman.env

az acr build \
  --image "${repositoryName}:${tag}" \
  --registry $acrName \
  --file Dockerfile .

az acr repository show-tags -o table -n $acrName --repository ${repositoryName}

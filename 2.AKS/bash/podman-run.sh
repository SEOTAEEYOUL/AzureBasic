. ./podman.env

podman pull "acrhomepage.azurecr.io/${repositoryName}:${tag}"
podman run --network=host "${repositoryName}:${tag}" --name springmysql -p 8080:8080 -d -it  

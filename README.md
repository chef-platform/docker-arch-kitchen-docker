docker-arch-kitchen-docker
==========================

Docker image for an ArchLinux provisionned with Ruby, Test Kitchen and Docker.
It is mainly use to execute Chef coobooks integration tests with Test Kitchen.

Test it easily with:

    # Get the image
    docker pull chefplatform/arch-kitchen-docker
    # Run it (do not forget docker socket volume)
    docker run -d -v /var/run/docker.sock:/var/run/docker.sock --name akd \
      chefplatform/arch-kitchen-docker
    # Open a shell in it
    docker exec -it akd bash
    # Kill and remove the container
    docker kill akd; docker rm akd

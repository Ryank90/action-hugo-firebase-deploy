FROM rk90/alpine-hugo-firebase:latest

# Add our entrypoint file to the container.
ADD entrypoint.sh /entrypoint.sh

# Define out entrypoint and ensure it is ran.
ENTRYPOINT [ "sh", "/entrypoint.sh" ]
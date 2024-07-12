#!/usr/bin/env bash
# vim: shiftwidth=2 tabstop=2 expandtab
set -euo pipefail
[[ "${TRACE-0}" == "1" ]] && set -x


IMAGE_SOURCE=${IMAGE_SOURCE:-'https://github.com/ghrcdaac/sdptk-el8'}
IMAGE_PREFIX=${IMAGE_PREFIX:-ghcr.io/ghrcdaac}
IMAGES=(
    base:el8
    base:el8-devel
    sdptk:el8
)

for image in "${IMAGES[@]}"
do
  name=${image%%:*}
  tag=${image#*:}
  fullname=$IMAGE_PREFIX/$image
  context=images/$name/$tag

  build_args=(
      --build-arg "IMAGE_PREFIX=$IMAGE_PREFIX"
      --cache-from "$fullname"
      # --cgroup-parent string    Optional parent cgroup for the container
      # --compress                Compress the build context using gzip
      # --cpu-period int          Limit the CPU CFS (Completely Fair Scheduler) period
      # --cpu-quota int           Limit the CPU CFS (Completely Fair Scheduler) quota
      # --cpu-shares int          CPU shares (relative weight)
      # --cpuset-cpus string      CPUs in which to allow execution (0-3, 0,1)
      # --cpuset-mems string      MEMs in which to allow execution (0-3, 0,1)
      # --disable-content-trust   Skip image verification (default true)
      # --file string             Name of the Dockerfile (Default is 'PATH/Dockerfile')
      # --force-rm                Always remove intermediate containers
      # --iidfile string          Write the image ID to the file
      # --isolation string        Container isolation technology
      --label "org.opencontainers.image.source=$IMAGE_SOURCE"
      # --memory bytes            Memory limit
      # --memory-swap bytes       Swap limit equal to memory plus swap: '-1' to enable unlimited swap
      # --network string          Set the networking mode for the RUN instructions during build (default "default")
      # --no-cache                Do not use cache when building the image
      # --pull                    Always attempt to pull a newer version of the image
      # --quiet                   Suppress the build output and print image ID on success
      # --rm                      Remove intermediate containers after a successful build (default true)
      # --security-opt strings    Security options
      # --shm-size bytes          Size of /dev/shm
      --tag "$fullname"
      # --target string           Set the target build stage to build.
      # --ulimit ulimit           Ulimit options (default [])
  )

  docker pull "$fullname" ||:
  docker build "${build_args[@]}" "$context"
  docker push "$fullname"
done

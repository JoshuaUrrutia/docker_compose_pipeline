# Import Agave runtime extensions
. _lib/extend-runtime.sh

# Allow CONTAINER_IMAGE over-ride via local file
if [ -z "${CONTAINER_IMAGE}" ]
then
    if [ -f "./_lib/CONTAINER_IMAGE" ]; then
        CONTAINER_IMAGE=$(cat ./_lib/CONTAINER_IMAGE)
    fi
    if [ -z "${CONTAINER_IMAGE}" ]; then
        echo "CONTAINER_IMAGE was not set via the app or CONTAINER_IMAGE file"
        CONTAINER_IMAGE="sd2e/base:ubuntu17"
    fi
fi

# Usage: container_exec IMAGE COMMAND OPTIONS
#   Example: docker run centos:7 uname -a
#            container_exec centos:7 uname -a

echo input directories are ${input_dir1} ${input_dir2}

export LANG=C.UTF-8

echo container_exec ${CONTAINER_IMAGE} multiqc -o . ${input_dir1} ${input_dir2}
container_exec ${CONTAINER_IMAGE} multiqc -o . ${input_dir1} ${input_dir2}


#singularity exec /work/05369/urrutia/singularity_cache/app_multiqc-0.1.0.simg  multiqc -o /work/05369/urrutia/wrangler/multiqc /work/projects/SD2E-Community/prod/data/testing/rnaseq_q0/reference_test/processed/

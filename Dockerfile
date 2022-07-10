FROM quay.io/openshift/origin-must-gather:4.10 as builder

FROM registry.access.redhat.com/ubi8/ubi-minimal
RUN microdnf install tar rsync

COPY --from=builder /usr/bin/oc /usr/bin/oc

# Save original gather script
COPY --from=builder /usr/bin/gather /usr/bin/gather_original
COPY --from=builder /usr/bin/version /usr/bin/version

# Copy all collection scripts to /usr/bin
COPY collection-scripts/* /usr/bin/

ENTRYPOINT /usr/bin/gather

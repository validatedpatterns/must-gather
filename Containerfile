FROM quay.io/openshift/origin-must-gather:4.19 as builder

FROM registry.access.redhat.com/ubi10/ubi-minimal:10.0
RUN microdnf install -y tar rsync jq && microdnf upgrade -y \
  && microdnf clean all

COPY --from=builder /usr/bin/oc /usr/bin/oc

# Save original gather script
COPY --from=builder /usr/bin/gather /usr/bin/gather_original
COPY --from=builder /usr/bin/version /usr/bin/version_original

# Copy all collection scripts to /usr/bin
COPY collection-scripts/* /usr/bin/

ENTRYPOINT ["/usr/bin/gather"]

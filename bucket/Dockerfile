FROM public.ecr.aws/c2u4x1k5/amazon/aws-cli:2.4.19

COPY entrypoint.sh /entrypoint.sh
COPY /var/run/secrets/kubernetes.io/serviceaccount /var/run/secrets/kubernetes.io/serviceaccount

ENTRYPOINT ["/entrypoint.sh"]
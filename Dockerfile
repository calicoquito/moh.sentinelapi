FROM plone:5

COPY docker.cfg /plone/instance/
COPY --chown=plone:plone  .   /plone/instance/src/moh.sentinelapi
RUN gosu plone buildout -c docker.cfg

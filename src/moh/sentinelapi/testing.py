# -*- coding: utf-8 -*-
from plone.app.contenttypes.testing import PLONE_APP_CONTENTTYPES_FIXTURE
from plone.app.robotframework.testing import REMOTE_LIBRARY_BUNDLE_FIXTURE
from plone.app.testing import applyProfile
from plone.app.testing import FunctionalTesting
from plone.app.testing import IntegrationTesting
from plone.app.testing import PloneSandboxLayer
from plone.testing import z2

import moh.sentinelapi


class MohSentinelapiLayer(PloneSandboxLayer):

    defaultBases = (PLONE_APP_CONTENTTYPES_FIXTURE,)

    def setUpZope(self, app, configurationContext):
        # Load any other ZCML that is required for your tests.
        # The z3c.autoinclude feature is disabled in the Plone fixture base
        # layer.
        import plone.restapi
        self.loadZCML(package=plone.restapi)
        self.loadZCML(package=moh.sentinelapi)

    def setUpPloneSite(self, portal):
        applyProfile(portal, 'moh.sentinelapi:default')


MOH_SENTINELAPI_FIXTURE = MohSentinelapiLayer()


MOH_SENTINELAPI_INTEGRATION_TESTING = IntegrationTesting(
    bases=(MOH_SENTINELAPI_FIXTURE,),
    name='MohSentinelapiLayer:IntegrationTesting',
)


MOH_SENTINELAPI_FUNCTIONAL_TESTING = FunctionalTesting(
    bases=(MOH_SENTINELAPI_FIXTURE,),
    name='MohSentinelapiLayer:FunctionalTesting',
)


MOH_SENTINELAPI_ACCEPTANCE_TESTING = FunctionalTesting(
    bases=(
        MOH_SENTINELAPI_FIXTURE,
        REMOTE_LIBRARY_BUNDLE_FIXTURE,
        z2.ZSERVER_FIXTURE,
    ),
    name='MohSentinelapiLayer:AcceptanceTesting',
)

# -*- coding: utf-8 -*-
from moh.sentinelapi.testing import MOH_SENTINELAPI_INTEGRATION_TESTING  # noqa
from plone import api
from plone.app.testing import setRoles
from plone.app.testing import TEST_USER_ID
from plone.dexterity.interfaces import IDexterityFTI
from zope.component import createObject
from zope.component import queryUtility

import unittest


try:
    from plone.dexterity.schema import portalTypeToSchemaName
except ImportError:
    # Plone < 5
    from plone.dexterity.utils import portalTypeToSchemaName


class SyndromeIntegrationTest(unittest.TestCase):

    layer = MOH_SENTINELAPI_INTEGRATION_TESTING

    def setUp(self):
        """Custom shared utility setup for tests."""
        self.portal = self.layer['portal']
        setRoles(self.portal, TEST_USER_ID, ['Manager'])

    def test_ct_syndrome_schema(self):
        fti = queryUtility(IDexterityFTI, name='Syndrome')
        schema = fti.lookupSchema()
        schema_name = portalTypeToSchemaName('Syndrome')
        self.assertEqual(schema_name, schema.getName())

    def test_ct_syndrome_fti(self):
        fti = queryUtility(IDexterityFTI, name='Syndrome')
        self.assertTrue(fti)

    def test_ct_syndrome_factory(self):
        fti = queryUtility(IDexterityFTI, name='Syndrome')
        factory = fti.factory
        obj = createObject(factory)


    def test_ct_syndrome_adding(self):
        setRoles(self.portal, TEST_USER_ID, ['Contributor'])
        obj = api.content.create(
            container=self.portal,
            type='Syndrome',
            id='syndrome',
        )


        # check that deleting the object works too
        api.content.delete(obj=obj)
        self.assertIn('syndrome', self.parent.objectIds())

    def test_ct_syndrome_globally_addable(self):
        setRoles(self.portal, TEST_USER_ID, ['Contributor'])
        fti = queryUtility(IDexterityFTI, name='Syndrome')
        self.assertTrue(
            fti.global_allow,
            u'{0} is not globally addable!'.format(fti.id)
        )

.. This README is meant for consumption by humans and pypi. Pypi can render rst files so please do not use Sphinx features.
   If you want to learn more about writing documentation, please check out: http://docs.plone.org/about/documentation_styleguide.html
   This text does not appear on pypi or github. It is a comment.

===============
moh.sentinelapi
===============

This is an early prototype of an open source platform for capturing aggregated health data.


Installation
------------

Setup virtualenv, install requirements and build::

    virtualenv --clear .
    ./bin/pip install -r requirements.txt
    ./bin/buildout

Launch with the following command::

    ./bin/instance fg

The system provides a REST api for capturing of syndrome data by Epi Week. The api can be consumed by REST clients.

Documentation
-------------

Full documentation for end users can be found in the "docs" folder, and is also available online at http://docs.plone.org/foo/bar



Adding to an existing build
--------------------------------

Install moh.sentinelapi by adding it to your buildout::

    [buildout]

    ...

    eggs =
        moh.sentinelapi


and then running ``bin/buildout``


Contribute
----------

- Issue Tracker: https://github.com/calicoquito/moh.sentinelapi/issues
- Source Code: https://github.com/calicoquito/moh.sentinelapi
- Documentation: https://moh-sentinel-api.readthedocs.io/


Support
-------

If you are having issues, please let us know.
Through our Issue Tracker: https://github.com/calicoquito/moh.sentinelapi/issues


License
-------

The project is licensed under the GPLv2.

# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s moh.sentinelapi -t test_site.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src moh.sentinelapi.testing.MOH_SENTINELAPI_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/moh/sentinelapi/tests/robot/test_site.robot
#
# See the http://docs.plone.org for further details (search for robot
# framework).
#
# ============================================================================

*** Settings *****************************************************************

Resource  plone/app/robotframework/selenium.robot
Resource  plone/app/robotframework/keywords.robot

Library  Remote  ${PLONE_URL}/RobotRemote

Test Setup  Open test browser
Test Teardown  Close all browsers


*** Test Cases ***************************************************************

Scenario: As a site administrator I can add a Site
  Given a logged-in site administrator
    and an add Site form
   When I type 'My Site' into the title field
    and I submit the form
   Then a Site with the title 'My Site' has been created

Scenario: As a site administrator I can view a Site
  Given a logged-in site administrator
    and a Site 'My Site'
   When I go to the Site view
   Then I can see the Site title 'My Site'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add Site form
  Go To  ${PLONE_URL}/++add++Site

a Site 'My Site'
  Create content  type=Site  id=my-site  title=My Site

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the Site view
  Go To  ${PLONE_URL}/my-site
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a Site with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the Site title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}

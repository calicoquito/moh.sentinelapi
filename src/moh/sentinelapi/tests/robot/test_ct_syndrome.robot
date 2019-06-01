# ============================================================================
# DEXTERITY ROBOT TESTS
# ============================================================================
#
# Run this robot test stand-alone:
#
#  $ bin/test -s moh.sentinelapi -t test_syndrome.robot --all
#
# Run this robot test with robot server (which is faster):
#
# 1) Start robot server:
#
# $ bin/robot-server --reload-path src moh.sentinelapi.testing.MOH_SENTINELAPI_ACCEPTANCE_TESTING
#
# 2) Run robot tests:
#
# $ bin/robot /src/moh/sentinelapi/tests/robot/test_syndrome.robot
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

Scenario: As a site administrator I can add a Syndrome
  Given a logged-in site administrator
    and an add Syndrome form
   When I type 'My Syndrome' into the title field
    and I submit the form
   Then a Syndrome with the title 'My Syndrome' has been created

Scenario: As a site administrator I can view a Syndrome
  Given a logged-in site administrator
    and a Syndrome 'My Syndrome'
   When I go to the Syndrome view
   Then I can see the Syndrome title 'My Syndrome'


*** Keywords *****************************************************************

# --- Given ------------------------------------------------------------------

a logged-in site administrator
  Enable autologin as  Site Administrator

an add Syndrome form
  Go To  ${PLONE_URL}/++add++Syndrome

a Syndrome 'My Syndrome'
  Create content  type=Syndrome  id=my-syndrome  title=My Syndrome

# --- WHEN -------------------------------------------------------------------

I type '${title}' into the title field
  Input Text  name=form.widgets.IBasic.title  ${title}

I submit the form
  Click Button  Save

I go to the Syndrome view
  Go To  ${PLONE_URL}/my-syndrome
  Wait until page contains  Site Map


# --- THEN -------------------------------------------------------------------

a Syndrome with the title '${title}' has been created
  Wait until page contains  Site Map
  Page should contain  ${title}
  Page should contain  Item created

I can see the Syndrome title '${title}'
  Wait until page contains  Site Map
  Page should contain  ${title}

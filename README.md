# CISP Auto Tests
This repo contains four tests suites which perform automated checks against the CE.

* A lightweight SIT (System Integration Test) suite, designed to quickly check that key components of the CE are operational post-deployment.
* RSpec Integration Tests - primarily focussed on the V2/V3 Jive APIs.
* Non-UI - The bulk of tests, driven from a combination of API and UI calls (just like Jive).
* UI - Specific tests that check aspects of the UI.

The test suites are written in Ruby, described using a combination of RSpec (for API tests) and Cucumber (for the UI).

## Running Test Suites

### Jenkins
All four test suites have been configured to run against both SV Ref V2 (Jive 7) and SV Ref V3 (Jive 8) via build jobs in Jenkins (see: https://jenkins.sure.vine/view/CERT%20Automation/).
These jobs are executed on a slave (external) node for Jenkins (see: https://jenkins.sure.vine/computer/cisp-auto-slave/), to keep resource usage lower for other Jenkins build jobs.

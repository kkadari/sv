# Threatvine Hub Tests
This repo contains four test suites that perform automated checks against variants of Threatvine Hub, comprising:

* @sit - A lightweight SIT (System Integration Test) suite, designed to quickly check that key components of the CE are operational post-deployment.
* @integration - RSpec Integration Tests - primarily focussed on the V2/V3 Jive APIs.
* @non-ui - The bulk of tests, driven from a combination of API and UI calls (just like Jive).
* @ui - Specific tests that check aspects of the UI.

The test suites are written in Ruby, described using a combination of RSpec (for API tests) and Cucumber (for the UI).

For more details on installation, configuration and execution of tests, please refer to Surevine's Confluence pages.

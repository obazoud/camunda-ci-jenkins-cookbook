# Testing the camunda-ci-jenkins cookbook

This cookbook includes both unit tests via [ChefSpec](https://github.com/sethvargo/chefspec) and integration tests via [Test Kitchen](https://github.com/test-kitchen/test-kitchen). Contributions to this cookbook will only be accepted if all tests pass successfully:

    kitchen test
    rspec


## Setting up the test environment

To test the camunda-ci-jenkins cookbook environment see [VAGRANT](VAGRANT.md) for necessary installations


Clone the latest version of the cookbook from the repository.

    git clone git@github.com:camunda-ci/camunda-ci-jenkins-cookbook.git
    cd camunda-ci-jenkins-cookbook

Install the gems used for testing:

    bundle install


## Running ChefSpec

ChefSpec unit tests are located in `test/unit`. Each recipe has a `recipename_spec.rb` file that contains unit tests for that recipe. Your new functionality or bug fix should have corresponding test coverage - if it's a change, make sure it doesn't introduce a regression (existing tests should pass). If it's a change or introduction of new functionality, add new tests as appropriate.

To run ChefSpec for the whole cookbook:

    rspec

To run ChefSpec for a specific recipe:

    rspec spec/default_spec.rb

    
## Running Test Kitchen

Test Kitchen test suites are defined in [.kitchen.yml](https://github.com/camunda-ci/camunda-ci-jenkins-cookbook/blob/master/.kitchen.yml). Running `kitchen test` will cause Test Kitchen to spin up each platform VM in turn, running the `camunda-ci-jenkins::default` recipe. If the Chef run completes successfully, corresponding tests in `test/integration` are executed. These must also pass.

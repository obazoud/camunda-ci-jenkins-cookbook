# camunda-ci-jenkins-cookbook

## Description

This is the camunda continuous integration base cookbook. It is the foundation used to setup the ci infrastructure for camunda bpm.This is the camunda continuous integration setup aggregation cookbook. It is used to setup the ci infrastructure for camunda bpm.


## Supported Platforms

* Ubuntu 14.04


## Attributes

<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['camunda-ci-jenkins']['bacon']</tt></td>
    <td>Boolean</td>
    <td>whether to include bacon</td>
    <td><tt>true</tt></td>
  </tr>
</table>


## Usage

### camunda-ci-jenkins-cookbook::default

Include `camunda-ci-jenkins` in your node's `run_list`:

```json
{
  "run_list": [
    "recipe[camunda-ci-jenkins::default]"
  ]
}
```

### Testing and Development

Please see information in [VAGRANT](VAGRANT.md) for how to use the Vagrant environment.  
Full development and testing workflow with Test Kitchen and friends [TESTING](TESTING.md)


## Contributing

Please see contributing information in: [CONTRIBUTING](CONTRIBUTING.md)


## Maintainers

Author:: Christian Lipphardt (<christian.lipphardt@camunda.com>)


## License

Please see licensing information in: [LICENSE](LICENSE)


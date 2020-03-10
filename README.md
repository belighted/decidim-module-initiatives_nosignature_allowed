# Decidim::InitiativesNoSignatureAllowed

[![CircleCI](https://circleci.com/gh/OpenSourcePolitics/decidim-module-initiatives_nosignature_allowed.svg?style=svg)](https://circleci.com/gh/OpenSourcePolitics/decidim-module-initiatives_nosignature_allowed)

Allow a user to create an initiative that do not collect signatures..

## Usage

InitiativesNoSignatureAllowed will be available as a Component for a Participatory
Space.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'decidim-initiatives_no_signature_allowed', git: "https://github.com/OpenSourcePolitics/decidim-module-initiatives_nosignature_allowed.git"
```

And then execute:

```bash
bundle
bundle exec rake decidim_initiatives_no_signature_allowed:install:migrations
bundle exec rake db:migrate
```

## Contributing

See [Decidim](https://github.com/decidim/decidim).

## License

This engine is distributed under the GNU AFFERO GENERAL PUBLIC LICENSE.

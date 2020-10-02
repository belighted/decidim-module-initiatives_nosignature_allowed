# Decidim::InitiativesNoSignatureAllowed

## About

This is an extension of Decidim. Its main purpose is to allow a user to create an initiative
that do not collect signatures.

InitiativesNoSignatureAllowed will be available as a Component for a Participatory Space.

## How to Install

Add this line to your application's Gemfile:

```ruby
gem "decidim-initiatives_no_signature_allowed", git: "https://github.com/belighted/decidim-module-initiatives_nosignature_allowed.git"
```

And then execute:

```bash
$ bundle
$ bundle exec rake decidim_initiatives_no_signature_allowed:install:migrations
$ bundle exec rake db:migrate
```

## Usage

As a organization admin you can enable a new workflow for initiative scope in the following steps:

* Sign in to the /admin.

* In the initiative section, change view  to `Initiative types`.

* Edit existed one or create a new initiative type.

* In the `Options` section enable, `No signature allowed` option.

## Testing

Create a dummy app in the `spec` dir:

```bash
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password>  bundle exec rails decidim:generate_external_test_app
$ cd spec/decidim_dummy_app
$ bunde exec rails decidim_initiatives_no_signature_allowed:install:migrations
$ RAILS_ENV=test bundle exec rails db:migrate
```

This extension includes some system specs. They require setup for chrome driver, which can be done in following steps:

* change path to `spec/decidim_dummy_app`

* install chrome driver via webdrivers `$ bundle exec rails webdrivers:chromedriver:update`

* go back to the extension root path and run the specs

Run tests:

```bash
$ bundle exec rspec spec
```

### Test code coverage

If you want to generate the code coverage report for the tests, you can use the SIMPLECOV=1
environment variable in the rspec command as follows:

```bash
$ SIMPLECOV=1 bundle exec rspec
```

This will generate a folder named coverage in the project root which contains the code coverage report.

## Contributing

For instructions how to setup your development environment for Decidim, see [Decidim](https://github.com/decidim/decidim).
Also follow Decidim's general instructions for development for this project as well.

### Developing

To start contributing to this project, first:

    Install the basic dependencies (such as Ruby and PostgreSQL)
    Clone this repository

Decidim's main repository also provides a Docker configuration file if you prefer to use Docker instead of installing the dependencies locally on your machine.

You can create the development app by running the following commands after cloning this project:

```bash
$ bundle
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails decidim:generate_external_development_app
$ npm i
```

Note that the database user has to have rights to create and drop a database in order to create the dummy test app database.

Then to test how the module works in Decidim, start the development server:

```bash
$ cd development_app
$ bundle exec rails decidim_initiatives_no_signature_allowed:install:migrations
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails db:migrate
$ DATABASE_USERNAME=<username> DATABASE_PASSWORD=<password> bundle exec rails s
```

In case you are using rbenv and have the rbenv-vars plugin installed for it,
you can add the environment variables to the root directory of the project in a file named .rbenv-vars.
If these are defined for the environment, you can omit defining these in the commands shown above.

This extension is based on the OpenSourcePolitics [gem](https://github.com/OpenSourcePolitics/decidim-module-initiatives_nosignature_allowed) with additional utilities
extracted from the [OpenSourcePolitics/decidim](https://github.com/OpenSourcePolitics/decidim/tree/alt/petition_merge),
to provide functionality without forking the decidim.

## License

This engine is distributed under the [GNU AFFERO GENERAL PUBLIC LICENSE](LICENSE-AGPLv3.txt).

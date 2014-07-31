# A sample Guardfile
# More info at https://github.com/guard/guard#readme

ignore %r{^.chef}

guard :bundler do
  watch('Gemfile')
  # Uncomment next line if your Gemfile contains the `gemspec' command.
  # watch(/^.+\.gemspec/)
end

guard :rspec, cmd: 'bundle exec rspec', all_on_start: true,
  notification: false, spec_paths: ['test/unit'], failed_mode: :focus do
  watch(%r{^test/unit/(.+)_spec\.rb$})
  watch(%r{^recipes/(.+)\.rb$})   { |m| "spec/#{m[1]}_spec.rb" }
  watch('test/unit/spec_helper.rb')  { "spec" }
end

guard :foodcritic, cookbook_paths: ".", all_on_start: false,
  notification: false do

  watch(%r{attributes/.+\.rb$})
  watch(%r{providers/.+\.rb$})
  watch(%r{recipes/.+\.rb$})
  watch(%r{resources/.+\.rb$})
end

guard :rubocop do
  watch(%r{.+\.rb$})
  watch(%r{(?:.+/)?\.rubocop\.yml$}) { |m| File.dirname(m[0]) }
end


#
#  This file is part of the "Teapot" project, and is released under the MIT license.
#

teapot_version "2.0"

define_target "generate-travis" do |target|
	target.description = <<-EOF
		Generates a `.travis.yml` file suitable for executing tests.
	EOF
	
	target.depends "Generate/Template"
	target.provides "Generate/Travis"
	
	target.build do |test_target_name|
		source_path = Build::Files::Directory.new(target.package.path + "templates/travis")
		substitutions = target.context.substitutions
		
		substitutions['TEST_TARGET_NAME'] = test_target_name
		
		generate source: source_path, prefix: target.context.root, substitutions: substitutions
	end
end

define_configuration 'generate-travis' do |configuration|
	configuration.public!
	
	configuration.require 'generate-template'
	
	configuration.targets[:create] << "Generate/Travis"
end
